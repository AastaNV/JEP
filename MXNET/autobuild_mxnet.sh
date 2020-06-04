#!/bin/bash

gpu_sm=7.2
gpu_arch=72

if [ "$1" = "Nano" ]
then
        gpu_sm=5.3
        gpu_arch=53
        echo "Compile mxnet for sm="$gpu_arch"(Nano)"
elif [ "$1" = "TX1" ]
then
        gpu_sm=5.3
        gpu_arch=53
        echo "Compile mxnet for sm="$gpu_arch"(TX1)"
elif [ "$1" = "TX2" ]
then
        gpu_sm=6.2
        gpu_arch=62
        echo "Compile mxnet for sm="$gpu_arch"(TX2)"
elif [ "$1" = "Xavier" ]
then
        gpu_sm=7.2
        gpu_arch=72
        echo "Compile mxnet for sm="$gpu_arch"(Xavier)"
else
        echo $0" <Nano/TX1/TX2/Xavier>"
        exit 1
fi


# 1. Install dependencies
sudo apt-get update
sudo apt-get install -y git build-essential python-pip python3-pip ninja-build ccache libprotobuf-dev protobuf-compiler
sudo apt-get install -y git libatlas-base-dev libopencv-dev graphviz libopenblas-dev libopenblas-base


# 2. Install pip prerequisite
sudo pip3 install --upgrade pip
sudo pip3 install --upgrade setuptools
sudo pip3 install numpy graphviz


# 3. Upgrade cmake
wget http://www.cmake.org/files/v3.13/cmake-3.13.2.tar.gz
tar xpvf cmake-3.13.2.tar.gz cmake-3.13.2/
cd cmake-3.13.2/
./bootstrap
make -j8
sudo make install
sudo ldconfig
cd ..


# 4. Install pybind11
pip3 install pytest
git clone https://github.com/pybind/pybind11.git
cd pybind11
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=../install/
make -j8
make install
cd ../../


# 5. Install onnx-onnxtrt
export PYVER=3.6
git clone https://github.com/apache/incubator-mxnet.git --branch v1.7.x --recursive mxnet
cd mxnet/3rdparty/onnx-tensorrt/third_party/onnx/
export CPLUS_INCLUDE_PATH=/usr/include/python3.6:/usr/local/cuda/targets/aarch64-linux/include
mkdir -p build && cd build
cmake -DCMAKE_CXX_FLAGS=-I/usr/include/python${PYVER} -DBUILD_ONNX_PYTHON=ON -Dpybind11_DIR=/home/nvidia/pybind11/install/share/cmake/pybind11/ -DBUILD_SHARED_LIBS=ON ..
sudo make -j$(nproc) install && \
sudo ldconfig && \
cd .. && \
sudo mkdir -p /usr/include/x86_64-linux-gnu/onnx && \
sudo cp build/onnx/onnx*pb.* /usr/include/x86_64-linux-gnu/onnx && \
sudo cp build/libonnx.so /usr/local/lib && \
sudo rm -f /usr/lib/x86_64-linux-gnu/libonnx_proto.a && \
sudo ldconfig

cd ../../ && \
mkdir -p build && \
cd build && \
cmake  -DCMAKE_CXX_FLAGS=-I/usr/local/cuda/targets/aarch64-linux/include -DONNX_NAMESPACE=onnx2trt_onnx .. && \
sudo make -j$(nproc) install && \
sudo ldconfig
cd ../../../../


# 6. Build MXNet
cd mxnet
mkdir -p build && cd build
CUDACXX=/usr/local/cuda/bin/nvcc \
cmake \
        -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} \
        -DUSE_CUDA=ON \
        -DMXNET_CUDA_ARCH="$gpu_sm" \
        -DENABLE_CUDA_RTC=OFF \
        -DSUPPORT_F16C=OFF \
        -DUSE_OPENCV=OFF \
        -DUSE_OPENMP=ON \
        -DUSE_LAPACK=OFF \
        -DUSE_SIGNAL_HANDLER=ON \
        -DCMAKE_BUILD_TYPE=Release \
        -DUSE_MKL_IF_AVAILABLE=OFF \
        -DGPU_ARCHS="$gpu_arch" \
        -DUSE_CUDNN=ON \
        -DUSE_TENSORRT=ON \
        -ONNX_NAMESPACE=onnx \
        -DCMAKE_CXX_FLAGS=-I/usr/local/cuda/targets/aarch64-linux/inlude  \
        ..

sudo make -j$(nproc)
cd ../..


# 7. Create wheel file
set -ex
pushd .

PYTHON_DIR=$PWD/mxnet/python
BUILD_DIR=$PWD/mxnet/build

cd ${PYTHON_DIR}
python3 setup.py bdist_wheel
WHEEL=`readlink -f dist/*.whl`
TMPDIR=`mktemp -d`
unzip -d ${TMPDIR} ${WHEEL}
rm ${WHEEL}
cd ${TMPDIR}
mv *.data/data/mxnet/libmxnet.so mxnet
zip -r ${WHEEL} .
cp ${WHEEL} ${BUILD_DIR}
rm -rf ${TMPDIR}
popd

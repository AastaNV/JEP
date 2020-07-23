#!/bin/bash

gpu_sm=7.2
gpu_arch=72

if [ "$1" = "Nano" ]
then
        gpu_sm=5.3
        gpu_arch=53
	FILEID="1Iz2JRHFdw1MYmp4fXbO_uhJ1FBgwoEts"
        echo "Download mxnet for sm="$gpu_arch"(Nano)"
elif [ "$1" = "TX1" ]
then
        gpu_sm=5.3
        gpu_arch=53
	FILEID="1Iz2JRHFdw1MYmp4fXbO_uhJ1FBgwoEts"
        echo "Download mxnet for sm="$gpu_arch"(TX1)"
elif [ "$1" = "TX2" ]
then
        gpu_sm=6.2
        gpu_arch=62
	FILEID="1Mt_4VIIYybrbBZrnud_uvXHdUpb9vpiB"
        echo "Download mxnet for sm="$gpu_arch"(TX2)"
elif [ "$1" = "Xavier" ]
then
        gpu_sm=7.2
        gpu_arch=72
	FILEID="1xi9h0KHBwz-uYbcnUFpeIRQVKrf_-dGb"
        echo "Download mxnet for sm="$gpu_arch"(Xavier)"
else
        echo $0" <Nano/TX1/TX2/Xavier>"
        exit 1
fi

FILENAME="mxnet-1.7.0-py3-none-any.whl"
export CUDACXX="/usr/local/cuda/bin/nvcc"

# 1. Install dependencies
sudo apt-get update
sudo apt-get install -y git build-essential python3-pip libprotobuf-dev protobuf-compiler libopencv-dev graphviz libopenblas-dev libopenblas-base libatlas-base-dev libprotoc-dev python-setuptools


# 2. Install pip prerequisite
sudo pip3 install --upgrade pip
sudo pip3 install --upgrade setuptools
sudo pip3 install numpy graphviz


# 3. Install ONNX-TRT
sudo pip3 uninstall onnx

export PYVER=3.6
git clone https://github.com/apache/incubator-mxnet.git --branch v1.7.x --recursive mxnet
cd mxnet/3rdparty/onnx-tensorrt/third_party/onnx/
export CPLUS_INCLUDE_PATH=/usr/include/python3.6:/usr/local/cuda/targets/aarch64-linux/include
mkdir -p build && cd build
cmake -DCMAKE_CXX_FLAGS=-I/usr/include/python${PYVER} -DBUILD_ONNX_PYTHON=ON -Dpybind11_DIR=/home/nvidia/pybind11/install/share/cmake/pybind11/ -DBUILD_SHARED_LIBS=ON ..
sudo make -j$(nproc) install && \
sudo ldconfig && \
cd .. && \
sudo mkdir -p /usr/include/aarch64-linux-gnu/onnx && \
sudo cp build/onnx/onnx*pb.* /usr/include/aarch64-linux-gnu/onnx && \
sudo cp build/libonnx.so /usr/local/lib && \
sudo rm -f /usr/lib/aarch64-linux-gnu/libonnx_proto.a && \
sudo ldconfig

cd ../../ && \
mkdir -p build && \
cd build && \
cmake  -DCMAKE_CXX_FLAGS=-I/usr/local/cuda/targets/aarch64-linux/include -DONNX_NAMESPACE=onnx2trt_onnx -DGPU_ARCHS="$gpu_arch" .. && \
sudo make -j$(nproc) install && \
sudo ldconfig
cd ../../../../


# 4. Download & install mxnet wheel
sudo pip3 install gdown
gdown "https://drive.google.com/uc?id="$FILEID -O $FILENAME
sudo pip3 install $FILENAME


# 4. Test
echo "Start testing for MXNet-TRT"
if [ "$1" = "Nano" ]
then
        wget https://raw.githubusercontent.com/AastaNV/JEP/master/MXNET/resnet18-mxnet-trt_nano.py
	mv resnet18-mxnet-trt_nano.py resnet18-mxnet-trt.py
else
	wget https://raw.githubusercontent.com/AastaNV/JEP/master/MXNET/resnet18-mxnet-trt.py
fi
python3 resnet18-mxnet-trt.py

echo "Finish : )"

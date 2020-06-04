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

# 1. Install dependencies
sudo apt-get update
sudo apt-get install -y git build-essential python3-pip libprotobuf-dev protobuf-compiler libopencv-dev graphviz libopenblas-dev libopenblas-base libatlas-base-dev


# 2. Install pip prerequisite
sudo pip3 install --upgrade pip
sudo pip3 install --upgrade setuptools
sudo pip3 install numpy graphviz


# 3. Download mxnet wheel
sudo pip3 install gdown
gdown "https://drive.google.com/uc?id="$FILEID -O $FILENAME
sudo pip3 install $FILENAME


# 4. Test
echo "Start testing for MXNet-TRT"
wget https://raw.githubusercontent.com/AastaNV/JEP/master/MXNET/resnet18-mxnet-trt.py
python3 resnet18-mxnet-trt.py

echo "Finish : )"

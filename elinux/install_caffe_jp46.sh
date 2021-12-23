#!/bin/bash
#
# Copyright (c) 2021, NVIDIA CORPORATION.  All rights reserved.
#
# NVIDIA Corporation and its licensors retain all intellectual property
# and proprietary rights in and to this software, related documentation
# and any modifications thereto.  Any use, reproduction, disclosure or
# distribution of this software and related documentation without an express
# license agreement from NVIDIA Corporation is strictly prohibited.
#

set -e


echo "Install dependencies"
sudo apt update
sudo apt install -y libboost-dev libboost-all-dev
sudo apt install -y libgflags-dev libgoogle-glog-dev liblmdb-dev libatlas-base-dev liblmdb-dev libblas-dev libatlas-base-dev
sudo apt install -y libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler
sudo ln -s /usr/include/locale.h /usr/include/xlocale.h


echo "Update source"
git clone https://github.com/BVLC/caffe
cd caffe
git apply ../0001-patch-for-jp4.6.patch
cp Makefile.config.example Makefile.config
make -j4


echo "Setup python3"
cd src/
wget https://pypi.python.org/packages/03/98/1521e7274cfbcc678e9640e242a62cbcd18743f9c5761179da165c940eac/leveldb-0.20.tar.gz
tar xzvf leveldb-0.20.tar.gz
cd leveldb-0.20
python3 setup.py build
sudo apt install -y gfortran
pkgs=`sed 's/[>=<].*$//' ../../python/requirements.txt`
for pkg in $pkgs; do sudo pip3 install $pkg; done
cd ../../
make pycaffe
echo 'export PYTHONPATH='$PWD'/python' >> ~/.bashrc

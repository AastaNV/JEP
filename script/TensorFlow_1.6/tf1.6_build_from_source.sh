#!/bin/bash
#
# Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
#
# NVIDIA Corporation and its licensors retain all intellectual property
# and proprietary rights in and to this software, related documentation
# and any modifications thereto.  Any use, reproduction, disclosure or
# distribution of this software and related documentation without an express
# license agreement from NVIDIA Corporation is strictly prohibited.
#

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <Install Folder>"
    exit
fi
pwd_dir=$PWD
install="$1"
user="nvidia"
passwd="nvidia"

echo "** Create swap space"
cd $install
fallocate -l 8G swapfile
ls -lh swapfile
sudo chmod 600 swapfile
ls -lh swapfile
sudo mkswap swapfile
sudo swapon swapfile
swapon -s
cd $pwd_dir


echo "** Install requirement"
sudo apt-get install -y language-pack-id
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
sudo dpkg-reconfigure locales
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java8-installer -y
sudo apt-get install -y zip unzip autoconf automake libtool curl zlib1g-dev maven
sudo apt-get install -y python-numpy swig python-dev python-pip python-wheel


echo "** Build Bazel"
cd $install
wget --no-check-certificate https://github.com/bazelbuild/bazel/releases/download/0.10.0/bazel-0.10.0-dist.zip
unzip bazel-0.10.0-dist.zip -d bazel-0.10.0-dist
sudo chmod -R ug+rwx bazel-0.10.0-dist
cd bazel-0.10.0-dist
./compile.sh
sudo cp output/bazel /usr/local/bin
cd $pwd_dir


echo "** Clone TensorFlow source"
cd $install
git clone https://github.com/tensorflow/tensorflow.git
cd tensorflow
git checkout r1.6
patch -p1 < $pwd_dir/tensorflow.patch
cd $pwd_dir


echo "** Building TensorFlow for JetPack3.2 DP"
cd $install/tensorflow
source ./configure
bazel build -c opt --local_resources 3072,4.0,1.0 --verbose_failures --config=cuda //tensorflow/tools/pip_package:build_pip_package
sudo bazel-bin/tensorflow/tools/pip_package/build_pip_package ../
sudo pip install ../tensorflow-1.6.0-cp27-cp27mu-linux_aarch64.whl
#bazel build -c opt --local_resources 3072,4.0,1.0 --verbose_failures --config=cuda //tensorflow/tools/lib_package:libtensorflow
#cp bazel-bin/tensorflow/tools/lib_package/libtensorflow.tar.gz ../
#tar -C /usr/local -xzf ../libtensorflow.tar.gz
cd $pwd_dir


echo "** Install TensorFlow-1.6.0 successfully"
echo "** Bye :)"

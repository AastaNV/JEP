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
    echo "Usage: $0 <wheel file>"
    exit
fi
file="$1"
user="nvidia"
passwd="nvidia"


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


echo "** Install TensorFlow for JetPack3.2 DP"
sudo pip install $file
#tar -C /usr/local -xzf $file

echo "** Install TensorFlow-1.6.0 successfully"
echo "** Bye :)"

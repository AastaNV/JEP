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

user="nvidia"
passwd="nvidia"

echo "** correct CUDA for on target compilation"
sudo dpkg -i /var/cuda-repo-10-2-local-10.2.19/cuda-toolkit-10-2_10.2.19-1_arm64.deb
sudo apt --fix-broken -y install

echo "** calling install opencv4.1.1 for jetson"
./install_opencv4.1.1_Jetson.sh $1

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

user="nvidia"
passwd="nvidia"

echo "** Install Tool **"
sudo apt-get update
sudo apt-get install -y python-pip cmake
pip install -U pip
pip install scikit-build --user
pip install ninja --user


echo "** Update pip for Ubuntu18.04 **"
sudo sed -i 's/import main/import __main__/g' /usr/bin/pip
sudo sed -i 's/sys.exit(main())/sys.exit(__main__._main())/g' /usr/bin/pip


echo "** Build from Source **"
git clone http://github.com/pytorch/pytorch
cd pytorch

git submodule update --init
sudo pip install -U setuptools
sudo pip install -r requirements.txt

python setup.py build_deps
sudo python setup.py develop

echo "** Install pyTorch successfully **"
echo "** Bye :)"

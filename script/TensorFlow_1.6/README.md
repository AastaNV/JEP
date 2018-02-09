TensorFlow-1.6 for JetPack3.2 DP
======================================

# Install prebuilt wheel
```C
$ ./tf1.6_install_wheel.sh [/path/to/wheel/file]
```


# Build from source
```C
$ ./tf1.6_build_from_source.sh [/path/to/install/folder]
```
Please specify the location of python. [Default is /usr/bin/python]: **[Enter]**
</br>
</br>
</br>
Found possible Python library paths:
</br>
  /usr/local/lib/python2.7/dist-packages
</br>
  /usr/lib/python2.7/dist-packages
</br>
Please input the desired Python library path to use.  Default is [/usr/local/lib/python2.7/dist-packages] **[Enter]**
</br>
</br>
Do you wish to build TensorFlow with jemalloc as malloc support? [Y/n]: **Y**
</br>
jemalloc as malloc support will be enabled for TensorFlow.
</br>
</br>
Do you wish to build TensorFlow with Google Cloud Platform support? [Y/n]: **n**
</br>
No Google Cloud Platform support will be enabled for TensorFlow.
</br>
</br>
Do you wish to build TensorFlow with Hadoop File System support? [Y/n]: **n**
</br>
No Hadoop File System support will be enabled for TensorFlow.
</br>
</br>
Do you wish to build TensorFlow with Amazon S3 File System support? [Y/n]: **n**
</br>
No Amazon S3 File System support will be enabled for TensorFlow.
</br>
</br>
Do you wish to build TensorFlow with Apache Kafka Platform support? [y/N]: **n**
</br>
No Apache Kafka Platform support will be enabled for TensorFlow.
</br>
</br>
Do you wish to build TensorFlow with XLA JIT support? [y/N]: **n**
</br>
No XLA JIT support will be enabled for TensorFlow.
</br>
</br>
Do you wish to build TensorFlow with GDR support? [y/N]: **n**
</br>
No GDR support will be enabled for TensorFlow.
</br>
</br>
Do you wish to build TensorFlow with VERBS support? [y/N]: **Y**
</br>
VERBS support will be enabled for TensorFlow.
</br>
</br>
Do you wish to build TensorFlow with OpenCL SYCL support? [y/N]: **n**
</br>
No OpenCL SYCL support will be enabled for TensorFlow.
</br>
</br>
Do you wish to build TensorFlow with CUDA support? [y/N]: **y**
</br>
CUDA support will be enabled for TensorFlow.
</br>
</br>
Please specify the CUDA SDK version you want to use, e.g. 7.0. [Leave empty to default to CUDA 9.0]: **9.0**
</br>
</br>
</br>
Please specify the location where CUDA 9.0 toolkit is installed. Refer to README.md for more details. [Default is /usr/local/cuda]: **[Enter]**
</br>
</br>
</br>
Please specify the cuDNN version you want to use. [Leave empty to default to cuDNN 7.0]: **7.0.5**
</br>
</br>
</br>
Please specify the location where cuDNN 7.0.5 library is installed. Refer to README.md for more details. [Default is /usr/local/cuda]: **[Enter]**
</br>
</br>
</br>
Do you wish to build TensorFlow with TensorRT support? [y/N]: **N**
</br>
No TensorRT support will be enabled for TensorFlow.
</br>
</br>
Please specify a list of comma-separated Cuda compute capabilities you want to build with.
</br>
You can find the compute capability of your device at: https://developer.nvidia.com/cuda-gpus.
</br>
Please note that each additional compute capability significantly increases your build time and binary size. [Default is: 3.5,5.2] **6.2**
</br>
</br>
</br>
Do you want to use clang as CUDA compiler? [y/N]: **N**
</br>
nvcc will be used as CUDA compiler.
</br>
</br>
Please specify which gcc should be used by nvcc as the host compiler. [Default is /usr/bin/gcc]: **[Enter]**
</br>
</br>
</br>
Do you wish to build TensorFlow with MPI support? [y/N]: **N**
</br>
No MPI support will be enabled for TensorFlow.
</br>
</br>
Please specify optimization flags to use during compilation when bazel option "--config=opt" is specified [Default is -march=native]: **[Enter]**
</br>
</br>
</br>
Would you like to interactively configure ./WORKSPACE for Android builds? [y/N]:  **[Enter]**
</br>
Not configuring the WORKSPACE for Android builds.
</br>
</br>
Preconfigured Bazel build configs. You can use any of the below by adding "--config=<>" to your build command. See tools/bazel.rc for more details.
</br>
	--config=mkl         	# Build with MKL support.
</br>
	--config=monolithic  	# Config for mostly static monolithic build.
</br>
	--config=tensorrt    	# Build with TensorRT support.
</br>
Configuration finished
</br>


# Reference
https://github.com/jetsonhacks/installTensorFlowTX2
</br>
https://gist.github.com/vellamike/7c26158c93e89ef155c1cc953bbba956
</br>
</br>

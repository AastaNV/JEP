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
  /usr/local/lib/python2.7/dist-packages
  /usr/lib/python2.7/dist-packages
Please input the desired Python library path to use.  Default is [/usr/local/lib/python2.7/dist-packages] [Enter]

Do you wish to build TensorFlow with jemalloc as malloc support? [Y/n]: Y
jemalloc as malloc support will be enabled for TensorFlow.

Do you wish to build TensorFlow with Google Cloud Platform support? [Y/n]: n
No Google Cloud Platform support will be enabled for TensorFlow.

Do you wish to build TensorFlow with Hadoop File System support? [Y/n]: n
No Hadoop File System support will be enabled for TensorFlow.

Do you wish to build TensorFlow with Amazon S3 File System support? [Y/n]: n
No Amazon S3 File System support will be enabled for TensorFlow.

Do you wish to build TensorFlow with Apache Kafka Platform support? [y/N]: n
No Apache Kafka Platform support will be enabled for TensorFlow.

Do you wish to build TensorFlow with XLA JIT support? [y/N]: n
No XLA JIT support will be enabled for TensorFlow.

Do you wish to build TensorFlow with GDR support? [y/N]: n
No GDR support will be enabled for TensorFlow.

Do you wish to build TensorFlow with VERBS support? [y/N]: Y
VERBS support will be enabled for TensorFlow.

Do you wish to build TensorFlow with OpenCL SYCL support? [y/N]: n
No OpenCL SYCL support will be enabled for TensorFlow.

Do you wish to build TensorFlow with CUDA support? [y/N]: y
CUDA support will be enabled for TensorFlow.

Please specify the CUDA SDK version you want to use, e.g. 7.0. [Leave empty to default to CUDA 9.0]: 9.0


Please specify the location where CUDA 9.0 toolkit is installed. Refer to README.md for more details. [Default is /usr/local/cuda]: [Enter]


Please specify the cuDNN version you want to use. [Leave empty to default to cuDNN 7.0]: 7.0.5


Please specify the location where cuDNN 7.0.5 library is installed. Refer to README.md for more details. [Default is /usr/local/cuda]: [Enter]


Do you wish to build TensorFlow with TensorRT support? [y/N]: N
No TensorRT support will be enabled for TensorFlow.

Please specify a list of comma-separated Cuda compute capabilities you want to build with.
You can find the compute capability of your device at: https://developer.nvidia.com/cuda-gpus.
Please note that each additional compute capability significantly increases your build time and binary size. [Default is: 3.5,5.2] 6.2


Do you want to use clang as CUDA compiler? [y/N]: N
nvcc will be used as CUDA compiler.

Please specify which gcc should be used by nvcc as the host compiler. [Default is /usr/bin/gcc]: [Enter]


Do you wish to build TensorFlow with MPI support? [y/N]: N
No MPI support will be enabled for TensorFlow.

Please specify optimization flags to use during compilation when bazel option "--config=opt" is specified [Default is -march=native]: [Enter]


Would you like to interactively configure ./WORKSPACE for Android builds? [y/N]:  [Enter]
Not configuring the WORKSPACE for Android builds.

Preconfigured Bazel build configs. You can use any of the below by adding "--config=<>" to your build command. See tools/bazel.rc for more details.
	--config=mkl         	# Build with MKL support.
	--config=monolithic  	# Config for mostly static monolithic build.
	--config=tensorrt    	# Build with TensorRT support.
Configuration finished


# Reference
https://github.com/jetsonhacks/installTensorFlowTX2
</br>
https://gist.github.com/vellamike/7c26158c93e89ef155c1cc953bbba956
</br>
</br>

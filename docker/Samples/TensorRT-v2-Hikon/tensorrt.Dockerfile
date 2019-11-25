ARG CUDA_VERSION=9.0
FROM nvidia/cuda:${CUDA_VERSION}-cudnn7-devel-ubuntu16.04

LABEL maintainer="FOXCONN CORPORATION"

# Install requried libraries
RUN rm -rf /var/lib/apt/lists/* && mkdir /var/lib/apt/lists/partial &&\
    apt-get update && apt-get install -y --no-install-recommends \
    wget vim git unzip \
    zlib1g-dev \
    pkg-config \
    python3 \
    python3-pip \
    build-essential \
    cmake libgtk2.0-dev libavcodec-dev libavformat-dev libswscale-dev \
    python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev \
    libdrm2 libgtkglext1 libilmbase12 libopencv-core2.4v5 libopencv-highgui2.4v5 \
    libopencv-imgproc2.4v5 libopenexr22 libpangox-1.0-0 libv4l-0 libv4lconvert0 \
    libx11-xcb1 libxcb-dri2-0 libxcb-dri3-0 libxcb-glx0 libxcb-present0 \
    libxcb-sync1 libxmu6 libxshmfence1 libxt6 libxxf86vm1 udev \
    libmodbus-dev libcurl4-openssl-dev

RUN cd /usr/local/bin &&\
    ln -s /usr/bin/python3 python &&\
    ln -s /usr/bin/pip3 pip

# Install TensorRT & OpenCV & Baumer
COPY . /tmp/

RUN cd /tmp &&\
    tar zxf TensorRT-5.0.2.6.Ubuntu-16.04.4.x86_64-gnu.cuda-9.0.cudnn7.3.tar.gz &&\
    mv TensorRT-5.0.2.6 /tensorrt \
&&\
    unzip opencv-2.4.13.zip -d /root/ &&\
    bash fixcupen.sh &&\
    cd /root/opencv-2.4.13 &&\
    mkdir release && cd release &&\
    cmake -DCMAKE_BUILD_TYPE=RELEASE \
          -DCMAKE_INSTALL_PREFIX=/usr/local .. &&\
    make -j4 && make install \
&&\
    cd /tmp &&\
    dpkg -i baumer-gapi-sdk-linux-v2.9.2.22969-Ubuntu-16.04-x86-64.deb \
&&\
    ln -s /usr/local/cuda/targets/x86_64-linux/lib/libcudart.so /usr/local/lib/libopencv_dep_cudart.so &&\
    ln -s /usr/local/cuda/targets/x86_64-linux/lib/libnppial.so /usr/local/lib/libopencv_dep_nppial.so &&\
    ln -s /usr/local/cuda/targets/x86_64-linux/lib/libnppicc.so /usr/local/lib/libopencv_dep_nppicc.so &&\
    ln -s /usr/local/cuda/targets/x86_64-linux/lib/libnppicom.so /usr/local/lib/libopencv_dep_nppicom.so &&\
    ln -s /usr/local/cuda/targets/x86_64-linux/lib/libnppidei.so /usr/local/lib/libopencv_dep_nppidei.so &&\
    ln -s /usr/local/cuda/targets/x86_64-linux/lib/libnppif.so /usr/local/lib/libopencv_dep_nppif.so &&\
    ln -s /usr/local/cuda/targets/x86_64-linux/lib/libnppig.so /usr/local/lib/libopencv_dep_nppig.so &&\
    ln -s /usr/local/cuda/targets/x86_64-linux/lib/libnppim.so /usr/local/lib/libopencv_dep_nppim.so &&\
    ln -s /usr/local/cuda/targets/x86_64-linux/lib/libnppist.so /usr/local/lib/libopencv_dep_nppist.so &&\
    ln -s /usr/local/cuda/targets/x86_64-linux/lib/libnppisu.so /usr/local/lib/libopencv_dep_nppisu.so &&\
    ln -s /usr/local/cuda/targets/x86_64-linux/lib/libnppitc.so /usr/local/lib/libopencv_dep_nppitc.so &&\
    ln -s /tensorrt/include/* /usr/include &&\
    ln -s /tensorrt/targets/x86_64-linux-gnu/lib/* /usr/lib/x86_64-linux-gnu \
&&\
    rm -rf /tmp/*

# Install Hikon
COPY MVS-1.0.0_x86_64.tar.gz /tmp/
RUN cd /tmp &&\
    tar zxf MVS_x86_64.tar.gz &&\
    cd MVS-1.0.0_x86_64 &&\
    ./setup.sh \
&&\
    rm -rf /tmp/*

# Set environment and working directory
ENV TRT_RELEASE /tensorrt
ENV TRT_LIB_DIR $TRT_RELEASE/lib
ENV TRT_SOURCE /workspace/TensorRT
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:$TRT_LIB_DIR
WORKDIR /workspace

RUN ["/bin/bash"]


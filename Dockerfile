
FROM ubuntu:20.04

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

ARG DEBIAN_FRONTEND=noninteractive 

# install GLX-Gears
RUN apt-get update && apt-get install -y --no-install-recommends mesa-utils x11-apps && rm -rf /var/lib/apt/lists/*

# install useful tool
RUN apt-get update && apt-get install -y git vim

COPY ./assets/bashrc /root/.bashrc
COPY ./assets/inputrc /root/.inputrc

WORKDIR /home

RUN apt-get update
RUN apt-get install -y cmake git build-essential

RUN git clone https://github.com/libigl/eigen.git
RUN cd eigen && mkdir build && cd build && cmake .. && make -j4 && make install

RUN apt-get update && apt-get install -y libsuitesparse-dev qtdeclarative5-dev qt5-qmake libqglviewer-dev-qt5 && rm -rf /var/lib/apt/lists/*
RUN mkdir /code && cd /code && git clone https://github.com/RainerKuemmerle/g2o.git && cd ./g2o && mkdir build && cd build && cmake ../ && make -j4 && make install -j4
RUN ldconfig

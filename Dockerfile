FROM ubuntu:xenial

MAINTAINER Andrei Gherghescu <gandrein@gmail.com>

LABEL Description="Ubuntu Xenial 16.04 with mapped NVIDIA driver from the host" Version="1.0"

# ------------------------------------------ Install required (&useful) packages --------------------------------------
RUN apt-get update && apt-get install -y \
  software-properties-common python-software-properties \
  lsb-release \
  mesa-utils \
  wget \
  curl \
  sudo vim \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# nvidia-docker hooks: Map host's NVIDIA driver to container
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

# In the newly loaded container sometimes you can't do `apt install <package>
# unless you do a `apt update` first.  So run `apt update` as last step
# NOTE: bash auto-completion may have to be enabled manually from /etc/bash.bashrc RUN apt-get update -y
CMD ["/bin/bash"]






RUN apt-get update
RUN apt-get install -y cmake git build-essential
RUN apt-get install -y libeigen3-dev libsuitesparse-dev qtdeclarative5-dev qt5-qmake libqglviewer-dev
RUN mkdir /code && cd /code && git clone https://github.com/RainerKuemmerle/g2o.git && cd ./g2o && mkdir build && cd build && cmake ../ && make -j4 && make install -j4
RUN ldconfig

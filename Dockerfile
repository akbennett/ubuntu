#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:16.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  apt-get install -y git make gcc g++ python3-ply ncurses-dev && \
  rm -rf /var/lib/apt/lists/*

# Setup Build Enviroment
ENV LANG C
ENV ZEPHYR_BASE /root/zephyr-project
ENV GCCARMEMB_TOOLCHAIN_PATH /root/gcc-arm-none-eabi-5_4-2016q2

# Build.
RUN \
  cd /root && \
  wget https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q2-update/+download/gcc-arm-none-eabi-5_4-2016q2-20160622-linux.tar.bz2 && \
  tar -C . -xaf gcc-arm-none-eabi-5_4-2016q2-20160622-linux.tar.bz2

# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]

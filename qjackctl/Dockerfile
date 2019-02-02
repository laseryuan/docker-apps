# FROM debian:stretch-20181226-slim
FROM ubuntu:bionic-20190122

RUN apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    software-properties-common autoconf \
    build-essential git \
    mesa-utils libgl1-mesa-dev \
    libglu1-mesa-dev libasound2-dev \
    libgl1-mesa-dri kmod alsa-utils \
    libpulse-dev libcsnd-dev libcsound64-dev libcsound64-6.0 \
    lsof dbus-x11 qt5-default qttools5-dev-tools

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y jackd2 libjack-jackd2-dev

# https://github.com/rncbc/qjackctl/
ADD qjackctl_0_5_5.tar.gz /tmp/
WORKDIR /tmp/qjackctl-qjackctl_0_5_5
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y pulseaudio-module-jack

# Add user
RUN useradd -ms /bin/bash qjackctl
RUN usermod -aG plugdev,audio qjackctl

USER qjackctl

WORKDIR /home/qjackctl

# Configure
RUN mkdir -p .config/rncbc.org

COPY --chown=qjackctl config.sh /tmp/config.sh
RUN bash /tmp/config.sh

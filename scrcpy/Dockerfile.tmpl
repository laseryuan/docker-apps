# https://github.com/Genymobile/scrcpy/blob/master/BUILD.md#simple
# https://github.com/pierlon/scrcpy-docker

FROM {{ARCH.images.base}}

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# Install adb
RUN apt-get update -qy && \
    apt-get install -y curl unzip && \
    curl -L -o platform-tools.zip \
      https://dl.google.com/android/repository/platform-tools-latest-linux.zip && \
    unzip platform-tools.zip platform-tools/adb && \
    mv platform-tools/adb /usr/bin/adb

# Build scrcpy
RUN \
  apt install -qy \
    ffmpeg libsdl2-2.0-0 wget \
    gcc git pkg-config meson ninja-build libsdl2-dev \
    libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev \
    libusb-1.0-0 libusb-1.0-0-dev

# fix: sudo command not found
RUN apt install -y sudo

RUN git clone --depth 1 https://github.com/Genymobile/scrcpy
#RUN git clone --depth 1 --branch {{IMAGE_VERSION}} https://github.com/Genymobile/scrcpy
WORKDIR /scrcpy

# Build scrcpy
RUN ./install_release.sh

# Create scrcpy user for X11
RUN useradd -m -G video scrcpy

WORKDIR /home/scrcpy

USER scrcpy

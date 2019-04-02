
FROM balenalib/raspberry-pi-debian:buster-20190325

RUN [ "cross-build-start" ]

ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
      git \
      `# build support` \
      build-essential \
      `# python support` \
      cython3 \
      python3-dev \
      python3-pip \
      python3-tk \
      `# usb support` \
      libudev-dev \
      libusb-1.0-0-dev \
      `# protocol buffers` \
      libprotoc-dev \
      protobuf-compiler \
      `# ssl support` \
      libssl-dev \
      && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade setuptools pip

RUN git clone --depth=1 --branch=v0.11.2 https://github.com/trezor/python-trezor /tmp/trezor
WORKDIR /tmp/trezor

RUN git submodule update --init
RUN pip install -r requirements-dev.txt

RUN python3 setup.py prebuild
RUN python3 setup.py develop

RUN useradd -ms /bin/bash trezor
RUN usermod -aG plugdev trezor

RUN [ "cross-build-end" ]

USER trezor
WORKDIR /home/trezor/app

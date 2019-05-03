
FROM balenalib/raspberry-pi-debian:buster-20190325

RUN [ "cross-build-start" ]

RUN apt-get update && apt-get install -y \
      git \
      `# build support` \
      build-essential \
      `# python support` \
      cython3 \
      python3-dev \
      python3-pip \
      python3-tk \
      `# qt5 support` \
      pyqt5-dev-tools \
      python3-pyqt5 \
      `# libEGL support` \
      libgl1-mesa-dri \
      mesa-utils \
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

# Install trezor
RUN git clone --depth=1 --branch=v0.11.2 https://github.com/trezor/python-trezor /tmp/trezor
WORKDIR /tmp/trezor

RUN git submodule update --init
RUN pip install -r requirements-dev.txt

RUN python3 setup.py prebuild
RUN python3 setup.py develop

# Install electron-cash
ADD Electron-Cash-4.0.2.tar.gz /

# Add user
RUN useradd -ms /bin/bash electron-cash
RUN usermod -aG plugdev electron-cash

# wallet mount point
RUN mkdir /tmp/wallet
RUN chown electron-cash:electron-cash /tmp/wallet

RUN [ "cross-build-end" ]

USER electron-cash
WORKDIR "/Electron Cash-4.0.2"

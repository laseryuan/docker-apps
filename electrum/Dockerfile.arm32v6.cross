
FROM balenalib/raspberry-pi-debian:buster-20190325

RUN [ "cross-build-start" ]

ENV LANG C.UTF-8

# RUN apt-get update && apt-get install --no-install-recommends -y \
RUN apt-get update && apt-get install -y \
    build-essential \
    cython3 \
    git \
    libprotoc-dev \
    libssl-dev \
    libudev-dev \
    libusb-1.0-0-dev \
    protobuf-compiler \
    pyqt5-dev-tools \
    python3-dev \
    python3-pip \
    python3-pyqt5 \
    zbar-tools `# qrcode reader` \
    && rm -rf /var/lib/apt/lists/*


RUN pip3 install --upgrade setuptools pip

# Install trezor
RUN pip install trezor==0.11.2

# Install ledger
RUN pip3 --no-cache-dir install btchip-python

# Install electrum
RUN git clone --depth=1 --branch 3.3.5 https://github.com/spesmilo/electrum.git /tmp/electrum
WORKDIR /tmp/electrum
RUN python3 -m pip install .[fast]
RUN protoc --proto_path=electrum --python_out=electrum electrum/paymentrequest.proto


# Add user
RUN useradd -ms /bin/bash electrum
RUN usermod -aG plugdev electrum

# wallet mount point
RUN mkdir /tmp/wallet
RUN chown electrum:electrum /tmp/wallet

RUN [ "cross-build-end" ]

USER electrum
WORKDIR /home/electrum

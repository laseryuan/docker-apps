FROM {{ARCH.images.base}}

ENV LANG C.UTF-8

RUN \
apt-get update && apt-get install -y \
    build-essential \
    curl \
    cython3 \
    git \
    libprotoc-dev \
    libssl-dev \
    libudev-dev \
    libusb-1.0-0-dev \
    protobuf-compiler \
    pyqt5-dev-tools \
    python3-cryptography \
    python3-dev \
    python3-pip \
    python3-pyqt5 \
    zbar-tools `# qrcode reader` \
    libsecp256k1-0 `#electrum dependency` \
    && rm -rf /var/lib/apt/lists/*

# Install hardware wallet
RUN \
pip3 install \
  trezor \
  btchip-python ecdsa `# ledger`\
  ``

# Install electrum
RUN \
curl -L \
  https://github.com/spesmilo/electrum/archive/refs/tags/{{IMAGE_VERSION}}.tar.gz \
  -o /tmp/electrum.tar.gz && \
tar xvf /tmp/electrum.tar.gz -C /tmp/

WORKDIR /tmp/electrum-{{IMAGE_VERSION}}

RUN \
python3 -m pip install . && \
electrum --offline version

# Add user
RUN useradd -ms /bin/bash electrum
RUN usermod -aG plugdev electrum

# wallet mount point
RUN mkdir /tmp/wallet
RUN chown electrum:electrum /tmp/wallet

USER electrum
WORKDIR /home/electrum

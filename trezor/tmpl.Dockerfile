FROM {{ARCH.images.base}}

ENV LANG C.UTF-8

RUN \
  apt-get update && apt-get install -y \
      curl \
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

{{#ARCH.is_amd}}
RUN \
  apt-get update && apt-get install -y \
    `# dependency for stellar` \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*
{{/ARCH.is_amd}}

RUN \
  pip3 install trezor[hidapi,ethereum,stellar] && \
  trezorctl --version
RUN \
  useradd -ms /bin/bash trezor && \
  usermod -aG plugdev trezor
USER trezor
WORKDIR /home/trezor

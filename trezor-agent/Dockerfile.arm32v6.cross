
FROM balenalib/raspberry-pi-debian:buster-20190325

RUN [ "cross-build-start" ]

ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
      build-essential \
      ca-certificates \
      cython3 \
      git \
      gpg \
      libudev-dev \
      libusb-1.0-0-dev \
      python3-dev \
      python3-pip \
      python3-tk \
      && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade setuptools pip

RUN pip install docutils

RUN useradd -ms /bin/bash trezor-agent
RUN usermod -aG plugdev trezor-agent

# Install trezor_agent
# RUN pip install hidapi trezor== trezor_agent==
# Patch: https://github.com/romanz/trezor-agent/pull/269
RUN pip install trezor==0.11.2

# Manually Install:
RUN git clone --depth=1 --branch=v0.13.1 https://github.com/romanz/trezor-agent /tmp/trezor-agent
WORKDIR /tmp/
RUN pip install -e trezor-agent/agents/trezor

WORKDIR /home/trezor-agent

RUN [ "cross-build-end" ]

USER trezor-agent

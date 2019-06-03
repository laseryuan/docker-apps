FROM balenalib/rpi-debian:stretch-20190511

ARG VERSION=1.4.7

RUN [ "cross-build-start" ]

ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
    libharfbuzz0b libfontconfig1 \
    wget \
    libraspberrypi0 `# Solve libbrcmGLESv2.so dependency issue` \
    libasound2-dev libssl-dev `# Solve libasound dependency issue`

# Install picam binary
RUN mkdir ~/picam
ADD picam-${VERSION}-binary.tar.xz /tmp/
RUN mv /tmp/picam-${VERSION}-binary/picam ~/picam/

WORKDIR /root/picam

RUN [ "cross-build-end" ]

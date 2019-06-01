
FROM balenalib/rpi-debian:stretch-20190511

ARG VERSION=0.27.0

RUN [ "cross-build-start" ]

ENV LANG C.UTF-8

RUN apt-get update && apt-get -y upgrade

# https://github.com/fatedier/frp/releases/

ADD frp_${VERSION}_linux_arm.tar.gz /tmp/
RUN mv /tmp/frp_${VERSION}_linux_arm /root/frp

RUN [ "cross-build-end" ]

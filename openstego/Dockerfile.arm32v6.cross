
FROM balenalib/raspberry-pi-debian-openjdk:8-20190511

ARG VERSION=0.7.3

RUN [ "cross-build-start" ]

ENV LANG C.UTF-8

ADD https://github.com/syvaidya/openstego/releases/download/openstego-${VERSION}/openstego-${VERSION}.zip /tmp/
RUN unzip /tmp/openstego-${VERSION}.zip
RUN mv openstego-${VERSION} openstego

RUN useradd -ms /bin/bash openstego

RUN [ "cross-build-end" ]

USER openstego
WORKDIR /home/openstego

# https://github.com/Yun-Mao/caddy_docker
# Build Caddy
FROM golang:1.13-alpine as caddy_builder
RUN apk add --no-cache git gcc musl-dev
RUN mkdir /www /caddy
COPY builder.sh /usr/bin/builder.sh
ARG version="1.0.5"
ARG enable_telemetry="true"
# Explicitly configure go builds for ARM32v6
ENV GOARCH=arm
ENV GOARM=7

RUN VERSION=${version} /bin/sh /usr/bin/builder.sh

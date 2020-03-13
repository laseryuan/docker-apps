FROM debian:stretch-20200224

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qy && apt-get install -qy \
      curl
RUN ["/bin/bash", "-c", "bash < <(curl -s -S -L https://install.direct/go.sh)"]

## Method 1 ##
# ############################
# # STEP 1 build executable binary
# ############################
# FROM golang:alpine AS builder
# RUN apk update && apk add --no-cache git bash wget
# WORKDIR /go/src/v2ray.com/core
# ENV VERSION "v4.22.1"
# RUN git clone --progress --branch ${VERSION} https://github.com/v2fly/v2ray-core.git .
# RUN git describe --tags
# RUN bash ./release/user-package.sh nosource noconf codename=$(git describe --tags) buildname=docker-fly abpathtgz=/tmp/v2ray.tgz
# ############################
# # STEP 2 build a small image
# ############################
# FROM alpine

# LABEL maintainer "V2Fly Community <admin@v2fly.org>"
# COPY --from=builder /tmp/v2ray.tgz /tmp
# RUN apk update && apk add ca-certificates && \
    # mkdir -p /usr/bin/v2ray && \
    # tar xvfz /tmp/v2ray.tgz -C /usr/bin/v2ray

# #ENTRYPOINT ["/usr/bin/v2ray/v2ray"]
# ENV PATH /usr/bin/v2ray:$PATH
# CMD ["v2ray", "-config=/etc/v2ray/config.json"]

## Method 2 ##
# FROM debian:stretch-20200224 as builder

# ENV LANG C.UTF-8
# ENV DEBIAN_FRONTEND noninteractive

# ENV ARCH "linux-arm"
# ENV VERSION "v4.22.1"

# # Install graphic driver
# RUN apt-get update -qy && apt-get install -qy \
      # unzip

# ADD https://github.com/v2ray/v2ray-core/releases/download/${VERSION}/v2ray-${ARCH}.zip v2ray.zip
# RUN unzip v2ray.zip

# FROM debian:stretch-20200224-slim

# ENV ARCH "linux-arm"
# ENV VERSION "v4.22.1"

# COPY --from=builder v2ray-${VERSION}-${ARCH}  /usr/bin/v2ray
# ENV PATH /usr/bin/v2ray/:$PATH
# CMD ["v2ray", "-h"]

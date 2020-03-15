# Reference:
# https://github.com/tdicola/caddy-docker/blob/master/Dockerfile.arm32v6
# https://github.com/pengchujin/v2rayDocker/blob/master/Dockerfile
#
# Builder
#
# Builder will run on whatever architecture is doing the building (CI system, etc.)
# and configure Go build for an ARM32v6 cross compilation.
FROM abiosoft/caddy:builder as builder

ARG version="0.11.1"
ARG plugins="git,cors,realip,expires,cache"

# Explicitly configure go builds for ARM32v6
ENV GOARCH=arm
ENV GOARM=6

# process wrapper
RUN go get -v github.com/abiosoft/parent
# Make sure to explicitly build the parent process so an ARM32v6 binary is generated.
RUN go build -v -o /install/parent github.com/abiosoft/parent

ARG plugins="git,cors,realip,expires,cache"
RUN PLUGINS=${plugins} ENABLE_TELEMETRY=false /bin/sh /usr/bin/builder.sh

#
# Final stage
#
FROM alpine:3.8
# process wrapper
LABEL maintainer "sebs sebsclub@outlook.com"

# V2RAY
ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV V2RAY_VERSION v4.19.1 
ENV V2RAY_LOG_DIR /var/log/v2ray
ENV V2RAY_CONFIG_DIR /etc/v2ray/
ENV V2RAY_DOWNLOAD_URL https://github.com/v2ray/v2ray-core/releases/download/${V2RAY_VERSION}/v2ray-linux-arm.zip

RUN apk upgrade --update \
    && apk add \
        bash \
        tzdata \
        curl \
    && mkdir -p \ 
        ${V2RAY_LOG_DIR} \
        ${V2RAY_CONFIG_DIR} \
        /tmp/v2ray \
    && curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip ${V2RAY_DOWNLOAD_URL} \
    && pwd \
    && unzip /tmp/v2ray/v2ray.zip -d /etc/v2ray/ \
    && ln -s /etc/v2ray/v2ray /usr/bin/v2ray \
    && ln -s /etc/v2ray/v2ctl /usr/bin/v2ctl \
    && mv /etc/v2ray/vpoint_vmess_freedom.json /etc/v2ray/config.json \
    && apk del curl \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /tmp/v2ray /var/cache/apk/*

# ADD entrypoint.sh /entrypoint.sh
WORKDIR /srv
# node
# install node 
RUN apk add --no-cache util-linux
RUN apk add --update nodejs nodejs-npm
COPY package.json /srv/package.json
RUN  npm install
COPY  v2ray.js /srv/v2ray.js

ARG version="0.11.1"
LABEL caddy_version="$version"

# Let's Encrypt Agreement
ENV ACME_AGREE="false"

# Telemetry Stats
ENV ENABLE_TELEMETRY="false"

RUN apk add --no-cache openssh-client git

# install caddy
COPY --from=builder /install/caddy /usr/bin/caddy

# validate install
RUN /usr/bin/caddy -version
RUN /usr/bin/caddy -plugins


VOLUME /root/.caddy /srv
# WORKDIR /srv

COPY Caddyfile /etc/Caddyfile
COPY index.html /srv/index.html
# COPY package.json /etc/package.json
# install process wrapper
COPY --from=builder /install/parent /bin/parent
ADD docker-entrypoint.sh /
ADD caddy.sh /
ADD client.sh /
EXPOSE 443 80
ENTRYPOINT ["/docker-entrypoint.sh"]

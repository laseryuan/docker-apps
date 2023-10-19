# Reference:
# https://github.com/tdicola/caddy-docker/blob/master/Dockerfile.arm32v6
# https://github.com/pengchujin/v2rayDocker/blob/master/Dockerfile
# --------------

# Build Caddy
FROM {{ARCH.images.build_base}} as caddy_builder
# Final stage
FROM {{ARCH.images.base}}

# Install V2ray
ENV V2RAY_VERSION {{IMAGE_VERSION}}
ENV V2RAY_LOG_DIR /var/log/v2ray
ENV V2RAY_CONFIG_DIR /etc/v2ray/

{{#ARCH.is_amd}}
ENV V2RAY_PACKAGE_NAME v2ray-linux-64.zip
{{/ARCH.is_amd}}
{{#ARCH.is_arm}}
ENV V2RAY_PACKAGE_NAME v2ray-linux-arm.zip
{{/ARCH.is_arm}}

ENV V2RAY_DOWNLOAD_URL https://github.com/v2ray/v2ray-core/releases/download/${V2RAY_VERSION}/${V2RAY_PACKAGE_NAME}
ENV TZ="Asia/Shanghai"

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

# install node
RUN apk add --no-cache util-linux
RUN apk add --update nodejs npm
COPY package.json /srv/package.json
RUN  npm install
COPY  v2ray.js /srv/v2ray.js


RUN apk add --no-cache openssh-client git

# install caddy
COPY --from=caddy_builder /usr/bin/caddy /usr/bin/caddy

# validate caddy install
RUN /usr/bin/caddy version
RUN /usr/bin/caddy list-modules

VOLUME /root/.caddy /srv

COPY Caddyfile /etc/Caddyfile
COPY index.html /srv/index.html
COPY package.json /etc/package.json

# install process wrapper
COPY tmpl/ /etc/v2ray/tmpl/
COPY docker-entrypoint.sh /

# validate v2ray install
RUN /usr/bin/v2ray -version

EXPOSE 443 80
ENTRYPOINT ["/docker-entrypoint.sh"]

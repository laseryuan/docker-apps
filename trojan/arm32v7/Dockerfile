# https://github.com/Yun-Mao/caddy_docker
# Build Caddy
FROM lasery/caddy as caddy_builder

# Build Trojan
FROM alpine:latest AS trojan_builder
WORKDIR /root
RUN set -ex \
      && VERSION="v1.15.1" \
      && apk add --no-cache git build-base make cmake boost-dev openssl-dev mariadb-connector-c-dev \
      && git clone --branch ${VERSION} --single-branch https://github.com/trojan-gfw/trojan.git \
      && cd trojan \
      && cmake . \
      && make \
      && strip -s trojan

# Final stage
# Install caddy
FROM alpine:latest

COPY --from=caddy_builder /install/caddy /usr/bin/caddy

RUN /usr/bin/caddy -version
RUN /usr/bin/caddy -plugins

# Install trojan
ENV TZ=Asia/Shanghai

RUN set -ex \
  && apk add --no-cache tzdata ca-certificates libstdc++ boost-system boost-program_options mariadb-connector-c

COPY --from=trojan_builder /root/trojan/trojan /usr/bin

COPY tmpl/ /etc/trojan/tmpl/
COPY docker-entrypoint.sh /

EXPOSE 443 80
ENTRYPOINT ["/docker-entrypoint.sh"]

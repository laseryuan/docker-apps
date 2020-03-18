FROM debian:stretch-20200224

RUN apt-get update -qy && apt-get install -qy \
      build-essential autoconf libtool libssl-dev libpcre3-dev asciidoc xmlto libz-dev \
      iptables iproute2 \
      --no-install-recommends \
      && rm -rf /var/lib/apt/lists/*

ADD ./ssr-libev-2.5.3.tar.gz /tmp/
RUN mv /tmp/shadowsocksr-libev-2.5.3 /root/shadowsocksr-libev

WORKDIR /root/shadowsocksr-libev

RUN ./configure && make
RUN make install

# Development
# RUN apt-get install -y \
  # curl \
  # dnsutils \
  # netcat \
  # --no-install-recommends

WORKDIR /root/app/

STOPSIGNAL SIGTERM
COPY docker-entrypoint.sh /
COPY README.md /
ENTRYPOINT ["/docker-entrypoint.sh"]

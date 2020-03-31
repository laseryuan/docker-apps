#!/bin/bash

# SIGTERM-handler
term_handler() {
  clean_docker
  echo "Trying to restore iptables ..."
  iptables-restore < ~/iptables.backup
  echo "Done"
  exit 143; # 128 + 15 -- SIGTERM
}

clean_docker() {
  echo "Shutting down the container."
  docker rm -f shadowsocksr-cli || true
}

start_ssr_cli() {
  echo "Start SSR client..."
  docker run -d \
    --name shadowsocksr-cli \
    --net=host \
    -e TPROXY_PORT=${TPROXY_PORT} \
    -e VERBOSE=TRUE \
    -e SERVER_IP=${SERVER_IP} -e SERVER_PORT=${SERVER_PORT} -e SERVER_PASSWORD=MY_SSPASSWORD \
    lasery/shadowsocksr:arm32-20.03 \
    client
}

sysctl -w net.ipv4.ip_forward=1

  # -p ${TPROXY_PORT}:${TPROXY_PORT} \
  # -p ${TPROXY_PORT}:${TPROXY_PORT}/udp \

  # --cap-add=NET_ADMIN \
  # --cap-add=NET_RAW \

# backup current iptables
iptables-save > ~/iptables.backup

clean_docker

start_ssr_cli
sleep 5

trap 'term_handler' SIGHUP SIGINT SIGTERM

if [[ -n $Gateway ]]; then
    echo "Set the gateway ..."
    echo "Disalbe the eth0 gateway..."
    ip route delete default via 192.168.8.1
    echo "Done"
fi

if [ -z $SERVER_IP ]; then
    echo "Get server ip..."
    SERVER_IP=`curl http://119.29.29.29/d?dn=$SERVER_NAME`
    echo "$SERVER_NAME: $SERVER_IP"
    export SERVER_IP
fi

echo "Setting up network..."
./ssr-iptables.sh
echo "Done"

tail -f /dev/null

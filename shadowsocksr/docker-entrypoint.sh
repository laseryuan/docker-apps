#!/bin/bash
# vim: set noswapfile :

main() {
  echo VERBOSE: $VERBOSE SERVER_NAME:$SERVER_NAME SERVER_IP:$SERVER_IP SERVER_PORT:$SERVER_PORT SERVER_PASSWORD:$SERVER_PASSWORD PROXY_PORT:$PROXY_PORT METHOD:$METHOD PROTOCOL:$PROTOCOL
  case "$1" in
    server)
      check-restart
      run-server
      ;;
    client)
run-client
      ;;
    help)
cat /README.md
      ;;
    *)
      exec "$@"
      ;;
  esac
}

run-client() {
  echo "Starting SSR client ..."
  ss-local \
  -u \
  `[ "$VERBOSE" = "TRUE"  ] && echo "-v"` \
  -l $PROXY_PORT -m aes-256-cfb -b 0.0.0.0 \
  -O origin \
  -s $SERVER_IP -p $SERVER_PORT -k $SERVER_PASSWORD
}

run-server() {
    cd /root/shadowsocksr/ && python shadowsocks/server.py
}

check-restart() {
  read-param
  write-config
}

read-param() {
  echo "The server will work on port 8388, please expose this port from docker"
  [ -z ${SERVER_PASSWORD+x} ] && read -p 'Sever password (default: MY_SSPASSWORD): ' SERVER_PASSWORD && SERVER_PASSWORD=${SERVER_PASSWORD:-MY_SSPASSWORD} && echo $SERVER_PASSWORD
  [ -z ${METHOD+x} ] && read -p 'Method (default: aes-256-cfb): ' METHOD && METHOD=${METHOD:-aes-256-cfb} && echo $METHOD
  [ -z ${PROTOCOL+x} ] && read -p 'PROTOCOL (default: origin): ' PROTOCOL && PROTOCOL=${PROTOCOL:-origin} && echo $PROTOCOL
}

write-config() {
  CONFIG_FILE=/root/shadowsocksr/user-config.json
  sed -i "s/<password>/${SERVER_PASSWORD}/" $CONFIG_FILE
  sed -i "s/<method>/${METHOD}/" $CONFIG_FILE
  sed -i "s/<protocol>/${PROTOCOL}/" $CONFIG_FILE
}

main "$@"

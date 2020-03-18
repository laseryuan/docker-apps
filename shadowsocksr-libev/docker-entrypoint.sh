#!/bin/bash
# vim: set noswapfile :

main() {
  case "$1" in
    start)
run-start
      ;;
    help)
cat /README.md
      ;;
    *)
      exec "$@"
      ;;
  esac
}

run-start() {
  echo "Starting SSR client..."
  echo VERBOSE: $VERBOSE SERVER_NAME:$SERVER_NAME SERVER_IP:$SERVER_IP SERVER_PORT:$SERVER_PORT SERVER_PASSWORD:$SERVER_PASSWORD TPROXY_PORT:$TPROXY_PORT
  ss-redir \
  -u \
  `[ "$VERBOSE" = "TRUE"  ] && echo "-v"` \
  -l $TPROXY_PORT -m aes-256-cfb -b 0.0.0.0 \
  -O origin \
  -s $SERVER_IP -p $SERVER_PORT -k $SERVER_PASSWORD & wait
}

main "$@"


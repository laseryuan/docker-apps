#!/bin/bash
# vim: set noswapfile :

main() {
echo VERBOSE: $VERBOSE SERVER_NAME:$SERVER_NAME SERVER_IP:$SERVER_IP SERVER_PORT:$SERVER_PORT SERVER_PASSWORD:$SERVER_PASSWORD PROXY_PORT:$PROXY_PORT
  case "$1" in
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
  echo "Starting SSR client..."
  ss-local \
  -u \
  `[ "$VERBOSE" = "TRUE"  ] && echo "-v"` \
  -l $PROXY_PORT -m aes-256-cfb -b 0.0.0.0 \
  -O origin \
  -s $SERVER_IP -p $SERVER_PORT -k $SERVER_PASSWORD
}

main "$@"


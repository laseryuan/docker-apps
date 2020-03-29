#!/bin/bash
# vim: set noswapfile :

main() {
  case "$1" in
    server)
shift
/caddy.sh "$@"
      ;;
    client)
      client-config
      /usr/bin/v2ray -config /etc/v2ray/config.json
      ;;
    help)
      cat /README.md
      ;;
    *)
      exec "$@"
      ;;
  esac
}

client-config() {
  [[ "${DEBUG}" == "true" ]] && loglevel='debug' || loglevel="warning"
  [ -z "${SOCKS_PORT}" ] && socks_port='1080' || socks_port="${SOCKS_PORT}"
  [ -z "${WS_PATH}" ] && ws_path='/one' || ws_path="${WS_PATH}"
  [ -z "${DOMAIN}" ] && { echo "Need to defaine DOMAIN !"; return 1; } || domain="${DOMAIN}"
  [ -z "${V2RAY_ID}" ] && ( echo "Need to defaine V2RAY_ID !"; return 1; ) || v2ray_id="${V2RAY_ID}"

  sed \
    -e "s|\${loglevel}|${loglevel}|" \
    -e "s|\${socks_port}|${socks_port}|" \
    -e "s|\${ws_path}|${ws_path}|" \
    -e "s|\${domain}|${domain}|" \
    -e "s|\${v2ray_id}|${v2ray_id}|" \
      /etc/v2ray/tmpl/client.tmpl.json > /etc/v2ray/config.json

  cat /etc/v2ray/config.json
}

main "$@"

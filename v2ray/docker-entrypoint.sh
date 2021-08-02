#!/bin/sh
# vim: set noswapfile :

main() {
  case "$1" in
    server)
      caddy_config
      server_config
      copy_web_pages
      server_run
      ;;
    client)
      client_config
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

server_run() {
  caddy run --config /etc/Caddyfile &
  echo "配置 JSON 详情"
  echo " "
  cat /etc/v2ray/config.json
  echo " "
  node v2ray.js
  /usr/bin/v2ray -config /etc/v2ray/config.json
}

caddy_config() {
  [ -z "${DOMAIN}" ] && { echo "Need to defaine DOMAIN !"; return 1; } || domain="${DOMAIN}"
  [ -z "${WS_PATH}" ] && ws_path='/one' || ws_path="${WS_PATH}"
  [[ "${DEBUG}" == "true" ]] && loglevel='DEBUG' || loglevel="INFO"

  sed \
    -e "s|\${loglevel}|${loglevel}|" \
    -e "s|\${domain}|${domain}|" \
    -e "s|\${ws_path}|${ws_path}|" \
      /etc/v2ray/tmpl/Caddyfile.tmpl > /etc/Caddyfile

  cat /etc/Caddyfile
}

server_config() {
  [ -z "${V2RAY_ID}" ] && ( echo "Need to defaine V2RAY_ID !"; return 1; ) || v2ray_id="${V2RAY_ID}"
  [ -z "${DOMAIN}" ] && { echo "Need to defaine DOMAIN !"; return 1; } || domain="${DOMAIN}"

  [[ "${DEBUG}" == "true" ]] && loglevel='debug' || loglevel="warning"
  [ -z "${WS_PATH}" ] && ws_path='/one' || ws_path="${WS_PATH}"
  [ -z "${PS_NAME}" ] && psname='V2RAY_WS' || psname="${PS_NAME}"

  sed \
    -e "s|\${v2ray_id}|${v2ray_id}|" \
    -e "s|\${loglevel}|${loglevel}|" \
    -e "s|\${ws_path}|${ws_path}|" \
      /etc/v2ray/tmpl/server.tmpl.json > /etc/v2ray/config.json

  cat /etc/v2ray/config.json

  sed \
    -e "s|\${domain}|${domain}|" \
    -e "s|\${ws_path}|${ws_path}|" \
    -e "s|\${v2ray_id}|${v2ray_id}|" \
    -e "s|\${psname}|${psname}|" \
      /etc/v2ray/tmpl/sebs.tmpl.js > /srv/sebs.js

  cat /srv/sebs.js
}

client_config() {
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

copy_web_pages() {
  if [ "$(ls -A /tmp/web)" ]; then
     echo "Copying web contents ..."
     cp -a /tmp/web/* /srv/
  fi
}

main "$@"

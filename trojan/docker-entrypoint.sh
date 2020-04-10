#!/bin/sh
# vim: set noswapfile :

main() {
  case "$1" in
    server)
      caddy_config
      server_config
      caddy --conf /etc/Caddyfile --log stdout --agree &
      sleep 5
      trojan -c /etc/trojan/config.json
      ;;
    client)
shift
      ;;
    help)
      cat /README.md
      ;;
    *)
      exec "$@"
      ;;
  esac
}

caddy_config() {
  [ -z "${DOMAIN}" ] && { echo "Need to defaine DOMAIN !"; return 1; } || domain="${DOMAIN}"

  # [[ "${DEBUG}" == "true" ]] && log_level='0' || log_level="1"
  # [ -z "${PASSWORDS}" ] && password='["my_trojan_pass"]' || password="${PASSWORDS}"

  sed \
    -e "s|\${domain}|${domain}|" \
      /etc/trojan/tmpl/Caddyfile.tmpl > /etc/Caddyfile

  cat /etc/Caddyfile
}

server_config() {
  [ -z "${DOMAIN}" ] && { echo "Need to defaine DOMAIN !"; return 1; } || domain="${DOMAIN}"

  [[ "${DEBUG}" == "true" ]] && log_level='0' || log_level="1"
  [ -z "${PASSWORDS}" ] && password='["my_trojan_pass"]' || password="${PASSWORDS}"

  sed \
    -e "s/\${domain}/${domain}/g" \
    -e "s|\${log_level}|${log_level}|" \
    -e "s|\${password}|${password}|" \
      /etc/trojan/tmpl/server.tmpl.json > /etc/trojan/config.json

  cat /etc/trojan/config.json
}

main "$@"

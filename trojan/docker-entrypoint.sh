#!/bin/sh
# vim: set noswapfile :

main() {
  case "$1" in
    caddy)
      caddy --conf /caddy/Caddyfile --log stdout --agree
      ;;
    server)
      server_config
      trojan -c /etc/trojan/config.json
      ;;
    client)
shift
copy_web_pages
      ;;
    help)
      cat /README.md
      ;;
    *)
      exec "$@"
      ;;
  esac
}

server_config() {
  [[ "${DEBUG}" == "true" ]] && log_level='0' || log_level="1"
  [ -z "${PASSWORDS}" ] && password='["my_trojan_pass"]' || password="${PASSWORDS}"

  sed \
    -e "s|\${log_level}|${log_level}|" \
    -e "s|\${password}|${password}|" \
      /etc/trojan/tmpl/server.tmpl.json > /etc/trojan/config.json

  cat /etc/trojan/config.json
}

copy_web_pages() {
  if [ "$(ls -A /tmp/web)" ]; then
     echo "Copying web contents ..."
     cp -a /tmp/web/* /srv/
  fi
}

main "$@"

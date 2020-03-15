#!/bin/bash
# vim: set noswapfile :

main() {
  case "$1" in
    server)
shift
/caddy.sh "$@"
      ;;
    client)
shift
/client.sh "$@"
      ;;
    help)
cat /README.md
      ;;
    *)
      exec "$@"
      ;;
  esac
}

main "$@"



#!/bin/bash
# vim: set noswapfile :

main() {
  case "$1" in
    run)
/etc/init.d/dbus start # docker exec -it -u root roblox-dev
      ;;
    help)
      run-help
      ;;
    *)
      exec "$@"
      ;;
  esac
}

run-help() {
cat /README.md
}

main "$@"



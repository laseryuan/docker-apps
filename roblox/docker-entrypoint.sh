#!/bin/bash
# vim: set noswapfile :

main() {
  /etc/init.d/dbus start
  case "$1" in
    run)
      minecraft-launcher
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



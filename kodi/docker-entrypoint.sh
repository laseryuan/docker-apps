#!/bin/bash
# vim: set noswapfile :

main() {
  case "$1" in
    run)
      kodi
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



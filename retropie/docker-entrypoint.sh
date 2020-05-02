#!/bin/bash
# vim: set noswapfile :

main() {
  case "$1" in
    run)
      emulationstation
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


#!/bin/bash
# vim: set noswapfile :

main() {
  case "$1" in
    run)
      tail -f /dev/null
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



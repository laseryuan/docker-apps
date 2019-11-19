#!/bin/bash
# vim: set noswapfile :

main() {
  case "$1" in
    init)
mkdir /home/mindustry/.config
      ;;
    run)
/tmp/Mindustry
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



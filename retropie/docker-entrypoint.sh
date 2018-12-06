#!/bin/bash
# vim: set noswapfile :

main() {
  case "$1" in
    help)
      run-help
      ;;
    *)
      exec "$@"
      ;;
  esac
}

run-help() {
  echo 'docker run -it --rm --name=retropie \
    --privileged \
    -e DISPLAY=unix:0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /var/run/dbus/:/var/run/dbus/ \
    -v ~/.emulationstation:/home/retropie/.emulationstation \
    lasery/retropie \
    emulationstation'
}

main "$@"


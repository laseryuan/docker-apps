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
  echo 'docker run -it --rm --name="chromium" \
    --net=host \
    -e DISPLAY=:0 \
    --privileged \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /opt/vc:/opt/vc \
    -v /dev/vchiq:/dev/vchiq \
    -v /dev/vcio:/dev/vcio \
    -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
    -v /dev/shm:/dev/shm \
    lasery/chromium \
    chromium-browser'
}

main "$@"


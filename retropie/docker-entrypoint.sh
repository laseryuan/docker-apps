#!/bin/bash
# vim: set noswapfile :

main() {
  case "$1" in
    run)
      emulationstation
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
  echo 'On ubuntu:'
  echo 'docker run -it --rm --name=retropie \
    --privileged \
    -e DISPLAY=unix:0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /var/run/dbus/:/var/run/dbus/ \
    -v ~/.emulationstation:/home/retropie/.emulationstation \
    lasery/retropie \
    emulationstation'
  echo
  echo 'On raspberry pi:'
  echo '
    docker run -it --rm --name=retropie \
      --privileged \
      -v /opt/vc:/opt/vc \
      -e PULSE_SERVER=unix:/run/user/1000/pulse/native -v /run/user/1000:/run/user/1000 \
      -v ~/.emulationstation:/home/retropie/.emulationstation \
      -v ~/.config/retroarch/autoconfig:/opt/retropie/configs/all/retroarch/autoconfig/ \
      --group-add video \
      -v /var/run/dbus/:/var/run/dbus/ \
      -v ~/.Xauthority:/home/retropie/.Xauthority:ro \
      -v /dev/shm:/dev/shm \
      -v /dev/snd:/dev/snd \
      -v /dev/input:/dev/input \
      -v /dev/vchiq:/dev/vchiq \
      -v /dev/vcio:/dev/vcio \
      -v /dev/fb0:/dev/fb0 \
      -v /dev/vcsm:/dev/vcsm \
      lasery/${REPO}:${TAG} \
  '
}

main "$@"


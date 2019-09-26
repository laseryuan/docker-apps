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
  echo '
  On x86:
docker run -it --name=retropie `# --rm: for debug` \
  --privileged \
  -e DISPLAY=unix:0 -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native -v /run/user/1000:/run/user/1000 \
  -v /dev/input:/dev/input \
  -v ~/.emulationstation:/home/pi/.emulationstation \
  -v ~/.config/retroarch/autoconfig:/opt/retropie/configs/all/retroarch/autoconfig/ \
  -v ~/.config/retropie/configs/all/retroarch.cfg:/opt/retropie/configs/all/retroarch.cfg \
  lasery/retropie \
  emulationstation

  On raspberry pi:
docker run -it --name=retropie `# --rm: for debug` \
  --name=retropie \
  --privileged \
  -v /opt/vc:/opt/vc \
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native -v /run/user/1000:/run/user/1000 \
  --group-add video \
  -v /var/run/dbus/:/var/run/dbus/ \
  -v /dev/shm:/dev/shm \
  -v /dev/snd:/dev/snd \
  -v /dev/input:/dev/input \
  -v /dev/vchiq:/dev/vchiq \
  -v /dev/vcio:/dev/vcio \
  -v /dev/fb0:/dev/fb0 \
  -v /dev/vcsm:/dev/vcsm \
  lasery/retropie \
  emulationstation

  Use custom roms:
read -p "docker volume or local drive path: " roms_volume && echo $roms_volume
  -v {roms_volume}:/home/pi/RetroPie/roms \

  Save configurations:
  -v ~/.config/retropie/emulationstation:/home/retropie/.emulationstation \
  -v ~/.config/retropie/autoconfig:/opt/retropie/configs/all/retroarch/autoconfig/ \
  -v ~/.config/retropie/retroarch.cfg:/opt/retropie/configs/all/retroarch.cfg \
  '
}

main "$@"


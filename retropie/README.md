# Usage
```
docker run --rm lasery/retropie
```

### Raspberry pi
Retropie default built doesn't use x server, it needs to run in non-desktop environment:
```
docker run -it --rm --name=retropie \
  --privileged \
  --group-add video \
  -v /dev/snd:/dev/snd \
  -v /dev/input:/dev/input \
  -v /dev/vchiq:/dev/vchiq \
  -v /dev/vcio:/dev/vcio \
  -v /dev/fb0:/dev/fb0 \
  -v /dev/vcsm:/dev/vcsm \
  lasery/retropie \
  run

  bash
```

### amd64
```
docker run -it --rm --name=retropie \
  --privileged \
  -e DISPLAY=unix:0 -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native -v /run/user/1000:/run/user/1000 \
  -v /dev/input:/dev/input \
  lasery/retropie \
  run

  bash
```

## Data storage
```
  -v retropie_roms:/home/pi/RetroPie/roms \
  -v ~/.config/retropie/emulationstation/:/home/pi/.emulationstation/ \
  -v ~/.config/retropie/autoconfig/:/opt/retropie/configs/all/retroarch/autoconfig/ \
  -v ~/.config/retropie/retroarch.cfg:/opt/retropie/configs/all/retroarch.cfg \
```

# Development
```
cd ~/projects/docker-apps/retropie

  emulationstation
```

RetroArch
```
cd /opt/retropie/emulators/retroarch/bin/
./retroarch -v
```

Test joystick
```
cat /dev/input/js0
jstest /dev/input/js0
```

## Build image
```
append "skip" to skip compile bake and dockerfiles
utils/build.py docker
utils/build.py push
utils/build.py deploy
```

# Issues
- joystick-selection
Can not be run from emulationstation
Work around:
Remove all containt in /opt/retropie/configs/all/joystick-selection.cfg
```
sudo ~/RetroPie-Setup/retropie_setup.sh
-> Manage packages
-> Manage experimental packages
-> joystick-selection
-> Configuration / Options
```

- cross build
Cross build not working due to not able to switch user to pi to run the script
The local version could work

- udev joypad driver
https://stackoverflow.com/questions/49687378/how-to-get-hosts-udev-events-from-a-docker-container
udev joypad driver is not working properly. For it to work, need to use
--net host and replug in the usb controller every time start retroarch:

```
  --net host \
  -v /run/udev/control:/run/udev/control \
```

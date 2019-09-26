# Usage
```
docker pull lasery/retropie

docker run --rm lasery/retropie help
```

# Development

## Set variables
```
REPO=retropie && VERSION=19.09 cd ~/projects/docker-apps/${REPO}
bash build.sh
```

## Build image
```
docker buildx bake
```

## Development
```
  emulationstation
```

### amd64
```
docker run -it --rm --name=${REPO} \
  --privileged \
  -e DISPLAY=unix:0 -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native -v /run/user/1000:/run/user/1000 \
  -v /dev/input:/dev/input \
  lasery/${REPO}:${VERSION}-amd64 \
  bash
```

### arm32
Since retropie default built doesn't use x server, it needs to run in non-desktop environment:
```
docker run -it --rm --name=${REPO} \
  --privileged \
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native -v /run/user/1000:/run/user/1000 \
  --group-add video \
  -v /opt/vc:/opt/vc \
  -v /var/run/dbus/:/var/run/dbus/ \
  -v /dev/shm:/dev/shm \
  -v /dev/snd:/dev/snd \
  -v /dev/input:/dev/input \
  -v /dev/vchiq:/dev/vchiq \
  -v /dev/vcio:/dev/vcio \
  -v /dev/fb0:/dev/fb0 \
  -v /dev/vcsm:/dev/vcsm \
  lasery/${REPO}:${VERSION}-arm32 \
  bash
```

## Run
```
  -v retropie_roms:/home/pi/RetroPie/roms \
  -v ~/.config/retropie/emulationstation/:/home/pi/.emulationstation/ \
  -v ~/.config/retropie/autoconfig/:/opt/retropie/configs/all/retroarch/autoconfig/ \
  -v ~/.config/retropie/retroarch.cfg:/opt/retropie/configs/all/retroarch.cfg \
```

## Multiple Archi
```
docker push lasery/${REPO}:${VERSION}-amd64 lasery/${REPO}:${VERSION}-arm32

export DOCKER_CLI_EXPERIMENTAL=enabled
docker manifest create lasery/${REPO} lasery/${REPO}:$VERSION-amd64 lasery/${REPO}:$VERSION-arm32

docker manifest annotate lasery/${REPO} lasery/${REPO}:$VERSION-amd64 --arch amd64
docker manifest annotate lasery/${REPO} lasery/${REPO}:$VERSION-arm32 --arch arm
docker manifest push -p lasery/${REPO}
docker manifest inspect lasery/${REPO}
```

## Start the program
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

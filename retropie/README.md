# Usage
```
docker pull lasery/retropie

docker run --rm lasery/retropie help
```

# Development

## Set variables
```
REPO=retropie && VERSION=19.01
echo $REPO && echo $VERSION

cd ~/projects/docker-app/${REPO}
bash build.sh
```

## Build image
- Docker cloud auto-build
```
curl --request POST https://cloud.docker.com/api/build/v1/source/ea7f7b29-3a3d-4f8e-85e5-fca62d32ed48/trigger/20813066-311b-468a-8471-717033da68e9/call/
```
- Local
```
ARCH=amd64
IS_CROSS_BUILD=

ARCH=arm32v6
IS_CROSS_BUILD=true

TAG=${VERSION}-${ARCH}`if [ \"$IS_CROSS_BUILD\" = \"true\" ]; then echo -cross; fi`

echo $TAG && echo $IS_CROSS_BUILD

docker build \
  -t lasery/${REPO}:${TAG} \
  -f Dockerfile.${ARCH}$(if [ \"$IS_CROSS_BUILD\" = \"true\" ]; then echo .cross; fi) \
  .

  --cache-from lasery/${REPO} \
  --cache-from lasery/${REPO}:${TAG} \

docker push lasery/${REPO}:${TAG}
```

### amd64
```
docker run -it --name=${REPO}-dev \
  --privileged \
  -e DISPLAY=unix:0 -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native -v /run/user/1000:/run/user/1000 \
  -v /dev/input:/dev/input \
  -v retropie_roms:/home/retropie/RetroPie/roms \
  -v ~/.config/retropie/emulationstation/:/home/retropie/.emulationstation/ \
  -v ~/.config/retropie/autoconfig/:/opt/retropie/configs/all/retroarch/autoconfig/ \
  -v ~/.config/retropie/retroarch.cfg:/opt/retropie/configs/all/retroarch.cfg \
  -v ~/.config/retropie/joystick-selection.cfg:/opt/retropie/configs/all/joystick-selection.cfg \
  lasery/${REPO}:${TAG} \
  bash

  emulationstation

docker rm ${REPO}-dev
```

### arm32
Since retropie default built doesn't use x server, it needs to run in non-desktop environment:
```
docker run -it --rm --name=${REPO} \
  --privileged \
  -v /opt/vc:/opt/vc \
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native -v /run/user/1000:/run/user/1000 \
  -v retropie_roms:/home/retropie/RetroPie/roms \
  -v ~/.config/retropie/emulationstation/:/home/retropie/.emulationstation/ \
  -v ~/.config/retropie/autoconfig/:/opt/retropie/configs/all/retroarch/autoconfig/ \
  -v ~/.config/retropie/retroarch.cfg:/opt/retropie/configs/all/retroarch.cfg \
  --group-add video \
  -v /var/run/dbus/:/var/run/dbus/ \
  -v /dev/shm:/dev/shm \
  -v /dev/snd:/dev/snd \
  -v /dev/input:/dev/input \
  -v /dev/vchiq:/dev/vchiq \
  -v /dev/vcio:/dev/vcio \
  -v /dev/fb0:/dev/fb0 \
  -v /dev/vcsm:/dev/vcsm \
  lasery/${REPO}:${TAG} \
  bash
```

## Multiple Archi
```
export DOCKER_CLI_EXPERIMENTAL=enabled
docker manifest create lasery/${REPO} lasery/${REPO}:$VERSION-amd64 lasery/${REPO}:$VERSION-arm32v6

docker manifest annotate lasery/${REPO} lasery/${REPO}:$VERSION-amd64 --arch amd64
docker manifest annotate lasery/${REPO} lasery/${REPO}:$VERSION-arm32v6 --arch arm
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

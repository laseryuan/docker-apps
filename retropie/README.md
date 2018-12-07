# Usage
```
docker pull lasery/retropie

docker run --rm lasery/retropie help
```

# Development

## Set variables
```
REPO=retropie

ARCH=amd64 && DEBIAN_IMG=debian:stretch-20181112-slim
ARCH=arm32v6 && DEBIAN_IMG=resin/raspberry-pi-debian:stretch-20181024

VERSION=18.12 && TAG=${VERSION}-${ARCH}
echo $VERSION && echo $TAG && echo $DEBIAN_IMG
cd ~/projects/docker-app/${REPO}
```


## Start the program
amd64
```
mkdir ~/.emulationstation
mkdir -p ~/.config/retroarch/autoconfig
mkdir -p ~/.config/retropie/configs/all

docker run -it --rm --name=${REPO} \
  --privileged \
  -e DISPLAY=unix:0 -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native -v /run/user/1000:/run/user/1000 \
  -v /dev/input:/dev/input \
  -v ~/.emulationstation:/home/retropie/.emulationstation \
  -v ~/.config/retroarch/autoconfig:/opt/retropie/configs/all/retroarch/autoconfig/ \
  -v ~/.config/retropie/configs/all/retroarch.cfg:/opt/retropie/configs/all/retroarch.cfg \
  -v '/mnt/raid1/Data/VirtualBox VMs/share/Backup/RetroPie_roms/RetroPie/roms':/home/retropie/RetroPie/roms \
  lasery/${REPO}:${TAG} \
  emulationstation

  bash
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

arm32
```
docker run -it --rm --name="retropie" \
  --net=host \
  -e DISPLAY=unix:0 \
  --privileged \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /opt/vc:/opt/vc \
  -v /dev/vchiq:/dev/vchiq \
  -v /dev/vcio:/dev/vcio \
  -v /var/run/dbus/:/var/run/dbus/ \
  -v /dev/shm:/dev/shm \
  lasery/${REPO}:${TAG} \
  retropie-browser

  bash
```

## Build image
```
docker build \
  --build-arg debian=${DEBIAN_IMG} \
  --build-arg arch=${ARCH} \
  -t lasery/${REPO}:${TAG} \
  .

  --cache-from lasery/${REPO}:${TAG} \

docker push lasery/${REPO}:${TAG}
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

# Issues
https://stackoverflow.com/questions/49687378/how-to-get-hosts-udev-events-from-a-docker-container
udev joypad driver is not working properly. For it to work, need to use
--net host and replug in the usb controller every time start retroarch:

```
  --net host \
  -v /run/udev/control:/run/udev/control \
```

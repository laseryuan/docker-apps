# Usage
```
docker pull lasery/chromium

docker run --rm lasery/chromium help
```

# Development

## Set variables
```
REPO=chromium

ARCH=amd64 && DEBIAN_IMG=debian:stretch-20181112-slim
ARCH=arm32v6 && DEBIAN_IMG=resin/raspberry-pi-debian:stretch-20181024

VERSION=18.12 && TAG=${VERSION}-${ARCH} && echo $VERSION && echo $TAG && echo $DEBIAN_IMG
cd ~/projects/docker-app/${REPO}
```


## Start the program
amd64
```
docker run -it --rm --name="chromium" \
  --net=host \
  -e DISPLAY=unix:0 -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native -v /run/user/1000/pulse:/run/user/1000/pulse \
  --privileged \
  -v /var/run/dbus/:/var/run/dbus/ \
  -v /dev/shm:/dev/shm \
  lasery/${REPO}:${TAG} \
  chromium
```

arm32
```
docker run -it --rm --name="chromium" \
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
  chromium-browser

  bash

  -e DISPLAY -v /home/pi/.Xauthority:/home/chrome/.Xauthority:ro \

  -v /etc/fonts/ \

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

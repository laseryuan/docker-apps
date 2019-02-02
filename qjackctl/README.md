# Usage
```
docker pull lasery/qjackctl
```

# Development

## Set enviornment
```
REPO=qjackctl && VERSION=19.01
echo $REPO && echo $VERSION

cd ~/projects/docker-app/${REPO}
```

## Build image
- Docker cloud auto-build
```
curl --request POST https://cloud.docker.com/api/build/v1/source/ec8fe9e1-10e5-4ebd-8383-1a9aa6254d94/trigger/3ddf7afd-b2b8-4b4e-8136-64b49481bbac/call/
```

- Local
```
TAG=${VERSION}
echo $TAG

docker build \
  -t lasery/${REPO}:${TAG} \
  .

```

## Start the program
```
docker volume create qjackctl-config_dev

docker run -it --rm --name qjackctl_dev \
  --privileged \
  -e DISPLAY=unix:0 -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v /run/dbus/:/run/dbus/ \
  -v /dev:/dev \
  -v /dev/bus/usb:/dev/bus/usb \
  -v /etc/machine-id:/etc/machine-id \
  -v /dev/snd:/dev/snd \
  -v /dev/shm:/dev/shm \
  --ulimit rtprio=99 \
  --cap-add=sys_nice  \
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native -v /run/user/1000:/run/user/1000 \
  lasery/qjackctl \
  bash

  qjackctl

  -v qjackctl-config_dev:/home/qjackctl/.config \

  -v $(pwd)/config/jackdrc:/home/qjackctl/.jackdrc \
  -v $(pwd)/config/patchbay/:/home/qjackctl/patchbay/ \
  -v $(pwd)/config/QjackCtl.conf:/home/qjackctl/.config/rncbc.org/QjackCtl.conf \
  --cpu-rt-runtime=950000 \
  -v $(pwd)/config/jack/:/home/qjackctl/.config/jack/ \
  -v /var/run/dbus/:/var/run/dbus/ \

qjackctl
jackd -d dummy
```

## Docker Multi-Architecture Deploy
```
export DOCKER_CLI_EXPERIMENTAL=enabled
docker manifest create lasery/${REPO} lasery/${REPO}:$VERSION
docker manifest push -p lasery/${REPO}
docker manifest inspect lasery/${REPO}
```

Docker Multi-Architecture Images

Works for both amd64 (Ubuntu) and arm32v6 (Rapsberry Pi)

# Usage
```
docker pull lasery/kodi
docker run --rm lasery/kodi
```

# Development

## Set enviornment
```
export REPO=kodi && export VERSION=19.10 && cd ~/projects/docker-apps/${REPO}
```

## Build image
```
export DOCKER_CLI_EXPERIMENTAL=enabled
./build.sh docker
docker buildx bake \
  amd64

  --cache-from lasery/${REPO} \
```

## Start the program
```
docker volume create \
  ${REPO}-config

docker run -it --rm --name=${REPO}-dev \
  --privileged \
  --gpus all \
  -v /dev:/dev \
  -e DISPLAY=unix:0 -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native -v /run/user/1000:/run/user/1000 \
  -v /dev/input:/dev/input \
  ${REPO} \
  bash

  -v kodi-config:/home/kodi/.kodi/userdata \

docker run -it --rm --name="$REPO"-dev \
  --privileged \
  --tmpfs /tmp/ \
  -v ${REPO}-config:/home/${REPO}/.config \
  -v /opt/vc:/opt/vc \
  -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /var/run/dbus/:/var/run/dbus/ \
  -v /dev:/dev \
  -v /dev/snd:/dev/snd \
  -v /dev/shm:/dev/shm \
  -v /dev/input:/dev/input \
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native -v /run/user/1000:/run/user/1000 \
  -v /etc/localtime:/etc/localtime:ro \
  -v /etc/machine-id:/etc/machine-id:ro \
  --group-add video \
  ${REPO} \
  bash

  -v /dev/vchiq:/dev/vchiq \
  -v /dev/vcio:/dev/vcio \
  -v /dev/fb0:/dev/fb0 \
  -v /dev/vcsm:/dev/vcsm \
```

## Deploy image
```
./build.sh push
```

# Issues


Docker Multi-Architecture Images

Works for both amd64 (Ubuntu) and arm32v6 (Rapsberry Pi)

# Usage
```
docker run --rm lasery/kodi
```

# Development

## Set enviornment
```
cd ~/projects/docker-apps/kodi
```

## Build image
```
append "skip" to skip compile bake and dockerfiles
utils/build.py docker
utils/build.py push
utils/build.py deploy
```

## Start the program
```
docker volume create \
  --label keep \
  kodi-config

  -v $(pwd)/docker-entrypoint.sh:/docker-entrypoint.sh \

  -v /home/laser/Videos/:/home/kodi/Videos/ \
  -v kodi-config:/home/kodi/.kodi/userdata \
```

amd64
```
docker run -it --rm --name=kodi \
  --privileged \
  -e DISPLAY=unix:0 -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native -v /run/user/1000:/run/user/1000 \
  -v /var/run/dbus/:/var/run/dbus/ \
  kodi:17.6-amd64 \
  bash
```

Raspberry pi
```
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


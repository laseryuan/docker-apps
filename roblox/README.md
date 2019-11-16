Docker Multi-Architecture Images

Works for both amd64 (Ubuntu) and arm32v6 (Rapsberry Pi)

# Usage
```
docker pull lasery/roblox
docker run --rm lasery/roblox
```

# Development

## Set enviornment
```
export REPO=roblox && export VERSION=$(date "+%y.%m") && cd ~/projects/docker-apps/roblox
./build.sh docker
```

## Start the program
```
docker volume create \
  --label keep \
  roblox-config

export PULSE_SERVER=/var/run/pulse/native
```

```
docker run -it --rm --name=roblox-dev \
  -v roblox-config:/home/mc/.roblox \
  -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
  --device=/dev/dri:/dev/dri \
  -e PULSE_SERVER=unix:${PULSE_SERVER} -v ${PULSE_SERVER}:${PULSE_SERVER} \
  roblox:amd64 \
  bash
```

Nvidia
```
docker run -it --rm --name=roblox-dev \
  --gpus all \
  -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e PULSE_SERVER=unix:${PULSE_SERVER} -v ${PULSE_SERVER}:${PULSE_SERVER} \
  roblox:nvidia \
  bash

  -v roblox-config:/home/mc/.roblox \
```

## Build image
- Local
```
docker buildx bake
```

## Deploy image
```
./build.sh push
```

# Issues


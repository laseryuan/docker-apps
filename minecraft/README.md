Docker Multi-Architecture Images

Works for both amd64 (Ubuntu) and arm32v6 (Rapsberry Pi)

# Usage
```
docker pull lasery/minecraft
docker run --rm lasery/minecraft
```

# Development

## Set enviornment
```
export REPO=minecraft && export VERSION=$(date "+%y.%m") && cd ~/projects/docker-apps/minecraft
./build.sh docker
```

## Start the program
```
docker volume create \
  --label keep \
  minecraft-config

docker run -it --rm --name=minecraft-dev \
  -v minecraft-config:/home/mc/.minecraft \
  -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
  --device=/dev/dri:/dev/dri \
  minecraft:amd64 \
  bash
```

Nvidia
```
docker run -it --rm --name=minecraft-dev \
  --gpus all \
  -v minecraft-config:/home/mc/.minecraft \
  -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native -v /run/user/1000:/run/user/1000 \
  minecraft:nvidia \
  bash
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


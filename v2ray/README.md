Docker Multi-Architecture Images

Works for both amd64 (Ubuntu) and arm32v6 (Rapsberry Pi)

# Usage
```
docker pull lasery/v2ray
docker run --rm lasery/v2ray
```

# Development

## Set enviornment
```
export REPO=v2ray && export VERSION=$(date "+%y.%m") && cd ~/projects/docker-apps/v2ray
./build.sh docker
```

## Build image
```
export DOCKER_CLI_EXPERIMENTAL=enabled
docker buildx bake

  --cache-from lasery/app \
```

### Cross run
```
docker run --rm -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static -it v2ray:arm32 sh
```

## Start the program
Prepare environment
```
docker volume create \
  --label keep \
  v2ray-config

docker run --rm -v v2ray-config:/home/v2ray/ v2ray:amd64 init

export PULSE_SERVER=/run/user/1000/pulse/native

# if using system-wise pulseaudio
export PULSE_SERVER=/run/pulse/native
xhost +SI:localuser:$(id -nu 1000) # if current user id is not 1000
```

```
docker run -it --rm --name=v2ray-dev \
  -v v2ray-config:/home/v2ray/ \
  -p 6567:6567 \
  -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
  --device=/dev/dri:/dev/dri \
  -e PULSE_SERVER=unix:${PULSE_SERVER} -v ${PULSE_SERVER}:${PULSE_SERVER} \
  -v /etc/localtime:/etc/localtime:ro \
  v2ray:amd64 \
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


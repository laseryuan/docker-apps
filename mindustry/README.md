Docker Multi-Architecture Images

Works for both amd64 (Ubuntu) and arm32v6 (Rapsberry Pi)

# Usage
```
docker pull lasery/mindustry
docker run --rm lasery/mindustry
```

# Development

## Set enviornment
```
export REPO=mindustry && export VERSION=$(date "+%y.%m") && cd ~/projects/docker-apps/mindustry
./build.sh docker
```

## Start the program
Prepare environment
```
docker volume create \
  --label keep \
  mindustry-config

docker run --rm -v mindustry-config:/home/mindustry/ mindustry:amd64 init

export PULSE_SERVER=/run/user/1000/pulse/native

# if using system-wise pulseaudio
export PULSE_SERVER=/run/pulse/native
xhost +SI:localuser:$(id -nu 1000) # if current user id is not 1000
```

```
docker run -it --rm --name=mindustry-dev \
  -v mindustry-config:/home/mindustry/ \
  -p 6567:6567 \
  -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
  --device=/dev/dri:/dev/dri \
  -e PULSE_SERVER=unix:${PULSE_SERVER} -v ${PULSE_SERVER}:${PULSE_SERVER} \
  -v /etc/localtime:/etc/localtime:ro \
  mindustry:amd64 \
  bash
```

Nvidia
```
  --gpus all \
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


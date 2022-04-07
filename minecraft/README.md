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
cd minecraft
```

## Start the program
```
docker volume create \
  --label keep \
  minecraft-config

export PULSE_SERVER=/var/run/pulse/native

docker run -it --rm --name=minecraft-dev \
  -v minecraft-config:/home/mc/.minecraft \
  -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
  --device=/dev/dri:/dev/dri \
  -e PULSE_SERVER=unix:${PULSE_SERVER} -v ${PULSE_SERVER}:${PULSE_SERVER} \
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
python3 ~/mbuild/utils/build.py docker
python3 ~/mbuild/utils/build.py deploy
python3 ~/mbuild/utils/build.py push --only
python3 ~/mbuild/utils/build.py deploy --only
```

# Issues


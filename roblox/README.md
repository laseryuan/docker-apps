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
export PULSE_SERVER=/run/user/1000/pulse/native
```

```
docker run -it --rm --name=roblox-dev \
  --privileged \
  -v roblox-config:/home/roblox/ \
  -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
  --device=/dev/dri:/dev/dri \
  -e PULSE_SERVER=unix:${PULSE_SERVER} -v ${PULSE_SERVER}:${PULSE_SERVER} \
  -v /etc/localtime:/etc/localtime:ro \
  --security-opt seccomp=$(pwd)/chrome.json \
  -e USER=$(whoami) \
  roblox:amd64 \
  bash
```

Install grapejuice
```
cd /tmp/grapejuice-master && python3.7 ./install.py
/etc/init.d/dbus start
cd ~
.local/share/grapejuice/bin/grapejuice gui
```

Start Roblox
```
chromium-browser
.local/share/grapejuice/bin/grapejuice player roblox-player:
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


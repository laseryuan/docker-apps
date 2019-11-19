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
Prepare environment
```
docker volume create \
  --label keep \
  roblox-config

export PULSE_SERVER=/run/user/1000/pulse/native

# if using system-wise pulseaudio
export PULSE_SERVER=/run/pulse/native
xhost +SI:localuser:$(id -nu 1000) # if current user id is not 1000
```

```
docker run -it --rm --name=roblox-dev \
  --privileged \
  -v roblox-config:/home/roblox/ \
  -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
  --device=/dev/dri:/dev/dri \
  --device=/dev/snd:/dev/snd \
  -e PULSE_SERVER=unix:${PULSE_SERVER} -v ${PULSE_SERVER}:${PULSE_SERVER} \
  -v /etc/localtime:/etc/localtime:ro \
  --security-opt seccomp=$(pwd)/chrome.json \
  roblox:amd64 \
  bash
```

Install grapejuice
```
export USER=$(whoami)

mkdir ~/.config
cd /tmp/grapejuice-master && python3.7 ./install.py
/etc/init.d/dbus start # docker exec -it -u root roblox-dev
```

```
cd ~/.local/share/grapejuice/bin
./grapejuice gui
```

Start Roblox Studio
```
chromium-browser
https://www.roblox.com/games/1818/Classic-Crossroads
./grapejuice studio --uri roblox-studio:
```

Start Roblox player
```
chromium-browser
./grapejuice player roblox-player:
```

Fix mime error
```
cd ~/.local/share/applications/
vim roblox-player.desktop
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


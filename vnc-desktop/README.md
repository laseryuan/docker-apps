Change resolution without restart desktop:
- quick and dirty
```
xrandr --fb 1280x720
```

- 
```
xrandr # list availabe resoltuions. Get the OUTPUT device: VNC-0
xrandr -s 5 # select preferred one

cvt 600 1165 # (optional) get modeline parameters

xrandr --newmode "600x1165"   58.50  600 648 704 808  1165 1168 1178 1208 -hsync +vsync
xrandr --addmode VNC-0 "600x1165"

xrandr -s 600x1165

```

Build lasery/vnc-desktop:build
```
git clone https://github.com/accetto/ubuntu-vnc-xfce-g3.git
cd ubuntu-vnc-xfce-g3
find . -type f -name "*.sh" -exec chmod +x '{}' \;
chmod +x docker/hooks/*

export REPO_OWNER_NAME="my"
export BUILDER_REPO="desktop"
# export FEATURES_NOVNC=0
./builder.sh latest all


docker tag my/desktop:latest lasery/vnc-desktop:build
# docker tag lasery/vnc-desktop:latest-vnc lasery/vnc-desktop:build
docker push lasery/vnc-desktop:build
```

```
export \

VNC_PASSWORD=\
RESOLUTION=\
1920x1080
600x1165 

echo \

  --ipc=host `# for MIT-SHM`\

docker run \
  --ipc=shareable \
  --privileged \
  -e VNC_PASSWORD \
  -e RESOLUTION \
  -d --rm --name desktop \
  -p 6080:80 `# web viewer`\
  -p 5900:5900 `# vnc viewer`\
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  lasery/vnc-desktop
```

Share Display with other apps
```
export \
DISPLAY=unix:1

  --ipc=container:desktop \
```

mount adb config for scrcpy
```
  -v $HOME/.android:/root/.android \
```

## Build image
```
python3 ~/mbuild/utils/build.py docker
python3 ~/mbuild/utils/build.py docker --bake-arg "--progress plain --set *.cache-from=lasery/ride:latest"
python3 ~/mbuild/utils/build.py push --only
python3 ~/mbuild/utils/build.py deploy --only
```


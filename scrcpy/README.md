Works for arm32 (Rapsberry Pi)

# Usage
```
docker run --rm lasery/scrcpy
```

```
export \

DISPLAY=\
unix:1

echo \

$DISPLAY \
```

amd64
```
docker run --rm -it \
  --privileged \
  -v /dev/shm:/dev/shm \
  `# mount adb config` \
  -v ${HOME}/.android:/root/.android \
  \
  `# use host display` \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY \
  \
  lasery/scrcpy \
  sh
```

Raspberry pi
```
docker run --rm -it \
  --privileged \
  -v /dev/shm:/dev/shm \
  `# mount adb config` \
  -v ${HOME}/.android:/home/scrcpy/.android \
  \
  `# use host display` \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=$DISPLAY \
  \
  -v /opt/vc:/opt/vc \
  --device=/dev/dri \
  --device /dev/bus/usb:/dev/bus/usb \
  --device /dev/vchiq `# ` \
  --device /dev/vcio `# GPU` \
  --device /dev/vcsm-cma:/dev/vcsm-cma `# VideoCore Shared Memory` \
  lasery/scrcpy \
  bash
```

```
adb tcpip 5555
adb connect tcpip.mydomain:5555
adb kill-server
adb devices
scrcpy
```

# Development
Build
```
python3 ~/mbuild/utils/build.py docker
python3 ~/mbuild/utils/build.py docker --bake-arg "--progress plain --set *.cache-from=lasery/ride:latest"
python3 ~/mbuild/utils/build.py push --only
python3 ~/mbuild/utils/build.py deploy --only
```

Works for arm32 (Rapsberry Pi)

# Usage
```
docker run --rm lasery/scrcpy

docker run --rm -it \
  `# mount adb config` \
  --mount type=bind,src="${HOME}/.android",dst=/home/scrcpy/.android \
  \
  `# use host display` \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=$DISPLAY \
  \
  `# Raspberry pi 4 specific` \
  -v /opt/vc:/opt/vc \
  --device=/dev/dri \
  --device /dev/bus/usb:/dev/bus/usb \
  --device /dev/vchiq `# ` \
  --device /dev/vcio `# GPU` \
  --device /dev/vcsm-cma:/dev/vcsm-cma `# VideoCore Shared Memory` \
  lasery/scrcpy \
  bash

adb devices
adb tcpip 5555
scrcpy
```

# Development
```
cd ~/projects/docker-apps/scrcpy

docker run --rm --name scrcpy-dev \
  -it \
  -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static `# Cross run` \
  scrcpy:armv7l \
  bash
```

Build
```
# append "skip" to skip compile bake and dockerfiles
# append "only" to perform current task only
python3 ~/mbuild/utils/build.py docker
python3 ~/mbuild/utils/build.py push only
python3 ~/mbuild/utils/build.py deploy only
```

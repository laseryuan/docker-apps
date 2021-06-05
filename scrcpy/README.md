Works for arm32 (Rapsberry Pi)

# Usage
```
docker run --rm lasery/scrcpy
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

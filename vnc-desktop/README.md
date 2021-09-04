https://github.com/fcwu/docker-ubuntu-vnc-desktop
```
VNC_PASSWORD=\
RESOLUTION=\
1920x1080
600x1165 

echo \

  --ipc=host `# for MIT-SHM`\

docker run \
  --privileged \
  -e VNC_PASSWORD \
  -e RESOLUTION \
  -d --rm --name desktop \
  -p 6080:80 `# web viewer`\
  -p 5900:5900 `# vnc viewer`\
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /dev/shm:/dev/shm \
  lasery/vnc-desktop
```

Share Display with other apps
```
export \
DISPLAY=unix:1
DISPLAY=:1
```

mount adb config for scrcpy
```
  -v $HOME/.android:/home/ubuntu/.android \
```

## Build image
```
python3 ~/mbuild/utils/build.py docker
python3 ~/mbuild/utils/build.py docker --bake-arg "--progress plain --set *.cache-from=lasery/ride:latest"
python3 ~/mbuild/utils/build.py push --only
python3 ~/mbuild/utils/build.py deploy --only
```


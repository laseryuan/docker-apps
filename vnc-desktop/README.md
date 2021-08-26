https://github.com/fcwu/docker-ubuntu-vnc-desktop
```
docker run \
  -d \
  --rm --name vnc-desktop \
  -p 6080:80 `web viewer`\
  -p 5900:5900 `# vnc viewer`\
  -v /dev/shm:/dev/shm lasery/vnc-desktop

```

## Build image
```
python3 ~/mbuild/utils/build.py docker
python3 ~/mbuild/utils/build.py docker --bake-arg "--progress plain --set *.cache-from=lasery/ride:latest"
python3 ~/mbuild/utils/build.py push --only
python3 ~/mbuild/utils/build.py deploy --only
```


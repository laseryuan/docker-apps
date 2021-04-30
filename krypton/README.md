Docker Multi-Architecture Images

Works for both amd64 (Ubuntu) and arm32v6 (Rapsberry Pi)

# Usage
```
docker run --rm lasery/krypton
```

# Development
```
cd ~/projects/docker-apps/krypton

docker run --name=krypton --rm \
  -it \
  krypton:armv7 \
  bash
```

runtime
```
  -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static `# Cross run` \
```

## Build image
- Local
```
docker run --rm -it \
  -v $(pwd)/:/home/mbuild/ \
  -v ~/.docker/:/root/.docker/ \
  -v /var/run/docker.sock:/var/run/docker.sock \
  lasery/mbuild \
bash

cd mbuild

# append "skip" to skip compile bake and dockerfiles
# append "only" to perform current task only
python3 /home/utils/build.py docker
python3 /home/utils/build.py skip push only
python3 /home/utils/build.py deploy only
```

# Issues


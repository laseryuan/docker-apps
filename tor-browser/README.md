```
docker pull  lasery/tor-browser

docker volume create \
  --label keep \
  tor-browser-config

docker run --name tor-browser \
  --label keep \
  --privileged \
  -v tor-browser-config:/usr/local/bin/Browser/TorBrowser/Data \
  -v /dev:/dev \
  -v /dev/shm:/dev/shm \
  -v /etc/machine-id:/etc/machine-id:ro \
  -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native -v /run/user/1000/pulse:/run/user/1000/pulse \
  lasery/tor-browser

docker start tor-browser
docker rm -f tor-browser
```

Build
```
REPO=tor-browser && ARCH=amd64
cd ~/projects/docker-apps/${REPO}

VERSION=19.10 && TAG=${VERSION}-${ARCH}
echo $REPO && echo $VERSION && echo $TAG
```

## Deploy
```
export DOCKER_CLI_EXPERIMENTAL=enabled
docker manifest create lasery/${REPO} lasery/${REPO}:$VERSION-amd64

docker manifest annotate lasery/${REPO} lasery/${REPO}:$VERSION-amd64 --arch amd64
docker manifest push -p lasery/${REPO}
docker manifest inspect lasery/${REPO}
```

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
cd ~/projects/docker-app/${REPO}

VERSION=19.01 && TAG=${VERSION}-${ARCH}
echo $REPO && echo $VERSION && echo $TAG

curl --request POST https://cloud.docker.com/api/build/v1/source/5586d46a-a97e-49b1-b244-ba6d9b6869cf/trigger/89040ce7-4cb9-4ec7-b1b7-4de5fd39a1a9/call/
```

## Deploy
```
export DOCKER_CLI_EXPERIMENTAL=enabled
docker manifest create lasery/${REPO} lasery/${REPO}:$VERSION-amd64

docker manifest annotate lasery/${REPO} lasery/${REPO}:$VERSION-amd64 --arch amd64
docker manifest push -p lasery/${REPO}
docker manifest inspect lasery/${REPO}
```

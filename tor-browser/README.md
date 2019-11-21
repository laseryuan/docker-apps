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
export REPO=tor-browser && export VERSION=$(date "+%y.%m") && cd ~/projects/docker-apps/tor-browser
docker build -t tor-browser:amd64 .
```

## Deploy
```
./build.sh push
```

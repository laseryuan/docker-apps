```
docker pull  lasery/tor-browser

docker run -d --name tor-browser \
  --label keep \
  --privileged \
  -v /dev:/dev \
  -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native -v /run/user/1000/pulse:/run/user/1000/pulse \
  lasery/tor-browser

docker start tor-browser

docker exec -it tor-browser bash

docker rm -f tor-browser
```

Build
```
curl --request POST https://cloud.docker.com/api/build/v1/source/5586d46a-a97e-49b1-b244-ba6d9b6869cf/trigger/89040ce7-4cb9-4ec7-b1b7-4de5fd39a1a9/call/
```

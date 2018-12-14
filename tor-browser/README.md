```
docker pull  lasery/tor-browser

docker run -it --name tor-browser \
  --label keep \
  --privileged \
  -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  lasery/tor-browser

docker start tor-browser

docker rm -f tor-browser
```

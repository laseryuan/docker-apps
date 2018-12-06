```
docker run -it --name tor-browser \
  --privileged \
  -v /dev/bus/usb:/dev/bus/usb \
  -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  paulczar/torbrowser

docker start tor-browser

docker rm -f tor-browser
```

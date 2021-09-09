```
export DISPLAY=unix:1

  --ipc=container:desktop \

docker run \
  --ipc=host \
  -it --rm \
  --memory 2gb \
  --cpuset-cpus 0 \
  -v /etc/localtime:/etc/localtime:ro \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v "${HOME}/.firefox/cache:/root/.cache/mozilla" \
  -v "${HOME}/.firefox/mozilla:/root/.mozilla" \
  -v "${HOME}/Downloads:/root/Downloads" \
  -v "${HOME}/Pictures:/root/Pictures" \
  -v "${HOME}/Torrents:/root/Torrents" \
  -e DISPLAY \
  -e GDK_SCALE \
  -e GDK_DPI_SCALE \
  --name firefox \
  lasery/firefox
```

## Build image
```
cd firefox
python3 ~/mbuild/utils/build.py docker
```

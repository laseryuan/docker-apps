- GPU supported vnc docker container.
- FPS (First Person Shot) game streaming.

Based on:
https://gitlab.com/nvidia/container-images/samples/blob/master/opengl/ubuntu16.04/turbovnc-virtualgl/Dockerfile

```
cd ~/projects/docker-apps/vnc-virtualgl-docker
```

Create credentials (Only for the first build)
```
openssl req -new -x509 -days 365 -nodes -out self.pem -keyout self.pem
```

## Build
```
docker build -t vnc-gpu .

docker tag vnc-gpu lasery/vnc-gpu:ubuntu-18.04-19.10 && docker push lasery/vnc-gpu:ubuntu-18.04-19.10
```

## Usage
```
docker run --rm vnc-gpu

docker run --gpus all  --name=vnc-gpu --rm -it -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0 -p 5901:5901 \
  lasery/vnc-gpu:ubuntu-18.04-19.10 \
  fps \
  ${Barrier_server_address}

  game
  web
```

## Development
```
  -v $(pwd)/turbovncserver-security.conf:/etc/turbovncserver-security.conf \

  -v $(pwd)/docker-entrypoint.sh:/docker-entrypoint.sh \
  -v $(pwd)/home:/home/app \

  vnc-gpu \
  bash
```

Test virtualgl with a small app
```
docker exec -ti vnc-gpu vglrun glxspheres64
```

NoVNC proxy
```
/opt/websockify/run 5901 --cert=/self.pem --ssl-only --web=/opt/noVNC --wrap-mode=ignore -- \
```

Turbovnc
```
/opt/TurboVNC/bin/vncserver :1 \

-securitytypes otp -otp \
-securitytypes None \

-noxstartup \
-viewonly \

/opt/TurboVNC/bin/vncserver -list
/opt/TurboVNC/bin/vncserver -kill :1

```

##FPS game setup
```
/opt/TurboVNC/bin/vncserver :1 -securitytypes None -viewonly
/opt/TurboVNC/bin/vncviewer -cursorshape=0
```

### Barrier
Server
- Connection: Disable ssl encryption on server
- Use relative mouse
- lockCursorToScreen(toggle) to a hotkey (i.e. ctrl+shift+L) and pressing it every time barrier starts.

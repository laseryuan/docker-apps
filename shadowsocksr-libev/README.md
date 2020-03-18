# Usage
```
docker run --rm lasery/shadowsocksr-libev help
```

# Development

## Set enviornment
```
export REPO=shadowsocksr-libev && export VERSION=$(date "+%y.%m")
cd ~/projects/docker-apps/shadowsocksr-libev
```

```
DEV_SERVER=\

sshfs -o allow_other ${DEV_SERVER}:projects/${REPO} ~/projects/sshfs
cd ~/projects/sshfs

Mount docker volume
sudo vim /etc/fuse.conf # uncomment user_allow_other in /etc/fuse.conf
sshfs -o allow_other ${DEV_SERVER}:projects/${REPO} ~/projects/sshfs
```

```
SERVER_IP=\

SERVER_PORT=\

TPROXY_PORT=\

cd ~/projects/pi-router/shadowsocksr-libev/

  -v $PWD/app/:/root/app/ \
  -v $PWD/docker-entrypoint.sh:/docker-entrypoint.sh \

docker run --rm \
  --name shadowsocksr-cli \
  -p ${TPROXY_PORT}:${TPROXY_PORT} \
  -p ${TPROXY_PORT}:${TPROXY_PORT}/udp \
  -e TPROXY_PORT=${TPROXY_PORT} \
  -e VERBOSE=TRUE \
  -e SERVER_IP=${SERVER_IP} -e SERVER_PORT=${SERVER_PORT} -e SERVER_PASSWORD=MY_SSPASSWORD \
  lasery/shadowsocksr-libev:arm32-${VERSION} \
  start
```

## Build image
```
./build.sh docker

export DOCKER_CLI_EXPERIMENTAL=enabled
docker buildx bake
```

## Deploy image
```
./build.sh push
./build.sh deploy
```

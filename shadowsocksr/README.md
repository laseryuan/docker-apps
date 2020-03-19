# Usage
```
docker run --rm lasery/shadowsocksr help
```

# Development

## Set enviornment
```
export REPO=shadowsocksr && export VERSION=$(date "+%y.%m")
cd ~/projects/docker-apps/shadowsocksr
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

PROXY_PORT=\

  -v $PWD/app/:/root/app/ \
  -v $PWD/docker-entrypoint.sh:/docker-entrypoint.sh \

docker run --rm \
  --name shadowsocksr-cli \
  -p ${PROXY_PORT}:${PROXY_PORT} -p ${PROXY_PORT}:${PROXY_PORT}/udp \
  -e PROXY_PORT=${PROXY_PORT} \
  -e VERBOSE=TRUE \
  -e SERVER_IP=${SERVER_IP} -e SERVER_PORT=${SERVER_PORT} -e SERVER_PASSWORD=MY_SSPASSWORD \
  shadowsocksr \
  client
```

## Build image
```
./build.sh docker

docker buildx bake
```

## Deploy image
```
./build.sh push
./build.sh deploy
```

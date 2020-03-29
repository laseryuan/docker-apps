Docker Multi-Architecture Images

Works for both amd64 (Ubuntu) and arm32v6 (Rapsberry Pi)

# Usage
```
docker pull lasery/v2ray
docker run --rm lasery/v2ray
```

# Development

## Set enviornment
```
export REPO=v2ray && export VERSION=$(date "+%y.%m") && cd ~/projects/docker-apps/v2ray
./build.sh docker
```

## Build image
```
export DOCKER_CLI_EXPERIMENTAL=enabled
docker buildx bake

  --cache-from lasery/app \
```

## Start the program
Prepare environment
```
  -e DEBUG=true
  -e WS_PATH="/two"

  -e DOMAIN=
  -e V2RAY_ID=

  -v $(pwd)/docker-entrypoint.sh:/docker-entrypoint.sh \
  -v $(pwd)/tmpl/:/etc/v2ray/tmpl/ \

docker run -it --rm --name=v2ray-dev \
  v2ray \
  bash

  client

  /docker-entrypoint.sh server {domain.com} V2RAY_WS {v2ray_id}

  -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static \
```

## Build image
- Local
```
docker buildx bake
```

## Deploy image
```
./build.sh push
```

# Issues


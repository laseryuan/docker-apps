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
docker run -it --rm --name=v2ray-dev \
  -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static \
  v2ray:amd64 \
  sh

  /docker-entrypoint.sh server {domain.com} V2RAY_WS {v2ray_id}
  /docker-entrypoint.sh client {domain.com} V2RAY_WS {v2ray_id}

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


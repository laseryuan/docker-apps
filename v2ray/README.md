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
```

## Build image
```
./build.sh docker
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
  -v $(pwd)/web/:/tmp/web/ \

docker run -it --rm --name=v2ray-dev \
  v2ray \
  bash

  client

  /docker-entrypoint.sh server {domain.com} V2RAY_WS {v2ray_id}
```

## Deploy image
```
./build.sh push
```

# Issues


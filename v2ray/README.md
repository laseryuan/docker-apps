Docker Multi-Architecture Images

Works for both amd64 (Ubuntu) and arm32v6 (Rapsberry Pi)

# Usage
```
docker pull lasery/v2ray
docker run --rm lasery/v2ray
```

caddy
```
docker run -it --rm --name=caddy \
  webhippie/caddy:latest \
  bash
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
Demand
```
  -e DOMAIN=\
  -e V2RAY_ID=\

on server:
  -p 80:80 -p 443:443 -p 80:80/udp -p 443:443/udp \

on client:
  -p 1080:1080 -p 1080:1080/udp \
```

Optional
```
  -e DEBUG=true
  -e WS_PATH="/two"
```


Development
```
  -v $(pwd)/docker-entrypoint.sh:/docker-entrypoint.sh \
  -v $(pwd)/tmpl/:/etc/v2ray/tmpl/ \

on server:
  -v $(pwd)/web/:/tmp/web/ \
  -v $(pwd)/web/ssl/:/root/.caddy/ \
```

```
docker run -it --rm --name=v2ray-dev \
  v2ray \
  sh

  /docker-entrypoint.sh server
  /docker-entrypoint.sh client
```

## Deploy image
```
./build.sh push
```

# Issues


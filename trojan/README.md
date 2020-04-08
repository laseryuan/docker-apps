Docker Multi-Architecture Images

Works for both amd64 (Ubuntu) and arm32v6 (Rapsberry Pi)

# Usage
```
docker pull lasery/trojan
docker run --rm lasery/trojan
```

# Development

## Set enviornment
```
export REPO=trojan && export VERSION=$(date "+%y.%m") && cd ~/projects/docker-apps/trojan
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
  -e trojan_ID=

  -v $(pwd)/docker-entrypoint.sh:/docker-entrypoint.sh \
  -v $(pwd)/tmpl/:/etc/trojan/tmpl/ \
  -v $(pwd)/web/:/tmp/web/ \

docker run --name=trojan-dev \
  -it --rm \
  trojan \
  sh

  client

```

## Deploy image
```
./build.sh push
```

# Issues


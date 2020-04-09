Docker Multi-Architecture Images

Works for both amd64 (Ubuntu) and arm32v7 (Rapsberry Pi)

# Usage
```
docker pull lasery/caddy
docker run --rm lasery/caddy
```

# Development

## Set enviornment
```
export REPO=caddy && export VERSION=$(date "+%y.%m") && cd ~/projects/docker-apps/caddy
```

## Build image
```
./build.sh docker
```

## Start the program
```
docker run --name=caddy-dev \
  -it --rm \
  caddy \
  sh
```

## Deploy image
```
./build.sh push
```

# Issues


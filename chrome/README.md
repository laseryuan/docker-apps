Docker Multi-Architecture Images

Works for both amd64 (Ubuntu) and arm32v6 (Rapsberry Pi)

# Usage
```
docker pull lasery/chrome
docker run --rm lasery/chrome
```

# Development

## Set enviornment
```
export REPO=chrome && export VERSION=$(date "+%y.%m") && cd ~/projects/docker-apps/chrome
./build.sh docker
```

## Start the program
Prepare environment
```
docker run --rm -it --entrypoint=/bin/bash chrome:amd64
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


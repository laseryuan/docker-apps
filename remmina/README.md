Docker Multi-Architecture Images

Works for both amd64 (Ubuntu) and arm32v6 (Rapsberry Pi)

# Usage
```
docker pull lasery/remmina
docker run --rm lasery/remmina
```

# Development

## Set enviornment
```
export REPO=remmina && export VERSION=$(date "+%y.%m") && cd ~/projects/docker-apps/remmina
./build.sh docker
```

## Start the program
Prepare environment
```
docker run --rm -it --entrypoint=/bin/bash remmina:amd64
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


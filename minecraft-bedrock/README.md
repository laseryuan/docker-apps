# Usage
```
docker pull lasery/minecraft-bedrock

docker run -it --rm --name=minecraft-bedrock\
  --net=host \
  lasery/minecraft-bedrock
```

# Development

## Set enviornment
```
REPO=minecraft-bedrock && VERSION=19.05 && TAG=${VERSION}
echo $REPO:$TAG

cd ~/projects/docker-app/${REPO}
```

## Start the program
```
docker volume create \
  --label keep \
  "$REPO"-config

docker run -it --rm --name="$REPO"-dev \
  --net=host \
  lasery/${REPO}:${TAG} \
  bash
```
## Build image
- Docker cloud auto-build
```
curl --request POST https://cloud.docker.com/api/build/v1/source/f91a7e26-1be8-48ef-ad95-3fbc5e2fb263/trigger/6b8fa0ea-aa44-4de3-9da9-b07e01db389d/call/
```

- Local
```
docker build \
  -t lasery/${REPO}:${TAG} \
  .

  --cache-from lasery/${REPO} \

docker push lasery/${REPO}:${TAG}
```

## Docker Deploy
```
export DOCKER_CLI_EXPERIMENTAL=enabled
docker manifest create lasery/${REPO} lasery/${REPO}:$VERSION

docker manifest annotate lasery/${REPO} lasery/${REPO}:$VERSION --arch amd64
docker manifest push -p lasery/${REPO}
docker manifest inspect lasery/${REPO}
```

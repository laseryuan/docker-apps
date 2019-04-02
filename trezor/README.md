# Usage
```
docker pull lasery/trezor

docker run -it --rm \
  --privileged \
  -v /dev:/dev \
  lasery/trezor bash
```

# Development

## Set variables
```
REPO=trezor && VERSION=19.04
echo $REPO && echo $VERSION

cd ~/projects/docker-app/${REPO}
bash build.sh
```

## Build image
```
curl --request POST https://cloud.docker.com/api/build/v1/source/79b73c49-214b-4af9-87e5-f7f8794e6d4b/trigger/07d03de2-25de-4fd9-8d67-aac20cfae4a7/call/
```

## Start the program
```
docker run -it --rm --name=trezor \
  --privileged \
  -v /dev:/dev \
  lasery/${REPO}:${TAG} \
  bash
```

## Multiple Archi
```
export DOCKER_CLI_EXPERIMENTAL=enabled
docker manifest create lasery/${REPO} lasery/${REPO}:$VERSION-amd64 lasery/${REPO}:$VERSION-arm32v6

docker manifest annotate lasery/${REPO} lasery/${REPO}:$VERSION-amd64 --arch amd64
docker manifest annotate lasery/${REPO} lasery/${REPO}:$VERSION-arm32v6 --arch arm
docker manifest push -p lasery/${REPO}
docker manifest inspect lasery/${REPO}
```

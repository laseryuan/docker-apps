# Usage
```
docker pull lasery/trezor-agent

docker run -it --rm --name trezor-agent \
  --privileged \
  -v /dev:/dev \
  lasery/trezor-agent bash
```

[Reference](https://github.com/romanz/trezor-agent/blob/master/doc/README-GPG.md)

# Development

## Set variables
```
REPO=trezor-agent && VERSION=19.04
echo $REPO && echo $VERSION

ARCH=amd64 && IS_CROSS_BUILD=

ARCH=arm32v6 && IS_CROSS_BUILD=true
IS_CROSS_BUILD=

TAG=${VERSION}-${ARCH}`if [ \"$IS_CROSS_BUILD\" = \"true\" ]; then echo -cross; fi`
echo $REPO:$TAG && echo $IS_CROSS_BUILD && echo $VERSION

cd ~/projects/docker-app/${REPO}
bash build.sh
```

## Build image
- Docker cloud auto-build
```
curl --request POST https://cloud.docker.com/api/build/v1/source/e33fad1d-48d7-4ec9-a06e-6c525d8ef18c/trigger/3a8028c2-cea6-4976-98ef-2194f1083ea2/call/
```

- Local
```
docker build \
  -t lasery/${REPO}:${TAG} \
  -f Dockerfile.${ARCH}$(if [ \"$IS_CROSS_BUILD\" = \"true\" ]; then echo .cross; fi) \
  .

  --cache-from lasery/${REPO} \

docker push lasery/${REPO}:${TAG}
```

## Start the program
```
docker run -it --rm --name electrum \
  -e DISPLAY=unix:0 -v /tmp/.X11-unix:/tmp/.X11-unix \
  --privileged \
  -v /dev:/dev \
  lasery/${REPO}:${TAG} \
  bash

  trezor-gpg init "trezor"
  export GNUPGHOME=~/.gnupg/trezor
  gpg -K
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

# Issue
"trezor-gpg init" command failed in arm32v6 version

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
REPO=trezor-agent && VERSION=19.01
echo $REPO && echo $VERSION

cd ~/projects/docker-app/${REPO}
bash build.sh
```

## Build image
```
curl --request POST https://cloud.docker.com/api/build/v1/source/e33fad1d-48d7-4ec9-a06e-6c525d8ef18c/trigger/3a8028c2-cea6-4976-98ef-2194f1083ea2/call/
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

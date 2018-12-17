# Usage
```
docker pull lasery/ansible

docker run --rm lasery/ansible help
```

# Development

## Set variables
```
REPO=ansible

ARCH=amd64
IS_CROSS_BUILD=

ARCH=arm32v6
IS_CROSS_BUILD=true

VERSION=18.12 && TAG=${VERSION}-${ARCH}`if [ \"$IS_CROSS_BUILD\" = \"true\" ]; then echo -cross; fi`

echo $REPO && echo $VERSION && echo $TAG && echo $IS_CROSS_BUILD

cd ~/projects/docker-app/${REPO}
```

## Start the program
```
docker run -it --rm \
  -v $(pwd)/app:/home/provision/app \
  -v $SSH_AUTH_SOCK:/ssh-agent \
  -e SSH_AUTH_SOCK=/ssh-agent \
  lasery/provision:${TAG} \
  bash

  -v $(pwd)/docker-entrypoint.sh:/docker-entrypoint.sh \
```

## Build image
```
bash build.sh

docker build \
  -t lasery/${REPO}:${TAG} \
  -f Dockerfile.${ARCH}$(if [ \"$IS_CROSS_BUILD\" = \"true\" ]; then echo .cross; fi) \
  .

curl --request POST https://cloud.docker.com/api/build/v1/source/39a65cf4-99d4-46d0-a061-84ebef316c33/trigger/4f879632-3306-4f73-8ffb-2ffad67d0cb7/call/

docker push lasery/${REPO}:${TAG}
```

## Multiple Archi
    ```
    export DOCKER_CLI_EXPERIMENTAL=enabled
    docker manifest create lasery/${REPO} lasery/${REPO}:$VERSION-amd64-hub lasery/${REPO}:$VERSION-arm32v6-hub

    docker manifest annotate lasery/${REPO} lasery/${REPO}:$VERSION-amd64-hub --arch amd64
    docker manifest annotate lasery/${REPO} lasery/${REPO}:$VERSION-arm32v6-hub --arch arm
    docker manifest push -p lasery/${REPO}
    docker manifest inspect lasery/${REPO}
    ```

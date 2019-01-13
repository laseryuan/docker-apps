# Usage
```
docker pull lasery/ansible
docker run --rm lasery/ansible help
```

# Development

## Set variables
```
REPO=ansible && VERSION=19.01
echo $REPO && echo $VERSION

cd ~/projects/docker-app/${REPO}
bash build.sh
```

## Build image
```
curl --request POST https://cloud.docker.com/api/build/v1/source/39a65cf4-99d4-46d0-a061-84ebef316c33/trigger/4f879632-3306-4f73-8ffb-2ffad67d0cb7/call/
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

#!/bin/bash
main() {
  case "$1" in
    docker)
mkdir -p amd64
mkdir -p arm32

amd64=true mo ./Dockerfile.templ > ./amd64/Dockerfile
arm32=true mo ./Dockerfile.templ > ./arm32/Dockerfile

mo ./docker-bake.hcl.templ > ./docker-bake.hcl
      ;;
    push)
export DOCKER_CLI_EXPERIMENTAL=enabled

docker tag ${REPO}:amd64 lasery/${REPO}:amd64-${VERSION}
docker push lasery/${REPO}:amd64-${VERSION}

docker tag ${REPO}:arm32 lasery/${REPO}:arm32-${VERSION}
docker push lasery/${REPO}:arm32-${VERSION}
      ;;
    deploy)
export DOCKER_CLI_EXPERIMENTAL=enabled

docker manifest create -a lasery/${REPO} \
  lasery/${REPO}:amd64-${VERSION} \
  lasery/${REPO}:arm32-${VERSION}

docker manifest annotate lasery/${REPO} lasery/${REPO}:amd64-${VERSION} --arch amd64
docker manifest annotate lasery/${REPO} lasery/${REPO}:arm32-${VERSION} --arch arm

docker manifest push -p lasery/${REPO}

docker manifest inspect lasery/${REPO}
      ;;
    *)
      exec "$@"
      ;;
  esac
}

main "$@"

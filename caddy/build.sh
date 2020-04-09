#!/bin/bash
main() {
  case "$1" in
    docker)
      docker-build
      docker buildx bake
      ;;
    push)
      docker-push
      ;;
    deploy)
      docker-push
      docker-deploy
      ;;
    *)
      exec "$@"
      ;;
  esac
}

docker-build() {
  mkdir -p amd64
  mkdir -p arm32
  mkdir -p arm32v7

  amd64=true mo ./Dockerfile.templ > ./amd64/Dockerfile
  arm32=true mo ./Dockerfile.templ > ./arm32/Dockerfile
  arm32=true mo ./Dockerfile.templ > ./arm32v7/Dockerfile

  mo ./docker-bake.hcl.templ > ./docker-bake.hcl
}

docker-push() {
  export DOCKER_CLI_EXPERIMENTAL=enabled

  docker tag ${REPO}:amd64 lasery/${REPO}:amd64-${VERSION}
  docker push lasery/${REPO}:amd64-${VERSION}

  docker tag ${REPO}:arm32v7 lasery/${REPO}:arm32v7-${VERSION}
  docker push lasery/${REPO}:arm32v7-${VERSION}
}

docker-deploy() {
  export DOCKER_CLI_EXPERIMENTAL=enabled

  docker manifest create -a lasery/${REPO} \
    lasery/${REPO}:amd64-${VERSION} \
    lasery/${REPO}:arm32v7-${VERSION}

  docker manifest annotate lasery/${REPO} lasery/${REPO}:amd64-${VERSION} --arch amd64
  docker manifest annotate lasery/${REPO} lasery/${REPO}:arm32v7-${VERSION} --arch armv7

  docker manifest push -p lasery/${REPO}

  docker manifest inspect lasery/${REPO}
}

main "$@"

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
docker tag ${REPO}:amd64 lasery/${REPO}:amd64-${VERSION}
docker push lasery/${REPO}:amd64-${VERSION}

docker tag ${REPO}:amd64 lasery/${REPO}
docker push lasery/${REPO}
      ;;
    *)
      exec "$@"
      ;;
  esac
}

main "$@"

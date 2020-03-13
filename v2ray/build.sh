#!/bin/bash
main() {
  case "$1" in
    docker)
mkdir -p arm32

arm32=true mo ./Dockerfile.templ > ./arm32/Dockerfile

mo ./docker-bake.hcl.templ > ./docker-bake.hcl
      ;;
    push)
docker tag ${REPO}:arm32 lasery/${REPO}:arm32-${VERSION}
docker push lasery/${REPO}:arm32-${VERSION}
      ;;
    *)
      exec "$@"
      ;;
  esac
}

main "$@"

#!/bin/bash
main() {
  case "$1" in
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

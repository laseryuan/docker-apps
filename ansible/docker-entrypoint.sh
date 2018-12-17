#!/bin/bash
# vim: set noswapfile :

main() {
  case "$1" in
    help)
      run-help
      ;;
    *)
      exec "$@"
      ;;
  esac
}

run-help() {
  echo 'docker run -it --rm \
    -v $(pwd)/ansible:/home/provision/app \
    -v $SSH_AUTH_SOCK:/ssh-agent \
    -e SSH_AUTH_SOCK=/ssh-agent \
    lasery/provision \
    bash'
}

run-cron() {
  bundle exec whenever --write-cron --set environment=${RAILS_ENV}
  exec "$@" # usually `cron -f`
}

main "$@"


#!/bin/bash
# vim: set noswapfile :

main() {
  case "$1" in
    start)
      shift
      trap 'term_handler' SIGTERM SIGINT
      start_picam "$@"
      run_custum_script
      tail -f /dev/null & wait
      ;;
    record)
      shift
      trap 'term_handler' SIGTERM SIGINT
      start_picam "$@"
      touch ~/picam/hooks/start_record
      tail -f /dev/null & wait
      ;;
    help)
      cat /README.md
      ;;
    test)
      ffmpeg -version && picam --help
      ;;
    *)
      exec "$@"
      ;;
  esac
}

run_custum_script() {
  sleep 10 # wait for picam
  if [ -f ~/picam/run_me.sh ]; then
    echo "Run custom script."
    bash ~/picam/run_me.sh
  fi
}

start_picam() {
  make_dirs
  cd ~/picam
  [ -z "$@" ] && param='--noaudio' || param="$@"
  echo "Execute: \"picam $param\""
  picam $param &
}

term_handler() {
  echo "Term signal catched. Shutting down ..."
  touch hooks/stop_record
  kill -9 $(pidof picam) || true
  echo "Gracefully shutted down."
  exit 143; # 128 + 15 -- SIGTERM
}

make_dirs() {
  DEST_DIR=~/picam
  SHM_DIR=/dev/shm

  mkdir -p $DEST_DIR
  mkdir -p $DEST_DIR/archive
  mkdir -p $SHM_DIR/rec
  mkdir -p $SHM_DIR/hooks
  mkdir -p $SHM_DIR/state

  ln -sfn $DEST_DIR/archive $SHM_DIR/rec/archive
  ln -sfn $SHM_DIR/rec $DEST_DIR/rec
  ln -sfn $SHM_DIR/hooks $DEST_DIR/hooks
  ln -sfn $SHM_DIR/state $DEST_DIR/state
}

main "$@"

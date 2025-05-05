#!/usr/bin/env bash

echo before comment
: <<'END'

The below bash script (after "code start") with file name app/bash.sh have these features:
* feature 1
* --debug: can debug the code
* --option1: config

Please make following changes:
* Instead of

END
echo after comment

config() {
    echo Command options: $@

    ffmpeg_option="-b:v 2500k -b:a 192k"
    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            --debug) debug_mode=0 ;;
            -m|--mount) will_mount=0 ;;
            -a|--acopy) ffmpeg_option="-c:a copy -b:v 2500k" ;;
            -a|--vcopy) ffmpeg_option="-c:v copy -b:a 192k" ;;
            -c|--copy) ffmpeg_option="-c copy" ;;
            *) FILE_ARG="$1" ;;
        esac
        shift
    done
}

debug-mode() {
  local cmd="$@"
  if [ "$debug_mode" -eq 0 ]; then
    echo "$cmd"
  else
    eval "$cmd"
  fi
}

main() {
    config "$@"

    local full_cmd="
        ffmpeg -y -i $origin_path $ffmpeg_option $new_path
    "
    debug-mode $full_cmd
}

test() {
  # mocking function
  function ssh {
    echo "calling: ssh $@"
  }

  # local debug_control=0
  # [ $debug_control ] && debugger "$@"
  # debugger "$@"
  local res=$(main --mount me@host)
  if ! [[ 
    $res =~ "calling: ssh"
      &&
    $res =~ "--mount me@host"
    ]]; then
    echo "TEST FAILURE: ssh --mount"
    exit 1
  fi

  echo test succeed!
}

if [[ "$1" = "test" ]]; then
  test "$@"
else
  main "$@"
fi

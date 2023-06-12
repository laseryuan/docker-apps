#!/usr/bin/env bash

main() {
  ssh "$@"
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

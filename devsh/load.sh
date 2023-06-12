#!/usr/bin/env bash
history -r script_history
set -o vi

debugger() {
  echo "Stopped in REPL. Press ^D to resume, or ^C to abort." >&2
  local line
  while read -e -r -p "> " line; do
    history -s "$line"
    eval "$line" >&2
  done
  echo
}
export -f debugger

init() {
  cp /sample.sh ./
}

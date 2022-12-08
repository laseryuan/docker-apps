debugger() {
  echo "Stopped in REPL. Press ^D to resume, or ^C to abort." >&2
  local line
  while read -r -p "> " line; do
    eval "$line" >&2
  done
  echo
}

export -f debugger

# showPort
showPort() {
  if [[ $1 != <-> ]] || (( $1 < 1 || $1 > 65535 )); then
    print -u2 'usage: showPort <1-65535>'
    return 2
  fi

  lsof -nP -iTCP:"$1"
}

# Kill listeners only after validating a single TCP port.
kill-port() {
  if [[ $1 != <-> ]] || (( $1 < 1 || $1 > 65535 )); then
    print -u2 'usage: kill-port <1-65535>'
    return 2
  fi

  local pids
  pids="$(lsof -nP -t -iTCP:"$1" -sTCP:LISTEN)" || return 0
  [[ -n "$pids" ]] || return 0
  command kill -- ${(f)pids}
}

alias killport='kill-port'

#!/bin/bash
# ProcessManager.sh - Register/start/stop/monitor services (Part B)

REG_DIR="$HOME/.processmanager"
mkdir -p "$REG_DIR"
REG_FILE="$REG_DIR/registry.txt"   # alias|path|priority
touch "$REG_FILE"

usage() {
  echo "Usage:"
  echo "  $0 -o register -s <path> -a <alias>"
  echo "  $0 -o start -a <alias>"
  echo "  $0 -o status -a <alias>"
  echo "  $0 -o kill -a <alias>"
  echo "  $0 -o priority -p <low/med/high> -a <alias>"
  echo "  $0 -o list"
  echo "  $0 -o top [-a <alias>]"
  exit 1
}

get_entry() {
  grep "^$1|" "$REG_FILE"
}

get_pidfile() {
  echo "$REG_DIR/$1.pid"
}

register() {
  local path=$1 alias=$2
  if [ -z "$path" ] || [ -z "$alias" ]; then usage; fi
  if get_entry "$alias" >/dev/null; then
    echo "Alias '$alias' already registered"
    return
  fi
  echo "$alias|$path|med" >> "$REG_FILE"
  echo "Registered '$alias' -> $path"
}

start_service() {
  local alias=$1
  local entry=$(get_entry "$alias")
  if [ -z "$entry" ]; then echo "Alias not registered"; return; fi
  local path=$(echo "$entry" | cut -d'|' -f2)
  nohup bash "$path" >/dev/null 2>&1 &
  local pid=$!
  echo "$pid" > "$(get_pidfile "$alias")"
  echo "Started '$alias' as daemon, PID=$pid"
}

status_service() {
  local alias=$1
  local pidfile=$(get_pidfile "$alias")
  if [ -f "$pidfile" ] && kill -0 "$(cat "$pidfile")" 2>/dev/null; then
    echo "'$alias' is RUNNING (PID $(cat "$pidfile"))"
  else
    echo "'$alias' is NOT running"
  fi
}

kill_service() {
  local alias=$1
  local pidfile=$(get_pidfile "$alias")
  if [ -f "$pidfile" ] && kill -0 "$(cat "$pidfile")" 2>/dev/null; then
    kill -9 "$(cat "$pidfile")"
    echo "Killed '$alias' (PID $(cat "$pidfile"))"
    rm -f "$pidfile"
  else
    echo "'$alias' is not running"
  fi
}

change_priority() {
  local level=$1 alias=$2
  local pidfile=$(get_pidfile "$alias")
  local nice_val
  case "$level" in
    low) nice_val=15 ;;
    med) nice_val=0 ;;
    high) nice_val=-10 ;;
    *) echo "priority must be low/med/high"; return ;;
  esac
  if [ -f "$pidfile" ]; then
    renice "$nice_val" -p "$(cat "$pidfile")" >/dev/null 2>&1
  fi
  # update registry entry
  sed -i "s/^$alias|\([^|]*\)|.*/$alias|\1|$level/" "$REG_FILE"
  echo "Priority of '$alias' set to $level"
}

list_services() {
  cut -d'|' -f1 "$REG_FILE"
}

top_services() {
  local filter=$1
  printf "%-12s %-8s %-10s %-8s %-s\n" "ALIAS" "PID" "STATE" "PRIORITY" "SCRIPT"
  while IFS='|' read -r alias path priority; do
    [ -z "$alias" ] && continue
    if [ -n "$filter" ] && [ "$alias" != "$filter" ]; then continue; fi
    local pidfile=$(get_pidfile "$alias")
    local pid="-" state="STOPPED"
    if [ -f "$pidfile" ] && kill -0 "$(cat "$pidfile")" 2>/dev/null; then
      pid=$(cat "$pidfile")
      state=$(ps -o stat= -p "$pid" | tr -d ' ')
    fi
    printf "%-12s %-8s %-10s %-8s %-s\n" "$alias" "$pid" "$state" "$priority" "$path"
  done < "$REG_FILE"
}

# ---- parse args ----
op=""; path=""; alias=""; priority=""
while getopts "o:s:a:p:" opt; do
  case "$opt" in
    o) op=$OPTARG ;;
    s) path=$OPTARG ;;
    a) alias=$OPTARG ;;
    p) priority=$OPTARG ;;
    *) usage ;;
  esac
done

case "$op" in
  register) register "$path" "$alias" ;;
  start) start_service "$alias" ;;
  status) status_service "$alias" ;;
  kill) kill_service "$alias" ;;
  priority) change_priority "$priority" "$alias" ;;
  list) list_services ;;
  top) top_services "$alias" ;;
  *) usage ;;
esac
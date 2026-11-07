#!/usr/bin/env bash
# Neon Transit on a real VT (Ctrl+Alt+F3, log in, run this).
#
#   SHADY_ROOT=~/src/shady ./run-native.sh
set -euo pipefail

RICE="$(cd "$(dirname "$0")" && pwd)"
ROOT="${SHADY_ROOT:-$RICE/../shady}"
if [[ ! -x "$ROOT/tools/run-native.sh" || ! -x "$ROOT/build/shady-shell" ]]; then
  echo "Neon Transit: no Shady build in $ROOT. Set SHADY_ROOT to a built Shady checkout." >&2
  exit 1
fi
ROOT="$(cd "$ROOT" && pwd)"

export SHADY_ROOT="$ROOT"
export SHADY_LUA_INIT="$RICE/init.lua"

if [[ $# -eq 0 ]]; then
  default_startup="'$ROOT/build/shady-shell' & exec ${TERMINAL:-foot}"
  set -- -s "${SHADY_STARTUP:-$default_startup}"
fi

exec "$ROOT/tools/run-native.sh" -c "$RICE/config.lua" "$@"

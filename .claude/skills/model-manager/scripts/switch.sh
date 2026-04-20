#!/usr/bin/env bash
# Change the active model (used by chat.sh and skills that read .selected-model).
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
M="$1"; [[ -n "$M" ]] || die "Usage: switch.sh <model>"

if ! ollama list | awk 'NR>1 {print $1}' | grep -qx "$M"; then
  warn "'$M' is not installed.  Pulling it first..."
  ollama pull "$M"
fi

ROOT=$(repo_root)
echo "$M" > "$ROOT/.selected-model"
ok "Active model is now: $M"
echo "Test it:  ./ai local-ai ask \"Say hi in 3 words.\""

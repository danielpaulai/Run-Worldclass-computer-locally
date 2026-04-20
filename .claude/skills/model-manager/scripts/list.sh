#!/usr/bin/env bash
# Pretty list of installed models.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
ROOT=$(repo_root)
ACTIVE=""
[[ -f "$ROOT/.selected-model" ]] && ACTIVE=$(cat "$ROOT/.selected-model")

echo
printf "  %-32s %10s %20s %s\n" "MODEL" "SIZE" "MODIFIED" "ACTIVE"
printf -- '-%.0s' {1..80}; echo
ollama list | awk 'NR>1' | while IFS= read -r line; do
  name=$(echo "$line" | awk '{print $1}')
  size=$(echo "$line" | awk '{print $3" "$4}')
  mod=$(echo "$line"  | awk '{print $5" "$6" "$7" "$8}')
  mark=""
  [[ "$name" == "$ACTIVE" ]] && mark="  *"
  printf "  %-32s %10s %20s %s\n" "$name" "$size" "$mod" "$mark"
done
echo
[[ -n "$ACTIVE" ]] && ok "Active: $ACTIVE  (*)" || warn "No active model selected."

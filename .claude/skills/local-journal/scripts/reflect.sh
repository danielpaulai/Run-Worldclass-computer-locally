#!/usr/bin/env bash
# Reflect on recent journal entries.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
ROOT=$(repo_root); DIR="$ROOT/.journal"
[[ -d "$DIR" ]] || die "No journal yet.  Run  ./ai local-journal write  first."

# Collect the 5 most recent entries, handling paths that contain spaces.
RECENT=()
while IFS= read -r -d '' f; do
  RECENT+=("$f")
done < <(find "$DIR" -maxdepth 1 -name '*.md' -print0 | xargs -0 ls -t 2>/dev/null | head -5 | tr '\n' '\0')

[[ ${#RECENT[@]} -eq 0 ]] && die "No journal entries yet."

{
  echo "You are a thoughtful, non-judgmental reader reflecting on someone's recent journal entries."
  echo "Offer:"
  echo "  - One pattern you notice across the entries"
  echo "  - One thing that seems worth sitting with"
  echo "  - One honest, specific question worth asking themselves"
  echo "Never be preachy. Never offer generic advice. Speak plainly."
  echo
  echo "Recent entries:"
  for f in "${RECENT[@]}"; do
    echo
    echo "---"
    echo "### $(basename "$f" .md)"
    cat "$f"
  done
} | ollama run "$MODEL"

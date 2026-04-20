#!/usr/bin/env bash
# Report disk usage per model and total.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"

DIR="$HOME/.ollama/models"
[[ -d "$DIR" ]] || die "No ollama models directory at $DIR"

echo
say "Ollama model storage:  $DIR"
echo
printf "  %-34s %10s\n" "MODEL" "SIZE"
printf -- '-%.0s' {1..50}; echo
ollama list | awk 'NR>1 {print $1" "$3" "$4}' | while read -r name size unit; do
  printf "  %-34s %10s\n" "$name" "${size} ${unit}"
done
printf -- '-%.0s' {1..50}; echo
TOTAL=$(du -sh "$DIR" 2>/dev/null | awk '{print $1}')
printf "  %-34s %10s\n" "TOTAL" "$TOTAL"
echo

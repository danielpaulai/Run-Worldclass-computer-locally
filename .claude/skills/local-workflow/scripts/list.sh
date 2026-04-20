#!/usr/bin/env bash
# List saved workflows.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ROOT=$(repo_root); DIR="$ROOT/.workflows"
[[ -d "$DIR" ]] || { echo "No workflows saved yet."; exit 0; }
echo
for f in "$DIR"/*.yaml; do
  [[ -f "$f" ]] || continue
  name=$(basename "$f" .yaml)
  desc=$(awk '/^description:/ {sub(/^description: */,""); print; exit}' "$f")
  printf "  %-20s  %s\n" "$name" "$desc"
done
echo

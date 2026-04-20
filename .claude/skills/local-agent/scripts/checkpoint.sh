#!/usr/bin/env bash
# List existing agent workspaces so you can resume one.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ROOT=$(repo_root)
DIR="$ROOT/.agent-workspace"
[[ -d "$DIR" ]] || { echo "No agent runs yet."; exit 0; }

echo
printf "  %-22s  %s\n" "RUN" "GOAL"
printf -- '-%.0s' {1..70}; echo
for d in "$DIR"/*/; do
  [[ -d "$d" ]] || continue
  id=$(basename "$d")
  goal=$(head -c 100 "$d/goal.txt" 2>/dev/null || echo "(no goal)")
  printf "  %-22s  %s\n" "$id" "$goal"
done
echo
echo "Resume:   ./ai local-agent run  .agent-workspace/<run>/plan.md"
echo "Verify:   ./ai local-agent verify .agent-workspace/<run>"

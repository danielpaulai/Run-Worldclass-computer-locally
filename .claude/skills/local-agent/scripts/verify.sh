#!/usr/bin/env bash
# Ask the model whether the goal was met, given the workspace state.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
WORK="$1"; [[ -d "$WORK" ]] || die "Workspace not found: $WORK"

GOAL=$(cat "$WORK/goal.txt" 2>/dev/null || echo "(no goal recorded)")
LISTING=$(ls -la "$WORK")
LOG=$(cat "$WORK/execution.log" 2>/dev/null || echo "(no log)")

{ echo "Determine whether the following goal was successfully achieved."; \
  echo "Look at what's in the workspace and the execution log."; \
  echo; echo "## Goal"; echo "$GOAL"; \
  echo; echo "## Workspace contents"; echo "$LISTING"; \
  echo; echo "## Execution log"; echo "$LOG"; \
  echo; echo "Output:"; \
  echo "  - Met: yes / partial / no"; \
  echo "  - What worked:"; \
  echo "  - What didn't:"; \
  echo "  - Next step to close the gap (if any):"; } \
  | ollama run "$MODEL"

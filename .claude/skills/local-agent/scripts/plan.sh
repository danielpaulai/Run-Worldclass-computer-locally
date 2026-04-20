#!/usr/bin/env bash
# Break a goal into 3-7 concrete steps.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
GOAL="$*"; [[ -z "$GOAL" ]] && GOAL="$(cat)"
[[ -z "$GOAL" ]] && die "Usage: plan.sh <goal>"

ROOT=$(repo_root); ID=$(date +%Y%m%d-%H%M%S)
DIR="$ROOT/.agent-workspace/$ID"; mkdir -p "$DIR"
echo "$GOAL" > "$DIR/goal.txt"

{ echo "You are planning a task for a conservative agent to execute."; \
  echo "Break this goal into 3-7 concrete steps:"; \
  echo "  $GOAL"; \
  echo; echo "For each step, output EXACTLY this format:"; \
  echo "  ### Step N: <short title>"; \
  echo "  TYPE: shell   OR   TYPE: write"; \
  echo "  (if shell)  COMMAND: <the command to run>"; \
  echo "  (if write)  FILE: <path relative to ./.agent-workspace/${ID}/>"; \
  echo "              CONTENT_START"; \
  echo "              <exact file contents>"; \
  echo "              CONTENT_END"; \
  echo "RATIONALE: <1 line why>"; \
  echo; echo "Rules:"; \
  echo "  - Never propose rm, sudo, curl | sh, ssh, or anything that modifies system state outside the workspace."; \
  echo "  - All files live under ./.agent-workspace/${ID}/"; \
  echo "  - Each command should be under 200 chars."; } \
  | ollama run "$MODEL" > "$DIR/plan.md"

cat "$DIR/plan.md"
echo
ok "Plan saved to $DIR/plan.md"
echo "Execute with:  ./ai local-agent run $DIR/plan.md"

#!/usr/bin/env bash
# Analyze an error message and suggest fixes.  Error read from args or stdin.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
ERROR="$*"; [[ -z "$ERROR" ]] && ERROR="$(cat)"
[[ -z "$ERROR" ]] && die "Provide an error message (as args or stdin)."

{ echo "Diagnose the error below:"; \
  echo "  - What does the error mean (plain English)?"; \
  echo "  - What is the most likely cause?"; \
  echo "  - What are 1-3 ways to fix it, ranked by likelihood?"; \
  echo "  - If more context is needed, what should the user check?"; \
  echo; echo "Error:"; echo "$ERROR"; } \
  | ollama run "$MODEL"

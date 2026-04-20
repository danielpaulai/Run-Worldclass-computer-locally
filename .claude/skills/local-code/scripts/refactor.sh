#!/usr/bin/env bash
# Suggest refactoring improvements with rewritten snippets.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
FILE="$1"; [[ -f "$FILE" ]] || die "File not found: $FILE"
MODEL=$(get_model)
{ echo "Suggest refactoring improvements for the code below. For each improvement:"; \
  echo "  - Name the pattern or principle (e.g., 'extract function', 'guard clause', 'reduce nesting')"; \
  echo "  - Quote the original 3-10 lines"; \
  echo "  - Show the rewritten version"; \
  echo "  - Explain the benefit in one sentence"; \
  echo "Focus on clarity and maintainability, not micro-optimizations."; \
  echo; echo "File: $FILE"; echo; echo '```'; cat "$FILE"; echo '```'; } \
  | ollama run "$MODEL"

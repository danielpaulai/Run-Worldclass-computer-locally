#!/usr/bin/env bash
# Code review a file for bugs, style, and edge cases.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
FILE="$1"; [[ -f "$FILE" ]] || die "File not found: $FILE"
MODEL=$(get_model)
{ echo "Review the code below as a senior engineer. For each issue:"; \
  echo "  - Severity (blocker / major / minor / nit)"; \
  echo "  - Location (line number if clear)"; \
  echo "  - What's wrong"; \
  echo "  - Suggested fix"; \
  echo "Check for: bugs, edge cases, security issues, performance, readability, duplicated logic."; \
  echo "If the code is solid, say so in one line and stop."; \
  echo; echo "File: $FILE"; echo; echo '```'; cat "$FILE"; echo '```'; } \
  | ollama run "$MODEL"

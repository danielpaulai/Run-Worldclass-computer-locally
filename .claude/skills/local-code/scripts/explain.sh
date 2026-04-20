#!/usr/bin/env bash
# Explain what a code file does.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
FILE="$1"; [[ -f "$FILE" ]] || die "File not found: $FILE"
MODEL=$(get_model)
{ echo "Explain what the following code does. Be concise."; \
  echo "- Start with a 1-sentence summary of purpose."; \
  echo "- Then 3-6 bullets covering the main pieces."; \
  echo "- End with any non-obvious behavior or gotchas."; \
  echo; echo "File: $FILE"; echo; echo '```'; cat "$FILE"; echo '```'; } \
  | ollama run "$MODEL"

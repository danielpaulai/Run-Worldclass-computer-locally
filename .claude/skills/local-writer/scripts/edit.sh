#!/usr/bin/env bash
# Tighten existing prose.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
FILE="$1"; [[ -f "$FILE" ]] || die "File not found: $FILE"
MODEL=$(get_model)
{ echo "Edit the following prose for clarity and concision:"; \
  echo "  - Cut filler, hedges, and redundant phrasing."; \
  echo "  - Replace abstract language with concrete nouns/verbs."; \
  echo "  - Break up sentences that are too long."; \
  echo "  - Keep the author's voice and key points."; \
  echo "Output the edited version, then a short list of the most important changes you made."; \
  echo; cat "$FILE"; } | ollama run "$MODEL"

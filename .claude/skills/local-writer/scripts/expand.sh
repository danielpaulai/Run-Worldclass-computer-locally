#!/usr/bin/env bash
# Turn an outline into full prose.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
FILE="$1"; [[ -f "$FILE" ]] || die "File not found: $FILE"
MODEL=$(get_model)
{ echo "Expand the outline below into full prose. Rules:"; \
  echo "  - Follow the outline's structure faithfully."; \
  echo "  - Each bullet point becomes 1-3 sentences."; \
  echo "  - Add transitions between sections."; \
  echo "  - Don't invent new major claims not in the outline."; \
  echo "  - Lead each section with its strongest idea."; \
  echo; cat "$FILE"; } | ollama run "$MODEL"

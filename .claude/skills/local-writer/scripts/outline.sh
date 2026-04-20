#!/usr/bin/env bash
# Structured outline for a topic.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
TOPIC="$*"; [[ -z "$TOPIC" ]] && TOPIC="$(cat)"
{ echo "Produce a structured outline on: $TOPIC"; \
  echo "Format:"; \
  echo "  # Topic"; \
  echo "  ## Section 1"; \
  echo "    - key point"; \
  echo "    - key point"; \
  echo "  ## Section 2 ..."; \
  echo "Lead with the strongest angle. Include a 'What to cut' section at the bottom listing obvious-but-weaker ideas to skip."; } \
  | ollama run "$MODEL"

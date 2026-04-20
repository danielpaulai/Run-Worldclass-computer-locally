#!/usr/bin/env bash
# First draft from a brief.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
BRIEF="$*"; [[ -z "$BRIEF" ]] && BRIEF="$(cat)"
{ echo "Write a first draft based on this brief. Aim for clear, humane prose. No filler, no cliché."; \
  echo "Before writing, ask yourself: what's the single most important thing the reader needs to know? Lead with that."; \
  echo; echo "Brief: $BRIEF"; } | ollama run "$MODEL"

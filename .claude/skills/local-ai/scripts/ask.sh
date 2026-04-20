#!/usr/bin/env bash
# One-shot question to the local model.  Usage: ask.sh "your question"
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
if [[ $# -eq 0 ]]; then
  ai_ask "$MODEL"        # read from stdin
else
  ai_ask "$MODEL" "$@"
fi

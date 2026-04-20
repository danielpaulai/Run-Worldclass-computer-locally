#!/usr/bin/env bash
# Run a prompt at low temperature (0.1) for deterministic, factual output.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
USER="$*"; [[ -z "$USER" ]] && USER="$(cat)"
ai_ask_params "$MODEL" 0.1 0.5 "$USER"

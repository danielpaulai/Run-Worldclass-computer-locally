#!/usr/bin/env bash
# Run a prompt at high temperature (1.0) for brainstorming and creative output.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
USER="$*"; [[ -z "$USER" ]] && USER="$(cat)"
ai_ask_params "$MODEL" 1.0 0.95 "$USER"

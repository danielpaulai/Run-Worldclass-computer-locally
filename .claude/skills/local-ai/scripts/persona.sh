#!/usr/bin/env bash
# Apply a persona (system prompt) to a single question.  Usage: persona.sh <role> "<prompt>"
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)

ROLE="$1"; shift || die "Usage: persona.sh <role> <prompt>"
PERSONA_FILE="$(dirname "${BASH_SOURCE[0]}")/../prompts/personas/$ROLE.md"
[[ -f "$PERSONA_FILE" ]] || die "Unknown persona '$ROLE'.  Available: $(ls "$(dirname "$PERSONA_FILE")" | sed 's/\.md$//' | tr '\n' ' ')"

SYSTEM=$(cat "$PERSONA_FILE")
USER="$*"
[[ -z "$USER" ]] && USER="$(cat)"   # read stdin if no prompt

ai_ask_system "$MODEL" "$SYSTEM" "$USER"

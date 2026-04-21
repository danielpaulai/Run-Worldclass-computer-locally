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

# If stdin is piped in (not a tty), prepend it as context to the prompt.
# Supports workflows where previous step output feeds into this one.
if [[ ! -t 0 ]]; then
  STDIN="$(cat)"
  if [[ -n "$USER" ]]; then
    USER=$'Context from previous step:\n\n'"$STDIN"$'\n\n---\n\n'"$USER"
  else
    USER="$STDIN"
  fi
fi

[[ -z "$USER" ]] && die "No prompt provided and no stdin."

ai_ask_system "$MODEL" "$SYSTEM" "$USER"

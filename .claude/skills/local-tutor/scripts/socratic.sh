#!/usr/bin/env bash
# Socratic dialogue — the model only asks questions.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
TOPIC="$*"; [[ -z "$TOPIC" ]] && die "Usage: socratic.sh <topic>"

# Use the session script with a socratic system prompt pre-seeded
ROOT=$(repo_root); DIR="$ROOT/.ollama-sessions"; mkdir -p "$DIR"
NAME="socratic-$(date +%s)"
FILE="$DIR/$NAME.jsonl"

PERSONA=$(cat "$(dirname "${BASH_SOURCE[0]}")/../../local-ai/prompts/personas/socratic.md")
FIRST_Q=$(ai_ask_system "$MODEL" "$PERSONA" "We're going to think through '$TOPIC' together. Ask me your first question — one that opens up the most important unknown.")

echo
echo "$FIRST_Q"
echo

# Seed history with the system + first question
{
  printf '{"role":"system","content":'; printf '%s' "$PERSONA"  | _json_escape; printf '}\n'
  printf '{"role":"assistant","content":'; printf '%s' "$FIRST_Q" | _json_escape; printf '}\n'
} > "$FILE"

# Hand off to session for the back-and-forth
exec "$(dirname "${BASH_SOURCE[0]}")/../../local-ai/scripts/session.sh" "$NAME"

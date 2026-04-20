#!/usr/bin/env bash
# Rewrite prose in a different voice.  Usage: rewrite.sh <file> <voice>
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
FILE="$1"; VOICE="$2"
[[ -f "$FILE" ]] || die "File not found: $FILE"
[[ -n "$VOICE" ]] || die "Usage: rewrite.sh <file> <voice>   (voices: formal, casual, tight, warm, punchy, academic)"
MODEL=$(get_model)

declare -A HINTS=(
  [formal]="Formal register. Complete sentences. No contractions. Third person where natural."
  [casual]="Conversational. Contractions. First person OK. Short sentences, dry humor is fine."
  [tight]="Cut half the words. Every sentence earns its place. No throat-clearing."
  [warm]="Humane, generous. Acknowledge the reader. Avoid corporate-speak."
  [punchy]="Short sentences. Strong verbs. Begin paragraphs with the conclusion."
  [academic]="Precise, qualified. Cite claims where possible. No rhetoric."
)
HINT="${HINTS[$VOICE]:-"Rewrite in the '$VOICE' voice, applying whatever stylistic conventions that implies."}"

{ echo "Rewrite the following in the specified voice:"; \
  echo "Voice: $VOICE"; echo "Guidance: $HINT"; \
  echo; cat "$FILE"; } | ollama run "$MODEL"

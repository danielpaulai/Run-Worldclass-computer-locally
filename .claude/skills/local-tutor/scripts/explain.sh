#!/usr/bin/env bash
# Clean, patient intro to a topic.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
TOPIC="$*"; [[ -z "$TOPIC" ]] && TOPIC="$(cat)"

PERSONA_FILE="$(dirname "${BASH_SOURCE[0]}")/../../local-ai/prompts/personas/tutor.md"
SYSTEM=$(cat "$PERSONA_FILE" 2>/dev/null || echo "You are a patient tutor.")

ai_ask_system "$MODEL" "$SYSTEM" "Explain: $TOPIC

Structure:
1. One-sentence 'here's what it is'
2. One concrete analogy
3. Three key ideas, each with an example
4. One common misunderstanding to watch out for
5. End with: 'In your own words, what's [most important concept]?'"

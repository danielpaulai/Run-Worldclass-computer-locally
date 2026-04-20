#!/usr/bin/env bash
# Read stdin, apply an instruction, print the model's output.
# Usage:  cat file.txt | ./ai local-ai pipe "Summarize this in 3 bullets."
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)

INSTRUCTION="$*"
[[ -z "$INSTRUCTION" ]] && die "Usage: pipe.sh \"<instruction>\"   (stdin is the content)"

# Read all of stdin
CONTENT="$(cat)"
[[ -z "$CONTENT" ]] && die "No stdin content."

PROMPT="${INSTRUCTION}

---
${CONTENT}
---"

printf '%s' "$PROMPT" | ollama run "$MODEL"

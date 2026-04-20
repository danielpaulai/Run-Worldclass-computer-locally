#!/usr/bin/env bash
# Break a question into 5-8 sub-questions.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
Q="$*"; [[ -z "$Q" ]] && Q="$(cat)"
[[ -z "$Q" ]] && die "Usage: plan.sh <research question>"

ROOT=$(repo_root); SLUG=$(echo "$Q" | tr '[:upper:] ' '[:lower:]-' | tr -cd 'a-z0-9-' | cut -c1-40)
DIR="$ROOT/.research/${SLUG}-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$DIR"; echo "$Q" > "$DIR/question.txt"

{ echo "Break this research question into 5-8 specific sub-questions that together would produce a thorough answer."; \
  echo "Each sub-question:"; \
  echo "  - Should be answerable independently"; \
  echo "  - Should cover a different angle (causes, evidence, counterpoints, examples, implications)"; \
  echo "Output ONLY a numbered list of sub-questions, no preamble."; \
  echo; echo "Main question: $Q"; } | ollama run "$MODEL" > "$DIR/plan.md"

cat "$DIR/plan.md"
echo
ok "Plan saved to $DIR/plan.md"
echo "Gather answers with:  ./ai local-research gather $DIR/plan.md"

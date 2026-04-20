#!/usr/bin/env bash
# Feynman technique: you explain, the model critiques.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
TOPIC="$*"; [[ -z "$TOPIC" ]] && die "Usage: feynman.sh <topic>"

echo "Explain '$TOPIC' in your own words, as if teaching a curious 15-year-old."
echo "Write as much as you want. Press Ctrl-D when done."
echo
echo "---"
EXPLANATION="$(cat)"
[[ -z "$EXPLANATION" ]] && die "No explanation given."

say "Critiquing your explanation..."
echo "A student tried to explain '$TOPIC' to a 15-year-old. Evaluate the explanation:
  - What they got right (specific, not flattery)
  - What they glossed over or got wrong
  - One question their explanation doesn't answer that it should
  - A rewritten version of the weakest paragraph

Explanation:
$EXPLANATION" | ollama run "$MODEL"

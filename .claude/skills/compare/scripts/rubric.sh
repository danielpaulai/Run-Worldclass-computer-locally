#!/usr/bin/env bash
# Local model answers, then self-scores on accuracy, clarity, completeness.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
PROMPT="$*"; [[ -z "$PROMPT" ]] && PROMPT="$(cat)"

# Pass 1: answer
ANSWER=$(echo "$PROMPT" | ollama run "$MODEL")

# Pass 2: self-scoring
RUBRIC="You are evaluating the following answer on three dimensions:
  - Accuracy (1-10): are the factual claims correct?
  - Clarity (1-10): is it easy to understand?
  - Completeness (1-10): does it cover what was asked?
For each, give a score and a one-sentence justification. Then give an overall verdict in one sentence.

Question: $PROMPT

Answer: $ANSWER"

echo
echo "## Answer"
echo
echo "$ANSWER"
echo
echo "## Self-evaluation"
echo
echo "$RUBRIC" | ollama run "$MODEL"

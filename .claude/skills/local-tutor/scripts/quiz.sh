#!/usr/bin/env bash
# Interactive quiz.  Generates N questions, grades your answers.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
TOPIC="$1"; [[ -z "$TOPIC" ]] && die "Usage: quiz.sh <topic> [n]"
N="${2:-5}"

say "Generating $N quiz questions on: $TOPIC"
QUIZ=$(echo "Generate $N quiz questions on the topic '$TOPIC'. Output format:
Q1. <question>
Q2. <question>
...
No answers yet. Questions should progress from recall to analysis." \
  | ollama run "$MODEL")

echo "$QUIZ"
echo
echo "---"
echo "Answer each question.  Type 'done' when finished."
echo

ANSWERS=""
idx=1
while IFS= read -r q; do
  case "$q" in Q*|[0-9]*) ;; *) continue ;; esac
  printf "\n%s\nYour answer: " "$q"
  read -r a
  [[ "$a" == "done" ]] && break
  ANSWERS+="$q"$'\n'"Your answer: $a"$'\n\n'
  idx=$((idx+1))
done <<< "$QUIZ"

[[ -z "$ANSWERS" ]] && { echo "No answers given."; exit 0; }

say "Grading..."
echo "Grade these answers on topic '$TOPIC'. For each:
  - Score 0-2 (0 wrong, 1 partial, 2 correct)
  - One-line feedback
  - Correct answer if score < 2
At the end give overall score and one suggested follow-up topic.

$ANSWERS" | ollama run "$MODEL"

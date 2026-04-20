#!/usr/bin/env bash
# Run a 5-prompt evaluation suite: reasoning, code, writing, factual, creative.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)

ROOT=$(repo_root)
OUT="$ROOT/.benchmarks/$(date +%Y%m%d-%H%M%S)-$(echo "$MODEL" | tr ':/' '__')"
mkdir -p "$OUT"

declare -A PROMPTS=(
  [reasoning]="A man has 3 daughters. Each daughter has 1 brother. How many children does the man have? Explain step by step."
  [code]="Write a Python function that returns the longest palindromic substring in O(n) time using Manacher's algorithm. Include docstring and one example."
  [writing]="Write a 150-word letter to a former mentor thanking them for something specific they taught you. Warm but not saccharine."
  [factual]="List the 8 planets of the solar system in order from the Sun, with each planet's equatorial diameter in kilometers."
  [creative]="Invent a plausible-sounding product that doesn't exist yet, describe it in 100 words, and name its three biggest skeptics."
)

say "Running full benchmark on $MODEL. 5 prompts."
echo "hello" | ollama run "$MODEL" >/dev/null 2>&1  # warm up

for category in reasoning code writing factual creative; do
  say "[$category]"
  prompt="${PROMPTS[$category]}"
  output=$(echo "$prompt" | ollama run "$MODEL" --verbose 2>&1)
  {
    echo "### $category"
    echo
    echo "**Prompt:** $prompt"
    echo
    echo "**Response:**"
    echo
    echo "$output" | sed '/eval rate\|prompt eval\|total duration\|load duration/d'
    echo
    echo "**Timings:**"
    echo "$output" | grep -E "(eval rate|prompt eval|total duration)" || true
    echo
  } >> "$OUT/report.md"
  echo "$output" | grep -E "eval rate" | tail -1
done

echo
ok "Saved report to $OUT/report.md"

#!/usr/bin/env bash
# Quick single-prompt speed test.  Reports tokens/sec and time-to-first-token.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)

say "Warming up $MODEL..."
echo "hello" | ollama run "$MODEL" >/dev/null 2>&1

PROMPT="Write a 200-word explanation of how a transformer works, for a curious beginner."
say "Benchmarking..."
OUTPUT=$(echo "$PROMPT" | ollama run "$MODEL" --verbose 2>&1)

echo "$OUTPUT" | tail -20
echo
ok "Model: $MODEL"
echo "$OUTPUT" | grep -E "(eval rate|prompt eval|total duration)" || true

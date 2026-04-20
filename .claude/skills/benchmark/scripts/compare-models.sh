#!/usr/bin/env bash
# Run the quick benchmark on every installed model, then rank by tokens/sec.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama

MODELS=$(ollama list | awk 'NR>1 {print $1}')
[[ -z "$MODELS" ]] && die "No models installed.  Run ./setup.sh first."

PROMPT="Write a 150-word summary of the industrial revolution."
TMP=$(mktemp)
trap 'rm -f "$TMP"' EXIT

printf "%-30s %12s %12s\n" "MODEL" "TOK/S" "TTFT (s)"
printf -- '-%.0s' {1..60}; echo

for M in $MODELS; do
  echo "hello" | ollama run "$M" >/dev/null 2>&1 || continue  # warm
  OUT=$(echo "$PROMPT" | ollama run "$M" --verbose 2>&1)
  RATE=$(echo "$OUT"  | awk -F': *' '/eval rate/ {print $2; exit}' | awk '{print $1}')
  TTFT=$(echo "$OUT"  | awk -F': *' '/prompt eval duration/ {print $2; exit}' | awk '{print $1}')
  printf "%-30s %12s %12s\n" "$M" "${RATE:-?}" "${TTFT:-?}"
done

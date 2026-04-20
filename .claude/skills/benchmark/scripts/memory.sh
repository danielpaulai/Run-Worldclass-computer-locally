#!/usr/bin/env bash
# Peak memory usage during a large prompt.  Samples ps every 0.5s.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)

PROMPT="Write a 2000-word essay comparing three philosophies of education, with citations where plausible."
say "Running 2000-word prompt to stress memory... (~30-60s)"

echo "$PROMPT" | ollama run "$MODEL" >/dev/null 2>&1 &
OLLAMA_PID=$!

PEAK_MB=0
while kill -0 "$OLLAMA_PID" 2>/dev/null; do
  # Sample RSS of all ollama processes (includes the runner)
  SAMPLE=$(ps -ax -o rss,comm | awk '/ollama/ {sum+=$1} END {print sum/1024}')
  SAMPLE_INT=${SAMPLE%.*}
  (( SAMPLE_INT > PEAK_MB )) && PEAK_MB=$SAMPLE_INT
  sleep 0.5
done

wait "$OLLAMA_PID" 2>/dev/null || true
echo
ok "Peak RAM used by Ollama during inference:  ${PEAK_MB} MB  (~$((PEAK_MB/1024)) GB)"

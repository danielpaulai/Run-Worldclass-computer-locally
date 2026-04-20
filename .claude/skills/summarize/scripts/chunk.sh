#!/usr/bin/env bash
# Map-reduce summarization for long files.  Chunks the input, summarizes each,
# then summarizes the summaries.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
FILE="$1"; [[ -f "$FILE" ]] || die "File not found: $FILE"
MODEL=$(get_model)

CHUNK_CHARS=${CHUNK_CHARS:-20000}
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

say "Splitting $FILE into chunks of ${CHUNK_CHARS} chars..."
split -b "$CHUNK_CHARS" "$FILE" "$TMP/chunk_"
N=$(ls "$TMP"/chunk_* | wc -l | tr -d ' ')
ok "Created $N chunks."

i=0
for c in "$TMP"/chunk_*; do
  i=$((i+1))
  say "Summarizing chunk $i/$N..."
  { echo "Summarize the following chunk (this is part $i of $N of a longer document) in 3-5 bullets. Be factual."; \
    echo; cat "$c"; } \
    | ollama run "$MODEL" > "$c.sum"
done

say "Combining $N chunk summaries into final summary..."
{ echo "Below are $N partial summaries of a long document. Combine them into one coherent summary:"; \
  echo "- A 3-sentence TLDR at the top."; \
  echo "- Then 5-10 bullet points covering key ideas."; \
  echo "- Merge duplicate points, keep important details."; \
  echo; cat "$TMP"/chunk_*.sum; } \
  | ollama run "$MODEL"

echo
ok "Processed locally ($N chunks)."

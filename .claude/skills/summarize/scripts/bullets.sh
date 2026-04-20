#!/usr/bin/env bash
# 5-8 bullet key points.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
FILE="$1"; [[ -f "$FILE" ]] || die "File not found: $FILE"
MODEL=$(get_model)
{ echo "Summarize the following document as 5 to 8 bullet points. Each bullet should be one short line. Cover the key decisions, facts, and takeaways. No preamble, no conclusion — just bullets."; echo; cat "$FILE"; } \
  | ollama run "$MODEL"
echo
ok "Processed locally."

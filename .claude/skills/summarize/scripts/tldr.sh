#!/usr/bin/env bash
# 3-sentence summary of a file.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
FILE="$1"; [[ -f "$FILE" ]] || die "File not found: $FILE"
MODEL=$(get_model)
{ echo "Summarize the following document in exactly 3 sentences. Lead with the single most important point. No preamble."; echo; cat "$FILE"; } \
  | ollama run "$MODEL"
echo
ok "Processed locally — $FILE never left your machine."

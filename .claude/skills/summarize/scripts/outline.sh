#!/usr/bin/env bash
# Hierarchical markdown outline.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
FILE="$1"; [[ -f "$FILE" ]] || die "File not found: $FILE"
MODEL=$(get_model)
{ echo "Produce a hierarchical markdown outline of the following document. Use # for top-level themes, ## for sub-points, ### for details. Preserve the document's logical structure. No preamble."; echo; cat "$FILE"; } \
  | ollama run "$MODEL"
echo
ok "Processed locally."

#!/usr/bin/env bash
# Extract action items and owners.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
FILE="$1"; [[ -f "$FILE" ]] || die "File not found: $FILE"
MODEL=$(get_model)
{ echo "Extract every action item from the following document. For each, output one line in this exact format:"; \
  echo "  - [ ] <action>  (owner: <name or 'unassigned'>, due: <date or 'unspecified'>)"; \
  echo "Do not include anything else. If there are no action items, output exactly: No action items found."; \
  echo; cat "$FILE"; } \
  | ollama run "$MODEL"
echo
ok "Processed locally."

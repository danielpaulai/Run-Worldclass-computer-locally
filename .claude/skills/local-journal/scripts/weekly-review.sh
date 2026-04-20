#!/usr/bin/env bash
# Summarize the past 7 days of journal entries.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
ROOT=$(repo_root); DIR="$ROOT/.journal"
[[ -d "$DIR" ]] || die "No journal yet."

# Collect last 7 days
TMP=$(mktemp); trap 'rm -f "$TMP"' EXIT
for i in 6 5 4 3 2 1 0; do
  d=$(date -v-${i}d +%Y-%m-%d 2>/dev/null || date -d "-$i days" +%Y-%m-%d)
  f="$DIR/$d.md"
  [[ -f "$f" ]] && { echo; echo "=== $d ==="; cat "$f"; } >> "$TMP"
done

[[ -s "$TMP" ]] || die "No entries in the last 7 days."

{ echo "Produce a weekly review of these journal entries:"; \
  echo "  - 3-5 themes that came up"; \
  echo "  - What the writer seems to have been working through"; \
  echo "  - What felt stuck"; \
  echo "  - One forward-looking question for next week"; \
  echo "Be specific. Don't generalize."; \
  echo; cat "$TMP"; } \
  | ollama run "$MODEL"

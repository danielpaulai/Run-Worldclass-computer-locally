#!/usr/bin/env bash
# Combine gathered answers into a coherent report.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
GATHERED="$1"; [[ -f "$GATHERED" ]] || die "Gathered file not found: $GATHERED"
Q=$(cat "$(dirname "$GATHERED")/question.txt" 2>/dev/null || echo "(unknown)")
OUT="$(dirname "$GATHERED")/report.md"

{ echo "Produce a coherent research report answering this question:"; \
  echo "  $Q"; \
  echo; echo "You have research notes organized by sub-question below. Use them to produce:"; \
  echo "  1. A 3-sentence executive summary"; \
  echo "  2. A structured body with 4-6 sections"; \
  echo "  3. A 'Key tensions / open questions' section"; \
  echo "  4. A final 'What I would do next' section"; \
  echo "Refer to specific sub-questions by paraphrasing, don't just copy."; \
  echo; cat "$GATHERED"; } | ollama run "$MODEL" > "$OUT"

cat "$OUT"
echo
ok "Report saved to $OUT"

#!/usr/bin/env bash
# Answer each sub-question in a plan file.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
PLAN="$1"; [[ -f "$PLAN" ]] || die "Plan file not found: $PLAN"
OUT="$(dirname "$PLAN")/gathered.md"

: > "$OUT"
while IFS= read -r q; do
  q=$(echo "$q" | sed -E 's/^[[:space:]]*[0-9]+[.)][[:space:]]*//; s/^-[[:space:]]*//')
  [[ -z "$q" ]] && continue
  say "Answering: $q"
  {
    echo "## $q"
    echo
    echo "$q" | ollama run "$MODEL"
    echo
  } >> "$OUT"
done < "$PLAN"

ok "Gathered answers saved to $OUT"
echo "Synthesize with:  ./ai local-research synthesize $OUT"

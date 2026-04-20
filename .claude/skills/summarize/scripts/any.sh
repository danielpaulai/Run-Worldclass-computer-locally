#!/usr/bin/env bash
# Auto-detect file type and route to the right extractor + summarizer.
# Supports .txt, .md, .pdf, .docx.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
FILE="$1"; [[ -f "$FILE" ]] || die "File not found: $FILE"
MODEL=$(get_model)

EXT="${FILE##*.}"
EXT="${EXT,,}"
TMP=$(mktemp)
trap 'rm -f "$TMP"' EXIT

case "$EXT" in
  txt|md|markdown|log|json|yaml|yml|csv|sh|py|js|ts|html|xml)
    cp "$FILE" "$TMP" ;;
  pdf)
    command -v pdftotext >/dev/null 2>&1 || die "pdftotext required.  Install: brew install poppler  (macOS)  /  apt install poppler-utils  (Linux)"
    pdftotext -layout "$FILE" "$TMP" ;;
  docx)
    command -v pandoc >/dev/null 2>&1 || die "pandoc required.  Install: brew install pandoc  /  apt install pandoc"
    pandoc "$FILE" -t plain -o "$TMP" ;;
  *)
    warn "Unknown extension '$EXT'.  Treating as plain text."
    cp "$FILE" "$TMP" ;;
esac

SIZE=$(wc -c < "$TMP" | tr -d ' ')
if (( SIZE > 100000 )); then
  say "File is large ($SIZE chars).  Using chunked summarization..."
  exec "$(dirname "${BASH_SOURCE[0]}")/chunk.sh" "$TMP"
else
  say "File is $SIZE chars.  Producing a combined summary (TLDR + bullets + actions)..."
  { echo "You will summarize the document below. Produce three sections:"; \
    echo "## TLDR"; echo "Three sentences."; echo; \
    echo "## Key points"; echo "5-8 bullets."; echo; \
    echo "## Action items"; echo "List any action items in '- [ ] action (owner)' format, or 'None' if there aren't any."; \
    echo; cat "$TMP"; } \
    | ollama run "$MODEL"
  echo
  ok "Processed locally — $FILE never left your machine."
fi

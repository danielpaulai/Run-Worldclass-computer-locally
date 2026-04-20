#!/usr/bin/env bash
# Generate unit tests for a file.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
FILE="$1"; [[ -f "$FILE" ]] || die "File not found: $FILE"
MODEL=$(get_model)
EXT="${FILE##*.}"
{ echo "Write unit tests for the code below. Use the idiomatic test framework for the language:"; \
  echo "  - .py  -> pytest"; \
  echo "  - .js/.ts -> vitest or jest"; \
  echo "  - .go -> standard testing package"; \
  echo "  - .rs -> #[test]"; \
  echo "  - .rb -> RSpec"; \
  echo "Cover happy paths AND edge cases. Include at least one failure case. No commentary, just the test file."; \
  echo; echo "Language: .$EXT"; echo "Source file: $FILE"; echo; echo '```'; cat "$FILE"; echo '```'; } \
  | ollama run "$MODEL"

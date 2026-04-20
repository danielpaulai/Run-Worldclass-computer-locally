#!/usr/bin/env bash
# Multi-turn conversation with persistent history.  Usage: session.sh [name]
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)

NAME="${1:-default}"
DIR="$(repo_root)/.ollama-sessions"
mkdir -p "$DIR"
FILE="$DIR/$NAME.jsonl"

[[ -f "$FILE" ]] && ok "Resuming session '$NAME' ($(wc -l <"$FILE" | tr -d ' ') previous turns)" \
                || ok "New session '$NAME'"
echo "Type messages and press Enter.  /bye to exit, /reset to clear history, /show to dump history."

build_body() {
  local user="$1"
  {
    printf '{"model":"%s","stream":false,"messages":[' "$MODEL"
    local first=1
    if [[ -f "$FILE" ]]; then
      while IFS= read -r line; do
        [[ -z "$line" ]] && continue
        [[ $first -eq 0 ]] && printf ','
        printf '%s' "$line"
        first=0
      done < "$FILE"
    fi
    [[ $first -eq 0 ]] && printf ','
    printf '{"role":"user","content":'
    printf '%s' "$user" | _json_escape
    printf '}]}'
  }
}

while :; do
  printf "\n> "
  read -r user || break
  case "$user" in
    /bye|'') break ;;
    /reset) : > "$FILE"; echo "[history cleared]"; continue ;;
    /show)  cat "$FILE"; continue ;;
  esac
  body=$(build_body "$user")
  reply=$(curl -s http://localhost:11434/api/chat -d "$body" \
            | sed -n 's/.*"content":"\(.*\)","role.*/\1/p' \
            | _json_unescape)
  printf '\n%s\n' "$reply"
  # Append both messages to history
  {
    printf '{"role":"user","content":'; printf '%s' "$user"  | _json_escape; printf '}\n'
    printf '{"role":"assistant","content":'; printf '%s' "$reply" | _json_escape; printf '}\n'
  } >> "$FILE"
done
echo
ok "Session '$NAME' saved to $FILE"

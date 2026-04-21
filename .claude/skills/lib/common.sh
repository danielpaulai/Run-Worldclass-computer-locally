#!/usr/bin/env bash
# Shared helpers for every skill.  Source this from any skill script:
#   source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"

# --- colors / logging ---
_c_reset='\033[0m'; _c_cyan='\033[1;36m'; _c_green='\033[1;32m'
_c_yellow='\033[1;33m'; _c_red='\033[1;31m'; _c_dim='\033[2m'
say()  { printf "${_c_cyan}==>${_c_reset} %s\n" "$*"; }
ok()   { printf "${_c_green}[ok]${_c_reset}  %s\n" "$*"; }
warn() { printf "${_c_yellow}[!]${_c_reset}   %s\n" "$*"; }
err()  { printf "${_c_red}[x]${_c_reset}   %s\n" "$*" >&2; }
die()  { err "$*"; exit 1; }

# --- repo root discovery ---
# Walks up from the calling script until it finds .git or .selected-model.
repo_root() {
  local d; d="$(cd "$(dirname "${BASH_SOURCE[1]:-$0}")" && pwd)"
  while [[ "$d" != "/" ]]; do
    [[ -d "$d/.git" || -f "$d/.selected-model" ]] && { echo "$d"; return; }
    d="$(dirname "$d")"
  done
  # Fallback: caller's directory
  cd "$(dirname "${BASH_SOURCE[1]:-$0}")" && pwd
}

# --- active model ---
get_model() {
  local root; root="$(repo_root)"
  [[ -f "$root/.selected-model" ]] || die "No model selected. Run ./setup.sh first."
  cat "$root/.selected-model"
}

# --- ensure Ollama is running ---
ollama_up() { curl -s --max-time 2 http://localhost:11434/api/version >/dev/null 2>&1; }

ensure_ollama() {
  ollama_up && return 0
  say "Starting Ollama..."
  case "$(uname -s)" in
    Darwin)
      brew services start ollama >/dev/null 2>&1 || nohup ollama serve >/tmp/ollama.log 2>&1 &
      ;;
    Linux)
      if command -v systemctl >/dev/null 2>&1; then
        sudo systemctl start ollama 2>/dev/null || nohup ollama serve >/tmp/ollama.log 2>&1 &
      else
        nohup ollama serve >/tmp/ollama.log 2>&1 &
      fi
      ;;
  esac
  for _ in $(seq 1 10); do ollama_up && return 0; sleep 1; done
  die "Ollama did not start. Try: brew services restart ollama"
}

# --- core calls ---
# One-shot prompt (no system message).
ai_ask() {
  local model="${1:-$(get_model)}"
  shift || true
  # If no additional args, read from stdin; else join args as the prompt.
  if [[ $# -eq 0 ]]; then
    ollama run "$model"
  else
    printf "%s\n" "$*" | ollama run "$model"
  fi
}

# Prompt with a system message.  Uses /api/chat.
ai_ask_system() {
  local model="$1" system="$2" user="$3"
  python3 - "$model" "$system" "$user" <<'PY'
import sys, json, urllib.request
model, system, user = sys.argv[1], sys.argv[2], sys.argv[3]
body = json.dumps({
    "model": model, "stream": False,
    "messages": [
        {"role": "system", "content": system},
        {"role": "user",   "content": user},
    ],
}).encode()
req = urllib.request.Request(
    "http://localhost:11434/api/chat",
    data=body, headers={"Content-Type": "application/json"},
)
with urllib.request.urlopen(req, timeout=600) as r:
    data = json.loads(r.read())
print(data.get("message", {}).get("content", ""))
PY
}

# Prompt with temperature / top_p options.
ai_ask_params() {
  local model="$1" temp="$2" top_p="$3" user="$4"
  python3 - "$model" "$temp" "$top_p" "$user" <<'PY'
import sys, json, urllib.request
model, temp, top_p, user = sys.argv[1], float(sys.argv[2]), float(sys.argv[3]), sys.argv[4]
body = json.dumps({
    "model": model, "stream": False,
    "options": {"temperature": temp, "top_p": top_p},
    "messages": [{"role": "user", "content": user}],
}).encode()
req = urllib.request.Request(
    "http://localhost:11434/api/chat",
    data=body, headers={"Content-Type": "application/json"},
)
with urllib.request.urlopen(req, timeout=600) as r:
    data = json.loads(r.read())
print(data.get("message", {}).get("content", ""))
PY
}

# --- tiny JSON helpers (no jq required) ---
_json_escape() {
  # Stdin -> JSON string (including quotes)
  python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))'
}
_json_unescape() {
  # Strip the leading/trailing wrapping and unescape
  python3 -c 'import json,sys; print(json.loads("\""+sys.stdin.read().rstrip()+"\""))'
}

# --- embedding helper (for RAG) ---
# Uses the first available embedding model, pulling nomic-embed-text if needed.
ai_embed() {
  local text="$1"
  local emb_model="nomic-embed-text"
  if ! ollama list | awk 'NR>1 {print $1}' | grep -qx "$emb_model"; then
    ollama pull "$emb_model" >/dev/null 2>&1 || die "Could not pull embedding model."
  fi
  local body
  body=$(cat <<JSON
{"model":"$emb_model","prompt":$(printf '%s' "$text" | _json_escape)}
JSON
)
  curl -s http://localhost:11434/api/embeddings -d "$body"
}

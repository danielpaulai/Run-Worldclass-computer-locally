#!/usr/bin/env bash
# Tail Ollama logs.  Usage: logs.sh [N]   default 50 lines.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
N="${1:-50}"

case "$(uname -s)" in
  Darwin)
    # Homebrew services log
    LOG="$HOMEBREW_PREFIX/var/log/ollama.log"
    [[ -z "$HOMEBREW_PREFIX" ]] && LOG="/opt/homebrew/var/log/ollama.log"
    [[ ! -f "$LOG" ]] && LOG="/usr/local/var/log/ollama.log"
    [[ -f "$LOG" ]] || LOG="/tmp/ollama.log"
    ;;
  Linux)
    if command -v journalctl >/dev/null 2>&1; then
      exec journalctl -u ollama -n "$N" --no-pager
    fi
    LOG="/tmp/ollama.log"
    ;;
esac

[[ -f "$LOG" ]] || die "No Ollama log found at $LOG"
tail -n "$N" "$LOG"

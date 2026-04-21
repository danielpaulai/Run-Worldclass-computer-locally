#!/usr/bin/env bash
#
# Fuzz test — feeds each skill weird inputs and checks for hang/crash/empty.
# Inputs: empty, unicode, emoji, large file, path with spaces, binary.
#
set -u

cd "$(dirname "${BASH_SOURCE[0]}")/.."
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# --- Fixture files ---
: > "$TMP/empty.txt"
printf '日本語テスト αβγ привет 你好世界\n' > "$TMP/unicode.txt"
printf '🚀 rocket 🎉 party 💻 laptop\n' > "$TMP/emoji.txt"
python3 -c "print('lorem ipsum dolor sit amet ' * 5000)" > "$TMP/large.txt"   # ~135 KB
mkdir -p "$TMP/has spaces in path"
echo "content behind a spaced path" > "$TMP/has spaces in path/file.txt"
head -c 1024 /dev/urandom > "$TMP/binary.bin"

PASS=0; FAIL=0
FAILED=()

pick_timeout() {
  if command -v timeout  >/dev/null 2>&1; then echo "timeout 60";
  elif command -v gtimeout >/dev/null 2>&1; then echo "gtimeout 60";
  else echo ""; fi
}
TIMEOUT=$(pick_timeout)

run_fuzz() {
  local label="$1"; shift
  printf "  %-55s " "$label"
  local out; out=$(mktemp)
  if $TIMEOUT "$@" > "$out" 2>&1; then
    if [[ -s "$out" ]]; then
      printf "\033[1;32mPASS\033[0m\n"
      PASS=$((PASS+1))
    else
      printf "\033[1;33mEMPTY\033[0m\n"
      FAIL=$((FAIL+1)); FAILED+=("$label")
    fi
  else
    printf "\033[1;31mFAIL\033[0m (exit $?)\n"
    FAIL=$((FAIL+1)); FAILED+=("$label")
    tail -3 "$out" | sed 's/^/      /'
  fi
  rm -f "$out"
}

echo
echo "=================================================="
echo "  Fuzz test — weird inputs on every major skill"
echo "=================================================="
echo

# --- local-ai ---
run_fuzz "local-ai ask  empty stdin"          bash -c "echo '' | ./ai local-ai ask"
run_fuzz "local-ai ask  unicode prompt"       ./ai local-ai ask "Translate to English: 日本語で「こんにちは」"
run_fuzz "local-ai ask  emoji prompt"         ./ai local-ai ask "Explain 🚀 in one sentence"
run_fuzz "local-ai persona  stdin context"    bash -c "cat '$TMP/large.txt' | ./ai local-ai persona engineer 'Summarize this'"

# --- summarize ---
run_fuzz "summarize tldr  empty file"         ./ai summarize tldr "$TMP/empty.txt"
run_fuzz "summarize tldr  unicode file"       ./ai summarize tldr "$TMP/unicode.txt"
run_fuzz "summarize tldr  large file (~135k)" ./ai summarize tldr "$TMP/large.txt"
run_fuzz "summarize tldr  path-with-spaces"   ./ai summarize tldr "$TMP/has spaces in path/file.txt"
run_fuzz "summarize bullets  unicode"         ./ai summarize bullets "$TMP/unicode.txt"

# --- local-code ---
run_fuzz "local-code review  empty file"      ./ai local-code review "$TMP/empty.txt"
run_fuzz "local-code review  path w/ spaces"  ./ai local-code review "$TMP/has spaces in path/file.txt"

# --- local-writer ---
run_fuzz "local-writer draft  emoji brief"    ./ai local-writer draft "Write a tagline for 🚀🎉 rocket"
run_fuzz "local-writer draft  empty brief"    bash -c "echo '' | ./ai local-writer draft"

# --- local-tutor ---
run_fuzz "local-tutor explain  unicode topic" ./ai local-tutor explain "トランスフォーマーとは"

# --- model-manager (no model calls, just bash) ---
run_fuzz "model-manager list"                  ./ai model-manager list
run_fuzz "model-manager disk-audit"            ./ai model-manager disk-audit

# --- privacy-audit ---
run_fuzz "privacy-audit listeners"             ./ai privacy-audit listeners

echo
echo "=================================================="
printf "  %s passed · %s failed / empty\n" "$PASS" "$FAIL"
echo "=================================================="

if (( FAIL > 0 )); then
  echo
  echo "Failures:"
  printf '    - %s\n' "${FAILED[@]}"
  exit 1
fi
echo "All fuzz inputs produced non-empty output."

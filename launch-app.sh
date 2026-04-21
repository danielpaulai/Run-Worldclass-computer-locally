#!/usr/bin/env bash
#
# One-command launcher for the Local AI Workshop desktop app.
# Handles everything — just run:  ./launch-app.sh
#
set -e

# Go to the repo root (dir containing this script), portable on macOS/Linux
cd "$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

APP_DIR="desktop-app"

bold()  { printf "\033[1m%s\033[0m\n" "$1"; }
green() { printf "\033[1;32m%s\033[0m\n" "$1"; }
yellow(){ printf "\033[1;33m%s\033[0m\n" "$1"; }
red()   { printf "\033[1;31m%s\033[0m\n" "$1"; }

# ---------- sanity ----------
if [[ ! -d "$APP_DIR" ]]; then
  red "Cannot find $APP_DIR/ — are you running this from the repo root?"
  exit 1
fi

if ! command -v node >/dev/null 2>&1; then
  red "Node.js isn't installed."
  echo "Install it with:  brew install node"
  echo "Then re-run ./launch-app.sh"
  exit 1
fi

cd "$APP_DIR"

# ---------- first-time install ----------
if [[ ! -d "node_modules" ]]; then
  bold "First-time setup: installing Electron (~150 MB, ~1 minute)..."
  echo
  npm install
  echo
  green "Done installing."
  echo
fi

# ---------- launch ----------
bold "Launching Local AI Workshop..."
echo "(Close the app window or press Ctrl-C here to quit.)"
echo
npm start

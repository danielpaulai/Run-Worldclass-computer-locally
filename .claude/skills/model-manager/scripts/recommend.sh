#!/usr/bin/env bash
# Recommend models for the user's RAM + use case.  Usage: recommend.sh [general|code|reasoning|vision|embedding]
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"

USE="${1:-general}"
CATALOG="$(dirname "${BASH_SOURCE[0]}")/../data/catalog.json"

if [[ "$(uname -s)" == "Darwin" ]]; then
  RAM_GB=$(( $(sysctl -n hw.memsize) / 1024 / 1024 / 1024 ))
else
  RAM_GB=$(( $(awk '/^MemTotal:/ {print $2}' /proc/meminfo) / 1024 / 1024 ))
fi

say "Your RAM: ${RAM_GB} GB — recommended '$USE' models:"
echo
python3 - "$CATALOG" "$USE" "$RAM_GB" <<'PY'
import json, sys
cat = json.load(open(sys.argv[1]))
use = sys.argv[2]
ram = int(sys.argv[3])
if use not in cat:
    print(f"Unknown use case '{use}'. Try one of: {list(cat.keys())}")
    sys.exit(1)
fit = [m for m in cat[use] if m["ram_gb"] <= ram]
if not fit:
    print("  None of the catalog models fit your RAM. Consider smaller models.")
    sys.exit(0)
for m in fit:
    print(f"  {m['name']:30}  {m['size_gb']:2} GB download   — {m['notes']}")
PY
echo
echo "  Install with:  ./ai model-manager install <name>"

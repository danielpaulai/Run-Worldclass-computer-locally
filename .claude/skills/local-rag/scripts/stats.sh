#!/usr/bin/env bash
# Report index stats.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ROOT=$(repo_root)
INDEX="$ROOT/.rag/index.json"
[[ -f "$INDEX" ]] || die "No RAG index found."

python3 - "$INDEX" <<'PY'
import sys, json, os
idx = json.load(open(sys.argv[1]))
files = set(e["file"] for e in idx)
chunks = len(idx)
total_chars = sum(len(e["chunk"]) for e in idx)
size_bytes = os.path.getsize(sys.argv[1])
print(f"\n  Indexed files:     {len(files)}")
print(f"  Total chunks:      {chunks}")
print(f"  Total characters:  {total_chars:,}")
print(f"  Index file size:   {size_bytes/1024/1024:.1f} MB")
print(f"  Vector dim:        {len(idx[0]['vec']) if idx else 'N/A'}")
print()
PY

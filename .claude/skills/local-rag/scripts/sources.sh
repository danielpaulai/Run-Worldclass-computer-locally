#!/usr/bin/env bash
# Show which indexed chunks match a question (without answering).
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
ROOT=$(repo_root)
INDEX="$ROOT/.rag/index.json"
[[ -f "$INDEX" ]] || die "No RAG index found."

QUESTION="$*"; [[ -z "$QUESTION" ]] && die "Usage: sources.sh <question>"

python3 - "$INDEX" "$QUESTION" <<'PY'
import sys, json, urllib.request, math
index = json.load(open(sys.argv[1])); q = sys.argv[2]
req = urllib.request.Request(
    "http://localhost:11434/api/embeddings",
    data=json.dumps({"model":"nomic-embed-text","prompt":q}).encode(),
    headers={"Content-Type":"application/json"})
qv = json.loads(urllib.request.urlopen(req, timeout=60).read())["embedding"]
def cos(a,b):
    n = sum(x*y for x,y in zip(a,b)); d = math.sqrt(sum(x*x for x in a))*math.sqrt(sum(y*y for y in b))
    return n/d if d else 0.0
ranked = sorted(index, key=lambda e: cos(e["vec"], qv), reverse=True)[:5]
for i, e in enumerate(ranked, 1):
    score = cos(e["vec"], qv)
    print(f"\n[Source {i}]  score={score:.3f}  file={e['file']}")
    print("-"*60)
    print(e["chunk"][:600])
    if len(e["chunk"]) > 600: print("  ...")
PY

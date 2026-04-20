#!/usr/bin/env bash
# Ask a question over the indexed documents.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
ROOT=$(repo_root)
INDEX="$ROOT/.rag/index.json"
[[ -f "$INDEX" ]] || die "No RAG index found.  Run:  ./ai local-rag ingest <folder>"

QUESTION="$*"; [[ -z "$QUESTION" ]] && die "Usage: query.sh <question>"
MODEL=$(get_model)

CONTEXT=$(python3 - "$INDEX" "$QUESTION" <<'PY'
import sys, json, urllib.request, math

index = json.load(open(sys.argv[1]))
q = sys.argv[2]

req = urllib.request.Request(
    "http://localhost:11434/api/embeddings",
    data=json.dumps({"model":"nomic-embed-text","prompt":q}).encode(),
    headers={"Content-Type":"application/json"})
qv = json.loads(urllib.request.urlopen(req, timeout=60).read())["embedding"]

def cos(a,b):
    n = sum(x*y for x,y in zip(a,b))
    d = math.sqrt(sum(x*x for x in a))*math.sqrt(sum(y*y for y in b))
    return n/d if d else 0.0

ranked = sorted(index, key=lambda e: cos(e["vec"], qv), reverse=True)[:5]
out = []
for i, e in enumerate(ranked, 1):
    out.append(f"[Source {i}: {e['file']}]\n{e['chunk']}\n")
print("\n".join(out))
PY
)

PROMPT="Use the context below to answer the user's question. If the context doesn't contain the answer, say so. Cite source numbers in [brackets].

Context:
$CONTEXT

Question: $QUESTION

Answer:"

echo "$PROMPT" | ollama run "$MODEL"

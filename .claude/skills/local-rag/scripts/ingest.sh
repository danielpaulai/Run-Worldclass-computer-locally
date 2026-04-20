#!/usr/bin/env bash
# Walk a folder, chunk every supported file, embed each chunk, save index.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama

FOLDER="$1"; [[ -d "$FOLDER" ]] || die "Folder not found: $FOLDER"
ROOT=$(repo_root)
RAG_DIR="$ROOT/.rag"
mkdir -p "$RAG_DIR"

# Ensure embedding model
if ! ollama list | awk 'NR>1 {print $1}' | grep -qx "nomic-embed-text"; then
  say "Pulling embedding model (one-time)..."
  ollama pull nomic-embed-text
fi

echo "$FOLDER" > "$RAG_DIR/folder"
say "Indexing $FOLDER..."

python3 - "$FOLDER" "$RAG_DIR" <<'PY'
import os, sys, json, urllib.request, re, subprocess

folder, rag_dir = sys.argv[1], sys.argv[2]

def extract(path):
    ext = path.lower().rsplit(".", 1)[-1]
    if ext in ("md","markdown","txt","log","rst","org"):
        return open(path, errors="ignore").read()
    if ext == "pdf":
        try:
            return subprocess.check_output(["pdftotext","-layout",path,"-"], text=True, stderr=subprocess.DEVNULL)
        except Exception:
            return ""
    if ext == "docx":
        try:
            return subprocess.check_output(["pandoc",path,"-t","plain","-o","-"], text=True, stderr=subprocess.DEVNULL)
        except Exception:
            return ""
    return ""

def chunk(text, size=500, overlap=50):
    words = re.findall(r"\S+", text)
    out = []
    i = 0
    while i < len(words):
        out.append(" ".join(words[i:i+size]))
        i += size - overlap
    return out

def embed(text):
    req = urllib.request.Request(
        "http://localhost:11434/api/embeddings",
        data=json.dumps({"model":"nomic-embed-text","prompt":text[:4000]}).encode(),
        headers={"Content-Type":"application/json"})
    with urllib.request.urlopen(req, timeout=60) as r:
        return json.loads(r.read())["embedding"]

index = []
files = 0
chunks = 0
for root, _, names in os.walk(folder):
    for n in names:
        if n.startswith("."): continue
        p = os.path.join(root, n)
        text = extract(p)
        if not text.strip(): continue
        files += 1
        for ch in chunk(text):
            try:
                v = embed(ch)
                index.append({"file": p, "chunk": ch, "vec": v})
                chunks += 1
            except Exception as e:
                print(f"  [skip] {p}: {e}", file=sys.stderr)
        if files % 5 == 0:
            print(f"  ...indexed {files} files, {chunks} chunks")

with open(os.path.join(rag_dir, "index.json"), "w") as f:
    json.dump(index, f)

print(f"\nIndexed: {files} files, {chunks} chunks")
PY

ok "Index saved to $RAG_DIR/index.json"
echo "Query with:  ./ai local-rag query \"your question\""

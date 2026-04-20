---
name: local-rag
description: Build a local RAG (retrieval-augmented generation) index over any folder of documents and ask questions over them — fully offline. Five actions — ingest (index a folder), query (ask a question), sources (show which chunks matched), rebuild (re-index), stats (index size). Uses nomic-embed-text for embeddings and cosine similarity for retrieval. Use when the user asks to "talk to my notes", "RAG over my docs", "ask questions about my files", "search my PDFs", "query my Obsidian vault", "chat with my documents privately".
---

# Local RAG — talk to your documents, fully offline

Indexes any folder, then lets you ask questions that are answered using your documents as context. Everything runs locally — the index, the embeddings, the retrieval, and the answer generation.

| Action | Does |
|---|---|
| `ingest <folder>` | Walks the folder, chunks each file, embeds each chunk, saves a JSON index |
| `query <question>` | Finds top-k relevant chunks, stuffs them into a prompt, returns the answer |
| `sources <question>` | Same retrieval but shows the matched chunks instead of answering |
| `rebuild` | Re-indexes the last-ingested folder |
| `stats` | Index size, document count, token count |

## Under the hood

- **Embeddings:** `nomic-embed-text` via Ollama (auto-pulled on first ingest)
- **Index format:** JSON at `.rag/index.json` in the repo root
- **Chunk size:** 500 words with 50-word overlap
- **Retrieval:** cosine similarity, top 5 chunks
- **Supported files:** .md, .txt, .pdf (via pdftotext), .docx (via pandoc)

## Examples

```bash
./ai local-rag ingest ~/Documents/my-notes
./ai local-rag query "What did I write about pricing strategy?"
./ai local-rag sources "customer feedback trends"
./ai local-rag stats
./ai local-rag rebuild
```

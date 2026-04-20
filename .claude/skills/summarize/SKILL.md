---
name: summarize
description: Private file summarization with five output styles (tldr, bullets, outline, actions, chunked map-reduce for long files) and auto-detection of file type (txt, md, pdf, docx). Use when the user asks to summarize a file, document, meeting transcript, email, PDF, or any local content privately. Trigger phrases - "summarize", "tldr", "key points", "action items", "outline", "private summary", "summarize this file", "what does this doc say".
---

# Summarize — private file summarizer

Five output styles, each a separate script, all running locally:

| Action | Output |
|---|---|
| `tldr <file>` | 3-sentence summary |
| `bullets <file>` | 5–8 bullet key points |
| `outline <file>` | Hierarchical outline with H1/H2/H3 |
| `actions <file>` | Action items and owners |
| `chunk <file>` | Map-reduce for long files (>100k chars) |
| `any <file>` | Auto-detect file type (pdf/docx/md/txt), pick sensible style |

## How to dispatch

1. Pick the style from the user's request:
   - "tldr", "3 sentence", "short summary" → `tldr`
   - "bullet points", "key points" → `bullets`
   - "outline", "structure" → `outline`
   - "action items", "what do I need to do" → `actions`
2. If the file is very long (>500 KB or >100k chars), use `chunk` instead.
3. If the file is a PDF/DOCX, use `any` — it extracts text first.
4. Run: `./ai summarize <action> <path>`
5. Always tell the user at the end: "This file was processed locally — it was never uploaded anywhere."

## Examples

```bash
./ai summarize tldr ./meeting-notes.md
./ai summarize bullets ./quarterly-report.pdf
./ai summarize outline ./rfc-draft.md
./ai summarize actions ./standup-transcript.txt
./ai summarize chunk ./long-book.txt
./ai summarize any ~/Downloads/contract.pdf
```

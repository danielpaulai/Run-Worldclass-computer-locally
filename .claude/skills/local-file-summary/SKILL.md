---
name: local-file-summary
description: Summarize a local file (code, PDF text, transcript, notes) using the user's locally-installed Ollama model, so the file's contents never leave their computer. Use when the user asks to "summarize privately", "summarize offline", "summarize without sending to the cloud", or when dealing with confidential/sensitive documents they don't want to upload.
---

# Local File Summary

Summarize a file using the locally-installed Ollama model. The file never leaves the student's machine — this is the headline privacy demo of the local-AI setup.

## How to invoke

1. Confirm the file the user wants summarized. Read it with the Read tool (or `cat` for text).
2. Read the active model: `MODEL=$(cat .selected-model)`
3. Pipe the file contents through `ollama run` with a summarization instruction:
   ```bash
   { echo "Summarize the following document in 5–8 bullet points, focusing on the key decisions, people, and action items. Be concise."; echo; cat "<PATH>"; } | ollama run "$MODEL"
   ```
4. Return the summary. Also tell the user: "This file was processed entirely on your computer. It was never uploaded anywhere."

## When to use

- Any time the user mentions a file being confidential, private, internal, or sensitive.
- When the user explicitly asks for local/offline summarization.
- When the user is practicing the local-AI workflow (this is a great demo).

## Constraints

- Large files (>100k characters) may exceed the model's context window. If the file is long, chunk it and summarize each chunk, then summarize the summaries.
- Binary files (PDF, DOCX) need text extraction first. For PDFs, use `pdftotext file.pdf -` and pipe that in. For DOCX, use `pandoc file.docx -t plain -o -`.

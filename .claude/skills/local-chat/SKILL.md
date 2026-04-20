---
name: local-chat
description: Send a prompt to the user's locally-installed Ollama model and return the response. Use when the user says "ask local", "ask my local model", "ask offline", "ask privately", "run locally", or references "my local AI". Works fully offline and never sends the prompt to any cloud service.
---

# Local Chat

Route a prompt to the Ollama model the student installed via `setup.sh`. Nothing leaves their machine.

## How to invoke

1. Read the active model from `.selected-model` at the repo root.
   ```bash
   MODEL=$(cat .selected-model)
   ```
2. Send the prompt through `ollama run` via stdin to avoid quoting issues.
   ```bash
   echo "<THE_USER_PROMPT>" | ollama run "$MODEL"
   ```
3. Return the model's output to the user verbatim, prefixed with the model name so they can see which one answered.

## When to use vs. not

- **Use** when the user wants privacy, is offline, or explicitly asks for the local model.
- **Do not use** for tasks that need tools, browsing, or the best possible reasoning — route those to the main Claude session.
- If `.selected-model` doesn't exist, tell the user to run `./setup.sh` first.

## Error handling

- If `ollama` is not in PATH: tell them Ollama isn't installed and point to `./setup.sh`.
- If the Ollama service isn't responding (`curl http://localhost:11434/api/version` fails): run `brew services start ollama` (macOS), `sudo systemctl start ollama` (Linux), or `Start-Process ollama -ArgumentList serve -WindowStyle Hidden` (Windows).
- If the model isn't pulled yet: `ollama pull "$MODEL"`.

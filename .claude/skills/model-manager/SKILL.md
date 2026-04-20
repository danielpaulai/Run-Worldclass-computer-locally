---
name: model-manager
description: Full lifecycle control over Ollama models — list (pretty table with sizes), recommend (best models for the user's RAM and use case), install (pull with progress), remove (safely delete), switch (change active model), and disk-audit (show space used). Use when the user asks to "switch model", "try a different model", "install llama", "free up disk space", "which model should I use", "what models do I have", "what's the best model for coding on my machine".
---

# Model Manager — lifecycle control for local models

| Action | Does |
|---|---|
| `list` | Pretty table of installed models with size + last used |
| `recommend [use-case]` | Suggests models based on RAM and use-case (general / code / reasoning) |
| `install <model>` | Pulls a model with progress |
| `remove <model>` | Removes a model (confirms first) |
| `switch <model>` | Changes the active model (what chat.sh uses) |
| `disk-audit` | Shows total disk used by all models |

Curated model catalog lives in `data/catalog.json` — add to it to grow the recommend logic.

## Examples

```bash
./ai model-manager list
./ai model-manager recommend code
./ai model-manager install qwen2.5-coder:7b
./ai model-manager switch qwen2.5-coder:7b
./ai model-manager disk-audit
./ai model-manager remove llama3.2:3b
```

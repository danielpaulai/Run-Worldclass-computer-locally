---
name: swap-model
description: Switch the active local model, or pull a new one. Use when the user says "change model", "switch to", "try a different model", "use llama instead", "install qwen", or wants to experiment with multiple models.
---

# Swap Model

Change which Ollama model `chat.sh` / `chat.ps1` uses, and pull new ones on demand.

## How to invoke

1. List what they already have:
   ```bash
   ollama list
   ```
2. If they named a model that isn't installed, pull it first:
   ```bash
   ollama pull <model>
   ```
3. Update the active selection so the chat scripts pick it up:
   ```bash
   echo "<model>" > .selected-model
   ```
4. Confirm by running a one-line test:
   ```bash
   echo "Say hi in 5 words." | ollama run "<model>"
   ```

## Sensible suggestions by RAM

| RAM | Recommended | Why |
|---|---|---|
| 8 GB   | `llama3.2:3b`      | Small, fast, surprisingly capable |
| 16 GB  | `qwen2.5:7b`       | Great general-purpose default |
| 16 GB  | `qwen2.5-coder:7b` | Coding-focused variant |
| 32 GB  | `qwen2.5:14b`      | Noticeably smarter than 7b |
| 32 GB  | `deepseek-r1:14b`  | Reasoning-tuned |
| 64 GB+ | `gpt-oss:20b`      | Near-frontier open model |

## Notes

- Models take 2–15 GB of disk each. Warn the user before pulling something huge.
- Use `ollama rm <model>` to free space if they want to clean up.
- Very large MoE models (e.g. `qwen3-coder-next` at 51 GB) are usually too heavy for student laptops. Don't recommend unless they have 64 GB+ RAM and fast SSD.

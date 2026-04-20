---
name: compare
description: Compare responses from the local model against other sources (cloud Claude via main session, or another locally-installed model) using single (one prompt), evals (a battery of prompts), or rubric (scored on specific criteria). Use when the user asks "local vs cloud", "compare models", "which is better", "honest quality check", "is my local AI good enough for X".
---

# Compare — side-by-side model evaluation

| Action | Does |
|---|---|
| `single <prompt>` | Runs the prompt on local model; cloud comparison produced by the main Claude session |
| `local-vs-local <modelA> <modelB> <prompt>` | Side-by-side between two installed models |
| `rubric <prompt>` | Local model answers; then scores itself on accuracy, clarity, completeness |

## When this skill runs

Use `single` when you (Claude Code) are in the conversation — you produce the cloud response yourself as part of the comparison. For pure local-vs-local, use the other action.

## Examples

```bash
./ai compare single "Explain quantum entanglement to a 10-year-old."
./ai compare local-vs-local qwen2.5:7b llama3.2:3b "Write a haiku about autumn."
./ai compare rubric "What are the main arguments against deontology?"
```

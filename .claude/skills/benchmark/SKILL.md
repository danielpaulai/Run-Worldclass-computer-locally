---
name: benchmark
description: Measure performance of local Ollama models with five modes — quick (single-prompt speed), full (5-prompt evaluation suite across reasoning/code/writing/factual/creative), compare-models (run suite on every installed model), memory (peak RAM usage during inference), and report (generate a markdown report). Use when the user asks "how fast is my model", "tokens per second", "benchmark", "compare models on my machine", "is this model any good", "which model is best for my laptop".
---

# Benchmark — measure your local model's performance

| Action | Measures |
|---|---|
| `quick` | Single prompt, tokens/sec + time-to-first-token |
| `full` | 5-prompt suite: reasoning, code, writing, factual, creative |
| `compare-models` | Runs the full suite on every installed model; ranks them |
| `memory` | Peak RAM usage during a large prompt |
| `report` | Aggregates last run into a printable markdown report |

All results save to `.benchmarks/` at the repo root.

## Examples

```bash
./ai benchmark quick
./ai benchmark full
./ai benchmark compare-models
./ai benchmark memory
./ai benchmark report
```

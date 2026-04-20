---
name: local-benchmark
description: Measure how fast the user's local Ollama model runs on their hardware (tokens per second, time-to-first-token). Use when the user asks "how fast is my model", "benchmark", "tokens per second", "is my laptop fast enough", or wants to compare their Mac/PC to others.
---

# Local Benchmark

Measure real throughput of the student's installed model so they can see exactly what their laptop delivers. Great for the session — gives everyone a concrete number to share.

## How to invoke

1. Read the active model:
   ```bash
   MODEL=$(cat .selected-model)
   ```
2. Ensure Ollama is warm by running a tiny prompt first (the first call after idle is slower because the model needs to load into memory):
   ```bash
   echo "hello" | ollama run "$MODEL" >/dev/null
   ```
3. Run the benchmark prompt with `--verbose` — Ollama prints timing stats at the end:
   ```bash
   echo "Write a 200-word explanation of how a transformer works, suitable for a curious beginner." \
     | ollama run "$MODEL" --verbose
   ```
4. Parse the `eval rate` line (e.g. `eval rate: 47.3 tokens/s`) and report:
   - Model name
   - Tokens per second
   - Time to first token (the `prompt eval` line)
   - Rough interpretation: <15 tok/s = slow, 15–40 = comfortable, 40+ = snappy

## What to tell the user

Give them a one-liner they could post:

> "On my [MacBook Pro M3 16 GB], `qwen2.5:7b` runs at **47 tokens/sec**. First token in 0.3s."

## Notes

- If the user wants to compare models, pull another (`ollama pull llama3.2:3b`), swap via the swap-model skill, and re-run the benchmark.
- Tokens/sec is hardware-bound; quantization matters. Most Ollama models are q4_K_M by default.

# Example: `summarize tldr` on a real document

**Model used:** `qwen2.5:7b` (5 GB, runs on any Mac with 16 GB RAM)
**Input:** First 4 KB of this repo's own `README.md`
**Command:** `./ai summarize tldr README.md`

## What went in (excerpt)
The full README — title, install instructions, model picker table, Mermaid diagrams, etc.

## What came out

> This document outlines how to run a high-performance AI model locally on your laptop, eliminating the need for cloud services or API keys. After a one-time setup using `./preflight.sh && ./setup.sh`, you can start chatting with the AI using `./chat.sh` (macOS/Linux) or `.\chat.ps1` (Windows), ensuring all interactions remain completely offline. The process is designed to be accessible, even for beginners, and supports multiple models based on your system's RAM, providing a seamless experience from installation to conversation.

## Teacher's note

**Quality: strong.** Three sentences, all accurate, hits the key points (local, no API keys, offline, RAM-sized models, beginner-friendly). This is the kind of output that justifies the whole tool.

**Time to generate:** ~8 seconds on an M-series Mac.

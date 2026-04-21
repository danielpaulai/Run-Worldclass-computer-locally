# FAQ — Purely Personal

The 12 questions you'll get asked. Short, specific, no dodging.

---

### "Is this really private?"

Yes.

The app talks to an AI model running on your own hard drive via `localhost:11434` — a network interface that only exists inside your laptop. No cloud account, no API key, no telemetry, no login.

You can prove it: turn off your WiFi, ask a question, watch the answer stream back.

### "Is it really free?"

Yes.

MIT-licensed open-source. No subscription, no per-token billing, no "basic plan vs. pro." The model weights are Apache-2.0 from Alibaba (Qwen 2.5). Install once, use for the rest of your career.

### "How is this different from ChatGPT?"

ChatGPT is smarter on hard reasoning.

Purely Personal is private, offline, and free.

For the 80% of daily AI work — summarize, draft, extract, explain — they're roughly equivalent. For the confidential 80% — Purely Personal is the only option.

### "How is this different from Ollama?"

Ollama is the engine. Purely Personal is a desktop app on top of it that makes the engine usable without a terminal.

Think Docker vs. Docker Desktop.

### "What model does it run?"

Default: **Qwen 2.5 (7B parameters)**, ~5 GB on disk, Apache-2.0 from Alibaba.

Swappable to ~100 other models (Llama 3, Mistral, DeepSeek, GPT-OSS) with one command. App picks a model sized to your RAM automatically.

### "How much RAM do I need?"

- **8 GB:** Llama 3.2 3B — fast, good for basic Q&A and short summaries.
- **16 GB:** Qwen 2.5 7B — the default, strong on most daily work.
- **32 GB+:** 14B-class models — noticeably smarter.
- **64 GB+:** GPT-OSS 20B — closest open model to frontier cloud.

### "Does it work on Windows?"

Yes.

Windows `.exe` installer ships alongside the Mac `.dmg`. Both in the repo's Releases.

### "Does it work offline?"

Yes.

After the one-time model download (~5 GB), zero internet required. You can fly across the country with it.

### "Is it as smart as ChatGPT?"

Honest answer: no, not on hard reasoning.

A 7B local model is roughly GPT-3.5 from 2023. Strong on summarization, drafting, extraction. Weaker on complex reasoning, long context, specialized tasks.

For the everyday stuff you'd use AI for 20 times a day — it's right there.

For once-a-month hard problems — still use the cloud.

### "Can I use it for legal / medical / financial work?"

The tool doesn't care. The output is the same quality whether you're asking about pizza or litigation.

**You** are responsible for verifying output before you rely on it professionally.

For regulated work (HIPAA, legal privilege, SEC) where you can't upload to the cloud — Purely Personal is often the only workable AI option at all.

### "What about my IT department?"

The app installs on your own machine, no server component, no phoning home, no ports opened.

If IT lets you install Slack, Zoom, or Notion, they'll let you install this.

If you're on a locked-down corporate laptop with no install rights — you can't install Purely Personal either. That's a policy limit, not a product limit.

### "What if I need a feature you don't have?"

Three paths:

1. **Build it.** The whole thing is open-source. Fork it, add your thing.
2. **Request it.** File an issue on GitHub. It's on the roadmap.
3. **Use the underlying skills directly.** The repo ships 15 terminal skills (summarize, RAG, writer, research, etc.) that work whether or not you use the desktop app.

### "Is this a business?"

Not yet.

It's a tool I built for my own work and decided to share.

If enough people want it, I'll add a paid tier with signed builds, priority support, and an easier install path for non-technical teams.

The core app stays free and open-source no matter what.

---

## The question beneath all questions

**"Can I trust this?"**

Three reasons the trust doesn't need to be trust:

1. **The code is open.** Every line on GitHub. Anyone can audit it. If it phoned home, someone would have flagged it by now.

2. **The privacy claim is verifiable by you.** Turn off WiFi. Watch it work. You don't take anyone's word for it.

3. **The model is open-weights.** Runs on your hardware with your resources. It has no mechanism to phone home, even if the original authors wanted it to.

This is privacy you can verify. Not privacy you have to trust.

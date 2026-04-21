# FAQ — Purely Personal

The questions you'll get asked, with sharp answers.

---

### "Is this really private?"

Yes. The app talks to an AI model running on your own hard drive via `localhost:11434` — a network interface that only exists inside your laptop. There's no cloud account, no API key, no telemetry, no login. You can prove it: turn off your WiFi, and the chat still works.

### "Is it really free?"

Yes. Open-source, MIT licensed. No subscription, no per-token billing, no "basic plan vs. pro." The model weights themselves are Apache-2.0 from Alibaba (Qwen 2.5). You pay $0 to install, $0 per query, $0 per month, forever.

### "How is this different from ChatGPT?"

ChatGPT is smarter on hard reasoning. Purely Personal is private, offline, and free. For the 80% of daily AI work that's summarization, drafting, extraction, or explanation — they're roughly equivalent. For *confidential* 80% of daily AI work — Purely Personal is the only option.

### "How is this different from Ollama?"

Ollama is the underlying runtime — the engine that runs the model. Purely Personal is a beautiful app on top of it that makes the engine usable without a terminal. Think of Ollama as Docker and Purely Personal as Docker Desktop.

### "What model does it run?"

Default: **Qwen 2.5 (7B parameters)**, about 5 GB on disk. It's an open-weights model from Alibaba, Apache-2.0. You can swap to any of ~100 other models — Llama 3, Mistral, DeepSeek, GPT-OSS — with one command. The app picks a model sized to your RAM automatically.

### "How much RAM do I need?"

- **8 GB** — runs the small 3B model (Llama 3.2), fast, good for basic Q&A and short summaries.
- **16 GB** — runs the default 7B model, strong on everything most people do.
- **32 GB+** — runs 14B or bigger, noticeably smarter.
- **64 GB+** — runs the best open laptop model (GPT-OSS 20B), close to cloud quality.

### "Does it work on Windows?"

Yes. We ship a Windows `.exe` installer alongside the Mac `.dmg`.

### "Does it work offline?"

Yes. After the one-time model download (5–15 GB), the app needs zero internet. You can fly across the country with it.

### "Is it as smart as ChatGPT?"

Honest answer: no, not on hard reasoning problems. A 7B local model is roughly comparable to GPT-3.5 from 2023 — strong on summarization, drafting, extraction; weaker on complex reasoning, long-context, and specialized tasks. For the everyday stuff you'd use AI for 20 times a day, it's right there. For once-a-month hard problems, still use cloud.

### "Can I use it for legal / medical / financial work?"

The tool itself doesn't care. The model's output is the same quality whether you're asking about pizza or litigation. **You** are responsible for verifying the output before you rely on it professionally. For regulated work (HIPAA, legal, SEC) where you can't upload to the cloud, Purely Personal is often the only workable AI option at all.

### "What about my IT department?"

The app installs locally on your own machine with no server component. It doesn't call home, doesn't require VPN, doesn't open ports. If your IT department allows you to install any software (Slack, Zoom, etc.), it will allow this. If you're on a locked-down corporate laptop that forbids new installs, you won't be able to install this either — that's a policy limit, not a product limit.

### "What happens if I need a feature you don't have?"

Three paths:
1. **Add it yourself** — the whole thing is open-source. Fork it.
2. **Request it** — file an issue on GitHub, it'll be on the roadmap.
3. **Use the underlying tool directly** — the repo also ships 15 terminal skills (summarize, RAG, writer, research, etc.) that work whether or not you use the desktop app.

### "Is this a business?"

Not yet. It's a tool I built for myself and decided to share. If it turns out a lot of people want it, I may add a paid tier with signed builds, priority support, and an easier install for non-technical teams. The core app will stay free and open-source either way.

---

## The question beneath all questions

**"Can I trust this?"**

The trust comes from three places:

1. **The code is open.** Every line of the app and every script in the skill layer is on GitHub. Anyone can audit it. If it did something shady, someone would have posted about it.

2. **The privacy claim is verifiable by you.** Run `./ai privacy-audit check` in the terminal. Turn off your WiFi. Watch it still work. You don't have to take anyone's word for it.

3. **The model itself is open-weights.** It runs on your hardware with your resources. It has no way to phone home even if its creators wanted it to.

This is privacy you can prove. Not privacy you have to trust.

# In-Class Activity — The Live Session (60 min)

**Format:** Students follow along on their own laptops. Those whose setup didn't finish still participate by watching and reading the [examples gallery](./examples/).

**What you need as the teacher:**
- Your laptop with the repo installed and a model loaded
- This document projected
- The [examples folder](./examples/) pulled up in a second window as a fallback
- Permission to be honest about where the local model is weaker than cloud AI — that honesty is the lesson

---

## The session at a glance

```
 5 min  ·  Intro + "everyone type /ai ask hi" thumbs-up check
 8 min  ·  Demo 1 — Summarize (the strong case)
 8 min  ·  Demo 2 — Code review (the impressive case)
 8 min  ·  Demo 3 — Draft an email (the honest-tradeoff case)
 8 min  ·  Demo 4 — The hallucination (the critical case)
 8 min  ·  Demo 5 — Local vs cloud, side by side
 7 min  ·  Students try their own task
 8 min  ·  Q&A + post-class preview
```

---

## 0:00 — Welcome + thumbs-up check  (5 min)

1. Confirm everyone's local AI is alive:
   ```bash
   ./ai local-ai ask "hi in 3 words"
   ```
   Anyone whose command errors out should **keep their laptop open** but follow the demos in the [examples folder](./examples/) instead of running them.

2. Set the frame:
   > "In the next hour you'll see five things. The first two will impress you — a local AI can do them as well as ChatGPT. The next two will disappoint you — you'll see the model fail in specific ways you should expect. The fifth will teach you when to pick local vs. cloud."

---

## 0:05 — Demo 1: Summarize a document  (8 min) — **THE STRONG CASE**

Pick any public document — your repo's README, a news article, a Wikipedia page.

```bash
./ai summarize tldr README.md
```

**What students will see** (example from an actual run — [full file](./examples/01-summarize-tldr.md)):

> This document outlines how to run a high-performance AI model locally on your laptop, eliminating the need for cloud services or API keys. After a one-time setup using `./preflight.sh && ./setup.sh`, you can start chatting with the AI using `./chat.sh` (macOS/Linux) or `.\chat.ps1` (Windows), ensuring all interactions remain completely offline...

**Teaching point:**
> "This is the best case. Summarizing is what 7B models are world-class at. If your daily job involves reading things and pulling out what matters — **you just automated it.**"

**Ask the room:** "What's a document in your work life you'd want summarized right now?"

---

## 0:13 — Demo 2: Review a piece of code  (8 min) — **THE IMPRESSIVE CASE**

```bash
./ai local-code review chat.sh
```

**What students will see** ([full file](./examples/02-local-code-review.md)):

The model produces a numbered list of bugs, a list of improvements, a list of things done well, and **a rewritten version of the script** that's objectively better.

**Teaching point:**
> "This is the second thing 7B models are great at. Reading code and finding issues. If you build software — or review contracts, which is similar pattern-matching — this is a tool that pays for itself immediately."

---

## 0:21 — Demo 3: Draft an email  (8 min) — **THE HONEST-TRADEOFF CASE**

```bash
./ai local-writer draft "Cold outreach email from a marketing consultant offering a 30-min positioning audit to a B2B SaaS head of marketing. Open with something specific, not generic."
```

**What students will actually get** ([full file](./examples/05-local-writer-cold-email.md)):

The model opens with *"I hope this message finds you well"* — the most generic cold-email opener on Earth — despite your explicit instruction to do the opposite.

**Read it out loud, then pause.**

**Teaching point:**
> "Ignore the cringe. Notice what happened: the model heard 'not generic' and still wrote generic. Why? It's a 7B model. It does best with concrete examples, not abstract instructions. If you want good output for writing tasks, **give it a sample** of the voice you want. Two real emails you've sent, pasted into the prompt, change everything."

**Do the second pass live:** paste a real email you've written into the prompt and ask for a draft in that voice. Show the improvement.

---

## 0:29 — Demo 4: The hallucination  (8 min) — **THE CRITICAL CASE**

```bash
./ai local-ai ask "What is Ollama?"
```

**What students will see** ([full file](./examples/06-local-ai-hallucination.md)):

> Ollama is an artificial intelligence tool designed to help businesses automate tasks and improve productivity...

**Read it confidently, then ask the room:** "What's wrong with that?"

Let someone say it. If nobody does, tell them:

> "Ollama isn't an AI. It's a runtime — a thing that lets you run AIs. The model just **confidently made up** a definition. It didn't hedge, it didn't say 'I'm not sure.' This is what small models do when you ask them facts they don't really know."

**The rule students should leave with:**
> **Use local AI for things you can verify.** Summarizing a doc you can re-read — fine. Reviewing code you can test — fine. "What is X, what year did Y happen" — check it before trusting it.

---

## 0:37 — Demo 5: Local vs cloud, side by side  (8 min) — **JUDGMENT-BUILDING**

Pick a reasoning prompt — something where the difference will be visible. Good ones:

- *"What are the second-order effects of a 10% tariff on imported steel?"*
- *"Explain the trolley problem and why it matters for self-driving cars."*
- *"Here's a contract clause. What are the hidden risks?"*

Run it locally:
```bash
./ai local-ai ask "<the prompt>"
```

Then run the same prompt through ChatGPT / Claude / Gemini on your screen.

**Put the two answers side by side.** Let students read silently for 90 seconds. Then ask: *"Which one do you want in your work?"*

**Teaching point:**
> "For reasoning, cloud still wins. For the stuff you do 20 times a day — summarize, draft, review — local is right there. The question isn't 'which is better.' It's 'which one do I pick for this task?'"

---

## 0:45 — Students try their own  (7 min)

Each student runs **one prompt on a real thing from their work** — the one they brought to the session.

Two rules:
1. Nothing confidential that you wouldn't want me seeing over your shoulder.
2. Pick a task from the "good at" column: summarize, review, rewrite, extract.

Walk around. Help people. When they get a good output, have them post it in chat.

---

## 0:52 — Q&A + post-class preview  (8 min)

Open Q&A. Common questions I've hit:

- *"Can I use a bigger model?"* — Yes: `./ai model-manager recommend power-user`, then `./ai model-manager install <name>`.
- *"Does this work on my work laptop?"* — Probably not if it's locked-down corporate IT. Try on personal.
- *"How do I stop it from running in the background?"* — `brew services stop ollama` (Mac) / `sudo systemctl stop ollama` (Linux).
- *"Is there a GUI?"* — Yes: Open WebUI via Docker, or the Ollama Mac desktop app. Next session.

Close with a preview of [POST-CLASS.md](./POST-CLASS.md) — what they can try this week.

---

## If the session goes sideways

**If the projector's laptop itself fails:**
Switch to the [examples folder](./examples/) full-screen. Every demo here has a real output saved. You can walk through them as slides.

**If 50%+ of students couldn't install:**
Turn the session into a read-along. Each demo: read the prompt, read the output from the example file, discuss. Then spend the last 20 min doing live install help in small groups.

**If a student's model gives a totally different output from yours:**
Normal. Models are non-deterministic (unless you set temperature to 0 and seed). Use it as a teaching moment: "This is why you always sanity-check the output."

# Purely Personal — Master Deck (20 slides)

> **For pasting into genspark.ai.** Each slide has a title, bullets/body, and speaker notes. Brand tokens are at the bottom — give Genspark those when it asks for colors and fonts.

---

## SLIDE 1 — Title

### Purely Personal
**A private AI that runs on your laptop.**

Free. Open source. Works offline. Everything you need, nothing you don't.

*Tagline small: "For the files you'd never paste into ChatGPT."*

**Speaker note:** Open with quiet confidence. Don't oversell. Let the subtitle do the work.

---

## SLIDE 2 — The hesitation

### You've done this before.

- You open ChatGPT
- You start to paste a document
- You read it again
- You close the tab

**This is a contract. A session note. A tax file. A P&L.**

It's the half of your work you stopped using AI for.

**Speaker note:** This is the emotional hook. Everyone in the room has felt this exact moment. Say it slowly. Watch the nods.

---

## SLIDE 3 — The cost of that hesitation

### You've been doing the hard 70% by hand.

- AI works for the easy 30%: blog outlines, generic emails, quick brainstorms
- The hard 70% (the work you actually get paid for) still eats your evenings
- Every hesitation is hours lost
- Every "maybe I shouldn't" is trust in a policy, not a certainty

**Speaker note:** Name the cost in hours. Specific. One consultant told me 6 hours a week. That number lands.

---

## SLIDE 4 — What this is

### A real AI, on your laptop.

- Not ChatGPT. Not Claude. Not a web app.
- Not billed by the month.
- Not behind a login.
- Not calling home.

**You open an app. You type a question. The model on your own disk answers. Nothing leaves the machine.**

**Speaker note:** "Your data never goes anywhere" is the whole deal. Everything else is implementation detail.

---

## SLIDE 5 — The frame

### This isn't a replacement. It's the missing half.

- **Cloud AI (ChatGPT, Claude):** for hard reasoning, latest news, very long documents
- **Local AI (Purely Personal):** for confidential, routine, offline work
- You stop choosing between "use AI" and "protect your data"
- You keep using the cloud when it's the right tool. You use local when it isn't.

**Speaker note:** Pre-empt "is this better than ChatGPT?" No. Different job. This is about giving you the tool for the work you weren't doing with AI at all.

---

## SLIDE 6 — The stack

### Three open-source pieces. That's it.

| Piece | Role | Size | What it does |
|---|---|---|---|
| **Ollama** | Engine | ~40 MB | Runs AI models locally |
| **Qwen 2.5** | Brain | 4.7 GB | The actual intelligence |
| **Purely Personal** | UI | ~95 MB | The chat window you use |

Each piece is independent. Each is free. Each is open-source.

**Speaker note:** Students get confused because they think the DMG is everything. It isn't. Three pieces, three things to install. Be explicit.

---

## SLIDE 7 — Ollama (the engine)

### The runtime that brings the model to life.

- Loads 4.7 GB of AI weights into your RAM
- Exposes a clean HTTP API at `localhost:11434`
- Handles streaming tokens, GPU acceleration (Apple Metal / Nvidia CUDA)
- Phones home only once: the first model download. Never again.
- Open source, MIT licensed

**Think of it as a local-AI Docker: one binary that does everything.**

**Speaker note:** The key point: Ollama is why this is easy. Before Ollama, running a local model meant 50 lines of PyTorch and GPU tuning. Now it's one command.

---

## SLIDE 8 — Qwen 2.5 (the brain)

### 7 billion parameters. 4.7 GB. Open weights.

- Built by Alibaba's Qwen team, released with commercial-use rights
- Best-in-class for its size as of early 2026
- Competitive with GPT-3.5 on most tasks
- GPT-4-class on code and summarization
- Quantized to 4-bit so it fits in 5 GB of RAM

**The file on your disk is pure numbers. No executable code. No telemetry. No callbacks.**

**Speaker note:** Demystify it. A model is literally a big file of numbers. Chatting with it is math, not magic. That's also why it can run anywhere.

---

## SLIDE 9 — Purely Personal (the UI)

### Your friendly chat window.

- Built with Electron (same tech as VS Code, Slack, Figma)
- Talks to Ollama over the local loopback
- ~8,000 lines of code, MIT-licensed, fork it
- Features: streaming chat, drag-drop files, 23 templates, folder indexing, saved prompts, dark mode, save-as-markdown

**Takes 15 minutes to install, 15 years to run out of uses.**

**Speaker note:** The app is the part you see, but the value is in the stack below it. Keep showing the layers.

---

## SLIDE 10 — The architecture

### What happens when you press Enter.

**[Horizontal diagram in 4 boxes, connected by arrows:]**

```
You  →  Purely Personal  →  Ollama  →  Qwen 2.5
                              (localhost:11434)      (4.7 GB on disk)
```

**Below, in red, crossed out: "The internet — never touched"**

- Every box runs in a different process on the same laptop
- The longest network path is the loopback interface
- Your computer talking to itself

**Speaker note:** Walk through each arrow out loud. You press Enter, app POSTs to localhost, Ollama loads the model, model predicts the next word. Tokens stream back. Done.

---

## SLIDE 11 — How a chat actually works

### Six steps, all on your laptop.

1. You type a prompt, press Enter
2. App POSTs to `http://localhost:11434/api/chat` over the loopback
3. Ollama loads the model into RAM (first time only, 15–30 sec)
4. Qwen 2.5 predicts the next token, then the next, then the next
5. Tokens stream back as Server-Sent Events
6. Markdown renders, em dashes get stripped, conversation saves to disk

**Speaker note:** The whole pipeline, named out loud. Engineers in the room will lean forward. Non-engineers will feel the magic get demystified.

---

## SLIDE 12 — The 8 core workflows

### One click, eight real jobs.

- **Summarize** — any document, any length
- **Reply** — hard emails, with your voice preserved
- **Clearer** — rewrite your own bad drafts
- **Explain** — any concept, plainly
- **Decide** — options in, structured pros/cons out
- **Brainstorm** — ten angles on any topic
- **Index a folder** — search your own notes by asking
- **Save as markdown** — plain files, you own them

**Each one is one button. Each one runs on your laptop.**

**Speaker note:** The point: no prompt-engineering required. The common cases are already wired up. You can still type freeform, but 80% of uses fit these 8.

---

## SLIDE 13 — RAG (search your own folder)

### Point it at a folder. Ask questions. Get cited answers.

- App walks your folder, chops every text file into 900-char chunks
- Each chunk becomes a 768-number "fingerprint" via local embeddings
- You ask a question, your question gets a fingerprint
- Cosine similarity finds the 5 most relevant chunks
- Those 5 go to Qwen 2.5 as context, you get a cited answer

**Like ChatGPT + your file, but nothing uploads.**

**Speaker note:** RAG = retrieval-augmented generation. Don't use the acronym. Say "the folder-search feature." The proof point: you can index 500 pages of session notes and ask "what did I decide about pricing?" and get an answer with a citation.

---

## SLIDE 14 — The privacy math

### "Local" means something exact.

- **No prompts leave your laptop.** Memory and disk only.
- **No files leave your laptop.** Drag-drop reads locally, feeds local inference, displays locally.
- **No telemetry.** Zero outbound connections except the one-time model download.
- **No vendor lock-in.** Chats save as plain markdown. You own everything.
- **Verify it yourself.** WiFi off, `lsof` during a chat, Activity Monitor. All three will show you the same truth.

**Speaker note:** The meta-point: you don't have to trust anyone. You can observe the privacy directly. That's what makes this different from "we promise not to train on your data."

---

## SLIDE 15 — Local AI vs cloud AI

### Use the right tool for the job.

| | **Purely Personal** | **ChatGPT / Claude** |
|---|---|---|
| Where it runs | Your laptop | A data center |
| What leaves | Nothing | Every prompt and file |
| Works offline | Yes | No |
| Cost | Free forever | $20/month typical |
| Training on your input | Physically can't | Depends on settings |
| Hard reasoning | Weaker | Stronger |
| Long docs (>200 pages) | Falls off | Claude handles 200k tokens |
| Best for | Confidential, routine, offline | Hard reasoning, latest news |

**Speaker note:** Honesty sells. Don't pretend the 7B model beats GPT-4 at everything. Say where the ceiling is. Students respect it.

---

## SLIDE 16 — 15-minute install

### Three steps. One per OS.

**macOS:**
1. `brew install ollama && brew services start ollama`
2. `ollama pull qwen2.5:7b`
3. Download the DMG, drag to Applications, right-click → Open

**Windows:**
1. Download Ollama installer from ollama.com/download/windows
2. In PowerShell: `ollama pull qwen2.5:7b`
3. Download the EXE, run it, SmartScreen → More info → Run anyway

**Linux:**
1. `curl -fsSL https://ollama.com/install.sh | sh`
2. `ollama pull qwen2.5:7b`
3. Clone the repo, run `./chat.sh`

**Speaker note:** Give this page to students the night before. Don't spend class time on installation. Show this slide, let them verify.

---

## SLIDE 17 — What to bring to class

### Four things.

- **Laptop, charged.** Charger anyway.
- **A document to summarize.** 2–10 pages. Not confidential. Practice material.
- **One real task you do manually** that you suspect AI could help with.
- **The class link.** Don't waste 5 min hunting for it.

**Speaker note:** Mention these in the pre-class email too. Reduces setup friction on the day.

---

## SLIDE 18 — What you walk away with

### After this session, you have:

- A free AI on your own laptop
- Eight one-click tools for daily work
- The confidence to use AI on your confidential files
- A clear rule for when to use local vs when to use cloud
- Zero monthly bills for AI, forever
- Proof (not a promise) that private means private

**Speaker note:** This is the outcomes slide. Students should read this and feel: "Yes, that's what I'll take home." Keep it concrete.

---

## SLIDE 19 — Roadmap

### What's next.

- **v0.1 — Shipped today.** Chat, templates, RAG, 23 workflows.
- **v0.2 — Next.** PDF and DOCX support. Code-signed installers. Linux desktop app.
- **v0.3 — Later.** Team features. Shared folder indexes. Vision model support (images, screenshots).
- **v1.0 — The goal.** A tool your mother could use without a terminal.

**Speaker note:** Transparency about limits builds trust. Also: it signals that this is a living project, not a one-off workshop demo.

---

## SLIDE 20 — Close

### One step tonight.

**Install it. Use it on one real thing this week. Tell me Friday how it went.**

- Download: purely-personal.vercel.app/download
- Source: github.com/danielpaulai/Run-Worldclass-computer-locally
- Workshop: tonight, 8 PM

*Everything here is free, open-source, and stays on your laptop. Forever.*

**Speaker note:** The close. Don't stack 4 CTAs. One thing: install and use. Make the ask small and the action specific.

---

---

# 🎨 Brand tokens for Genspark

**Paste these when Genspark asks about design:**

### Colors

| Token | Hex | Use |
|---|---|---|
| Cream (background) | `#faf7f2` | Every slide background |
| Cream-deep (alt bg) | `#f2ede2` | Alternating slides |
| Ink (text) | `#1a1a1a` | Body and headings |
| Muted (secondary text) | `#6b655c` | Captions, footnotes |
| Coral (accent) | `#c15f3c` | Accents, highlights, 1 color per slide max |
| Coral-deep | `#8a3d21` | Links, hover, dense coral text |
| Coral-soft | `#f4d4c2` | Soft accent backgrounds |
| Mint (success) | `#3d8a7c` | "Yes," "local," success states |
| Line (dividers) | `#e4dfd6` | Thin borders |
| Night (dark sections) | `#14110d` | Dark-mode slides, code blocks |

### Typography

- **Headings:** Iowan Old Style (fallbacks: Charter, Georgia, Times New Roman). **Bold, weight 700. Tight tracking (-0.014em).**
- **Body:** System font stack (`-apple-system, BlinkMacSystemFont, "Segoe UI", Inter, Helvetica, sans-serif`). Weight 400. Line-height 1.55–1.6.
- **Mono (code):** SF Mono, Consolas, Menlo.

### Logo

- Coral rounded square (13px radius) with lowercase italic "pp" inside
- Italic Iowan Old Style serif
- White "pp" on coral background
- Never use sans-serif for the mark

### Voice (pin this so Genspark's copy stays on-brand)

**Use:** On your laptop. Private. Local. Free. Open source. Offline. Yours. Straightforward. Works. Fixes. Solves. Proof.

**Never use:** Leverage. Unlock. Synergy. Revolutionary. Paradigm. Supercharge. Transform. Cutting-edge. Seamless. Magical. Bespoke. Curated.

**Punctuation:**
- No em dashes. Use commas or periods. (Em dashes are the AI tell.)
- No exclamation marks in body copy.
- Oxford comma on.
- Short paragraphs, 2–3 sentences max.
- Sentence case in UI, Title Case in marketing heads only.

### Layout principles

- Generous whitespace. Don't fill every pixel.
- One primary accent per slide. Coral or nothing.
- Serif for emotional weight (headings, pull-quotes). Sans for everything else.
- Proof over claim: show the diagram, the number, the quote. Don't just state.
- Warm, not white. Cream backgrounds, never pure white.

---

**That's 20 slides, brand tokens, voice rules. Paste this whole file into Genspark, tell it "use these tokens, use these slides, create the presentation." You should get something that looks like it came from Linear or Notion.**

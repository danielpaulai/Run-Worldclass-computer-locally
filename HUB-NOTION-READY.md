# Purely Personal

*A workshop on running a world-class AI entirely on your own laptop.*

---

## What this is

**Purely Personal is a private AI that lives on your computer.**

Not in the cloud. Not behind a login. Not billed by the month.

You open an app. You type a question. The model on your own laptop answers. Your data never goes anywhere.

---

## ⚠️ Important: students install THREE things (not one)

A common misunderstanding is that the DMG is all you need. It isn't. The DMG is the pretty chat window. It needs an AI engine running underneath to talk to.

Here's what every student installs, in this order:

| # | What | What it is | Size | Why |
|---|---|---|---|---|
| 1 | **Ollama** | The AI runtime (engine) | ~40 MB | Loads models into memory and runs inference |
| 2 | **`qwen2.5:7b`** | The AI model (the "brain") | 4.7 GB | The actual intelligence |
| 3 | **Purely Personal** | The desktop app (the UI) | ~95 MB DMG / 152 MB EXE | The friendly chat window you use |

**Without step 1**, the app opens but the chat says "Ollama not reachable."

**Without step 2**, the app opens but says "no models installed."

**Without step 3**, everything works but you'd be chatting via `curl` in a terminal.

Students do all three in the Pre-Class Activity. Total time: 15 minutes. Bulk of that is the 4.7 GB model download.

---

## Why it matters

Every professional has a folder of documents they'd never paste into ChatGPT. Client contracts. Session notes. Financial docs. Medical records. Anything under NDA.

So they use AI for the easy 30% and do the hard 70% by hand.

**Purely Personal is for the hard 70%.** For everything you get paid to handle but can't safely upload anywhere.

---

## Download links (v0.1.0)

The installers are free, open-source, and work offline. These are just the desktop app — students still need Ollama + model (see below).

- **🍎 Mac (Apple Silicon, M1/M2/M3/M4):** https://github.com/danielpaulai/Run-Worldclass-computer-locally/releases/download/v0.1.0/Purely.Personal-0.1.0-arm64.dmg (91 MB)
- **🍎 Mac (Intel):** https://github.com/danielpaulai/Run-Worldclass-computer-locally/releases/download/v0.1.0/Purely.Personal-0.1.0.dmg (97 MB)
- **🪟 Windows 10/11 (x64 and ARM):** https://github.com/danielpaulai/Run-Worldclass-computer-locally/releases/download/v0.1.0/Purely.Personal.Setup.0.1.0.exe (152 MB)
- **🐧 Linux:** No desktop app yet (v0.2 roadmap). Use repo scripts.

**Release page:** https://github.com/danielpaulai/Run-Worldclass-computer-locally/releases/tag/v0.1.0

---

## Install on macOS (3 steps)

### Step 1 — Install Ollama (the engine)

```
brew install ollama
brew services start ollama
```

**Verify:** `curl http://localhost:11434/api/version`

No Homebrew? Download from https://ollama.com/download/mac

### Step 2 — Download the AI model

```
ollama pull qwen2.5:7b
```

4.7 GB, 3–10 min on WiFi. Verify: `ollama list` shows `qwen2.5:7b`.

### Step 3 — Install Purely Personal (the UI)

1. Download the DMG for your chip
2. Open the DMG, drag Purely Personal to Applications
3. Open Applications, **right-click** Purely Personal → **Open** → **Open** (one-time Gatekeeper bypass)

### Security notes

- App runs entirely locally. Talks to Ollama on `localhost:11434`. **No data leaves the machine.**
- **Verify:** turn off WiFi, ask a question. Chat keeps working.
- `lsof -i :11434` shows only `ollama` on localhost.
- Gatekeeper warning is because we haven't paid Apple's $99/year. Fully open source.
- Corporate-locked? Use WSL/Linux path.

---

## Install on Windows (3 steps)

### Step 1 — Install Ollama (the engine)

Download the installer: https://ollama.com/download/windows → run it → click through defaults. Ollama starts automatically.

**Verify** in PowerShell: `curl http://localhost:11434/api/version`

### Step 2 — Download the AI model

```
ollama pull qwen2.5:7b
```

### Step 3 — Install Purely Personal (the UI)

1. Download Purely Personal Setup 0.1.0.exe
2. Double-click to run
3. SmartScreen warning → **More info → Run anyway**

### Security notes

- App binds only to `localhost`. No external traffic during chat.
- SmartScreen warning is because we haven't paid for code-signing ($100–400/year).
- Windows Defender does not flag it.
- Corporate-locked? Use WSL2.

---

## Install on Linux (4 steps, no GUI yet)

### Step 1 — Install Ollama

```
curl -fsSL https://ollama.com/install.sh | sh
```

### Step 2 — Start the service

```
sudo systemctl enable --now ollama
curl http://localhost:11434/api/version
```

### Step 3 — Pull the model

```
ollama pull qwen2.5:7b
```

### Step 4 — Clone the repo

```
git clone https://github.com/danielpaulai/Run-Worldclass-computer-locally.git
cd Run-Worldclass-computer-locally
./setup.sh
./chat.sh
```

Or use the 16 bundled skills:

```
./ai local-ai ask "Explain HTTPS in 3 sentences."
./ai summarize tldr some-document.txt
./ai local-rag ingest ~/my-notes-folder
```

### Security notes

- Ollama runs as systemd service. `systemctl status ollama` to check.
- `sudo lsof -i -P -n | grep LISTEN | grep ollama` → only `127.0.0.1:11434`.
- On SELinux/AppArmor distros, first launch may need permission.

---

## What you can do with Purely Personal

### The chat + six one-click starters

- **Summarize** — paste anything, get the gist
- **Reply** — draft responses to hard emails
- **Clearer** — rewrite your own writing
- **Explain** — any topic, plainly
- **Decide** — pros, cons, the question to ask yourself
- **Brainstorm** — ten angles

### Drag any file onto the chat

Text files up to 500 KB. Five preset actions: TLDR · Key bullets · Action items · Find risks · Draft a reply.

### Templates library (23 items across 4 categories)

- **Writing (6):** Cover letter, Thank-you note, Polite decline, Cold intro, Follow-up, Apology
- **Marketing (7):** Positioning, LinkedIn post, Twitter thread, Email sequence, FAQ, Landing copy, Press release
- **Meetings (5):** Agenda, 1:1 prep, Recap, Decision doc, Retrospective
- **Learning (5):** Explain simply, Feynman mode, Quiz me, Compare concepts, Flashcards

### Query your own folder (RAG)

Click Docs → Index a folder. Indexing takes ~60 sec. Ask questions, get cited answers. All local.

### Everything else

Saved prompts · Conversation history · Model switcher · Save as markdown · Dark mode · Stop generating

---

## Session notes — the 60-minute workshop

### Arc

| Minutes | What | Why |
|---|---|---|
| 0–5 | Frame, not features | Set the problem first |
| 5–13 | Install check + thumbs-up | Everyone on the same page |
| 13–23 | Demo: Summarize | The strongest case |
| 23–38 | Their own document | The conversion moment |
| 38–43 | WiFi-off privacy proof | The emotional anchor |
| 43–53 | Templates demo | Shows the depth |
| 53–60 | Q&A + 5-day plan | The commitment |

### The opener

> "Quick show of hands. Who here has ever hesitated to paste a document into ChatGPT because it had confidential data in it?"

> "Today's session is about that hesitation. What if there was an AI for the files you can't upload?"

### The pivot line (memorize)

> "And it just did that on my laptop. Nothing uploaded. Now imagine you're the one with the contract."

### The privacy proof

> "Everyone. Turn off your WiFi. Right now. Airplane mode."

Wait. Then: "Type a new message. Anything."

They hit send. AI responds.

> "Your file was never going to the cloud, because the app never needed the internet. This is what 'local' means."

### Likely questions

- "Can I use a bigger model?" → Yes, model dropdown. Try `qwen2.5:14b` if 32 GB RAM.
- "Work laptop?" → If IT allows Slack/Zoom, probably yes. Else WSL/Linux path.
- "As smart as ChatGPT?" → Honest: no on hard reasoning. For 20x/day tasks, right there.

### The close

> "Don't try to do everything. Pick one thing from your real work you've avoided because you couldn't trust cloud. Try that this week. Reply Friday."

---

## Pin this (things that are NOT the same)

- **Ollama ≠ Purely Personal.** Ollama = engine. Purely Personal = UI.
- **The DMG ≠ the AI.** DMG = 95 MB chat window. AI = 4.7 GB model file.
- **"Installed" ≠ "working."** Fresh install shows errors until Ollama is running AND a model is pulled.
- **"Running" ≠ "loaded."** First message takes 15–30 sec while model loads into RAM. Normal.

---

## The repo

https://github.com/danielpaulai/Run-Worldclass-computer-locally — MIT licensed, open source.

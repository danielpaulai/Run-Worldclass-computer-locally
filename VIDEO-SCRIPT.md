# Video Script — Run a World-Class AI on Your Laptop

**Target length:** 5–6 minutes
**Audience:** Complete beginners who have never run a local model
**Goal:** They finish the video with a working local AI and five ways to use it.

Timings are cumulative. Format: `[mm:ss] SCREEN | NARRATION`

---

## Cold open — the hook (0:00–0:20)

`[00:00] Close-up of terminal showing an AI response streaming in.`

> "Everything you're watching on my screen right now is running on this laptop. No internet. No subscription. No data leaving my machine. And in the next five minutes, I'm going to show you how to do the same."

`[00:15] Cut to: presenter on camera, laptop visible.`

> "Three things, one command each. Let's go."

---

## Part 1 — What you'll have at the end (0:20–0:50)

`[00:20] Cut to finished state: chat.sh running, conversation visible.`

> "By the end you'll have a world-class AI model — the same calibre people used to pay for — running fully on your own computer. No API keys. Completely private. Works on a plane."

`[00:35] Cut to repo README on GitHub, scroll through.`

> "All the code is in one public GitHub repo. I'll link it below. One command sets the whole thing up."

---

## Part 2 — Preflight (0:50–1:20)

`[00:50] Terminal. Show the user running ./preflight.sh.`

```bash
./preflight.sh
```

> "Before you install anything, run preflight. It checks your RAM, your disk space, your internet, and tells you exactly which model you'll get."

`[01:05] Highlight the "You will get: qwen2.5:7b" line.`

> "On my 16-gig MacBook, I get qwen-2.5 seven billion. If you've got 32 gigs, you'll get the 14 billion model. 64 gigs, you get gpt-oss 20B. The script picks the right size automatically."

---

## Part 3 — Setup (1:20–3:00)

`[01:20] Terminal. Run ./setup.sh.`

```bash
./setup.sh
```

> "Now the actual install. This one command does four things."

`[01:30] Screen-overlay with numbered list appearing as each happens.`

1. Installs Homebrew if you don't have it
2. Installs Ollama — that's the runtime
3. Starts Ollama in the background on localhost port 11434
4. Downloads your model

> "The download is the longest part. Walk away. Grab coffee. For a 5-gig model on a typical home internet, we're talking three to eight minutes."

`[02:15] Time-lapse the progress bar. Speed up 8x.`

`[02:45] Show the green "Setup complete" banner.`

> "Done. Ollama is running. The model is on disk. Nothing we do from here on needs the internet."

---

## Part 4 — First chat (3:00–3:30)

`[03:00] Terminal. Run ./chat.sh.`

```bash
./chat.sh
```

`[03:05] Type: "Explain what makes a transformer different from an RNN, in two sentences."`

`[03:10] Wait briefly for first token. Then streaming response.`

> "First response takes about 15 seconds while the model loads into RAM. After that, it's fast. Watch."

`[03:22] Ask a follow-up, show instant response.`

> "That's the baseline. A real AI, on your own machine, right now. But the fun part is what you can build on top of this."

---

## Part 5 — The five skills (3:30–4:45)

`[03:30] Open Claude Code in the repo folder.`

> "The repo ships with five Claude Code skills. They all route through the local model, so everything you do stays private."

`[03:40] Screen: speak the prompt, show Claude Code invoking the skill.`

### Demo 1 — local-chat  (10 sec)

> "'Ask my local model to name three good sci-fi novels from the nineties.'"

`[Show three titles appear.]`

### Demo 2 — local-file-summary  (15 sec)

> "Here's a fake confidential memo. Watch — 'summarize this file privately.'"

`[Claude Code invokes local-file-summary. Summary appears.]`

> "Never left my machine. Can't stress this enough — this is why local matters."

### Demo 3 — local-benchmark  (10 sec)

> "'Benchmark my model.' Forty-seven tokens per second on an M3. That's faster than most people read."

### Demo 4 — local-compare  (15 sec)

> "And because we're honest — 'compare local and cloud on this logic puzzle.'"

`[Show side-by-side. Cloud answer is slightly better.]`

> "Local won't always match frontier Claude. But for summarization, drafting, Q&A over your notes — it's right there."

### Demo 5 — swap-model  (10 sec)

> "And when you want to try a different model — 'switch to qwen-2.5 coder.' One prompt, done."

---

## Part 6 — What to do next (4:45–5:30)

`[04:45] Back on camera, repo visible.`

> "Three homework assignments if you want to go deeper."

`[04:50] Numbered overlay.`

1. **Summarize something confidential.** A journal entry. A contract. Watch it work with zero network activity.
2. **Benchmark a second model.** Pull llama3.2:3b alongside yours. Compare speeds.
3. **Write a sixth skill.** Template is in `SKILLS.md`. Share yours with me.

> "Everything — the scripts, the skills, the walkthrough, a cheat sheet PDF — is in the repo. Link below."

---

## Close (5:30–6:00)

`[05:30] Presenter on camera.`

> "If this saved you an afternoon, forward it to one person who's been curious about local AI but hasn't pulled the trigger. That's the whole ask."

`[05:45] End card: repo URL, subscribe.`

---

## B-roll shot list (record during or after)

- [ ] Overhead shot of laptop with no wifi bars visible
- [ ] Hands typing on keyboard, close-up
- [ ] Screen showing Activity Monitor / Task Manager with Ollama using RAM
- [ ] Progress bar filling (time-lapse)
- [ ] Green "Setup complete" banner (static shot for thumbnails)
- [ ] Side-by-side local vs cloud split screen (for thumbnails)

## On-screen graphics to prep

- [ ] Title card: "Run a World-Class AI on Your Laptop"
- [ ] Four-step setup overlay (Homebrew → Ollama → Start → Download)
- [ ] RAM → Model table (from README)
- [ ] "Total time: 12 minutes" badge
- [ ] Repo URL lower third
- [ ] End card with subscribe / repo links

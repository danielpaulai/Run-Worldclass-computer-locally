# Pre-Class Activity — Do This Before We Meet

**Total time:** ~30 minutes (mostly waiting for a download)
**Goal:** Everyone walks into the live session with a working local AI.

> **Don't panic if this fails.** If you can't finish the setup, you can still fully participate in the session by following along with the [example outputs](./examples/). We'll have you covered.

---

## Step 1 — Run the preflight check  (5 min)

```bash
git clone https://github.com/danielpaulai/Run-Worldclass-computer-locally
cd Run-Worldclass-computer-locally
./preflight.sh                    # Windows: .\preflight.ps1
```

You'll get output like:

```
  [OK]   macOS 15.2
  [OK]   16 GB RAM
  [OK]   Free disk space           82 GB
  [OK]   Internet to ollama.com    reachable
  You will get:  qwen2.5:7b  (~5 GB download)
  You're good to go.  Run:  ./setup.sh
```

**Reply to the pre-class email with the "You will get:" line.** That tells me you're ready.

## Step 2 — Run the setup  (20 min, mostly download)

```bash
./setup.sh                        # Windows: .\setup.ps1
```

This will:
1. Install Homebrew if you're on a Mac and don't have it
2. Install Ollama (the runtime for local AI models)
3. Start Ollama quietly in the background
4. Download the model picked for your RAM (~5 GB for most)
5. Print a "Setup complete" banner when done

**Walk away during the download.** It resumes automatically if your wifi drops.

## Step 3 — Confirm it works  (2 min)

```bash
./chat.sh                         # Windows: .\chat.ps1
```

Type something. Wait 15–30 seconds for the first response (the model is loading into RAM). You should get a sensible reply.

Type `/bye` to exit.

**If you made it this far, you're set for the session.**

---

## If anything fails

Three escape hatches, in order:

1. **Re-run the script.** Both `preflight.sh` and `setup.sh` are safe to run as many times as you want.
2. **Skim the [troubleshooting table in the walkthrough](./WALKTHROUGH.md#common-hiccups).** 90% of issues have a one-line fix.
3. **Reply to the pre-class email with the last ~20 lines of your terminal output.** I'll have a fix before the session.

---

## While you wait for the download

Read these — they take about 15 minutes total and will make the live session ~3x more valuable:

- [ ] **[USE-CASES.md](./USE-CASES.md)** — five real small-business owners and what they'd actually do with this
- [ ] **[WALKTHROUGH.md](./WALKTHROUGH.md)** — step-by-step with diagrams
- [ ] **[examples/README.md](./examples/README.md)** — six real outputs the model produced on my laptop, so you know what to expect

## Bring to the session

- Your laptop, charged
- A sample file you'd like to summarize (can be public — we're practicing, not sharing secrets)
- One task you're currently doing manually that an AI might help with — we'll actually try it live

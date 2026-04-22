# 📋 Pre-Class Setup — Do this tonight (15 min)

> **Do this tonight. Takes 15 minutes. Nothing ever leaves your laptop.**

# The one thing you have to do before class

Install a free, private AI on your laptop. Tomorrow we'll use what you installed. If you skip this, you'll spend the hour watching the rest of us instead of doing it yourself, and you won't get the best of this session.

**Everything below is free. Everything runs locally. No account, no credit card, no subscription.**

---

## Why we're doing this ahead of time

Tomorrow's class is hands-on. We don't want 100 people installing software while the clock ticks. If you hit a bump tonight, that's 5 minutes of trouble that never touches the class. Tomorrow you get to spend the whole hour *using* what you built.

**If you hit a wall, email me tonight. Not during class.**

---

## ⚡ Before you start, confirm you have this

- [ ]  A laptop running macOS, Windows 10/11, or Linux
- [ ]  At least 8 GB of RAM (16 GB recommended, 8 works)
- [ ]  At least 15 GB of free disk space
- [ ]  A stable WiFi connection for the one-time ~5 GB download
- [ ]  An hour of wall-plugged laptop time

If any of those are no, reply to the class email tonight so we can work around it.

---

# 🍎 macOS: 4 steps

## Step 1 — Install Ollama

Ollama is the runtime that runs the AI. Open **Terminal** (⌘+Space → "Terminal" → Enter) and paste:

```
brew install ollama
```

No Homebrew? Grab the Mac installer: [ollama.com/download/mac](https://ollama.com/download/mac)

## Step 2 — Start Ollama

```
brew services start ollama
```

Confirm it's running:

```
curl http://localhost:11434/api/version
```

JSON response with a version number? Ollama is live.

## Step 3 — Download the AI model

```
ollama pull qwen2.5:7b
```

4.7 GB download, 3–10 minutes on WiFi. Keep the laptop plugged in. When done:

```
ollama list
```

You should see `qwen2.5:7b`.

## Step 4 — Install Purely Personal

- **Apple Silicon (M1/M2/M3/M4):** [Purely Personal arm64 DMG](https://github.com/danielpaulai/Run-Worldclass-computer-locally/releases/download/v0.1.0/Purely.Personal-0.1.0-arm64.dmg)
- **Intel Mac (2015–2020):** [Purely Personal Intel DMG](https://github.com/danielpaulai/Run-Worldclass-computer-locally/releases/download/v0.1.0/Purely.Personal-0.1.0.dmg)

Not sure which? Apple menu → *About This Mac*. "Apple M…" = arm64.

Open the DMG, drag the app into Applications.

> 🔒 **Security note:** First launch, macOS will say *"cannot be opened because it is from an unidentified developer."* We haven't paid Apple $99 for a code-signing certificate yet (we're a free, open-source project). **To open:** right-click the app in Applications → **Open** → **Open**. One-time only.

Open the app. You should see "✓ ready · 1 model installed". Type "hello", press Enter. Reply in under 5 seconds? Setup done.

---

# 🪟 Windows: 3 steps

## Step 1 — Install Ollama

Download the installer: [ollama.com/download/windows](https://ollama.com/download/windows)

Run it. Click through the defaults. Ollama installs and starts automatically.

Confirm. Open PowerShell (Win key → "powershell" → Enter):

```
curl http://localhost:11434/api/version
```

## Step 2 — Download the model

```
ollama pull qwen2.5:7b
```

## Step 3 — Install Purely Personal

- **Windows (x64 and ARM):** [Purely Personal Setup 0.1.0.exe](https://github.com/danielpaulai/Run-Worldclass-computer-locally/releases/download/v0.1.0/Purely.Personal.Setup.0.1.0.exe)

> 🔒 **Security note:** SmartScreen will warn *"Windows protected your PC."* We haven't paid for a code-signing cert ($100–400/year, open source project). **To install:** click **More info** → **Run anyway**. One-time only.

Launch from the Start menu. Type "hello", press Enter. Reply in under 10 seconds? Done.

---

# 🐧 Linux: 4 steps (no desktop app yet)

## Step 1 — Install Ollama

```
curl -fsSL https://ollama.com/install.sh | sh
```

## Step 2 — Start the service

```
sudo systemctl enable --now ollama
curl http://localhost:11434/api/version
```

## Step 3 — Pull the model

```
ollama pull qwen2.5:7b
```

## Step 4 — Clone the repo

```
git clone https://github.com/danielpaulai/Run-Worldclass-computer-locally.git
cd Run-Worldclass-computer-locally
./setup.sh
./chat.sh
```

> 🔒 **Security note:** You're running an install script from the internet. Read it first, a few hundred lines of bash. No outbound network once the model is pulled. We'll walk through this in class.

---

# ✅ You're ready if you can say yes to all five

- [ ]  Ollama is installed and running (`curl http://localhost:11434/api/version` returns a version)
- [ ]  `ollama list` shows `qwen2.5:7b`
- [ ]  I've installed Purely Personal (Mac/Windows) or cloned the repo (Linux)
- [ ]  I can type "hello" and get a reply in under 10 seconds
- [ ]  I know the class time and the link to join

Five checks? Set. Close the laptop, see me tomorrow.

---

# 🧰 What to bring to class

- **Laptop, charged.** Bring the charger anyway.
- **A document you'd like summarized.** 2–10 pages. Nothing confidential, we're practicing.
- **One task you do manually** that you suspect AI could help with. A real one, not hypothetical.
- **Your class link or meeting room.**

---

# 🆘 If something breaks

**"Ollama not reachable"** — Ollama isn't running. Restart it: `brew services restart ollama` (Mac) / `sudo systemctl restart ollama` (Linux) / relaunch from the tray (Windows).

**"No models installed"** — Pull didn't finish. `ollama pull qwen2.5:7b` again.

**Mac "unidentified developer"** — Right-click the app → Open → Open.

**Windows SmartScreen** — More info → Run anyway.

**Slow on 8 GB RAM** — First message takes 15–30 seconds to load. After that it speeds up. Still slow? Pull a smaller model: `ollama pull qwen2.5:3b`, then switch in the app dropdown.

**Corporate laptop** — Use WSL2 on Windows, or ask IT for a one-off exception tonight.

**Still stuck** — Reply to the class email with OS + exact error + screenshot. I'll reply within a few hours.

---

# 📌 Your one call-to-action

**Right now, today, not tomorrow morning:**

1. Open your laptop
2. Follow the steps for your OS
3. Check every box in the "You're ready" list
4. Email me if you get stuck

That's it. See you in class.

---

*Repo:* https://github.com/danielpaulai/Run-Worldclass-computer-locally

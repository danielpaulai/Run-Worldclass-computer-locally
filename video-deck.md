---
marp: true
theme: default
paginate: false
backgroundColor: "#faf7f2"
color: "#1a1a1a"
style: |
  section {
    font-family: "Iowan Old Style", Charter, Georgia, serif;
    padding: 80px 100px;
  }
  h1 {
    font-size: 72px;
    font-weight: 700;
    letter-spacing: -0.02em;
    line-height: 1.1;
    color: #1a1a1a;
    margin-bottom: 24px;
  }
  h2 {
    font-size: 48px;
    color: #c15f3c;
    margin-bottom: 18px;
  }
  p {
    font-family: -apple-system, "Segoe UI", Helvetica, sans-serif;
    font-size: 30px;
    line-height: 1.5;
    color: #1a1a1a;
  }
  strong { color: #c15f3c; font-weight: 700; }
  .kicker {
    display: inline-block;
    background: #f4d4c2;
    color: #8a3d21;
    padding: 6px 16px;
    border-radius: 100px;
    font-size: 18px;
    font-weight: 700;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    margin-bottom: 24px;
  }
  .logo {
    width: 90px; height: 90px; border-radius: 20px;
    background: #c15f3c;
    color: #fff;
    display: inline-flex;
    align-items: center; justify-content: center;
    font-style: italic;
    font-size: 52px; font-weight: 700;
    letter-spacing: -3px;
    margin-bottom: 32px;
  }
  .big {
    font-size: 44px; line-height: 1.3;
    font-family: "Iowan Old Style", Charter, serif;
  }
---

<div class="logo"><em>pp</em></div>

# Install tonight.

**A private AI on your laptop. Free. In 15 minutes.**

<!--
Look, I'll keep this short. Tomorrow, you're going to install a real AI on your laptop. Not ChatGPT. Not Claude. Not something you pay for. A real AI. On your own computer. For free. That never sends your data anywhere. And tonight, you're going to install it.
-->

---

<span class="kicker">Why</span>

## You've stopped using AI for the hard 70%.

Every one of you has a folder of documents you'd never paste into ChatGPT.

Client contracts. Session notes. Financial stuff. The things you get paid to handle.

**Tomorrow, we fix that. You get the 70% back.**

<!--
Here's why this matters. Every one of you has a folder of documents you'd never paste into ChatGPT. Client contracts. Session notes. Financial stuff. The things you get paid to handle. So you've been using AI for the easy 30% of your work. And doing the hard 70% by hand. Tomorrow, we fix that. You get the 70% back.
-->

---

<span class="kicker">The Promise</span>

## Here's what happens in class.

I paste a contract into an AI. Live. In front of you.

WiFi off. No cloud. My laptop.

You watch it summarize, extract risks, flag weird clauses. In under 30 seconds.

**Then you do the same thing. On yours.**

<!--
Here's what happens in class. I'm going to paste a contract into an AI, live, in front of you. WiFi off. No cloud. My laptop. You're going to watch it summarize, extract the risks, flag the weird clauses. In under 30 seconds. Then you're going to do the same thing. On yours.
-->

---

<span class="kicker">Install</span>

## Three things. Not one.

**1. Ollama.** The engine. 40 MB. One minute.

**2. Qwen 2.5.** The AI model. 4.7 gigabytes. Three to ten minutes.

**3. Purely Personal.** The chat window. 95 megabytes. Thirty seconds.

**All free. All open source. Nothing leaves your laptop.**

<!--
For this to work, you need three things installed tonight. Not one. Three. One. Ollama. It's the engine that runs the AI. Free, open source, 40 megabytes. Takes a minute. Two. The AI model. It's called qwen two-point-five. It's 4.7 gigabytes. The download takes five to ten minutes. Do it on WiFi, plugged in. Three. The Purely Personal app. That's the chat window you'll actually use. 95 megabytes. Drag and drop. Three things. All free. All open source. Nothing leaves your laptop.
-->

---

<span class="kicker">macOS</span>

## Open Terminal. Paste these.

```
brew install ollama
brew services start ollama
ollama pull qwen2.5:7b
```

Then download the DMG. Drag it into Applications. Right-click to open the first time.

**Done.**

<!--
If you're on a Mac: Open Terminal. Paste three lines. brew install ollama. Then brew services start ollama. Then ollama pull qwen two-point-five colon seven b. Then download the DMG from the link in the pre-class Notion page. Drag it into Applications. Right-click to open the first time. Done.
-->

---

<span class="kicker">Windows</span>

## Install Ollama. Pull the model. Run the EXE.

Download from **ollama.com/download/windows**. Run it.

Open PowerShell:
```
ollama pull qwen2.5:7b
```

Download the EXE. Windows warns you. Click **More Info → Run Anyway**.

**Done.**

<!--
If you're on Windows: Go to ollama dot com slash download slash windows. Run the installer. Then open PowerShell and run ollama pull qwen two-point-five colon seven b. Then download the EXE. Run it. Windows will warn you. Click More Info, Run Anyway. Done.
-->

---

<span class="kicker">Stakes</span>

## Here's the real ask.

Tomorrow is sixty minutes. I'm not spending twenty of them watching you install.

Do this tonight. You use the whole hour on what you built.

Skip this. You spend thirty minutes stuck. Thirty minutes watching others.

**Don't be that person.**

<!--
Here's the real ask. Tomorrow's an hour. Sixty minutes. I'm not going to spend twenty of those watching you install software. If you do this tonight, you spend the whole hour using what you built. If you don't, you spend thirty minutes stuck and thirty minutes watching others use it. Don't be that person.
-->

---

# See you in class.

**Open the pre-class link in the email.**

Check the five boxes before you close your laptop tonight.

If you get stuck, reply to the email. Don't wait till tomorrow.

<!--
Open the pre-class Notion link in my email. Five checkboxes. Hit them all before you close your laptop tonight. If you get stuck, reply to the email. Don't wait till tomorrow. See you in class.
-->

# 90-Second Pre-Class Video Script

A short, personal video to record tonight and attach to the pre-class email. Goal: reassure students that setup is easy, and pre-commit them to doing it.

**Total length:** 90 seconds. **No editing needed.** One take, phone camera, your desk.

---

## Before you hit record (30 seconds of prep)

- Camera at eye level
- Good natural light or lamp in front of you
- One browser tab open to the GitHub repo: https://github.com/danielpaulai/Run-Worldclass-computer-locally
- Your terminal visible in the background (optional — it signals "this is real")

---

## The script

**[0:00–0:10] — Hook**

> "Hey — quick 90-second video for tomorrow's workshop. I want to show you exactly what you're going to do tonight so there are zero surprises."

*(Look at camera. Don't rush.)*

**[0:10–0:25] — The promise**

> "You've got one job tonight: install the thing. Takes about 15 minutes of waiting while a file downloads. You don't have to sit there — you can go make dinner. When it's done, you'll have a private AI running on your laptop. Nothing leaves your machine. No API key. No subscription."

**[0:25–0:50] — Show the commands (screen share or point at monitor)**

> "Here's the whole thing. Three lines. Mac users: open Terminal, paste these three lines."

*(Switch to showing the screen or reading slowly:)*

```
git clone https://github.com/danielpaulai/Run-Worldclass-computer-locally
cd Run-Worldclass-computer-locally
./preflight.sh && ./setup.sh
```

> "Windows users: PowerShell instead of Terminal, and the commands have dots and backslashes — I sent them in the email. Same three lines, same result."

**[0:50–1:10] — What success looks like**

> "When it finishes, you'll see a green banner that says 'Setup complete'. That's it. When you see that, close your laptop, you're done for tonight."

*(Optional: hold up your own laptop showing the banner.)*

**[1:10–1:25] — What if it fails**

> "If it fails, don't panic, don't stay up fixing it. Just come to class anyway. I've built a fallback so you can follow along even without a working install, and we'll get yours working in the first five minutes."

**[1:25–1:30] — Close**

> "Bring a document you want summarized \u2014 email thread, PDF, meeting notes, anything 2 to 10 pages. Nothing confidential. See you tomorrow."

*(Small wave. End.)*

---

## Production notes

- **Don't script-read.** Memorize the beats, not the words. Talk to the camera like you'd talk to one student in your office.
- **One take is fine.** Flubs are human. Don't re-record unless you say the wrong URL.
- **No editing.** Upload the raw file.
- **Hosting:** drop it on Loom, Google Drive, or Dropbox. Link it in the email under the install commands.

## If you want the script shorter (60 seconds)

Cut sections [0:25–0:50] and [1:10–1:25]. Combine into:

> "Three commands, in the email. Mac opens Terminal, Windows opens PowerShell. Takes 15 minutes, mostly downloading. If it fails, come anyway \u2014 I've got a fallback. Bring a document to summarize, 2-10 pages, nothing confidential. See you tomorrow."

## If you want the script longer (3 minutes)

Add [1:05–2:00]: actually demo Step 2 on camera.

> "Here's what you'll do in class. One command \u2014 `./ai local-ai ask hi in 3 words`. About 15 seconds of waiting because the model is loading into RAM. And then \u2014" *(show the 3-word response on your screen)* \u2014 *"that. That's your local AI, on your laptop. From there we go to summarizing real documents, then we turn off the WiFi to prove it's private. You'll leave class with it running on your machine."*

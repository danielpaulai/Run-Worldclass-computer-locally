# Pre-Class Email — copy & paste

Copy everything between the `---` lines below into your email client. Works for any audience (mixed Mac / Windows).

---

**Subject:** Tomorrow's workshop — 15 min of prep tonight will make everything smoother

Hi everyone,

Looking forward to tomorrow. **One thing to do tonight** so we don't burn class time on downloads:

### If you're on a Mac

Open Terminal (⌘-Space → "Terminal") and run:

```bash
git clone https://github.com/danielpaulai/Run-Worldclass-computer-locally
cd Run-Worldclass-computer-locally
./preflight.sh && ./setup.sh
```

### If you're on Windows

Open PowerShell (Start → "PowerShell") and run:

```powershell
git clone https://github.com/danielpaulai/Run-Worldclass-computer-locally
cd Run-Worldclass-computer-locally
.\preflight.ps1
.\setup.ps1
```

**What you'll see:** about 15–20 minutes of downloading (5 GB model). Walk away. Make dinner. It resumes if your wifi hiccups.

**When it finishes:** you'll see a green "Setup complete" banner. That's it — you're set.

---

### What to bring to class

1. **Your laptop, charged.**
2. **A document of yours** to summarize — anything 2-10 pages you'd actually like read for you. An email thread, a PDF you've been putting off, meeting notes. **Nothing confidential** — we're practicing, not sharing secrets.
3. **One question** you've been meaning to answer but haven't had time to research.

### If the setup fails tonight

Don't panic — **just come anyway.** I've built a fallback so you can follow along even without a working install, and we'll get yours working in class.

See you tomorrow,
[Your name]

---

## Notes for the teacher (not for the email)

- **Send this TONIGHT**, ideally by 9 pm, so students have time to install before bed.
- The email mentions both operating systems. If your cohort is all-Mac or all-Windows, delete the other block.
- The "green banner" line is a real thing — that's exactly what they'll see on success. So they can look for a specific signal.
- Add one line if you have a Windows student willing to QA: *"Windows students — if anyone has time to test `.\setup.ps1` before tomorrow and reply here, I owe you one."*

# Local AI Workshop — Desktop App

A minimal Electron wrapper around `workshop.html`. Opens the interactive Five-Real-Mondays workshop as a real native window with a dock icon, menu bar, and full-screen support.

This is the **MVP wrapper** — it shows the existing workshop page as a desktop app. A follow-up version (streaming Ollama integration, file pickers, all 15 skills wired into the GUI) is on the roadmap after the first cohort.

## Easiest way to run it

From the **repo root** (not `desktop-app`):

```bash
./launch-app.sh
```

That's the whole command. It:

- `cd`s into `desktop-app/` automatically
- Runs `npm install` the first time (~1 min)
- Launches the app every time after

No need to `cd` manually.

## If you prefer the manual way

```bash
cd desktop-app
npm install        # only needed the first time (~1 min)
npm start          # every time
```

## Build a distributable

### macOS (.dmg)

```bash
npm run build:mac
```

Produces `dist/Local AI Workshop-0.1.0.dmg`. Drag the app to Applications. Done.

The DMG is **unsigned** by default — macOS will show a "cannot be opened" warning on first launch. Right-click the app in Applications → "Open" → "Open" again to bypass. For distribution to students, consider signing with an Apple Developer ID (`$99/year`); see electron-builder docs.

### Windows (.exe installer)

```bash
npm run build:win
```

Produces `dist/Local AI Workshop Setup 0.1.0.exe`.

### Linux (.AppImage)

```bash
npm run build:linux
```

## Keeping `workshop.html` in sync

The desktop app has its own copy of `workshop.html` so the built app bundle is self-contained. After editing the repo-root `workshop.html`:

```bash
npm run sync-html
```

## What this MVP does NOT do (yet)

- It does not directly talk to Ollama. Students still copy the generated command into Terminal.
- No file picker. Students still type file paths.
- No streaming model output inside the app.

All three are on the v1.0 roadmap (~5–7 days of focused work after the first workshop cohort).

## File layout

```
desktop-app/
  main.js           # Electron main process
  package.json      # deps and build config
  workshop.html     # the workshop page (synced copy of repo-root file)
  README.md         # this file
```

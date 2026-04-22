# Roadmap — Purely Personal

What's shipped, what's next, what's blocked.

---

## v0.1 (shipped, tonight)

### App
- Electron desktop app for macOS (arm64 + Intel) and Windows (x64 + arm64)
- **Live chat** streaming from local Ollama
- **6 real-world use cases** built in as one-click quick-actions
- **Drag-and-drop file attachment** with 5 preset actions (TLDR / bullets / actions / risks / reply)
- **Model switcher dropdown** with persistence
- **Saved prompts library** (localStorage)
- **Conversation history** (auto-save, resume, delete)
- **Marketing kit** popover with 8 assets (load into chat to adapt)
- **Save conversation** as markdown (native dialog)
- **Stop generating** button with preserved partial output
- **Dark mode** toggle (persists across launches)
- **Native file/folder pickers**
- **Markdown rendering** in chat bodies (bold, lists, tables, code blocks)
- **Em-dash stripper** for cleaner output
- **Custom app icon** (coral rounded square with italic "pp" mark)

### Content
- 8 marketing files rewritten in Daniel's voice
- Full landing page ready to deploy

### Skills
- 16 bundled skills (15 local-AI + workshop-image-builder)

---

## v0.2 — "Queryable archive" (weekend project, ~1 week out)

The one big missing feature: **in-app RAG.**

Drop a folder, the app indexes it, you ask questions across everything. The feature that makes users' own archives queryable.

### Scope
- Folder picker in the brand bar
- Background indexer: walks folder, reads text/md/pdf, chunks, embeds via `nomic-embed-text`
- Progress UI during indexing
- Query interface: ask a question → top-k chunks retrieved → injected into prompt → answer with citations
- Index management: list indexed folders, delete, re-index

### Why not tonight
- 3-5 hours of focused work
- Introduces many moving parts (embedding API, cosine similarity, citation rendering)
- Too risky to ship hours before a live workshop

---

## v0.3 — "Trusted distribution" (2-4 weeks out, blocked on external setup)

### Code signing

**Required purchases:**
- **Apple Developer ID** — $99/year, 24–48 hr approval
- **Windows EV Code Signing Certificate** — $100-$400/year from DigiCert, Sectigo, etc.

**Once purchased, code in electron-builder:**
- Mac: add `notarize: true` + `appleId`, `appleIdPassword` env vars
- Windows: add `sign` config with certificate subject

**Effect:**
- Mac: no more "cannot be opened because the developer cannot be verified" warning
- Windows: no SmartScreen warning on first install
- Required for auto-update to work safely

### Auto-update
**Depends on code signing.**

**Scope:**
- Add `electron-updater` to the app
- Configure GitHub Releases as the update source
- Background check for new version on app start
- Prompt user to install when available
- 3-4 hours of work once signing is set up

---

## v0.4 — "Team-ready" (distant)

- **Shared prompt libraries** — a team can publish their prompt presets
- **Encrypted team backups** — conversations sync between their own devices (not cloud, but LAN)
- **Custom skill packs** — marketplace of third-party skill bundles
- **Multi-user profiles** in the app

---

## What I decided NOT to build

- **A web-hosted version.** Defeats the whole point (privacy).
- **A mobile app.** The model is too big for phones. Revisit when laptops are out.
- **An account system.** No account is a feature.
- **Telemetry / analytics.** Even anonymous usage stats go against the privacy promise.
- **A "team plan" cloud sync service.** Teams that want this already have Slack + Google Drive.

---

## How to suggest what's next

Open an issue on the repo. Two rules:

1. Tell me what you tried to do that didn't work, not what feature you think you need.
2. If you'd hack it in yourself, send a PR.

Everything's MIT. The building is shared.

# Landing Page — Purely Personal

Static landing page for purelypersonal.ai (or whatever URL you end up using). Single HTML file, zero dependencies, opens anywhere.

## What's in this folder

- `index.html` — the whole landing page, ~450 lines, self-contained
- `README.md` — this file

## Preview locally

Just double-click `index.html` or run:

```bash
open landing/index.html
```

Works offline. Same styling system as the Purely Personal app (coral accent, serif headings, cream background).

## Deploy (3 options, ranked by effort)

### Option A — GitHub Pages (free, 5 min)

1. **Go to** your repo on GitHub → **Settings** → **Pages**
2. Under **Source**, pick:
   - Branch: `main`
   - Folder: `/landing`
   - Click **Save**
3. Wait ~1 min. Your site goes live at:
   `https://danielpaulai.github.io/Run-Worldclass-computer-locally/`
4. To use a custom domain:
   - Add a `CNAME` file inside `landing/` with your domain (one line, e.g. `purelypersonal.ai`)
   - Configure the domain's DNS with a CNAME pointing at `danielpaulai.github.io`
   - GitHub Pages auto-issues an SSL cert

### Option B — Cloudflare Pages / Vercel / Netlify (free, 10 min)

Sign up → connect this GitHub repo → set build directory to `landing/` → deploy. Auto-SSL, auto-CDN, custom domain support in their dashboard.

### Option C — Drop into Framer / Webflow / any static host

The HTML/CSS is hand-crafted and vanilla, no JS dependencies. Paste the `<body>` contents into any page builder. Won't look pixel-identical because of typography differences but will preserve the structure.

## What to change before launching

- **Download buttons** currently link to GitHub Releases. If you host the .dmg / .exe elsewhere (Dropbox, S3, etc.), update the URLs in the `#download` section.
- **Footer contact link** is missing an email. Add yours.
- **Meta tags** at the top (`og:title`, `og:description`) use the default copy. Consider tweaking for SEO.
- **Favicon** isn't set yet. To match the app icon:

   ```html
   <link rel="icon" type="image/png" href="/icon.png">
   ```

   and copy `desktop-app/build/icon.png` to `landing/icon.png`.

## What's NOT here yet

- A changelog / blog (add one when v0.2 ships)
- Customer testimonials (collect these from workshop attendees)
- Screenshots of the app in action (take these tomorrow after the workshop and add a gallery)
- Analytics (add Plausible or Fathom — avoid Google Analytics for a privacy product)

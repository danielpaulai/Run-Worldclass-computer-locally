# Code Templates — Workshop Image Builder

Production-ready HTML/CSS templates with {{VARIABLE}} placeholders. Copy the template, replace variables, deliver. Do NOT reconstruct from memory.

---

## Template #1: The 4-Column Worksheet

The most-used template. Covers Promise, Guarantee, Bonuses, Scarcity, Pricing, and any custom Best Practice / Examples / Current / Ideas grid.

```html
<div style="background:#f0eeea;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',sans-serif;color:#3d3d3d;padding:32px 40px;max-width:960px;margin:0 auto;min-height:640px;display:flex;flex-direction:column">

  <!-- Header -->
  <div style="margin-bottom:20px">
    <h1 style="font-family:Georgia,serif;font-size:26px;font-weight:700;margin:0 0 4px">{{FRAMEWORK_NAME}}</h1>
    <div style="display:flex;gap:40px;font-size:13px;color:#888;border-bottom:1px solid #d0cdc8;padding-bottom:10px">
      <span>Name: _______________</span>
      <span>Date: _______________</span>
    </div>
  </div>

  <!-- 4-Column Grid -->
  <div style="display:grid;grid-template-columns:1fr 1fr 1fr 1fr;flex:1;border:1px solid #d0cdc8">

    <!-- Headers -->
    <div style="background:#e2dfd9;padding:8px 12px;font-size:12px;font-weight:600;border:1px solid #d0cdc8">{{COL_A_HEADER}}</div>
    <div style="background:#e2dfd9;padding:8px 12px;font-size:12px;font-weight:600;border:1px solid #d0cdc8">{{COL_B_HEADER}}</div>
    <div style="background:#e2dfd9;padding:8px 12px;font-size:12px;font-weight:600;border:1px solid #d0cdc8">{{COL_C_HEADER}}</div>
    <div style="background:#e2dfd9;padding:8px 12px;font-size:12px;font-weight:600;border:1px solid #d0cdc8">{{COL_D_HEADER}}</div>

    <!-- Content Row -->
    <!-- Column A: Pre-filled reference bullets -->
    <div style="background:#fff;border:1px solid #d0cdc8;padding:12px 16px;font-size:12px;line-height:2">
      {{COL_A_BULLETS}}
    </div>

    <!-- Column B: Pre-filled examples -->
    <div style="background:#fff;border:1px solid #d0cdc8;padding:12px 16px;font-size:12px;line-height:2">
      {{COL_B_BULLETS}}
    </div>

    <!-- Column C: Blank with optional prompt + Insight sub-box -->
    <div style="background:#fff;border:1px solid #d0cdc8;padding:12px 16px;display:flex;flex-direction:column">
      <div style="font-size:11px;color:#888;font-style:italic">{{COL_C_PROMPT}}</div>
      <div style="flex:1"></div>
      <div style="border-top:1px solid #d0cdc8;padding-top:8px;margin-top:auto">
        <div style="font-size:11px;font-weight:600;color:#888">{{INSIGHT_LABEL}}</div>
      </div>
    </div>

    <!-- Column D: Completely blank -->
    <div style="background:#fff;border:1px solid #d0cdc8;padding:12px 16px"></div>
  </div>

  <!-- Footer -->
  <div style="display:flex;align-items:center;gap:12px;padding-top:12px;margin-top:16px;border-top:1px solid #d0cdc8">
    <span style="font-family:Georgia,serif;font-weight:700;font-size:13px">{{BRAND_NAME}}</span>
    <span style="font-size:11px;color:#888">{{BRAND_TAGLINE}} • {{MODULE_NUMBER}} • {{MODULE_TOPIC}}</span>
  </div>
</div>
```

### Bullet Format for Pre-fill Columns
Each bullet is a paragraph with a bullet character:
```html
• Specific result<br>
• Set timeframe<br>
• Small promises<br>
• Aspirational
```

---

## Template #2: The 3-Column Grid (Whiteboard)

For Fears/Mistakes/Tips, Wins/Lessons/Upgrade, Insights/Progress/Stuck, or any 3-category grid.

```html
<div style="background:#f0eeea;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',sans-serif;color:#3d3d3d;padding:32px 40px;max-width:960px;margin:0 auto;min-height:640px;display:flex;flex-direction:column">

  <h1 style="font-family:Georgia,serif;font-size:26px;font-weight:700;margin:0 0 20px">{{FRAMEWORK_NAME}}</h1>

  <div style="display:grid;grid-template-columns:1fr 1fr 1fr;flex:1;border:1px solid #d0cdc8">

    <!-- Column Headers -->
    <div style="background:#e2dfd9;padding:10px 16px;font-size:14px;font-weight:600;border:1px solid #d0cdc8;text-align:center">{{COL_1_HEADER}}</div>
    <div style="background:#e2dfd9;padding:10px 16px;font-size:14px;font-weight:600;border:1px solid #d0cdc8;text-align:center">{{COL_2_HEADER}}</div>
    <div style="background:#e2dfd9;padding:10px 16px;font-size:14px;font-weight:600;border:1px solid #d0cdc8;text-align:center">{{COL_3_HEADER}}</div>

    <!-- Column Bodies (bullet lines for writing) -->
    <div style="background:#fff;border:1px solid #d0cdc8;padding:8px 0">
      {{BULLET_LINES_8}}
    </div>
    <div style="background:#fff;border:1px solid #d0cdc8;padding:8px 0">
      {{BULLET_LINES_8}}
    </div>
    <div style="background:#fff;border:1px solid #d0cdc8;padding:8px 0">
      {{BULLET_LINES_8}}
    </div>
  </div>

  <!-- Footer -->
  <div style="display:flex;align-items:center;gap:12px;padding-top:12px;margin-top:16px;border-top:1px solid #d0cdc8">
    <span style="font-family:Georgia,serif;font-weight:700;font-size:13px">{{BRAND_NAME}}</span>
    <span style="font-size:11px;color:#888">{{BRAND_TAGLINE}} • {{MODULE_NUMBER}} • {{MODULE_TOPIC}}</span>
  </div>
</div>
```

### Bullet Lines Block (reusable)
Replace {{BULLET_LINES_8}} with:
```html
<div style="border-bottom:1px solid #d0cdc8;height:36px;padding-left:16px;position:relative;margin:0 8px">
  <span style="position:absolute;left:4px;top:8px;color:#d0cdc8;font-size:10px">•</span>
</div>
<!-- Repeat 8 times -->
```

---

## Template #3: Hero Slide (Dark Title Card)

The signature dark background with 3D tilted bold italic text.

```html
<div style="background:#1a1a1a;width:960px;height:680px;position:relative;display:flex;flex-direction:column;justify-content:center;align-items:center;overflow:hidden">

  <!-- Title with 3D tilt effect -->
  <div style="text-align:center;transform:perspective(600px) rotateX(-5deg)">
    <div style="font-family:Georgia,serif;font-weight:700;font-style:italic;font-size:{{TITLE_SIZE}};color:#fff;line-height:0.95;text-shadow:0 3px 6px rgba(0,0,0,0.4)">
      {{SLIDE_TITLE}}
    </div>
  </div>

  <!-- Subtitle (optional) -->
  <div style="font-family:-apple-system,sans-serif;font-size:18px;color:#888;margin-top:16px;text-align:center">
    {{SLIDE_SUBTITLE}}
  </div>

  <!-- Footer -->
  <div style="position:absolute;bottom:24px;left:40px;display:flex;align-items:center;gap:12px">
    <span style="font-family:Georgia,serif;font-weight:700;font-style:italic;font-size:14px;color:#fff">{{BRAND_NAME}}</span>
    <span style="font-size:11px;color:#888">{{BRAND_TAGLINE}} • {{MODULE_NUMBER}} • {{MODULE_TOPIC}}</span>
  </div>

  <!-- Page number (optional) -->
  <div style="position:absolute;bottom:24px;right:40px;width:32px;height:32px;border-radius:50%;background:#fff;display:flex;align-items:center;justify-content:center;font-size:13px;font-weight:600;color:#1a1a1a">
    {{PAGE_NUMBER}}
  </div>
</div>
```

### Title Size Guide
- 1 word: 96px
- 2-3 words: 80px
- 4-6 words: 64px
- 7+ words: 48px
- Multi-line: use `<br>` breaks, 72px

---

## Template #4: The Pyramid Slide

Dark background with all 6 levels of the Launchpad pyramid. Current module highlighted in white.

```html
<div style="background:#1a1a1a;width:960px;height:680px;position:relative;display:flex;align-items:center;justify-content:center">

  <svg viewBox="0 0 600 500" width="500" style="transform:perspective(600px) rotateX(-3deg)">
    <!-- Pyramid outline -->
    <polygon points="300,40 550,460 50,460" fill="none" stroke="#444" stroke-width="2"/>

    <!-- Level dividers -->
    <line x1="133" y1="320" x2="467" y2="320" stroke="#444" stroke-width="1"/>
    <line x1="175" y1="250" x2="425" y2="250" stroke="#444" stroke-width="1"/>
    <line x1="216" y1="180" x2="384" y2="180" stroke="#444" stroke-width="1"/>
    <line x1="91" y1="390" x2="509" y2="390" stroke="#444" stroke-width="1"/>

    <!-- Level labels (italic, perspective feel) -->
    <text x="300" y="440" text-anchor="middle" fill="{{COLOR_MARKET}}" font-family="Georgia,serif" font-weight="700" font-style="italic" font-size="36">Market</text>
    <text x="220" y="365" text-anchor="middle" fill="{{COLOR_PROGRAM}}" font-family="Georgia,serif" font-weight="700" font-style="italic" font-size="30">Program</text>
    <text x="400" y="365" text-anchor="middle" fill="{{COLOR_OFFER}}" font-family="Georgia,serif" font-weight="700" font-style="italic" font-size="30">Offer</text>
    <text x="300" y="295" text-anchor="middle" fill="{{COLOR_CONVERSION}}" font-family="Georgia,serif" font-weight="700" font-style="italic" font-size="28">Conversion</text>
    <text x="300" y="228" text-anchor="middle" fill="{{COLOR_TRAFFIC}}" font-family="Georgia,serif" font-weight="700" font-style="italic" font-size="26">Traffic</text>
    <text x="300" y="160" text-anchor="middle" fill="{{COLOR_PIPELINE}}" font-family="Georgia,serif" font-weight="700" font-style="italic" font-size="24">Pipeline</text>
  </svg>

  <!-- Footer -->
  <div style="position:absolute;bottom:24px;left:40px;display:flex;align-items:center;gap:12px">
    <span style="font-family:Georgia,serif;font-weight:700;font-style:italic;font-size:14px;color:#fff">{{BRAND_NAME}}</span>
    <span style="font-size:11px;color:#888">{{BRAND_TAGLINE}} • {{MODULE_NUMBER}} • {{MODULE_TOPIC}}</span>
  </div>

  <div style="position:absolute;bottom:24px;right:40px;width:32px;height:32px;border-radius:50%;background:#fff;display:flex;align-items:center;justify-content:center;font-size:13px;font-weight:600;color:#1a1a1a">{{PAGE_NUMBER}}</div>
</div>
```

### Highlight Rules
The CURRENT module gets `fill="#ffffff"`. All others get `fill="#4a4a4a"`.

Example for Offer module:
```
{{COLOR_MARKET}}     = #4a4a4a
{{COLOR_PROGRAM}}    = #4a4a4a
{{COLOR_OFFER}}      = #ffffff  ← current
{{COLOR_CONVERSION}} = #4a4a4a
{{COLOR_TRAFFIC}}    = #4a4a4a
{{COLOR_PIPELINE}}   = #4a4a4a
```

---

## Template #5: The Pipeline Board

Customizable multi-stage kanban board.

```html
<div style="background:#f0eeea;font-family:-apple-system,sans-serif;color:#3d3d3d;padding:32px 40px;max-width:960px;margin:0 auto;min-height:640px;display:flex;flex-direction:column">

  <!-- Header with name/date -->
  <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:16px">
    <h1 style="font-family:Georgia,serif;font-size:24px;font-weight:700;margin:0">{{FRAMEWORK_NAME}}</h1>
    <div style="display:flex;gap:24px;font-size:13px;color:#888">
      <span>Name: ___________</span>
      <span>Date: ___________</span>
    </div>
  </div>

  <!-- Pipeline Grid -->
  <div style="display:grid;grid-template-columns:repeat({{STAGE_COUNT}},1fr);flex:1;border:1px solid #d0cdc8">

    <!-- Stage Headers -->
    {{STAGE_HEADERS}}

    <!-- Card Slots (2 per column) + Write-in Lines -->
    {{STAGE_BODIES}}
  </div>

  <!-- Footer -->
  <div style="display:flex;align-items:center;gap:12px;padding-top:12px;margin-top:16px;border-top:1px solid #d0cdc8">
    <span style="font-family:Georgia,serif;font-weight:700;font-size:13px">{{BRAND_NAME}}</span>
    <span style="font-size:11px;color:#888">{{BRAND_TAGLINE}} • {{MODULE_NUMBER}} • {{MODULE_TOPIC}}</span>
  </div>
</div>
```

### Stage Header Block (repeat per stage)
```html
<div style="background:#e2dfd9;padding:8px 12px;font-size:12px;font-weight:600;border:1px solid #d0cdc8;text-align:center">{{STAGE_NAME}}</div>
```

### Stage Body Block (repeat per stage)
```html
<div style="background:#fff;border:1px solid #d0cdc8;padding:8px;display:flex;flex-direction:column;gap:6px">
  <!-- Card slot 1 -->
  <div style="border:1px solid #d0cdc8;min-height:56px;padding:6px"></div>
  <!-- Card slot 2 -->
  <div style="border:1px solid #d0cdc8;min-height:56px;padding:6px"></div>
  <!-- Write-in lines -->
  <div style="border-bottom:1px solid #d0cdc8;height:24px;margin-top:4px"></div>
  <div style="border-bottom:1px solid #d0cdc8;height:24px"></div>
  <div style="border-bottom:1px solid #d0cdc8;height:24px"></div>
</div>
```

Default stages: Find, Invite, Engage, Qualify, Close, Collect (6 stages)

---

## Template #6: The Control Room

3-column debrief with split right column.

```html
<div style="background:#f0eeea;font-family:-apple-system,sans-serif;color:#3d3d3d;padding:32px 40px;max-width:960px;margin:0 auto;min-height:640px;display:flex;flex-direction:column">

  <h1 style="font-family:Georgia,serif;font-size:24px;font-weight:700;margin:0 0 16px">{{FRAMEWORK_NAME}}</h1>

  <div style="display:grid;grid-template-columns:1fr 1fr 1fr;grid-template-rows:1fr;flex:1;border:1px solid #d0cdc8">

    <!-- Column 1: Insights (full height) -->
    <div style="border:1px solid #d0cdc8;display:flex;flex-direction:column">
      <div style="background:#e2dfd9;padding:8px 16px;font-size:13px;font-weight:600;text-align:center">Insights</div>
      <div style="background:#fff;flex:1;padding:12px"></div>
    </div>

    <!-- Column 2: Progress (full height) -->
    <div style="border:1px solid #d0cdc8;display:flex;flex-direction:column">
      <div style="background:#e2dfd9;padding:8px 16px;font-size:13px;font-weight:600;text-align:center">Progress</div>
      <div style="background:#fff;flex:1;padding:12px"></div>
    </div>

    <!-- Column 3: Stuck (top 55%) + Action (bottom 45%) -->
    <div style="border:1px solid #d0cdc8;display:flex;flex-direction:column">
      <div style="background:#e2dfd9;padding:8px 16px;font-size:13px;font-weight:600;text-align:center">Stuck</div>
      <div style="background:#fff;flex:1.2;padding:12px;border-bottom:1px solid #d0cdc8"></div>
      <div style="background:#fff;padding:8px 12px">
        <div style="font-size:13px;font-weight:600;color:#3d3d3d;margin-bottom:4px">Action</div>
      </div>
      <div style="background:#fff;flex:0.8;padding:12px"></div>
    </div>
  </div>

  <div style="display:flex;align-items:center;gap:12px;padding-top:12px;margin-top:16px;border-top:1px solid #d0cdc8">
    <span style="font-family:Georgia,serif;font-weight:700;font-size:13px">{{BRAND_NAME}}</span>
    <span style="font-size:11px;color:#888">{{BRAND_TAGLINE}} • {{MODULE_NUMBER}} • {{MODULE_TOPIC}}</span>
  </div>
</div>
```

---

## Template #7: Dot Grid Notes Page

The simplest page — just dots and a footer.

```html
<div style="background:#f0eeea;font-family:-apple-system,sans-serif;color:#3d3d3d;padding:32px 40px;max-width:960px;margin:0 auto;min-height:640px;display:flex;flex-direction:column">

  <div style="flex:1;display:flex;flex-wrap:wrap;align-content:flex-start;gap:0">
    {{DOT_GRID}}
  </div>

  <div style="display:flex;align-items:center;gap:12px;padding-top:12px;margin-top:auto;border-top:1px solid #d0cdc8">
    <span style="font-family:Georgia,serif;font-weight:700;font-size:13px">{{BRAND_NAME}}</span>
    <span style="font-size:11px;color:#888">{{BRAND_TAGLINE}} • {{MODULE_NUMBER}} • {{MODULE_TOPIC}}</span>
  </div>
</div>
```

### Dot Grid Generator
Generate the dot grid with this pattern (28px spacing, 2px dots):
```html
<!-- Generate via JS or repeat manually. ~30 columns × 20 rows = 600 dots -->
<svg width="100%" height="560" style="flex:1">
  <!-- Row 1 -->
  <circle cx="14" cy="14" r="1.5" fill="#d0cdc8"/>
  <circle cx="42" cy="14" r="1.5" fill="#d0cdc8"/>
  <!-- ... every 28px across, then every 28px down -->
</svg>
```

---

## Template #8: The "Next..." Action Page

Split layout with 3 stacked sections + dot grid.

```html
<div style="background:#f0eeea;font-family:-apple-system,sans-serif;color:#3d3d3d;padding:32px 40px;max-width:960px;margin:0 auto;min-height:640px;display:flex;flex-direction:column">

  <!-- Header -->
  <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:16px;border-bottom:2px solid #e90d41;padding-bottom:8px">
    <h1 style="font-family:Georgia,serif;font-size:26px;font-weight:700;margin:0">Next...</h1>
    <div style="display:flex;gap:24px;font-size:13px;color:#888">
      <span>Name: ___________</span>
      <span>Date: ___________</span>
    </div>
  </div>

  <!-- Content: 60/40 split -->
  <div style="display:grid;grid-template-columns:1.4fr 1fr;gap:0;flex:1">

    <!-- Left: 3 stacked sections -->
    <div style="display:flex;flex-direction:column;border:1px solid #d0cdc8">
      <div style="border-bottom:1px solid #d0cdc8;flex:1;padding:12px 16px">
        <div style="font-size:13px;font-weight:600;margin-bottom:8px">Takeaways</div>
      </div>
      <div style="border-bottom:1px solid #d0cdc8;flex:1;padding:12px 16px">
        <div style="font-size:13px;font-weight:600;margin-bottom:8px">Actions</div>
      </div>
      <div style="flex:1;padding:12px 16px">
        <div style="font-size:13px;font-weight:600;margin-bottom:8px">Communications</div>
      </div>
    </div>

    <!-- Right: Dot grid -->
    <div style="border:1px solid #d0cdc8;border-left:none;padding:12px">
      {{DOT_GRID_SMALL}}
    </div>
  </div>

  <div style="display:flex;align-items:center;gap:12px;padding-top:12px;margin-top:16px;border-top:1px solid #d0cdc8">
    <span style="font-family:Georgia,serif;font-weight:700;font-size:13px">{{BRAND_NAME}}</span>
    <span style="font-size:11px;color:#888">{{BRAND_TAGLINE}} • {{MODULE_NUMBER}} • {{MODULE_TOPIC}}</span>
  </div>
</div>
```

---

## Template Composition Notes

### Purely Personal Brand Override
Replace in ALL templates:
```
font-family: Georgia, serif  →  font-family: 'Rethink Sans', sans-serif
background: #f0eeea         →  background: #f8f7f5
{{BRAND_NAME}}               →  Purely Personal
{{BRAND_TAGLINE}}            →  purelypersonal.ai
```
Add Google Fonts import at top:
```html
<link href="https://fonts.googleapis.com/css2?family=Rethink+Sans:wght@400;500;600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
```

### Print CSS (add to any template for print-friendliness)
```html
<style>
@media print {
  body, div { -webkit-print-color-adjust: exact !important; print-color-adjust: exact !important; }
  @page { size: A4 landscape; margin: 0.5in; }
}
</style>
```

### Responsive (add for mobile/tablet)
```html
<style>
@media (max-width: 768px) {
  div[style*="grid-template-columns"] { grid-template-columns: 1fr !important; }
}
</style>
```

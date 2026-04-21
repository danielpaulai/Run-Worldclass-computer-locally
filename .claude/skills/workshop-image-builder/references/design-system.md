# Design System — Workshop Image Builder

Complete design tokens extracted from the official Taki Moore / Black Belt Launchpad materials.

---

## Color Palette

### Worksheet Colors (Light Theme)
| Token | Hex | Usage |
|-------|-----|-------|
| `page-bg` | #f0eeea | Warm off-white page background — the signature Taki beige |
| `box-fill` | #ffffff | White fill for input/writing boxes |
| `header-bg` | #e2dfd9 | Column/row headers, section dividers |
| `text-primary` | #3d3d3d | Near-black for headings and body (never pure #000) |
| `text-secondary` | #888888 | Labels, subtexts, footer, metadata |
| `border` | #d0cdc8 | All box borders, divider lines |
| `accent-yellow` | #f5c842 | Taki brand yellow — used sparingly for emphasis |
| `accent-red` | #e8553a | Coral red — ribbon badges, urgent callouts |

### Slide Colors (Dark Theme)
| Token | Hex | Usage |
|-------|-----|-------|
| `slide-bg` | #1a1a1a | Hero slide background (or pure #000000) |
| `slide-text` | #ffffff | Title text on dark slides |
| `slide-muted` | #888888 | Subtitles, footer on dark slides |
| `slide-highlight` | #ffffff | Current module text (others in #666666) |
| `slide-dim` | #4a4a4a | Non-active module text on pyramid |

### Purely Personal Brand Override
| Token | Hex | Usage |
|-------|-----|-------|
| `pp-red` | #e90d41 | Primary accent |
| `pp-silver` | #b8bec1 | Secondary |
| `pp-dark` | #0a0a0a | Background dark |
| `pp-near-dark` | #1d1f20 | Card backgrounds |

---

## Typography

### Font Stack
```css
/* Headings — serif for authority */
font-family: Georgia, 'Times New Roman', serif;

/* Body — clean sans for readability */
font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;

/* Purely Personal override */
font-family: 'Rethink Sans', sans-serif;  /* display/headings */
font-family: 'Inter', sans-serif;          /* body */
```

### Scale
| Element | Size | Weight | Style | Color |
|---------|------|--------|-------|-------|
| Page title (The [Name]™) | 28-32px | 700 | normal | #3d3d3d |
| Hero slide title | 72-96px | 700 | italic | #ffffff |
| Framework name | 22-26px | 700 | normal | #3d3d3d |
| Section label | 11-13px | 600 | uppercase, ls: 0.05em | #888 |
| Column header | 12-14px | 600 | normal | #3d3d3d |
| Body text | 13-15px | 400 | normal | #3d3d3d |
| Box label | 11-12px | 400 | normal | #888 |
| Pre-filled bullet | 11-13px | 400 | normal | #3d3d3d |
| Footer text | 11-12px | 400-600 | normal | #888 |
| Footer brand | 14px | 700 | normal | #3d3d3d |

### Rules
- Only 2 font weights: 400 (regular) and 600-700 (bold)
- Left-align everything (never center body text)
- Labels: uppercase with letter-spacing
- Hero slides: italic + bold + perspective tilt

---

## Layout

### Page Dimensions
```
Viewport: 960 × 680px (A4 landscape proportions)
Padding: 32px 40px (worksheets) or 0 (full-bleed slides)
Max-width: 960px, centered
```

### Grid Rules
```
Border: 1px solid #d0cdc8
Border-radius: 0px — ALWAYS (no rounded corners ever)
Cell padding: 8px 12px minimum
Minimum fill-in box height: 80px
Header cell height: 36-44px
```

### Spacing
```
Between sections: 16-20px
Between header and content: 8px
Between worksheet and footer: 24px
Dot grid spacing: 28px between dots
Dot size: 2px circles, color #d0cdc8
```

---

## Shape Rules (SVG Diagrams)

### Universal
```
stroke: #3d3d3d
stroke-width: 1.5 to 2
fill: none (or #ffffff for filled shapes)
NO gradient fills
NO drop shadows
NO decorative elements
NO color fills on shapes
```

### Shape Types
- **Rectangles**: No rounded corners (rx=0)
- **Circles**: Outlined only
- **Triangles/Polygons**: Outlined only
- **Lines/Arrows**: 1.5px stroke, simple arrowhead
- **Text in shapes**: 12-14px, fill #3d3d3d, centered

### Diagram Container
```
Background: #ffffff
Border: 1px solid #d0cdc8
Padding: 16px
Max height: 280px (keep compact)
```

---

## Component Library

### Box Types
```css
/* Fill-in box (for participant writing) */
.fill-box {
  background: #ffffff;
  border: 1px solid #d0cdc8;
  min-height: 80px;
  padding: 8px 12px;
}

/* Header cell */
.header-cell {
  background: #e2dfd9;
  border: 1px solid #d0cdc8;
  padding: 8px 12px;
  font-size: 12px;
  font-weight: 600;
}

/* Pre-filled reference cell */
.reference-cell {
  background: #ffffff;
  border: 1px solid #d0cdc8;
  padding: 12px 16px;
  font-size: 12px;
  line-height: 1.8;
}

/* Insight sub-box (inside a fill-in cell) */
.insight-box {
  border-top: 1px solid #d0cdc8;
  margin-top: auto;
  padding-top: 8px;
  font-size: 11px;
  font-weight: 600;
  color: #888;
}
```

### Bullet Lines (for writing space)
```css
.bullet-line {
  border-bottom: 1px solid #d0cdc8;
  height: 32px;
  padding-left: 16px;
  position: relative;
}
.bullet-line::before {
  content: '•';
  position: absolute;
  left: 4px;
  color: #d0cdc8;
}
```

### Card/Thumbnail (for workbench overview)
```css
.worksheet-thumb {
  width: 280px;
  height: 200px;
  border: 1px solid #d0cdc8;
  background: #f0eeea;
  padding: 8px;
  /* Contains a scaled-down representation of the worksheet */
  /* Internal lines suggest grid structure but text is illegibly small */
}
```

### Red Ribbon Badge
```css
.ribbon {
  position: absolute;
  top: 0;
  right: 0;
  background: #e8553a;
  color: #ffffff;
  font-size: 11px;
  font-weight: 600;
  padding: 8px 12px;
  writing-mode: vertical-rl;
  text-orientation: mixed;
  letter-spacing: 0.02em;
}
```

---

## Footer Formats

### Black Belt Mode
```
[Logo: BlackBelt bold italic] | The Black Belt Launchpad • [##] • [Topic]
```

### Purely Personal Mode
```
[Logo: Purely Personal] | purelypersonal.ai
```

### Custom Brand Mode
```
[Logo: Brand Name] | [Tagline or URL]
```

### Footer CSS
```css
.page-footer {
  display: flex;
  align-items: center;
  gap: 16px;
  padding-top: 12px;
  border-top: 1px solid #d0cdc8;
  margin-top: 24px;
}
.footer-brand {
  font-family: Georgia, serif;
  font-weight: 700;
  font-size: 14px;
  color: #3d3d3d;
}
.footer-meta {
  font-size: 11px;
  color: #888;
  letter-spacing: 0.03em;
}
```

---

## Print Considerations

```css
@media print {
  body { background: white; }
  .page-bg { background: #f0eeea !important; -webkit-print-color-adjust: exact; }
  .header-cell { background: #e2dfd9 !important; -webkit-print-color-adjust: exact; }
  .no-print { display: none; }
  @page { 
    size: A4 landscape; 
    margin: 0.5in; 
  }
}
```

---

## Anti-Patterns (What NOT to Do)

1. **No rounded corners** — border-radius: 0 always. This is the #1 visual tell.
2. **No color fills on shapes** — outlines only, stroke #3d3d3d
3. **No icons or emoji** — geometry and text only
4. **No gradients** — flat fills only (exception: gem card backgrounds on dark slides)
5. **No drop shadows** — clean flat aesthetic
6. **No more than 2 font weights** — 400 and 600/700
7. **No centered body text** — left-align everything
8. **No tiny fill-in boxes** — minimum 80px height, people need room to write
9. **No decorative elements** — whitespace is intentional
10. **No pure black (#000000)** — use #3d3d3d for text, #1a1a1a for dark backgrounds

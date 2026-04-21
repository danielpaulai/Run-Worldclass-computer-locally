# Slide Patterns — Workshop Image Builder

## 1. Hero Slide (Dark Title Card)

**Source**: Module title pages (Market, Program, Offer, Conversion, Traffic, Pipeline)
**Use**: Session opener, module transition

### Design Spec
```
Background: #1a1a1a (near-black) or #000000 (pure black)
Layout: Full viewport, text centered vertically and horizontally

Title: Bold italic display font
  - Font: Georgia or Impact-like condensed
  - Size: 72-96px
  - Weight: 700
  - Style: italic
  - Color: #ffffff
  - Text-shadow: subtle 3D depth effect (2px 2px 0 rgba(0,0,0,0.3))
  - Perspective/rotation: slight 3D tilt (-5 to -10deg rotateX) for the Taki "tilted text" look

Subtitle (optional): 
  - Size: 18-24px
  - Weight: 400
  - Color: #888888

Footer: 
  - Left-aligned
  - Logo + "The Black Belt Launchpad • [Module Number] • [Topic]"
  - Font-size: 12px
  - Color: #888888

Page number (optional):
  - Bottom-right circle
  - White circle with number inside
  - Size: 32px diameter
```

### The Tilted 3D Text Effect
The Taki hero slides use a characteristic "tilted" text style where the words look like they're receding into a 3D space. Achieve this with:
```css
.hero-title {
  font-family: Georgia, serif;
  font-weight: 700;
  font-style: italic;
  font-size: 80px;
  color: #fff;
  transform: perspective(500px) rotateX(-5deg);
  text-shadow: 0 2px 4px rgba(0,0,0,0.5);
  line-height: 0.95;
}
```

### The Launchpad Pyramid
Several hero slides show the full program pyramid with all 6 levels. The current module is highlighted in WHITE while others are GRAY:

```
           Pipeline (gray)
          Traffic (gray)
        Conversion (gray)
      Program   Offer (WHITE = current)
            Market (gray)
```

Use CSS transform for the 3D perspective tilt on the entire pyramid.

---

## 2. Section Divider (Diamond Gem)

**Source**: Offer module playlist page with diamond gem images
**Use**: Topic separator within a session

### Design Spec
```
Background: #2a2a2a (dark gray) or transparent
Image area: Diamond/gem photograph or SVG illustration
  - Centered
  - Width: ~500px
  - The gem is a photo-realistic diamond with light reflections on dark background
  
Text overlay on gem:
  - Bold italic, white
  - Size: 36-48px
  - Positioned center of the gem image
  - Examples: "Risk & Reward", "Promise", "Guarantee", "Bonuses", "Payment Plan", "Scarcity & Urgency"
  
Label below:
  - Clean sans-serif
  - Size: 16px, weight 600
  - Color: #3d3d3d or #ffffff depending on background
  - Same text as overlay (e.g. "Risk And Reward")
```

### Without Gem Image (SVG Fallback)
When no gem photo is available, use a geometric diamond SVG:
```svg
<polygon points="200,20 380,160 300,340 100,340 20,160" 
  fill="none" stroke="#4a4a4a" stroke-width="2"/>
```
With subtle gradient fill suggesting a gem facet pattern.

---

## 3. Today's Playlist Page

**Source**: "Today's Launchpad Playlist • Offer" page
**Use**: Session overview showing all training videos/topics

### Design Spec
```
Background: #ffffff or #f0eeea

Header: "Today's Launchpad Playlist • [Topic]"
  - Bold serif, 22px

Red ribbon badge (top-right corner):
  - Background: #e8553a (coral red)
  - Text: "10 min. trainings" (rotated -90deg or along right edge)
  - White text, 11px

Grid: 3×2 or 2×3 of topic cards
  - Each card: ~280×180px
  - Dark background image (gem or gradient)
  - Bold italic white text overlay (topic name)
  - Below each: "▶ Watch the video" link in blue (#4a90d9)

Footer: Brand + module reference
```

---

## 4. Coming Up Next Page

**Source**: "Coming Up Next Week • Conversion" pages
**Use**: Session closer, teaser for next session

### Design Spec
```
Same layout as Today's Playlist but:
- Fewer cards (1-3 instead of 6)
- Header: "Coming Up Next Week • [Topic] • [Sub-topic]"
- Same red ribbon badge
- Same video card format
```

---

## 5. Quote/Inspiration Slide

**Source**: "You Gotta Shake Your Money Maker" — Elmore James page
**Use**: Energy moment, transition between sections

### Design Spec
```
Background: Full-bleed tinted photo (red overlay at 70% opacity)
  - Or solid #c41a1a (red) background

Quote text:
  - Bold italic, white
  - Size: 60-80px
  - Centered
  - Line-height: 0.9

Attribution:
  - Italic, lighter weight
  - Size: 24-32px
  - Color: rgba(255,255,255,0.7)
  - Preceded by em-dash: "—Elmore James"

Footer: Brand + module reference, lighter opacity
```

---

## 6. Homework/Next Steps Slide

**Source**: "Next..." action page with bullet instructions
**Use**: Clear action items for participants

### Design Spec
```
Background: #f0eeea or #ffffff

Header: "Next..."
  - Bold serif, 28px, with Name/Date fields to the right

Content area (left ~55%):
  - Bulleted list of 3-4 actions
  - Each bullet: bold for the action phrase, italic for sub-instruction
  - Font: 14-16px sans-serif
  - Line-height: 1.8 for readability

Notes area (right ~45%):
  - Dot grid for free-form notes
  - Same dot spec as notes page (2px, #d0cdc8, 28px spacing)
```

---

## Color Overlay Techniques

### Red Tint (for quote slides)
```css
.overlay-red {
  position: relative;
}
.overlay-red::after {
  content: '';
  position: absolute;
  inset: 0;
  background: rgba(180, 20, 20, 0.7);
  mix-blend-mode: multiply;
}
```

### Dark Gradient (for gem cards)
```css
.gem-card {
  background: linear-gradient(135deg, #1a1a1a 0%, #2a3a4a 50%, #1a1a1a 100%);
}
```

---

## Page Order in a Complete Workbook

For a full session workbook, generate pages in this exact order:

1. Cover page (program title, logo, module list)
2. The Launchpad Snapshot™ (tracking matrix)
3. My Black Belt Pipeline™ (pipeline board)
4. The Launchpad Control Room (3-column debrief)
5. Dot Grid Notes (blank)
6. Pyramid slide (showing current module highlighted)
7. Today's Playlist (all topics for this session)
8. The Launchpad Workbench (thumbnail overview of worksheets)
9. Worksheets (one per topic, with matching framework diagrams)
10. Dot Grid Notes (between worksheets for overflow)
11. Quote/Inspiration slide
12. "I Made a Thing" template page
13. Dot Grid Notes (final)
14. Weekly Cadence
15. Launchpad Timeline (full program map)
16. Coming Up Next Week
17. Homework/Next Steps
18. Pyramid slide (full program, closing page)

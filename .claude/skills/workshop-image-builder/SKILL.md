---
name: workshop-image-builder
description: Generate all visual assets for workshops and training sessions in the Taki Moore / Black Belt Launchpad style. Triggers on "workshop visual", "session slide", "workshop worksheet", "framework diagram", "build a visual", "workshop image", "hero slide", "workbench page", "pipeline board", "control room", "dot grid", "notes page", "weekly cadence", "timeline visual", "teaching diagram", "whiteboard layout", "seesaw diagram", "diamond diagram", "triangle diagram", or any request to create visual materials for a teaching session, workshop, bootcamp, or course. Also triggers when someone says "make this look like Taki worksheets", "Black Belt style", or wants a complete visual set. Always use for ANY workshop visual creation even casual requests like "make me a worksheet."
---

# Workshop Image Builder v2

Generate pixel-accurate workshop visuals matching the Taki Moore / Black Belt Launchpad design system. This skill provides working code templates, SVG primitives, and content libraries — not just descriptions.

## How This Skill Works

Unlike V1 which described layouts, V2 provides **actual code templates with {{VARIABLE}} placeholders**. The generation process is:

1. Pick the template from [references/code-templates.md]
2. Fill the {{VARIABLES}} from user input or [references/content-library.md]
3. Inject SVG diagrams from [references/svg-primitives.md]
4. Add interactivity from [references/interactive-patterns.md] if needed
5. Validate against the quality checklist

**ALWAYS read the relevant reference file BEFORE generating.** The templates are load-bearing — deviation from them produces off-brand output.

## Reference Files

| File | What It Contains | When to Read |
|------|-----------------|--------------|
| [references/code-templates.md] | Complete HTML/CSS code for every visual type with {{VARIABLE}} placeholders | ALWAYS — this is your primary build tool |
| [references/svg-primitives.md] | Exact SVG code for diamond, seesaw, triangle, pipeline, and all signature shapes | When generating framework diagrams |
| [references/content-library.md] | All pre-fill content from Taki's frameworks (Promise, Guarantee, Bonuses, etc.) | When building Taki-specific worksheets |
| [references/interactive-patterns.md] | JavaScript for fillable fields, traffic lights, auto-save, clipboard copy, PDF export | When building interactive/fillable versions |
| [references/design-system.md] | Complete color tokens, typography scale, spacing, and anti-patterns | When customizing or troubleshooting |
| [references/visual-catalog.md] | Structural specs for all 12 visual types | When choosing which visual to generate |
| [references/slide-patterns.md] | Hero slides, section dividers, playlist pages, quote slides | When generating presentation-style visuals |

## The 12 Visual Types

**Worksheets (fill-in):**
1. 4-Column Worksheet — Best Practice / Examples / Current / Ideas
2. 3-Column Grid — Fears / Mistakes / Tips (or any 3 categories)
3. Snapshot Matrix — Multi-row tracking grid
4. "Next..." Action Page — Takeaways / Actions / Communications
5. "I Made a Thing" Template — DM outreach with writing space

**Diagrams (teaching):**
6. Framework Diagram — Diamond, seesaw, triangle, or custom shape
7. Pipeline Board — Multi-stage kanban (Find → Invite → ... → Collect)
8. Control Room — Insights / Progress / Stuck + Action
9. Weekly Cadence — Day-of-week calendar with session blocks
10. Launchpad Timeline — Multi-week program map with connected nodes

**Slides (presentation):**
11. Hero Slide — Dark title card with 3D tilted text
12. Workbench Overview — Miniature thumbnails of all session worksheets

## Variable System

Every template uses {{DOUBLE_BRACE}} variables. Standard variables:

### Global Variables (apply to all templates)
```
{{FRAMEWORK_NAME}}     — "The Offer Diamond™" / "The Program Promise™"
{{MODULE_NUMBER}}      — "03" / "01"
{{MODULE_TOPIC}}       — "Offer" / "Market"
{{BRAND_NAME}}         — "BlackBelt" / "Purely Personal"
{{BRAND_TAGLINE}}      — "The Black Belt Launchpad" / "purelypersonal.ai"
{{BRAND_ACCENT}}       — "#f5c842" (yellow) / "#e90d41" (red)
```

### Worksheet Variables
```
{{COL_A_HEADER}}       — "Goal" / "Best Practice"
{{COL_B_HEADER}}       — "Examples"
{{COL_C_HEADER}}       — "Current"
{{COL_D_HEADER}}       — "Ideas"
{{COL_A_BULLETS}}      — Pre-filled bullet content (from content library)
{{COL_B_BULLETS}}      — Pre-filled example content
{{COL_C_PROMPT}}       — Prompt text in current box ("It's designed to...")
{{INSIGHT_LABEL}}      — "Insight" (sub-box label in current column)
```

### Slide Variables
```
{{SLIDE_TITLE}}        — Hero text (bold italic)
{{SLIDE_SUBTITLE}}     — Optional subtitle
{{CURRENT_MODULE}}     — Which pyramid level is highlighted
{{PAGE_NUMBER}}        — Bottom-right circle number
```

## Workflow: Step by Step

### Step 1: Identify Visual Type
Match the request to one of the 12 types. If ambiguous, default to 4-Column Worksheet.

### Step 2: Determine Brand Mode
- **Taki/BlackBelt** (default): Georgia serif, #f5c842 accent, BlackBelt footer
- **Purely Personal**: Rethink Sans + Inter, #e90d41 accent, PP footer
- **Custom**: Ask for brand name, primary color, accent color

### Step 3: Load the Template
Read [references/code-templates.md] and find the matching template. Copy it completely — do not reconstruct from memory.

### Step 4: Fill Variables
Replace all {{VARIABLES}} with:
- User-provided content (framework name, column headers, topic)
- Content library data (pre-fill bullets from [references/content-library.md])
- SVG code (from [references/svg-primitives.md]) if the template includes a diagram slot

### Step 5: Add Interactivity (if requested)
If the user wants a fillable/interactive version, inject patterns from [references/interactive-patterns.md]:
- Editable text fields in fill-in boxes
- Traffic light scoring buttons
- Auto-save to localStorage
- Copy-to-clipboard for Claude prompts
- Print-friendly CSS

### Step 6: Quality Validation
Before delivering, verify EVERY item:

**Layout checks:**
- [ ] Page background is #f0eeea (NOT white, NOT gray)
- [ ] All borders are 1px solid #d0cdc8 (NOT black, NOT #ccc)
- [ ] Border-radius is 0px on EVERY element (NO rounded corners anywhere)
- [ ] Fill-in boxes are minimum 80px tall
- [ ] Header cells use #e2dfd9 background
- [ ] Footer is present with correct brand + module reference

**Typography checks:**
- [ ] Headings use Georgia serif, weight 700
- [ ] Body uses system sans-serif, weight 400
- [ ] Labels are 11-13px, uppercase, letter-spacing 0.05em
- [ ] Text color is #3d3d3d (NOT pure black #000)
- [ ] Secondary text is #888888

**Diagram checks (if applicable):**
- [ ] All shapes are stroke-only (fill: none or fill: #fff)
- [ ] Stroke color is #3d3d3d
- [ ] Stroke width is 1.5-2px
- [ ] No gradients, shadows, or decorative elements
- [ ] Diagram container has white background with #d0cdc8 border

**Content checks:**
- [ ] Pre-fill bullets match the exact Taki content from the content library
- [ ] "Current" and "Ideas" columns are EMPTY (blank white boxes)
- [ ] Framework name includes the ™ symbol
- [ ] "It's designed to..." prompt appears in Promise worksheet Current box

## Quick Triggers

| User Says | Generate |
|-----------|----------|
| "4-col worksheet for [topic]" | Template #1 with custom headers |
| "promise worksheet" | Template #1 with Promise pre-fills from content library |
| "guarantee worksheet" | Template #1 with Guarantee pre-fills |
| "bonuses worksheet" | Template #1 with Bonuses pre-fills |
| "scarcity worksheet" | Template #1 with Scarcity pre-fills |
| "pricing worksheet" | Template #1 with Pricing pre-fills |
| "hero slide: [title]" | Template #11 |
| "diamond diagram" | SVG diamond from primitives |
| "seesaw diagram" | SVG seesaw from primitives |
| "pyramid for [modules]" | SVG pyramid from primitives |
| "pipeline: [stages]" | Template #7 with custom stages |
| "whiteboard: [col1] / [col2] / [col3]" | Template #2 |
| "full set for [session]" | All templates in workbook order |
| "interactive worksheet for [topic]" | Template #1 + interactive patterns |
| "fillable [anything]" | Add interactive patterns to any template |

## Output Modes

### Static HTML (default)
Clean HTML artifact. Renders in browser, prints well, screenshot-ready. This is the standard output for all workshop visuals.

### Interactive HTML
Static template + JavaScript interactivity. Editable fields, buttons, auto-save. Use when the visual will be filled in digitally by participants.

### Full Workbook
Multiple pages generated in sequence. Follow the exact page order from [references/slide-patterns.md] → "Page Order in a Complete Workbook" section.

## Chaining with Other Skills

This skill is designed to chain with:
- **taki-workshop-builder** → builds the framework → this skill generates the matching visuals
- **taki-offer-diamond** → builds the offer → this skill generates the diamond diagram + worksheets
- **carousel-cheatsheet-builder** → this skill generates the worksheet → carousel skill turns it into LinkedIn content
- **trainer-guide-builder** → the guide references these visuals as session materials

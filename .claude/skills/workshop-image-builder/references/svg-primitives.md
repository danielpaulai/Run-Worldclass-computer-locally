# SVG Primitives — Workshop Image Builder

Exact SVG code for every signature shape. Copy directly into templates. Do NOT recreate from memory.

---

## The Offer Diamond™

Pentagon/diamond shape with 5 facet labels arranged around it.

```svg
<svg viewBox="0 0 680 420" width="100%" style="max-width:680px">
  <!-- Diamond shape -->
  <polygon points="340,40 560,160 490,360 190,360 120,160"
    fill="none" stroke="#3d3d3d" stroke-width="2" stroke-linejoin="round"/>

  <!-- Facet labels with connecting lines -->
  <!-- Top-left: Pay Plan -->
  <line x1="230" y1="100" x2="160" y2="70" stroke="#3d3d3d" stroke-width="0.5"/>
  <text x="150" y="66" text-anchor="end" font-family="-apple-system,sans-serif" font-size="14" font-weight="600" fill="#3d3d3d">Pay Plan</text>

  <!-- Top-right: Bonuses -->
  <line x1="450" y1="100" x2="520" y2="70" stroke="#3d3d3d" stroke-width="0.5"/>
  <text x="530" y="66" text-anchor="start" font-family="-apple-system,sans-serif" font-size="14" font-weight="600" fill="#3d3d3d">Bonuses</text>

  <!-- Left: Guarantee -->
  <line x1="155" y1="260" x2="80" y2="240" stroke="#3d3d3d" stroke-width="0.5"/>
  <text x="70" y="236" text-anchor="end" font-family="-apple-system,sans-serif" font-size="14" font-weight="600" fill="#3d3d3d">Guarantee</text>

  <!-- Right: Promise -->
  <line x1="525" y1="260" x2="600" y2="240" stroke="#3d3d3d" stroke-width="0.5"/>
  <text x="610" y="236" text-anchor="start" font-family="-apple-system,sans-serif" font-size="14" font-weight="600" fill="#3d3d3d">Promise</text>

  <!-- Bottom: Urgency & Scarcity -->
  <line x1="340" y1="360" x2="340" y2="400" stroke="#3d3d3d" stroke-width="0.5"/>
  <text x="340" y="416" text-anchor="middle" font-family="-apple-system,sans-serif" font-size="14" font-weight="600" fill="#3d3d3d">Urgency & Scarcity</text>
</svg>
```

### Diamond with Traffic Light Dots
Add colored dots next to each label to show scoring:
```svg
<!-- Green dot next to Promise -->
<circle cx="602" cy="248" r="5" fill="#22c55e"/>
<!-- Yellow dot next to Guarantee -->
<circle cx="62" cy="248" r="5" fill="#eab308"/>
<!-- Red dot next to Pay Plan -->
<circle cx="142" cy="78" r="5" fill="#ef4444"/>
```

### Diamond with Content (filled in)
Add text blocks near each label with the user's actual content:
```svg
<!-- Promise content lines (right side) -->
<text x="610" y="256" font-family="-apple-system,sans-serif" font-size="11" fill="#888">
  <tspan x="610" dy="0">10 new clients in 30 days</tspan>
  <tspan x="610" dy="16">from warm leads only</tspan>
  <tspan x="610" dy="16">no ads, no funnels</tspan>
</text>
```

---

## The Risk:Reward Seesaw™

Horizontal balance beam on a triangle fulcrum.

```svg
<svg viewBox="0 0 680 320" width="100%" style="max-width:680px">
  <!-- Fulcrum triangle -->
  <polygon points="340,280 310,320 370,320" fill="none" stroke="#3d3d3d" stroke-width="2"/>

  <!-- Beam -->
  <line x1="80" y1="200" x2="600" y2="200" stroke="#3d3d3d" stroke-width="2.5"/>

  <!-- Left side: REWARD -->
  <text x="180" y="188" text-anchor="middle" font-family="Georgia,serif" font-weight="700" font-size="16" fill="#3d3d3d">REWARD</text>
  <!-- Reward items -->
  <text x="120" y="230" font-family="-apple-system,sans-serif" font-size="12" fill="#888">
    <tspan x="120" dy="0">• Promise</tspan>
    <tspan x="120" dy="18">• Bonuses</tspan>
  </text>

  <!-- Right side: RISK -->
  <text x="500" y="188" text-anchor="middle" font-family="Georgia,serif" font-weight="700" font-size="16" fill="#3d3d3d">RISK</text>
  <!-- Risk items -->
  <text x="450" y="230" font-family="-apple-system,sans-serif" font-size="12" fill="#888">
    <tspan x="450" dy="0">• Guarantee</tspan>
    <tspan x="450" dy="18">• Payment Plan</tspan>
  </text>

  <!-- Center bottom: Urgency/Scarcity -->
  <text x="340" y="310" text-anchor="middle" font-family="-apple-system,sans-serif" font-size="12" font-weight="600" fill="#3d3d3d">Urgency & Scarcity</text>

  <!-- Header -->
  <text x="340" y="30" text-anchor="middle" font-family="Georgia,serif" font-weight="700" font-size="20" fill="#3d3d3d">The Risk:Reward Ratio™</text>
</svg>
```

### Tilted Seesaw (weighted toward reward)
To show the seesaw tilted (reward heavier), rotate the beam:
```svg
<g transform="rotate(-8, 340, 200)">
  <line x1="80" y1="200" x2="600" y2="200" stroke="#3d3d3d" stroke-width="2.5"/>
</g>
```

---

## The Launchpad Pyramid™

6-level pyramid for the full Black Belt Launchpad program.

### Light Version (for worksheets)
```svg
<svg viewBox="0 0 500 400" width="100%" style="max-width:500px">
  <!-- Outer triangle -->
  <polygon points="250,20 470,380 30,380" fill="none" stroke="#3d3d3d" stroke-width="2"/>

  <!-- Level dividers (from top to bottom) -->
  <line x1="154" y1="200" x2="346" y2="200" stroke="#3d3d3d" stroke-width="1"/>
  <line x1="125" y1="260" x2="375" y2="260" stroke="#3d3d3d" stroke-width="1"/>
  <line x1="95" y1="320" x2="405" y2="320" stroke="#3d3d3d" stroke-width="1"/>
  <line x1="183" y1="140" x2="317" y2="140" stroke="#3d3d3d" stroke-width="1"/>

  <!-- Labels -->
  <text x="250" y="360" text-anchor="middle" font-family="Georgia,serif" font-weight="700" font-style="italic" font-size="22" fill="#3d3d3d">Market</text>
  <text x="180" y="300" text-anchor="middle" font-family="Georgia,serif" font-weight="700" font-style="italic" font-size="18" fill="#3d3d3d">Program</text>
  <text x="330" y="300" text-anchor="middle" font-family="Georgia,serif" font-weight="700" font-size="18" fill="#3d3d3d">Offer</text>
  <text x="250" y="240" text-anchor="middle" font-family="Georgia,serif" font-weight="700" font-style="italic" font-size="16" fill="#3d3d3d">Conversion</text>
  <text x="250" y="180" text-anchor="middle" font-family="Georgia,serif" font-weight="700" font-style="italic" font-size="15" fill="#3d3d3d">Traffic</text>
  <text x="250" y="120" text-anchor="middle" font-family="Georgia,serif" font-weight="700" font-style="italic" font-size="14" fill="#3d3d3d">Pipeline</text>
</svg>
```

---

## The Pipeline Flow

Horizontal connected stages for Find → Invite → Engage → Qualify → Close → Collect.

```svg
<svg viewBox="0 0 680 60" width="100%" style="max-width:680px">
  <!-- Stage boxes -->
  <g>
    <rect x="10" y="10" width="90" height="40" fill="none" stroke="#3d3d3d" stroke-width="1.5"/>
    <text x="55" y="35" text-anchor="middle" font-family="-apple-system,sans-serif" font-size="11" font-weight="600" fill="#3d3d3d">Find</text>
  </g>
  <!-- Arrow -->
  <line x1="100" y1="30" x2="120" y2="30" stroke="#3d3d3d" stroke-width="1" marker-end="url(#arrowhead)"/>

  <g>
    <rect x="120" y="10" width="90" height="40" fill="none" stroke="#3d3d3d" stroke-width="1.5"/>
    <text x="165" y="35" text-anchor="middle" font-family="-apple-system,sans-serif" font-size="11" font-weight="600" fill="#3d3d3d">Invite</text>
  </g>
  <line x1="210" y1="30" x2="230" y2="30" stroke="#3d3d3d" stroke-width="1" marker-end="url(#arrowhead)"/>

  <g>
    <rect x="230" y="10" width="90" height="40" fill="none" stroke="#3d3d3d" stroke-width="1.5"/>
    <text x="275" y="35" text-anchor="middle" font-family="-apple-system,sans-serif" font-size="11" font-weight="600" fill="#3d3d3d">Engage</text>
  </g>
  <line x1="320" y1="30" x2="340" y2="30" stroke="#3d3d3d" stroke-width="1" marker-end="url(#arrowhead)"/>

  <g>
    <rect x="340" y="10" width="90" height="40" fill="none" stroke="#3d3d3d" stroke-width="1.5"/>
    <text x="385" y="35" text-anchor="middle" font-family="-apple-system,sans-serif" font-size="11" font-weight="600" fill="#3d3d3d">Qualify</text>
  </g>
  <line x1="430" y1="30" x2="450" y2="30" stroke="#3d3d3d" stroke-width="1" marker-end="url(#arrowhead)"/>

  <g>
    <rect x="450" y="10" width="90" height="40" fill="none" stroke="#3d3d3d" stroke-width="1.5"/>
    <text x="495" y="35" text-anchor="middle" font-family="-apple-system,sans-serif" font-size="11" font-weight="600" fill="#3d3d3d">Close</text>
  </g>
  <line x1="540" y1="30" x2="560" y2="30" stroke="#3d3d3d" stroke-width="1" marker-end="url(#arrowhead)"/>

  <g>
    <rect x="560" y="10" width="90" height="40" fill="none" stroke="#3d3d3d" stroke-width="1.5"/>
    <text x="605" y="35" text-anchor="middle" font-family="-apple-system,sans-serif" font-size="11" font-weight="600" fill="#3d3d3d">Collect</text>
  </g>

  <!-- Arrowhead marker -->
  <defs>
    <marker id="arrowhead" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="6" markerHeight="6" orient="auto">
      <path d="M0,0 L10,5 L0,10" fill="none" stroke="#3d3d3d" stroke-width="1.5"/>
    </marker>
  </defs>
</svg>
```

---

## The Timeline with Connected Nodes

Horizontal timeline with diamond connectors and milestone boxes above/below.

```svg
<svg viewBox="0 0 680 300" width="100%" style="max-width:680px">
  <!-- Central horizontal line -->
  <line x1="40" y1="150" x2="640" y2="150" stroke="#3d3d3d" stroke-width="1.5"/>

  <!-- Start circle -->
  <circle cx="60" cy="150" r="16" fill="none" stroke="#3d3d3d" stroke-width="1.5"/>

  <!-- Week connectors (diamonds at junction points) -->
  <polygon points="180,140 190,150 180,160 170,150" fill="#3d3d3d"/>
  <polygon points="300,140 310,150 300,160 290,150" fill="#3d3d3d"/>
  <polygon points="420,140 430,150 420,160 410,150" fill="#3d3d3d"/>
  <polygon points="540,140 550,150 540,160 530,150" fill="#3d3d3d"/>

  <!-- End arrow -->
  <polygon points="640,145 650,150 640,155" fill="#3d3d3d"/>

  <!-- Milestone boxes (above the line) -->
  <rect x="140" y="60" width="80" height="60" fill="#fff" stroke="#d0cdc8" stroke-width="1"/>
  <rect x="260" y="60" width="80" height="60" fill="#fff" stroke="#d0cdc8" stroke-width="1"/>
  <rect x="380" y="60" width="80" height="60" fill="#fff" stroke="#d0cdc8" stroke-width="1"/>
  <rect x="500" y="60" width="80" height="60" fill="#fff" stroke="#d0cdc8" stroke-width="1"/>

  <!-- Milestone boxes (below the line) -->
  <rect x="140" y="180" width="80" height="60" fill="#fff" stroke="#d0cdc8" stroke-width="1"/>
  <rect x="260" y="180" width="80" height="60" fill="#fff" stroke="#d0cdc8" stroke-width="1"/>
  <rect x="380" y="180" width="80" height="60" fill="#fff" stroke="#d0cdc8" stroke-width="1"/>
  <rect x="500" y="180" width="80" height="60" fill="#fff" stroke="#d0cdc8" stroke-width="1"/>

  <!-- Vertical connectors to boxes -->
  <line x1="180" y1="120" x2="180" y2="140" stroke="#d0cdc8" stroke-width="1"/>
  <line x1="180" y1="160" x2="180" y2="180" stroke="#d0cdc8" stroke-width="1"/>
  <line x1="300" y1="120" x2="300" y2="140" stroke="#d0cdc8" stroke-width="1"/>
  <line x1="420" y1="120" x2="420" y2="140" stroke="#d0cdc8" stroke-width="1"/>
  <line x1="540" y1="120" x2="540" y2="140" stroke="#d0cdc8" stroke-width="1"/>

  <!-- Week labels (top) -->
  <text x="180" y="40" text-anchor="middle" font-family="-apple-system,sans-serif" font-size="10" fill="#888">Week 1</text>
  <text x="180" y="52" text-anchor="middle" font-family="-apple-system,sans-serif" font-size="12" font-weight="600" fill="#3d3d3d">Market</text>
  <text x="300" y="40" text-anchor="middle" font-family="-apple-system,sans-serif" font-size="10" fill="#888">Week 2</text>
  <text x="300" y="52" text-anchor="middle" font-family="-apple-system,sans-serif" font-size="12" font-weight="600" fill="#3d3d3d">Program</text>
  <text x="420" y="40" text-anchor="middle" font-family="-apple-system,sans-serif" font-size="10" fill="#888">Week 3</text>
  <text x="420" y="52" text-anchor="middle" font-family="-apple-system,sans-serif" font-size="12" font-weight="600" fill="#3d3d3d">Offer</text>
  <text x="540" y="40" text-anchor="middle" font-family="-apple-system,sans-serif" font-size="10" fill="#888">Week 4</text>
  <text x="540" y="52" text-anchor="middle" font-family="-apple-system,sans-serif" font-size="12" font-weight="600" fill="#3d3d3d">Conversion</text>
</svg>
```

---

## Shape Customization Rules

1. **All shapes use stroke only** — fill: none or fill: #fff
2. **Stroke color is always #3d3d3d** — never pure black
3. **Stroke width: 1.5-2px** for primary shapes, 0.5-1px for connectors and leader lines
4. **No rounded corners on rectangles** — rx="0" always
5. **Text inside shapes** — font-size 11-14px, centered, fill #3d3d3d
6. **Connecting lines** — 0.5px, #d0cdc8 for subtle, #3d3d3d for emphasis
7. **Diamond connectors** — small filled diamonds at junction points
8. **Arrowheads** — open chevron style (not filled triangles)

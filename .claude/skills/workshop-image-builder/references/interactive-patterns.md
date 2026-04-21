# Interactive Patterns — Workshop Image Builder

JavaScript patterns to upgrade any static template into a fillable, saveable, interactive version. Add these on top of any base template from code-templates.md.

---

## Pattern 1: Editable Text Fields

Convert any blank fill-in box into an editable text area. The contenteditable approach is cleaner than input fields for worksheet aesthetics.

### CSS
```css
.editable {
  min-height: 80px;
  padding: 10px 14px;
  font-family: -apple-system, sans-serif;
  font-size: 14px;
  color: #3d3d3d;
  line-height: 1.6;
  outline: none;
  transition: box-shadow 0.2s;
  cursor: text;
}
.editable:empty::before {
  content: attr(data-placeholder);
  color: #bbb;
  font-style: italic;
  font-size: 12px;
}
.editable:focus {
  box-shadow: inset 0 0 0 2px rgba(233,13,65,0.15);
}
```

### HTML
Replace blank `<div>` cells with:
```html
<div class="editable" contenteditable="true" data-placeholder="Type here..." data-field="promise_current"></div>
```

The `data-field` attribute is used by auto-save (Pattern 3).

---

## Pattern 2: Traffic Light Scoring Buttons

Add green/yellow/red scoring to any facet or section.

### CSS
```css
.tl-group {
  display: flex;
  gap: 6px;
  margin-top: 6px;
}
.tl-btn {
  flex: 1;
  padding: 6px 0;
  border: 1.5px solid #d0cdc8;
  background: #fff;
  font-size: 11px;
  font-weight: 500;
  cursor: pointer;
  text-align: center;
  font-family: -apple-system, sans-serif;
  color: #888;
  transition: all 0.15s;
}
.tl-btn:hover { border-color: #b8bec1; }
.tl-btn.active-green { border-color: #22c55e; background: #f0fdf4; color: #166534; }
.tl-btn.active-yellow { border-color: #eab308; background: #fefce8; color: #854d0e; }
.tl-btn.active-red { border-color: #ef4444; background: #fef2f2; color: #991b1b; }
```

### HTML
```html
<div class="tl-group" data-field="tl_promise">
  <button class="tl-btn" data-color="green" onclick="setTL(this)">Green</button>
  <button class="tl-btn" data-color="yellow" onclick="setTL(this)">Yellow</button>
  <button class="tl-btn" data-color="red" onclick="setTL(this)">Red</button>
</div>
```

### JavaScript
```javascript
function setTL(btn) {
  const group = btn.parentElement;
  group.querySelectorAll('.tl-btn').forEach(b => b.className = 'tl-btn');
  btn.classList.add('active-' + btn.dataset.color);
  saveAll(); // trigger auto-save
}
```

---

## Pattern 3: Auto-Save to localStorage

Persist all editable fields and traffic light states across browser sessions.

### JavaScript
```javascript
const SAVE_KEY = '{{FRAMEWORK_SLUG}}_worksheet';

function saveAll() {
  const data = {};
  // Save editable text fields
  document.querySelectorAll('[data-field]').forEach(el => {
    if (el.classList.contains('editable')) {
      data[el.dataset.field] = el.innerHTML;
    }
  });
  // Save traffic light states
  document.querySelectorAll('.tl-group').forEach(group => {
    const active = group.querySelector('.tl-btn[class*="active-"]');
    if (active) {
      data['tl_' + group.dataset.field] = active.dataset.color;
    }
  });
  try { localStorage.setItem(SAVE_KEY, JSON.stringify(data)); } catch(e) {}
}

function loadAll() {
  try {
    const data = JSON.parse(localStorage.getItem(SAVE_KEY));
    if (!data) return;
    // Restore text fields
    document.querySelectorAll('.editable[data-field]').forEach(el => {
      if (data[el.dataset.field]) el.innerHTML = data[el.dataset.field];
    });
    // Restore traffic lights
    document.querySelectorAll('.tl-group').forEach(group => {
      const saved = data['tl_' + group.dataset.field];
      if (saved) {
        const btn = group.querySelector(`[data-color="${saved}"]`);
        if (btn) setTL(btn);
      }
    });
  } catch(e) {}
}

// Attach save listeners to all editable fields
document.querySelectorAll('.editable').forEach(el => {
  el.addEventListener('input', saveAll);
});

// Load on page ready
loadAll();
```

---

## Pattern 4: Copy-to-Clipboard Prompt Generator

Collect all filled-in data and generate a structured Claude prompt.

### HTML (add at bottom of worksheet)
```html
<div style="margin-top:16px;text-align:center">
  <button id="generateBtn" onclick="generatePrompt()" style="
    padding:12px 24px;background:#e90d41;color:#fff;border:none;
    font-family:'Rethink Sans',sans-serif;font-size:14px;font-weight:600;
    cursor:pointer;transition:background 0.2s;
  ">Generate Claude Prompt</button>
</div>

<div id="promptOutput" style="display:none;margin-top:12px">
  <div style="background:#1a1a1a;padding:16px;position:relative">
    <button onclick="copyToClipboard()" id="copyBtn" style="
      position:absolute;top:8px;right:8px;padding:4px 12px;
      background:rgba(255,255,255,0.1);border:1px solid rgba(255,255,255,0.2);
      color:#fff;font-size:11px;cursor:pointer;
    ">Copy</button>
    <pre id="promptText" style="font-family:'SF Mono',monospace;font-size:11px;color:#e0e0e0;white-space:pre-wrap;line-height:1.5;max-height:300px;overflow-y:auto"></pre>
  </div>
</div>
```

### JavaScript
```javascript
function generatePrompt() {
  const fields = {};
  document.querySelectorAll('.editable[data-field]').forEach(el => {
    fields[el.dataset.field] = el.innerText.trim();
  });
  document.querySelectorAll('.tl-group').forEach(group => {
    const active = group.querySelector('.tl-btn[class*="active-"]');
    fields['tl_' + group.dataset.field] = active ? active.dataset.color.toUpperCase() : 'Not scored';
  });

  const prompt = `Build me an Offer Diamond based on these inputs:

${Object.entries(fields).map(([k, v]) => `${k}: ${v}`).join('\n')}

Please score each facet, suggest improvements, and generate a prospect-facing offer doc.`;

  document.getElementById('promptText').textContent = prompt;
  document.getElementById('promptOutput').style.display = 'block';
  document.getElementById('promptOutput').scrollIntoView({ behavior: 'smooth' });
}

function copyToClipboard() {
  navigator.clipboard.writeText(document.getElementById('promptText').textContent).then(() => {
    const btn = document.getElementById('copyBtn');
    btn.textContent = 'Copied!';
    btn.style.background = '#22c55e';
    btn.style.borderColor = '#22c55e';
    setTimeout(() => {
      btn.textContent = 'Copy';
      btn.style.background = 'rgba(255,255,255,0.1)';
      btn.style.borderColor = 'rgba(255,255,255,0.2)';
    }, 2000);
  });
}
```

---

## Pattern 5: Print-Friendly Mode

Add a print button and CSS that produces clean printouts.

### CSS
```css
@media print {
  body, div { -webkit-print-color-adjust: exact !important; print-color-adjust: exact !important; }
  @page { size: A4 landscape; margin: 0.5in; }
  .no-print { display: none !important; }
  .editable { border: 1px solid #d0cdc8 !important; }
  .editable:empty::before { content: ''; }
  #promptOutput { display: none !important; }
  button { display: none !important; }
}
```

### HTML
```html
<button class="no-print" onclick="window.print()" style="
  margin-top:8px;padding:8px 16px;background:transparent;
  border:1px solid #d0cdc8;font-size:12px;cursor:pointer;color:#888;
">Print / Save as PDF</button>
```

---

## Pattern 6: Progress Indicator

Show completion status across all fill-in fields.

### HTML
```html
<div class="no-print" style="position:sticky;top:0;background:#f0eeea;padding:8px 0;border-bottom:1px solid #d0cdc8;z-index:10;display:flex;align-items:center;gap:8px">
  <div style="flex:1;height:4px;background:#d0cdc8;overflow:hidden">
    <div id="progressBar" style="height:100%;background:#22c55e;width:0%;transition:width 0.3s"></div>
  </div>
  <span id="progressLabel" style="font-size:11px;color:#888;min-width:36px">0%</span>
</div>
```

### JavaScript
```javascript
function updateProgress() {
  const fields = document.querySelectorAll('.editable[data-field]');
  const filled = [...fields].filter(el => el.innerText.trim().length > 0).length;
  const pct = Math.round((filled / fields.length) * 100);
  document.getElementById('progressBar').style.width = pct + '%';
  document.getElementById('progressLabel').textContent = pct + '%';
}

// Attach to all editable fields
document.querySelectorAll('.editable').forEach(el => {
  el.addEventListener('input', updateProgress);
});
updateProgress(); // initial check
```

---

## Pattern 7: Reset/Clear All

```html
<button class="no-print" onclick="if(confirm('Clear all entries?')){localStorage.removeItem(SAVE_KEY);location.reload()}" style="
  padding:6px 12px;background:transparent;border:1px solid #ef4444;
  color:#ef4444;font-size:11px;cursor:pointer;
">Reset worksheet</button>
```

---

## Composition Guide: Building an Interactive Worksheet

To convert any static template into a fully interactive version:

1. **Start with the base template** from code-templates.md
2. **Replace blank divs** with `<div class="editable" contenteditable="true" data-field="unique_name" data-placeholder="hint text">`
3. **Add traffic light groups** below each section header
4. **Add the auto-save script** (Pattern 3) — set {{FRAMEWORK_SLUG}} to a unique identifier
5. **Add the prompt generator** (Pattern 4) at the bottom
6. **Add the progress bar** (Pattern 6) at the top
7. **Add print CSS** (Pattern 5) and a print button
8. **Add reset button** (Pattern 7) near the footer
9. **Test**: Fill in one field, reload the page — data should persist

Total added JavaScript: ~80 lines. Total added CSS: ~50 lines. The interactive version adds about 130 lines to any base template.

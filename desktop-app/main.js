// Local AI Workshop — Electron main process.
// Opens a single window loading the interactive workshop HTML.
// External links (e.g. the GitHub repo) open in the default browser.

const { app, BrowserWindow, shell, Menu, dialog, ipcMain } = require("electron");
const path = require("path");

// ---- Native file / folder pickers (called from the renderer via preload) ----

ipcMain.handle("pick-file", async (event) => {
  const win = BrowserWindow.fromWebContents(event.sender);
  const result = await dialog.showOpenDialog(win, {
    title: "Choose a file to summarize",
    properties: ["openFile"],
    filters: [
      { name: "Common documents", extensions: ["pdf", "docx", "txt", "md", "rtf", "html"] },
      { name: "All files", extensions: ["*"] },
    ],
  });
  if (result.canceled || !result.filePaths.length) return null;
  return result.filePaths[0];
});

ipcMain.handle("pick-folder", async (event) => {
  const win = BrowserWindow.fromWebContents(event.sender);
  const result = await dialog.showOpenDialog(win, {
    title: "Choose a folder to index",
    properties: ["openDirectory"],
  });
  if (result.canceled || !result.filePaths.length) return null;
  return result.filePaths[0];
});

// Recursively walk a folder and return every text-readable file's content.
// Used by the in-app RAG feature to index a user's own archive.
ipcMain.handle("read-folder-text", async (_event, folderPath) => {
  const fs = require("fs").promises;
  const path = require("path");

  const TEXT_EXTS = new Set([
    ".txt", ".md", ".markdown", ".rst",
    ".csv", ".tsv", ".json", ".jsonl", ".yaml", ".yml", ".toml",
    ".html", ".htm", ".xml",
    ".js", ".ts", ".tsx", ".jsx", ".mjs", ".cjs",
    ".py", ".rb", ".go", ".rs", ".java", ".kt", ".swift",
    ".c", ".cpp", ".cc", ".h", ".hpp",
    ".sh", ".bash", ".zsh", ".fish",
    ".sql", ".env", ".ini", ".cfg", ".conf",
    ".log", ".eml",
  ]);

  const SKIP_DIRS = new Set([
    ".git", "node_modules", "__pycache__", ".venv", "venv", "env",
    "dist", "build", ".next", ".nuxt", ".cache", ".svelte-kit",
    "target", "out", ".idea", ".vscode", ".DS_Store",
  ]);

  const MAX_FILE_BYTES = 300 * 1024;   // skip files larger than 300 KB
  const MAX_TOTAL_FILES = 250;         // soft cap
  const MAX_TOTAL_BYTES = 4 * 1024 * 1024; // 4 MB of text total

  const out = [];
  let totalBytes = 0;
  let skippedBig = 0;
  let skippedBinary = 0;

  async function walk(dir, relBase) {
    if (out.length >= MAX_TOTAL_FILES || totalBytes >= MAX_TOTAL_BYTES) return;
    let entries;
    try { entries = await fs.readdir(dir, { withFileTypes: true }); }
    catch { return; }

    for (const entry of entries) {
      if (out.length >= MAX_TOTAL_FILES || totalBytes >= MAX_TOTAL_BYTES) break;
      if (entry.name.startsWith(".") && entry.name !== ".env") continue;
      if (SKIP_DIRS.has(entry.name)) continue;

      const full = path.join(dir, entry.name);
      const rel  = path.join(relBase, entry.name);

      if (entry.isDirectory()) {
        await walk(full, rel);
      } else if (entry.isFile()) {
        const ext = path.extname(entry.name).toLowerCase();
        if (!TEXT_EXTS.has(ext)) { skippedBinary++; continue; }

        let stat;
        try { stat = await fs.stat(full); } catch { continue; }
        if (stat.size > MAX_FILE_BYTES) { skippedBig++; continue; }
        if (totalBytes + stat.size > MAX_TOTAL_BYTES) break;

        try {
          const content = await fs.readFile(full, "utf8");
          // Skip content that's mostly binary (high non-printable ratio)
          let nonPrintable = 0;
          const sample = content.slice(0, 1000);
          for (const ch of sample) {
            const c = ch.charCodeAt(0);
            if (c < 9 || (c > 13 && c < 32)) nonPrintable++;
          }
          if (sample.length > 0 && nonPrintable / sample.length > 0.05) {
            skippedBinary++;
            continue;
          }
          out.push({ relPath: rel, content, size: stat.size });
          totalBytes += stat.size;
        } catch { /* unreadable, skip */ }
      }
    }
  }

  await walk(folderPath, "");
  return {
    folderPath,
    files: out,
    stats: {
      fileCount: out.length,
      totalBytes,
      skippedBig,
      skippedBinary,
      hitCap: out.length >= MAX_TOTAL_FILES || totalBytes >= MAX_TOTAL_BYTES,
    },
  };
});

// Save a string (typically markdown) to a user-chosen file path.
ipcMain.handle("save-file", async (event, { content, defaultName, title }) => {
  const win = BrowserWindow.fromWebContents(event.sender);
  const result = await dialog.showSaveDialog(win, {
    title: title || "Save conversation",
    defaultPath: defaultName || "conversation.md",
    filters: [
      { name: "Markdown", extensions: ["md"] },
      { name: "Text", extensions: ["txt"] },
      { name: "All files", extensions: ["*"] },
    ],
  });
  if (result.canceled || !result.filePath) return null;
  const fs = require("fs").promises;
  await fs.writeFile(result.filePath, content, "utf8");
  return result.filePath;
});

function createWindow() {
  const win = new BrowserWindow({
    width: 1280,
    height: 900,
    minWidth: 960,
    minHeight: 640,
    title: "Purely Personal",
    backgroundColor: "#faf7f2",
    // Premium macOS look: traffic-light buttons inset, transparent toolbar.
    titleBarStyle: process.platform === "darwin" ? "hiddenInset" : "default",
    webPreferences: {
      preload: path.join(__dirname, "preload.js"),
      nodeIntegration: false,
      contextIsolation: true,
      // Node stays sandboxed; the preload script exposes a minimal safe
      // bridge (file picker, folder picker) to the renderer.
    },
  });

  win.loadFile(path.join(__dirname, "workshop.html"));

  // Any <a target="_blank"> or window.open calls — open in the user's
  // default browser, not a new Electron window.
  win.webContents.setWindowOpenHandler(({ url }) => {
    shell.openExternal(url);
    return { action: "deny" };
  });

  // Intercept top-level navigations to external URLs as well.
  win.webContents.on("will-navigate", (event, url) => {
    const target = new URL(url);
    // Allow local file navigation, redirect everything else to the system browser.
    if (target.protocol !== "file:") {
      event.preventDefault();
      shell.openExternal(url);
    }
  });
}

// Minimal menu — keeps the standard Edit/View/Window/Help on macOS,
// removes developer noise. Works fine on Windows/Linux with defaults.
function buildMenu() {
  const isMac = process.platform === "darwin";
  const template = [
    ...(isMac ? [{ role: "appMenu" }] : []),
    {
      label: "File",
      submenu: [isMac ? { role: "close" } : { role: "quit" }],
    },
    { role: "editMenu" },
    {
      label: "View",
      submenu: [
        { role: "reload" },
        { role: "resetZoom" },
        { role: "zoomIn" },
        { role: "zoomOut" },
        { type: "separator" },
        { role: "togglefullscreen" },
      ],
    },
    { role: "windowMenu" },
    {
      role: "help",
      submenu: [
        {
          label: "Learn More (GitHub)",
          click: async () => {
            await shell.openExternal(
              "https://github.com/danielpaulai/Run-Worldclass-computer-locally"
            );
          },
        },
      ],
    },
  ];
  Menu.setApplicationMenu(Menu.buildFromTemplate(template));
}

app.whenReady().then(() => {
  buildMenu();
  createWindow();

  app.on("activate", () => {
    // On macOS, re-open a window when the dock icon is clicked and no windows are open.
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});

app.on("window-all-closed", () => {
  // Quit on non-macOS when all windows are closed. macOS apps stay in the dock.
  if (process.platform !== "darwin") app.quit();
});

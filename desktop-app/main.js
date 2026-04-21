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

function createWindow() {
  const win = new BrowserWindow({
    width: 1280,
    height: 900,
    minWidth: 960,
    minHeight: 640,
    title: "Local AI Workshop",
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

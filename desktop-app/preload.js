// Preload script — runs before the workshop page loads.
// Exposes a tiny, safe API for the page to call native OS dialogs.
//
// Only whitelisted functions are exposed via contextBridge; the rest
// of Node/Electron stays sandboxed away from the page.

const { contextBridge, ipcRenderer } = require("electron");

contextBridge.exposeInMainWorld("electronAPI", {
  isElectron: true,

  // Open a native Open-File dialog. Returns the chosen file's absolute path
  // as a string, or null if the user cancelled.
  pickFile: () => ipcRenderer.invoke("pick-file"),

  // Open a native Open-Folder dialog. Returns the chosen folder's absolute
  // path, or null if cancelled. Useful for RAG ingest flows.
  pickFolder: () => ipcRenderer.invoke("pick-folder"),

  // Write a string to a user-chosen path (via a native Save dialog).
  // Returns the saved path, or null if the user cancelled.
  saveFile: (opts) => ipcRenderer.invoke("save-file", opts),

  // Walk a folder and return every text-readable file's content.
  // Used by the in-app RAG indexer. Enforces file size and count caps.
  readFolderText: (folderPath) => ipcRenderer.invoke("read-folder-text", folderPath),
});

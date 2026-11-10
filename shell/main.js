// Spike 3 skeleton: load a local file and call the loopback service. Hardened settings from NFR-13 already on.
const { app, BrowserWindow } = require('electron');
const path = require('path');
if (!app.requestSingleInstanceLock()) app.quit();
app.whenReady().then(() => {
  const win = new BrowserWindow({
    width: 1200, height: 800,
    webPreferences: { contextIsolation: true, nodeIntegration: false, sandbox: true,
                      preload: path.join(__dirname, 'preload.js') }
  });
  win.loadFile(path.join(__dirname, '..', 'ui', 'index.html'));
});
app.on('window-all-closed', () => app.quit());

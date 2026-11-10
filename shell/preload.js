const { contextBridge } = require('electron');
contextBridge.exposeInMainWorld('wr', { servicePort: Number(process.env.WR_PORT || 0) }); // allowlisted bridge, grows in Sprint 1

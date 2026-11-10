# Wicked Reader

Windows desktop PDF/EPUB reader. Electron shell + vanilla JS UI + Spring Boot service + bundled MySQL.
See `docs/decision-log.md` for the Sprint 0 decisions and `docs/spikes/` for the five technology spikes.

| Folder | Purpose |
|---|---|
| `shell/` | Electron main process, preload, electron-builder config |
| `ui/` | HTML/CSS/vanilla JS front end |
| `service/` | Spring Boot service (Java 21, Maven) |
| `installer/` | jlink and MySQL bundling scripts, installer assets |
| `docs/` | Decision log, backlog, test plan, branching, spike results |
| `testlib/` | Test book manifest and generator (files themselves are git-ignored) |

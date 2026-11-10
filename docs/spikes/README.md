# Spikes: how to run and record

Each spike needs a Windows 10/11 machine with internet access. Scripts are provided; none of them has been run yet.
Record results in the table at the bottom of each spike file. A spike PASSES only when every threshold is met.

| Spike | Script / doc | Pass threshold |
|---|---|---|
| 1 MySQL bundle | `installer/spike1-mysql.ps1` | starts and stops cleanly; idle RSS (mysqld) <= 400 MB; cold start <= 6 s; unzipped size noted |
| 2 jlink + Spring Boot | `installer/spike2-jlink.ps1` | hello-world JAR runs on the jlink image with no system Java on PATH |
| 3 Electron + service | `shell/` (`npm start`, set `WR_PORT`) | window shows `{"status":"UP"}` from loopback |
| 4 PDF.js + epub.js | `docs/spikes/spike-4.md` | one PDF and one EPUB render in Electron; versions pinned |
| 5 installer | `npm run dist` in `shell/` | per-user install, no admin prompt, on a clean VM; uninstall is clean |

Overall budget to check at the end: Electron + JRE image + MySQL + JAR < 500 MB installer (NFR-27); idle total < 800 MB (NFR-7).

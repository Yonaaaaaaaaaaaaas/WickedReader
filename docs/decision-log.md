# Decision Log (Sprint 0)

Status: all decisions closed. Every decision lists the trigger that reopens it.

| # | Question (SRS 10.2 / plan) | Decision | Reason | Reopen if |
|---|---|---|---|---|
| D1 | Keep MySQL? | FINAL: keep MySQL, **8.4 LTS** (not 8.0). | SRS 2.5 mandates MySQL. MySQL 8.0 reached end of life in April 2026; 8.4 is the supported LTS and is still "8.x". | Spike 1 idle memory > 400 MB, cold start > 6 s, or installer > 500 MB. Fallback: H2 or SQLite; Flyway scripts stay ANSI-friendly. |
| D2 | Electron vs WebView2/JavaFX? | Electron, pinned **45.2.3** (latest stable on 2026-11-10, Chromium 156). | SRS assumes Electron; PDF.js/epub.js need a known Chromium; Electron supports only the latest 3 majors and ships every 8 weeks, so plan a bump before release. | Spike 5 installer cannot fit the 500 MB budget. |
| D3 | Copy or link by default? | Copy (SRS FR-2.2 default). Link mode stays an option. | Survives moved or deleted originals; simpler backup. | Disk-space complaints in usability tests. |
| D4 | Multiple profiles? | One profile for 1.0. Schema keeps `profile_id` everywhere. FR-1.7 (C) moves to the post-1.0 backlog. | Could-have, costs a profile switcher, per-profile data dirs and tests. | Stakeholder asks for it. |
| D5 | Per-user or per-machine install? | Per-user, no admin rights (NFR-27). | Matches SRS assumption; data lives in AppData. | Enterprise deployment request. |
| D6 | Code-signing certificate? | FINAL: no certificate assumed. 1.0 ships unsigned with a documented SmartScreen workaround; sign if a certificate arrives before Sprint 12. | Cannot be decided by engineering. | Certificate obtained. |
| D7 | Dictionary lookup (FR-7.8, C) approach for Sprint 8? | Bundled offline word list (permissively licensed, e.g. WordNet) read by the service. No network calls (NFR-29). Drop first if Sprint 8 runs long. | Offline requirement rules out online APIs. | Licensing review fails. |
| D8 | Spring Boot version | FINAL, SRS amended: Spring Boot **4.1.x**, not 3.x. | Every 3.x branch is out of open-source support (3.5 ended 2026-06-30); 4.0 ends 2026-12-31, before this project ships; 4.1 is supported to 2027-07-31. Supports Java 21. | Team cannot absorb Boot 4 / Jackson 3 changes. Fallback: stay on 3.5.16 and accept no patches. |
| D9 | Library versions | PDF.js and epub.js pinned with `--save-exact` at Spike 4; versions recorded in `docs/spikes/spike-4.md`. | Plan risk: compatibility with bundled Chromium. | Rendering defects. |
| D10 | Java | Java 21 LTS (SRS), jlink runtime. | SRS constraint. | None. |

## Remaining execution

1. Run the five spikes on Windows and fill in `docs/spikes/results.md`.
2. Create the VM snapshots and name the reference PC.
3. Order a code-signing certificate in parallel (optional for 1.0).

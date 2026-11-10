# Test Plan Outline

1. Scope and references: SRS v1.1, sprint plan, release acceptance checklist (SRS 10.1).
2. Levels: unit (services 70%+, NFR-30); integration (API flows, MySQL via Testcontainers or the bundled instance); end-to-end in the packaged shell (NFR-31); installer smoke test on clean VMs.
3. Environments: Windows 10 22H2 VM, Windows 11 VM, reference PC (SSD, 8 GB RAM) for NFR-1 to NFR-8.
4. Test data: `testlib/manifest.csv` (see that folder).
5. Non-functional: performance (NFR-1 to 8), security (NFR-9 to 17, port scan, DNS-rebinding, path traversal), reliability (kill service, kill MySQL, forced shutdown), accessibility (WCAG 2.2 AA), scalability (5,000 books, 100,000 annotations), offline audit.
6. Entry/exit criteria per sprint: Definition of Done in the sprint plan.
7. Defect process: severity levels, triage weekly, no open Sev-1/2 at release.
8. Traceability: `docs/backlog.csv` maps every FR and NFR to a sprint; add a test-case column from Sprint 1.

# Branch Strategy

- `main`: always releasable, protected, merge by pull request only, CI must pass, 1 review.
- `feature/<sprint>-<short-name>` (example `feature/s2-import-pipeline`): branch from `main`, squash-merge.
- `release/1.0`: cut at Sprint 13 freeze; only bug fixes.
- Tags: `v1.0.0`; sprint demo tags `sprint-<n>`.
- Commits: imperative mood, reference the requirement ID (`FR-2.1`).

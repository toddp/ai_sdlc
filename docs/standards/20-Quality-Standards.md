# 20 — Quality Standards

## Definition of Done
- Acceptance criteria met & traceable to `PROJECT_BRIEF.md`.
- Tests:
  - Unit tests cover ≥ **80%** of changed/new code (adjust in Testing Standards).
  - Critical flows have integration tests.
- **Browser verification**: Critical user flows verified with Playwright MCP
  - Features with UI changes MUST be tested in browser
  - Verify actual user experience matches expectations
  - Capture screenshots for visual confirmation
- Lint/format/type checks pass.
- CI green; `scripts/quality_gate.sh` returns 0.
- README/RUNBOOK updated.
- ADR added/updated; risks noted.

## Code Review
- Prefer small PRs (< 400 LOC).
- Link SPEC/ADR and acceptance criteria.
- Self-review checklist before requesting review.

## Style
- Use project language style guides; enforce via CI.

# 60 — Docs & Decision Log

## General
- Keep `README.md` updated.
- Add `RUNBOOK.md` per service in `project/RUNBOOKS/`.
- Store ADRs in `docs/adrs/[N].[feature]_adr.md`.
- Store SPECs in `docs/specs/[N].[feature]_spec.md`.
- Link ADRs and SPECs in PRs and commit messages.

## SPEC Documents

SPECs define **what** to build and **why**, not **how** to implement it.

### What belongs in a SPEC:
- Problem statement and motivation
- Requirements and acceptance criteria
- Data models (fields and relationships, not migrations)
- User flows and UI descriptions
- Edge cases and error handling
- Success metrics
- Open questions

### What does NOT belong in a SPEC:
- Ruby/code blocks with implementation
- Migration syntax
- Service class method implementations
- Controller actions
- Test code

**Rule:** If it looks like code you'd copy-paste into a file, it doesn't belong in the spec. Describe the behavior; let implementation happen during development.

### Example - Good vs Bad

**Bad (too much code):**
```
class UserInterest < ApplicationRecord
  belongs_to :account
  validates :topic, presence: true
  scope :confirmed, -> { where(status: "confirmed") }
end
```

**Good (describes the model):**
- `UserInterest` belongs to Account
- Required: topic
- Statuses: detected, confirmed, dismissed, snoozed
- Key scopes: confirmed interests, recent detections

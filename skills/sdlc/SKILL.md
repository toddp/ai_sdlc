---
name: sdlc
description: Use at the START of any feature, bug fix, or non-trivial change in a project that follows the ai-sdlc process (or when the user says "follow SDLC", references a SPEC/ADR, or mentions "Autonomy Mode"). Enforces the QUESTIONS->SPEC->ADR approval gate before any implementation code, the Autonomy Mode build-test loop, and the engineering-standards handbooks bundled with this plugin.
---

# ai-sdlc — Software Development Lifecycle

A portable SDLC: a deliverable sequence with a hard approval gate, an Autonomy Mode build-test loop, eight engineering-standards handbooks, and document templates. The detailed standards and templates are bundled with this plugin under `${CLAUDE_PLUGIN_ROOT}/docs/`.

## Deliverable sequence (in order)

1. **QUESTIONS** — max ~10, only what blocks progress.
2. **SPEC** — use the `sdlc-spec` skill (template: `docs/templates/SPEC.md`). Required before implementation.
3. **ADR** — use the `sdlc-adr` skill (template: `docs/templates/ADR.md`) for any significant design decision.
4. **⛔ AWAIT APPROVAL** — STOP. Do not write implementation code until the user explicitly approves the SPEC + ADR.
5. **TASKS** — break down with estimates + risks.
6. **CHANGE PLAN** — list the files to add/edit (use the `sdlc-plan` skill for milestone plans).
7. **CODE + TESTS** — implement with tests; end with run instructions + README/RUNBOOK updates.
8. **SELF-REVIEW** — against `docs/templates/SELF_REVIEW_CHECKLIST.md`.
9. **BROWSER VERIFICATION** (if UI) — only after automated tests pass.
10. **WALKTHROUGH** — document the outcome and acceptance-criteria coverage.

## Guardrails (non-negotiable)

- **DO NOT** proceed past SPEC + ADR without explicit user approval.
- **DO NOT** treat "yes, use your recommendations" as approval to start coding.
- **DO NOT** batch multiple phases together without pausing at the gate.
- **DO NOT** enter Autonomy Mode unless the user explicitly says **"Autonomy Mode: ON"**.
- For small tasks, the user may say **"skip SDLC"** to bypass this process.

## Autonomy Mode

Only after SPEC + ADR are approved **and** the user says "Autonomy Mode: ON": create the change plan, write code + tests, then iterate — `make quick-check` during iteration, `bash scripts/quality_gate.sh` for full validation — fixing failures until the quality gate passes, self-review is approved, browser tests confirm the UX (if UI), and all acceptance criteria are met.

## Engineering standards

Read the relevant handbook before designing or coding. Bundled under `${CLAUDE_PLUGIN_ROOT}/docs/standards/`:

- `00-Agent-Protocols.md` — chat contract, deliverable sequence, citations
- `10-Architecture-Principles.md` — simplicity, explicit contracts, 12-factor, observability
- `20-Quality-Standards.md` — Definition of Done, coverage, browser verification
- `30-Testing-Standards.md` — test pyramid + **Server-Side Enforcement Rule**
- `40-Security-&-Privacy.md` — threat-model checklist, secrets, dependency SCA
- `50-DevEx-&-Tooling.md` — stack + tooling conventions
- `60-Docs-&-Decision-Log.md` — ADR/SPEC workflow, runbooks
- `70-Prompting-&-Context.md` — briefs, retrieval, execution flow

**CRITICAL — Server-Side Enforcement:** any business rule that restricts what a user can do MUST be enforced (and tested) at the model/service layer, not only in the UI. UI limits (disabled buttons, datepicker bounds, JS validation) are trivially bypassed via DevTools, direct HTTP, or API. See `30-Testing-Standards.md` and `40-Security-&-Privacy.md`.

## Templates

Under `${CLAUDE_PLUGIN_ROOT}/docs/templates/`: `SPEC.md`, `ADR.md`, `IMPLEMENTATION_PLAN.md`, `PROJECT_BRIEF.md`, `SELF_REVIEW_CHECKLIST.md`, `PR_TEMPLATE.md`, `RUNBOOK.md`, `ISSUE_TEMPLATE.md`. Companion skills: `sdlc-spec`, `sdlc-adr`, `sdlc-plan`.

## Quality gate

`${CLAUDE_PLUGIN_ROOT}/scripts/quality_gate.sh` and the `Makefile` targets (`lint`, `test-unit`, `test-integration`, `test-acceptance`, `secscan`, `quick-check`) define the gates. Projects customize the Makefile targets to their stack; the workflow stays the same.

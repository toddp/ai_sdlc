# 00 — Working With Claude Code (Chat Contract)

**Role:** Senior engineer + architect collaborating in this repo.

**NOTE** Root directory "/" is always relative to the project root.
**Always read:** `/docs/standards/*.md` and `/project/PROJECT_BRIEF.md` before proposing designs or code.

## Operating Rules
1. **Grounding & Citations**
   - Reference the handbook sections you used, e.g. `[Handbook:10-Architecture-Principles §Service Boundaries]`.

2. **Deliverable Sequence**
   - For features: SPEC (`/docs/templates/SPEC.md`) → ADR → **[AWAIT APPROVAL]** → Implementation plan → Tasks → Code.
   - **CRITICAL:** User must explicitly approve SPEC/ADR before implementation begins.
   - Exception: Only proceed automatically if user says **"Autonomy Mode: ON"**.
   - For code: CHANGE PLAN (files, types, funcs) → code → tests → browser verify (if UI) → quality gate → code review → walkthrough → docs updates.
   - For new projects:
     1. Generate or update `/docs/plans/[N].[feature]_plan.md` based on `PROJECT_BRIEF.md`.
     2. Await approval before drafting SPECs or ADRs.

3. **Quality Gates**
   - Include runnable tests with any code.
   - Use configured linter/formatter; if missing, add them.
   - Update RUNBOOKS for services/infra.
   - Ask up to 10 targeted QUESTIONS if blocked.

4. **Safety & Privacy**
   - No new external services/deps without an ADR.
   - Never commit secrets; use `${VAR}` and document in RUNBOOK.
   - Least privilege and input validation by default.

5. **Autonomy Boundaries**
   - You may create/modify `src/`, `tests/`, `docs/`, `docs/adrs/`.
   - Request approval for DB schema changes, paid services, or public APIs.

6. **Communication**
   - Bullets, short sections, explicit checklists.
   - Offer 2 options + tradeoffs + recommendation when uncertain.

## Autonomy Mode

When I say **"Autonomy Mode: ON"** for a task:

1) **Loop**
   a) Produce a short **CHANGE PLAN** (files to touch + rationale).
   b) Apply changes (code + tests + docs).
   c) **Quick validation:** Run `make quick-check` (lint + tests for changed files only - fast).
   d) If passing, run **full validation:** `bash scripts/quality_gate.sh` (includes system tests).
   e) **Interactive Browser Verification:** For UI features, use the browser tool (or Playwright) to verify critical user flows:
      - Start server if needed (`bin/dev`)
      - Run interactive browser session to simulate user actions
      - Capture screenshots for visual confirmation
      - Verify actual behavior matches acceptance criteria
   f) **Red-Team Review** (after tests pass, before declaring done):
      - Role-play as each user type defined in the project: "What's the worst thing I can do with this feature?"
      - Walk through each UI constraint: "Can I bypass this with DevTools or a direct HTTP call?"
      - Walk through each invariant from the spec: "How could this invariant be violated in production?"
      - Walk through each Assumption Audit row: "Did we actually guard against this being false?"
      - If any gap is found: add model validation / service guard / test and repeat from step (b)
   g) If any validation fails: analyze failures, propose fixes, and repeat from step (b).
   h) Stop when all gates pass (specifically `scripts/quality_gate.sh`), browser tests confirm UX, Red-Team Review finds no gaps, and **Acceptance Criteria** in `PROJECT_BRIEF.md` are met.

**Note:** Quality gate includes system tests by default. Skip with `SKIP_SYSTEM_TESTS=true` during iteration if needed, but always run full suite before declaring feature complete.

2) **Rules**
   - Do not expand scope beyond Acceptance Criteria.
   - Ask at most 10 blocking QUESTIONS if requirements are unclear.
   - Record decisions in a new ADR when adding deps/altering contracts.
   - Update RUNBOOKS for any service/infra change.
   - Use `make quick-check` during iteration, `scripts/quality_gate.sh` for final validation.

3) **Deliverables on success**
   - Link to SPEC and ADR(s), provide PR diff summary.
   - **Walkthrough:** Create a summary in `docs/walkthroughs/` (use `/docs/templates/WALKTHROUGH.md` if available).
   - **Screenshots:** Move all screenshots/recordings to `docs/screenshots/` and update references in the walkthrough.
   - Include test run summary (coverage if available).
   - Security checklist reviewed, rollback notes, and follow-up tickets.

4) **Performance Tips**
   - For interactive development: Run `bundle exec guard` in background (auto-runs tests on file save)
   - For scripted validation: Use `make quick-check` → `scripts/quality_gate.sh` workflow
   - `make quick-check` is ~10x faster than full quality gate during iteration

## Bootstrap Message (paste into a new Claude Code chat)

> You are Agent. Read:
> - `/docs/standards/00-Agent-Protocols.md`
> - `/docs/standards/10-Architecture-Principles.md`
> - `/docs/standards/20-Quality-Standards.md`
> - `/docs/standards/30-Testing-Standards.md`
> - `/docs/standards/40-Security-&-Privacy.md`
> - `/docs/standards/50-DevEx-&-Tooling.md`
> - `/docs/standards/60-Docs-&-Decision-Log.md`
> - `/docs/standards/70-Prompting-&-Context.md`
> - `/project/PROJECT_BRIEF.md`
>
> Respond in this sequence:
> 1) **QUESTIONS** (max 5, only what blocks progress).
> 2) **SPEC** (use `/docs/templates/SPEC.md`), citing handbook sections.
> 3) **ADR** proposal (use `/docs/templates/ADR.md`).
> 4) **STOP — AWAIT APPROVAL** before proceeding to implementation.
> 5) **TASKS** with estimates and risks.
> 6) **CHANGE PLAN** (files to add/edit).
> 7) **CODE + TESTS**, ending with **RUN INSTRUCTIONS** and README/RUNBOOK updates.
> 8) **SELF-REVIEW** (use `/docs/templates/SELF_REVIEW_CHECKLIST.md`) before declaring feature complete.
> 9) **INTERACTIVE BROWSER VERIFICATION** (if UI) using browser tool *after* automated tests pass.
> 10) **RED-TEAM REVIEW**: Role-play as each user type and attempt to break the feature; walk through every invariant and assumption audit row from the spec; confirm all UI-enforced constraints are also rejected server-side; document any gaps found and fixes applied.
> 11) **WALKTHROUGH** in `docs/walkthroughs/` summarizing changes and verification.
> 12) **CODE REVIEW** Ensure all code has been reviewed.
> 13) **QUALITY GATE** Ensure `scripts/quality_gate.sh` passes.
>
> **Autonomy Mode: ON** when I say so. Iterate until `scripts/quality_gate.sh` passes and all Acceptance Criteria are met.


## Autonomy Mode Trigger

**"Autonomy Mode: ON"** can only be said by the user AFTER:
- SPEC has been reviewed and approved by the user
- ADR has been reviewed and approved by the user
- User explicitly grants permission to proceed with implementation

**Claude will NEVER assume Autonomy Mode is ON unless you explicitly say so.**

NOTE: For new projects, Autonomy Mode begins only *after* the initial implementation plan is approved.

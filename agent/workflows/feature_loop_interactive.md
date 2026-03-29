---
description: Interactive Feature Development Loop — same phases as agentic loop but pauses for user input at each sprint
---

# Interactive Feature Development Loop

Same structure as the agentic loop, but pauses for user approval at each sprint boundary
instead of looping autonomously. Use this when you want tighter control over implementation.

---

## Phase 1: Design (same as agentic loop)

1. Clarification: Ask Questions
   [Instruction] Review the user's request. Ask up to 10 clarifying questions.

2. Brainstorm
   [Instruction] You MUST invoke: `Skill: superpowers:brainstorming`

3. Design: Create SPEC and ADR
   [Instruction] Invoke: `Skill: superpowers:writing-plans`
   Create SPEC at `docs/specs/[N].[feature_name]_spec.md`.
   If architecture changes, create ADR at `docs/adrs/[N].[feature_name]_adr.md`.

4. Sprint Contracts: Define Testable Criteria
   [Instruction] Break the plan into sprints with testable contracts (see agentic loop for format).

5. STOP: Request User Approval
   [Instruction] Present SPEC, ADR, and sprint contracts. Wait for explicit approval before writing code.

---

## Phase 2: Implementation (per sprint, with user checkpoints)

FOR each sprint:

6. Implement sprint
   [Instruction] Write code and tests for the current sprint contract criteria.

7. Code style check
   bundle exec standardrb [files]

8. Quick verification
   make quick-check

9. Full validation
   bash scripts/quality_gate.sh

10. Browser verification (UI features only)
    [Instruction] Use Playwright to verify UI criteria from the sprint contract.

11. Security check
    make secscan

12. Evaluator review
    [Instruction] Invoke the evaluator as a SEPARATE AGENT:
    - `Skill: sprint-contract-evaluator` via Agent tool
    - `pr-review-toolkit:code-reviewer` (parallel)
    - `pr-review-toolkit:silent-failure-hunter` (parallel)

13. STOP: Present sprint results to user
    [Instruction] Show the evaluator's report. Wait for user approval before proceeding.
    - If user approves: commit sprint, move to next
    - If user requests changes: fix and re-evaluate (repeat from step 6)

END sprint loop

---

## Phase 3: Completion

14. Documentation update
    [Instruction] Update `RUNBOOK.md` and `README.md` as needed.

15. Structured handoff
    [Instruction] Invoke: `Skill: handoff`

16. Branch completion
    [Instruction] Invoke: `Skill: superpowers:finishing-a-development-branch`

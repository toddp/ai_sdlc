---
description: Agentic Feature Development Loop — iterates autonomously until evaluator confirms done
---

# Agentic Feature Development Loop

This workflow runs autonomously after the user approves the SPEC, ADR, and sprint contracts.
The generator NEVER declares "done" — the evaluator does.

---

## Phase 1: Design (interactive — requires user input)

1. Clarification: Ask Questions
   [Instruction] Review the user's request. Ask up to 10 clarifying questions. Do NOT proceed until you have a clear understanding of the goal.

2. Brainstorm
   [Instruction] You MUST invoke: `Skill: superpowers:brainstorming`
   Do NOT skip this step. Explore requirements and design before committing to an approach.

3. Design: Create SPEC and ADR
   [Instruction] Invoke: `Skill: superpowers:writing-plans`
   Create SPEC at `docs/specs/[N].[feature_name]_spec.md`.
   If architecture changes, create ADR at `docs/adrs/[N].[feature_name]_adr.md`.

4. Sprint Contracts: Define Testable Criteria
   [Instruction] Break the implementation plan into sprints. For each sprint, define a **contract** — a list of specific, testable pass/fail criteria. These are what the evaluator will grade against.

   Format in the plan file (`docs/plans/[N].[feature_name]_plan.md`):

   ```markdown
   ## Sprint 1: [name]
   ### Contract (all must PASS before moving to Sprint 2)
   - [ ] [Specific, testable criterion]
   - [ ] [Another criterion — be precise about expected behavior]
   - [ ] [Include at least one error/edge case criterion per sprint]
   ```

   Rules for good criteria:
   - Each criterion is independently testable
   - Include expected behavior AND at least one negative case
   - Avoid vague criteria like "works correctly" — say what "correctly" means
   - 5-15 criteria per sprint is typical

5. STOP: Request User Approval
   [Instruction] Present the SPEC, ADR, and sprint contracts to the user. Wait for explicit approval. The agentic loop (Phase 2) begins ONLY after the user says "Autonomy Mode: ON".

---

## Phase 2: Agentic Loop (autonomous — no user input needed)

After "Autonomy Mode: ON", execute this loop for each sprint contract:

```
FOR each sprint in the plan:

  GENERATOR LOOP (inner — mechanical fixes):
    6a. Implement against current sprint contract criteria
        [Instruction] Invoke: `Skill: superpowers:executing-plans`
        Focus only on the current sprint's criteria. Do not expand scope.

    6b. Code style check
        bundle exec standardrb [files]

    6c. Quick verification
        make quick-check
        IF FAIL → fix and repeat from 6a

    6d. Full validation
        bash scripts/quality_gate.sh
        IF FAIL → fix and repeat from 6a

    6e. Browser verification (UI features only)
        [Instruction] Use Playwright to verify UI criteria from the sprint contract.
        Navigate, interact, verify. Capture evidence.
        IF FAIL → fix and repeat from 6a

    6f. Security check
        make secscan
        [Instruction] Review for secrets, injection risks.
        IF FAIL → fix and repeat from 6a

  EVALUATOR LOOP (outer — judgment):
    7a. Invoke evaluator agent
        [Instruction] You MUST invoke the evaluator as a SEPARATE AGENT with fresh context.
        Use the Agent tool — do NOT self-evaluate.

        The evaluator receives:
        - The SPEC file path
        - The current sprint contract
        - Access to codebase (read) and running app (Playwright)

        The evaluator does NOT receive:
        - This conversation history
        - Your reasoning or change plan
        - Any self-assessment you've done

        Invoke: `Skill: sprint-contract-evaluator` via Agent tool

    7b. Also invoke code quality review (parallel with 7a):
        [Instruction] Launch these as parallel Agent subagents:
        - `pr-review-toolkit:code-reviewer` — code quality and patterns
        - `pr-review-toolkit:silent-failure-hunter` — error handling gaps

    7c. Process evaluator verdict
        IF overall verdict = PASS and code review has no critical issues:
          → Commit sprint, update contract checkboxes, move to next sprint
        IF overall verdict = FAIL:
          → Read failure report
          → Fix ONLY the failed criteria (do not touch passing criteria)
          → Repeat from 6a
        IF iteration count >= MAX_ITERATIONS (default: 3):
          → STOP and escalate to user with the failure report
          → Do NOT continue to the next sprint

  END sprint loop
```

---

## Phase 3: Completion (after all sprints pass)

8. Final cross-sprint evaluation
   [Instruction] Invoke the evaluator one final time with ALL sprint contracts combined.
   This catches integration issues between sprints.

9. Documentation update
   [Instruction] Update `RUNBOOK.md` if operational steps changed. Update `README.md` if necessary.

10. Structured handoff
    [Instruction] Invoke: `Skill: handoff`
    Create the handoff with sprint contract results as the state record.

11. Branch completion
    [Instruction] Invoke: `Skill: superpowers:finishing-a-development-branch`
    Present results to the user. Include:
    - Sprint contract pass/fail summary (all iterations)
    - Code review findings and resolutions
    - Total iterations per sprint
    - Any edge cases the evaluator discovered

---

## Escape Valves

- **Iteration cap:** 3 attempts per sprint contract. After 3 FAIL verdicts on the same sprint, stop and escalate.
- **Scope lock:** During the evaluator fix loop, the generator may ONLY fix criteria the evaluator flagged as FAIL. No refactoring, no "improvements", no new features.
- **Escalation:** When escalating, present: the sprint contract, the evaluator's last failure report, and what you've tried. Let the user decide whether to adjust the contract, help debug, or accept the current state.

---
description: Autonomous Feature Development Loop (Auto-runs after Plan approval)
---

1. Clarification Phase: Ask Questions
   [Instruction] Review the user's request. If there are ambiguities, missing requirements, or insufficient context to draft a Spec, ask up to 10 clarifying questions. Do NOT proceed to the Design Phase until you have a clear understanding of the goal.

2. Design Phase: Create or Update Spec and ADR
   [Instruction] Determine the next feature number (starting at 1). Create a new SPEC file at `docs/specs/[N].[feature_name]_spec.md`. If there are significant architecture changes, create an ADR at `docs/adrs/[N].[feature_name]_adr.md`.

3. Planning Phase: Create Implementation Plan
   [Instruction] Create `docs/plans/[N].[feature_name]_plan.md` (ensure the number and feature name match the Spec/ADR) detailing the changes, files to touch, and verification steps.

4. STOP: Request User Approval
   [Instruction] Present the implementation plan to the user and wait for explicit approval. Once approved, the subsequent steps will run automatically.

// turbo
5. Implementation Phase: Write Code and Unit Tests
   [Model] Write the necessary code and corresponding unit tests. Ensure you follow the `Service::ClassName` pattern and use parameterized SQL.

// turbo
6. Code Style Check
   bundle exec standardrb [files]
   [Instruction] Run standardrb on the files you modified or created.

// turbo
7. Quick Verification
   make quick-check

// turbo
8. Full Validation
   bash scripts/quality_gate.sh

// turbo
9. Browser Verification
   [Instruction] Use the `browser_subagent` tool to verify the UI implementation. Navigate to the local server (usually http://localhost:3000) and perform the steps defined in the acceptance criteria.

// turbo
10. Security Review
   make secscan
   [Instruction] Manually review the generated code for secrets or SQL injection risks.

// turbo
11. Documentation Update
   [Instruction] Update `RUNBOOK.md` if operational steps changed. Update `README.md` if necessary.
---
name: sdlc-plan
description: Use when creating an implementation plan or milestones for an approved feature in an ai-sdlc project (after SPEC + ADR are approved). Produces a plan from the bundled template.
---

# Write an implementation plan

1. Start from the template at `${CLAUDE_PLUGIN_ROOT}/docs/templates/IMPLEMENTATION_PLAN.md`.
2. Save it to `docs/plans/[N].[feature]_plan.md` in the project.
3. Break work into milestones, each with tasks, estimates, risks, and acceptance criteria traceable to `project/PROJECT_BRIEF.md`.
4. Keep a "Completed" section and move milestones into it as they land.

Only begin coding once SPEC + ADR are approved. For the build-test loop, use **Autonomy Mode** (see the `sdlc` skill): iterate with `make quick-check`, validate with `bash scripts/quality_gate.sh`, and stop when all acceptance criteria are met.

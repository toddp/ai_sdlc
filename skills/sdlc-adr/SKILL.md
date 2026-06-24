---
name: sdlc-adr
description: Use when recording an architecture decision (ADR) in an ai-sdlc project — any significant design choice, or the ADR step of the SDLC. Produces an ADR from the bundled template.
---

# Write an ADR

Significant architectural choices require an ADR.

1. Start from the template at `${CLAUDE_PLUGIN_ROOT}/docs/templates/ADR.md`.
2. Save it to `docs/adrs/[N].[feature]_adr.md` in the project.
3. Capture: context/problem, the decision, alternatives considered, and consequences (trade-offs).
4. Link the ADR from the SPEC, the PR, and the commit message.

The ADR is part of the approval gate: after presenting SPEC + ADR, **STOP and await the user's explicit approval** before implementation. See the `sdlc` skill for the full sequence and guardrails.

---
name: sdlc-spec
description: Use when writing or scaffolding a feature SPEC in an ai-sdlc project — the user asks for a spec, or you've reached the SPEC step of the SDLC. Produces a SPEC from the bundled template.
---

# Write a SPEC

Every feature MUST have a SPEC before implementation begins.

1. Start from the template at `${CLAUDE_PLUGIN_ROOT}/docs/templates/SPEC.md`.
2. Save it to `docs/specs/[N].[feature]_spec.md` in the project.
3. Cite the engineering-standards handbook sections you relied on, e.g. `[Handbook:10-Architecture-Principles §Service Boundaries]`.
4. Trace requirements to acceptance criteria (from `project/PROJECT_BRIEF.md` when present).

After the SPEC, propose an ADR (`sdlc-adr` skill) for any significant design decision, then **STOP and await the user's approval** of SPEC + ADR before writing implementation code. See the `sdlc` skill for the full sequence and guardrails.

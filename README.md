# ai-sdlc

Portable SDLC config for Claude Code — engineering standards, document templates, an approval-gated workflow, and an Autonomy Mode build-test loop — packaged as a **Claude Code plugin** so it travels across all your projects. Install it once and every project gets the same SDLC, with no per-repo setup.

## Install

This repo is its own plugin marketplace (`.claude-plugin/marketplace.json`).

**Local (personal, before publishing):**

```text
/plugin marketplace add /absolute/path/to/ai_sdlc
/plugin install ai-sdlc@ai-sdlc
/reload-plugins        # or restart Claude Code
```

**From GitHub (once pushed / shared with teammates):**

```text
/plugin marketplace add toddp/ai_sdlc
/plugin install ai-sdlc@ai-sdlc
```

## What it provides

- **Skills**
  - `sdlc` — the workflow + guardrails; auto-activates when you start a feature/fix/change.
  - `sdlc-spec`, `sdlc-adr`, `sdlc-plan` — scaffold a SPEC / ADR / implementation plan from the bundled templates.
- **Standards** — `docs/standards/00`–`70`: eight engineering handbooks (agent protocols, architecture, quality, testing, security, devex, docs, prompting).
- **Templates** — `docs/templates/`: SPEC, ADR, implementation plan, project brief, self-review checklist, PR / issue / runbook.
- **Quality gate** — `scripts/quality_gate.sh` + `Makefile` targets (`lint`, `test-unit`, `test-integration`, `test-acceptance`, `secscan`, `quick-check`). Customize the Makefile targets per stack; the workflow stays the same.

## The workflow

```text
QUESTIONS → SPEC → ADR → ⛔ await approval → TASKS → CHANGE PLAN
        → CODE + TESTS → SELF-REVIEW → BROWSER VERIFY → WALKTHROUGH
```

Autonomy Mode iterates the build-test loop until the quality gate passes — and is enabled only when you say **"Autonomy Mode: ON"** after approving the SPEC + ADR.

## Migrating from the git-submodule setup

This repo was previously consumed as a `.sdlc` git submodule, with symlinks into each project's `docs/standards` and `docs/templates`. The plugin **supersedes** that approach:

- No per-repo `git submodule update --init` (which silently left standards unloaded when forgotten — a `/file:` directive pointing at an uninitialized submodule loads nothing).
- No committed symlinks (OS-fragile, and their targets drifted from the actual layout).
- One install applies to every project, versioned, and publishable to a marketplace for teammates.

The legacy submodule instructions remain in `docs/GIT_SUBMODULE_SETUP.md` for reference. Projects still on the submodule keep working (the `docs/standards` paths are unchanged); migrate them by installing this plugin and removing the submodule + the project's `/file:` references.

# Claude Code Project Template

This template provides a complete Claude Code workflow setup for software projects. It includes engineering handbooks, quality standards, testing frameworks, and an Autonomy Mode loop that allows Claude to iterate until all quality gates pass.

**Template Version:** v1.0.0
**Compatible with:** Rails, Node.js, Python, or any language (customize Makefile and quality_gate.sh)

---

## Quick Start

### 1. Copy Template to Your Project

```bash
# From your project root
cp -r /path/to/template/* .

# Or clone just the template
git clone <template-repo-url>
cp -r claude-template/* /path/to/your-project/
```

### 2. Customize for Your Project

**Required customizations:**

1.  **ARCHITECTURE.md** - Document your project's specific architecture
    ```bash
    cp ARCHITECTURE.md.example docs/ARCHITECTURE.md
    # Edit docs/ARCHITECTURE.md with your stack details
    ```

2.  **project/PROJECT_BRIEF.md** - Define your project goals
    ```bash
    cp docs/templates/PROJECT_BRIEF.md project/PROJECT_BRIEF.md
    # Fill in your project details
    ```

3.  **Makefile** - Update targets for your language/framework
    ```bash
    # Edit Makefile targets (lint, test-unit, test-integration, etc.)
    ```

4.  **scripts/quality_gate.sh** - Customize quality checks
    ```bash
    # Update Makefile targets called in quality_gate.sh
    ```

**Optional customizations:**

- Update `docs/standards/*.md` if you have specific team conventions
- Customize templates in `docs/templates/` for your workflow

### 3. Initialize Project Documentation

```bash
# Create your first implementation plan
cp docs/templates/IMPLEMENTATION_PLAN.md docs/plans/1.feature_name_plan.md
# Fill in milestones based on PROJECT_BRIEF.md
```

### 4. Test the Setup

```bash
# Run quality gate to ensure everything works
bash scripts/quality_gate.sh

# Should see:
# ✅ QUALITY GATE: PASS
```

### 5. Setup AI Assistant

**For Claude Code:**
Paste the bootstrap message from `docs/AI_CONTEXT.md`.

**For Google Antigravity:**
Add the following to your **User Rules**:

```
Always follow the SDLC defined in: /docs/AI_CONTEXT.md
```

```
You are Agent. Read:
- /docs/standards/00-Agent-Protocols.md
- /docs/standards/10-Architecture-Principles.md
- /docs/standards/20-Quality-Standards.md
- /docs/standards/30-Testing-Standards.md
- /docs/standards/40-Security-&-Privacy.md
- /docs/standards/50-DevEx-&-Tooling.md
- /docs/standards/60-Docs-&-Decision-Log.md
- /docs/standards/70-Prompting-&-Context.md
- /project/PROJECT_BRIEF.md
- /docs/ARCHITECTURE.md

Respond in this sequence:
1) QUESTIONS (max 10, only what blocks progress).
2) SPEC (use /docs/templates/SPEC.md), citing handbook sections.
3) ADR proposal (use /docs/templates/ADR.md).
4) STOP — AWAIT APPROVAL before proceeding to implementation.
5) TASKS with estimates and risks.
6) CHANGE PLAN (files to add/edit).
7) CODE + TESTS, ending with RUN INSTRUCTIONS and README/RUNBOOK updates.
8) SELF-REVIEW (use /docs/templates/SELF_REVIEW_CHECKLIST.md) before declaring feature complete.
9) BROWSER VERIFICATION (if UI) using Playwright *after* automated tests pass.
10) WALKTHROUGH in docs/walkthroughs/ (save screenshots to docs/screenshots/).

Autonomy Mode: ON when I say so. Iterate until scripts/quality_gate.sh passes, self-review approved, Playwright browser tests confirm UX, and all Acceptance Criteria are met.
```

---

## Directory Structure

```
your-project/
├── your-project/
├── docs/
│   ├── AI_CONTEXT.md               # Bootstrap instructions for Claude Code
│   ├── ARCHITECTURE.md             # Project-specific architecture
│   ├── standards/                  # Engineering standards and practices
│   │   ├── 00-Agent-Protocols.md
│   │   └── ...
│   ├── templates/                  # Document templates
│   │   ├── ADR.md
│   │   ├── SPEC.md
│   │   └── ...
│   ├── plans/                      # Implementation Plans
│   ├── specs/                      # Feature Specifications
│   ├── adrs/                       # Architecture Decision Records
│   └── SDLC_README.md              # This file
├── Makefile                        # Build/test/lint targets
├── scripts/
│   └── quality_gate.sh             # Quality checks
├── project/
│   ├── PROJECT_BRIEF.md
│   └── ...

```

---

## How It Works

### The SDLC Workflow

Claude Code follows a structured workflow:

1. **QUESTIONS** - Clarify requirements (max 10)
2. **SPEC** - Write feature specification
3. **ADR** - Document design decisions
4. **AWAIT APPROVAL** - ⚠️ Stop here for user approval
5. **TASKS** - Break down implementation
6. **CHANGE PLAN** - List files to modify
7. **CODE + TESTS** - Implement with tests
8. **SELF-REVIEW** - Check against standards
9. **BROWSER VERIFICATION** - Verify UI works
10. **WALKTHROUGH** - Document results in `docs/walkthroughs/`

### Autonomy Mode

When you say **"Autonomy Mode: ON"**, Claude will:

1. Create CHANGE PLAN
2. Write code + tests
3. Run `make quick-check` (fast validation)
4. Run `bash scripts/quality_gate.sh` (full validation)
5. Run browser tests (if UI feature)
6. Fix failures and repeat until all pass
7. Complete self-review
8. Stop when all Acceptance Criteria met

**Important:** Only say "Autonomy Mode: ON" after approving SPEC and ADR!

---

## Customization Guide

### For Rails Projects

The included Makefile and quality_gate.sh are already configured for Rails 8.

**Verify these work:**
```bash
make lint          # Should run RuboCop
make test-unit     # Should run model/service tests
make test-integration  # Should run controller tests
make test-acceptance   # Should run system tests
make secscan       # Should run Brakeman + bundler-audit
```

### For Node.js Projects

**Update Makefile:**
```makefile
lint:
	npm run lint

test-unit:
	npm run test:unit

test-integration:
	npm run test:integration

test-acceptance:
	npm run test:e2e

secscan:
	npm audit
```

**Update ARCHITECTURE.md:**
- Replace Rails stack with Express/Fastify/Next.js
- Update development commands (npm start, etc.)
- Document your Node.js patterns

### For Python Projects

**Update Makefile:**
```makefile
lint:
	ruff check .
	black --check .

test-unit:
	pytest tests/unit

test-integration:
	pytest tests/integration

test-acceptance:
	pytest tests/e2e

secscan:
	safety check
	bandit -r src/
```

**Update ARCHITECTURE.md:**
- Replace Rails stack with Django/Flask/FastAPI
- Update development commands (python manage.py runserver, etc.)
- Document your Python patterns

---

## Key Files Explained

### docs/AI_CONTEXT.md
**Purpose:** Entry point for Claude Code. Contains bootstrap instructions.

**When to edit:** Rarely. Only if you want to change the SDLC workflow.

### docs/ARCHITECTURE.md
**Purpose:** Project-specific details Claude needs to know (stack, patterns, conventions).

**When to edit:** Often. Update as architecture evolves.

**What to include:**
- Tech stack and versions
- Development commands
- Architecture patterns (auth, multi-tenancy, etc.)
- Code style guidelines
- External services and APIs

### project/PROJECT_BRIEF.md
**Purpose:** High-level project goals, constraints, and acceptance criteria.

**When to edit:** At project start, and when scope changes.

**What to include:**
- Project goal (2-4 sentences)
- Technical constraints
- Data models and interfaces
- Acceptance criteria by phase
- Example scenarios

### docs/plans/
**Purpose:** Implementation plans for new features.

**Naming convention:** `[N].[feature_name]_plan.md`

### docs/standards/*.md
**Purpose:** Engineering standards and best practices.

**When to edit:** Rarely. Update if your team has specific conventions.

**Included handbooks:**
- 00 - Agent Protocols (workflow and autonomy mode)
- 10 - Architecture Principles (simplicity, observability, security)
- 20 - Quality Standards (testing, code review, documentation)
- 30 - Testing Standards (test types, coverage, patterns)
- 40 - Security & Privacy (auth, validation, secrets)
- 50 - DevEx & Tooling (CI/CD, local development)
- 60 - Docs & Decision Log (ADRs, runbooks, specs)
- 70 - Prompting & Context (how to work with Claude effectively)

### scripts/quality_gate.sh
**Purpose:** Automated quality checks that must pass before code is ready.

**When to edit:** When adding new quality tools or changing standards.

**What it checks:**
1. Lint (code style)
2. Typecheck (if applicable)
3. Unit tests
4. Integration tests
5. System/E2E tests
6. Security scan

---

## Workflow Examples

### Example 1: New Feature

```
You: I need to add user authentication

Claude:
[Reads PROJECT_BRIEF.md, ARCHITECTURE.md, handbooks]

QUESTIONS:
1. OAuth or email/password?
2. Session or JWT tokens?
3. Multi-factor auth required?

[You answer questions]

SPEC:
[Claude writes detailed spec using SPEC.md template]

ADR:
[Claude proposes architecture decision using ADR.md template]

[AWAITS YOUR APPROVAL]

You: Looks good! Autonomy Mode: ON

Claude:
[Iterates on implementation until quality_gate.sh passes]
✅ Feature complete! All tests passing.
```

### Example 2: Bug Fix

```
You: Fix the bug where uploads fail for large files

Claude:
[Reads codebase and docs]

QUESTIONS:
1. What's the current file size limit?
2. What error message do users see?

[You answer]

Claude:
[Proposes fix with ADR]

[AWAITS APPROVAL]

You: Approved. Autonomy Mode: ON

Claude:
[Implements fix, adds tests, passes quality gate]
✅ Bug fixed! Added regression test.
```

---

## Best Practices

### 1. Keep Documents Updated

- Update ARCHITECTURE.md when patterns change
- Update PROJECT_BRIEF.md when scope evolves
- Move completed features to "Completed" section in IMPLEMENTATION_PLAN.md

### 2. Review Claude's SPEC and ADR

- Don't skip the approval checkpoint
- Claude's proposals are starting points, not final decisions
- Ask questions if anything is unclear

### 3. Use Autonomy Mode Wisely

- ✅ **DO** use for well-defined features with approved specs
- ✅ **DO** use for bug fixes with clear reproduction steps
- ❌ **DON'T** use for exploratory work without requirements
- ❌ **DON'T** use when architecture decisions are still open

### 4. Maintain Quality Gates

- Keep quality_gate.sh fast (< 5 minutes ideal)
- Use `SKIP_SYSTEM_TESTS=true` during iteration
- Always run full gate before considering feature complete

### 5. Document Decisions

- Create ADRs for significant architectural choices
- Reference handbook sections in SPECs and ADRs
- Keep decision log in `project/DECISIONS/`

---

## Troubleshooting

### Claude ignores my ARCHITECTURE.md
**Solution:** Explicitly mention it in your message: "Read ARCHITECTURE.md first"

### Quality gate fails on first run
**Solution:** Customize Makefile targets for your project's actual commands

### Claude asks too many questions
**Solution:** Add more detail to PROJECT_BRIEF.md and ARCHITECTURE.md upfront

### Autonomy Mode doesn't iterate
**Solution:** Ensure quality_gate.sh is executable (`chmod +x scripts/quality_gate.sh`)

### Claude skips approval checkpoint
**Solution:** Remind Claude: "Follow the SDLC workflow from 00-Agent-Protocols.md"

---

## FAQ

**Q: Can I use this with non-Rails projects?**
A: Yes! Update Makefile and quality_gate.sh for your language/framework.

**Q: Do I have to use all the handbooks?**
A: No, but they provide good defaults. Remove sections that don't apply.

**Q: Can I modify the SDLC workflow?**
A: Yes, edit `docs/AI_CONTEXT.md` and `docs/standards/00-Agent-Protocols.md`.

**Q: How do I add custom quality checks?**
A: Add new Makefile targets and call them in quality_gate.sh.

**Q: What if my project doesn't need ADRs?**
A: You can skip ADRs for simple projects. Update `docs/AI_CONTEXT.md` workflow.

**Q: Can Claude generate PROJECT_BRIEF.md for me?**
A: Yes! Ask Claude to analyze your codebase and generate one.

---

## Support & Resources

- **Template Issues:** [GitHub Issues](https://github.com/your-template-repo/issues)
- **Claude Code Docs:** [https://docs.claude.com/claude-code](https://docs.claude.com/claude-code)
- **Examples:** See `examples/` directory (if you create one)

---

## License

[Your License Here - MIT recommended for templates]

---

## Contributing

Improvements welcome! See CONTRIBUTING.md for guidelines.

---



---

## Changelog

### v1.0.0 (2025-01-XX)
- Initial release
- Includes handbooks, templates, and quality gate
- Rails 8 example Makefile
- Complete SDLC workflow
- FGIO Parcel Data Import feature (Miami-Dade & Broward)

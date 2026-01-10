# 50 — DevEx & Tooling

## Stack (Rails 8 / Jumpstart Pro)
- Language: **Ruby 3.3+**
- Framework: **Rails 8**
- Package manager: Bundler
- Formatter/Linter: **Standard (standardrb)**
- Database: PostgreSQL
- JavaScript: Import Maps (no Node.js needed)
- CSS: TailwindCSS v4
- Testing: Minitest

## Commands
- `make setup` — install deps & setup database (`bin/setup`)
- `make lint` — Standard linting (`bundle exec standardrb`)
- `make lint:fix` — auto-fix lint issues (`bundle exec standardrb --fix`)
- `make check` — lint only (no type checking in Ruby)
- `make test` — runs unit, integration, system tests
- `make test:unit` — models, helpers, mailers
- `make test:integration` — controllers, integration tests
- `make test:acceptance` — system tests (Capybara)
- `make secscan` — Brakeman + bundler-audit
- `make run` — start development server (`bin/dev`)
- `bash scripts/quality_gate.sh` — full quality gate

## Development Server
- `bin/dev` — Runs Overmind/Foreman (Rails server + asset watching)
- `bin/rails server` — Rails server only (port 3000)

## Test Automation (Guard)
- `bundle exec guard` — Auto-runs relevant tests when files change (development only)
- Significantly speeds up TDD and autonomy mode iteration cycles
- See [project/docs/GUARD-USAGE.md](../../project/docs/GUARD-USAGE.md) for detailed workflow
- Only runs fast tests (unit/integration); use quality gate for full validation

## Git Workflow

**IMPORTANT: Always use feature branches. Never commit directly to `main`.**

### Before Starting Any Work
1. **Check current branch**: `git branch --show-current`
2. **If on `main`**, create a feature branch first:
   ```bash
   git checkout main
   git pull origin main
   git checkout -b feature/<short-descriptive-name>
   ```
3. **Never make changes directly on `main`** — feature branches protect against incomplete or broken changes

### Feature Development
1. **Create feature branch** before starting work
2. **All development** for the feature happens on this branch
3. **Commit incrementally** as you complete logical units of work
4. **Run tests** before considering work complete:
   ```bash
   bin/rails test  # or: make test
   ```
5. **After tests pass**, push and create PR:
   ```bash
   git push -u origin feature/<branch-name>
   gh pr create --title "Feature: description" --body "## Summary\n..."
   ```

### Branch Naming
- Features: `feature/<name>` (e.g., `feature/action-generation`)
- Bugfixes: `fix/<name>` (e.g., `fix/oauth-token-refresh`)
- Docs: `docs/<name>` (e.g., `docs/runbook-updates`)

### Quality Gates Before Merging
- [ ] All tests pass
- [ ] No linting errors
- [ ] Code reviewed (for significant changes)
- [ ] PR description includes summary and test plan

### Commit Messages
- Use present tense, imperative mood ("Add feature" not "Added feature")
- Keep first line under 72 characters
- Focus on *what* and *why*, not *how*

## CI
- `ci-claude.yml` runs the quality gate via GitHub Actions.
- Uses `ruby/setup-ruby` action with bundler caching.

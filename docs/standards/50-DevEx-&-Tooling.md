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

### Feature Development
1. **Create feature branch** before starting work:
   ```bash
   git checkout -b feature/<short-descriptive-name>
   ```
2. **All development** for the feature happens on this branch
3. **After review and approval**, commit and push:
   ```bash
   git add <new-and-changed-files>
   git commit -m "Short meaningful message describing the change"
   git push -u origin feature/<branch-name>
   ```

### Branch Naming
- Features: `feature/<name>` (e.g., `feature/action-generation`)
- Bugfixes: `fix/<name>` (e.g., `fix/oauth-token-refresh`)
- Docs: `docs/<name>` (e.g., `docs/runbook-updates`)

### Commit Messages
- Use present tense, imperative mood ("Add feature" not "Added feature")
- Keep first line under 72 characters
- Focus on *what* and *why*, not *how*

## CI
- `ci-claude.yml` runs the quality gate via GitHub Actions.
- Uses `ruby/setup-ruby` action with bundler caching.

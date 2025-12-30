# 30 — Testing Standards

## Test Pyramid
- **Unit:** Fast, deterministic. Mock side effects; assert behavior.
- **Integration:** Real adapters (DB/HTTP) via containers/sandboxes.
- **Acceptance (black-box):** Encodes `PROJECT_BRIEF` acceptance criteria.

## Coverage Targets
- Default: **80%** line coverage for changed/new code.

## Fixtures & Data
- Rails fixtures in `test/fixtures/` for test data.
- Tests independent & parallelizable (Minitest parallel execution enabled).
- Reset database state between tests automatically.

## Tooling (Rails 8 / Minitest)
- **Framework:** Minitest (Rails default)
- **Unit tests:** `test/models/`, `test/helpers/`, `test/mailers/`
- **Integration tests:** `test/controllers/`, `test/integration/`
- **System tests:** `test/system/` (Capybara + Selenium WebDriver)
- **Coverage:** SimpleCov (add to Gemfile if needed)
- **Mocking:** Minitest built-in mocks/stubs or Mocha gem

## Test Commands
- `bin/rails test` — run all tests
- `bin/rails test test/models` — unit tests
- `bin/rails test test/controllers` — controller tests
- `bin/rails test:system` — system/acceptance tests
- `bin/rails test path/to/test.rb:42` — run specific test by line

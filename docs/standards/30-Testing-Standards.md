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

## Browser Testing (Playwright)

When using Playwright for browser testing, test **complete user flows**, not just data operations.

### UX Verification Checklist
For every user action (form submit, button click, modal interaction):

1. **Modal state** — After submit: is modal closed? After cancel: is modal closed?
2. **Form state** — Is form reset? Are validation errors cleared?
3. **Visual feedback** — Toast/flash shown? Loading states resolved?
4. **Focus management** — Where is focus after action completes?
5. **Page state** — Is new data visible? Is deleted data gone?

### Testing Pattern
```python
# BAD: Only checks data succeeded
page.click('input[type="submit"]')
page.wait_for_load_state('networkidle')
assert page.locator('text="Item created"').count() > 0  # Toast appeared

# GOOD: Checks complete UX
page.click('input[type="submit"]')
page.wait_for_load_state('networkidle')
page.wait_for_timeout(300)  # Allow animations

# Verify toast
assert page.locator('text="Item created"').count() > 0

# Verify modal closed
assert page.locator('dialog[open]').count() == 0, "Modal should close after submit"

# Verify data appears in list
assert page.locator('text="New Item Name"').count() > 0
```

### Screenshot Strategy
Take screenshots at **UX-critical moments**, not just after waits:
- Immediately after form submit (before any wait)
- After modal should be closed
- After page navigation completes

**Actually review screenshots** during test development — don't just check that tests "pass".

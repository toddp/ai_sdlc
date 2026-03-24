# 30 — Testing Standards

## Test Pyramid
- **Unit:** Fast, deterministic. Mock side effects; assert behavior.
- **Integration:** Real adapters (DB/HTTP) via containers/sandboxes.
- **Acceptance (black-box):** Encodes `PROJECT_BRIEF` acceptance criteria.

## Server-Side Enforcement Rule (CRITICAL)

**Any business rule that restricts what a user can do MUST be tested at the model or service layer, regardless of whether the UI also enforces it.**

The UI (datepicker limits, disabled buttons, JavaScript validation) can be bypassed trivially by any user via browser DevTools, direct HTTP requests, or API calls. Do not rely on the UI as the sole enforcement point.

### When This Applies
A "business rule" includes any constraint on:
- **Time/date windows** (lead time minimums, booking cutoffs, blackout dates)
- **Quantities or amounts** (max items, price floors, capacity limits)
- **Status transitions** (can't submit without required fields, can't cancel after delivery)
- **Access/ownership** (can only edit your own records, admin-only actions)
- **Configuration-driven rules** (any rule that reads from a settings/config column)

### Required Tests
For each such rule, write tests that call the model or service **directly** — not through the controller or UI:

```ruby
# BAD: only tests that the UI blocks it
test "datepicker prevents past dates" do
  # ...HTML/JS test only...
end

# GOOD: tests that the model rejects it even without UI
test "order rejects submission when date is within lead time window" do
  @order.scheduled_date = 12.hours.from_now.to_date
  @order.status = :submitted
  assert_not @order.valid?
  assert_includes @order.errors[:scheduled_date], "must be at least 24 hours in advance"
end
```

### Checklist (add to spec's Testing section)
- [ ] List every UI constraint in the feature (datepicker min/max, disabled states, JS validation)
- [ ] For each: write a model/service test that confirms rejection *without* going through the UI
- [ ] Include the bypass scenario: "what if someone sends a direct HTTP request with an invalid value?"

## Invariant Tests

**Invariant tests verify that system-wide properties hold regardless of how data was created** — not just that a specific code path works. They're especially valuable for state machine constraints, multi-tenancy boundaries, and data integrity guarantees.

### When to Write Them
Write an invariant test for each invariant listed in the spec's **Invariants** section. They typically live alongside model or service tests.

### Pattern

```ruby
# Not: "test that this specific path succeeds"
# But: "test that this property holds no matter how we got here"

test "submitted orders always have scheduled_date at least min_lead_time in the future" do
  Order.where(status: :submitted).each do |order|
    lead_time = order.account.min_lead_time_hours.hours
    assert order.scheduled_date >= lead_time.ago,
      "Order #{order.id} violated lead time invariant"
  end
end

test "no record belongs to an account outside its tenant hierarchy" do
  # Adapt to your multi-tenancy model
  Order.includes(:account, :parent_account).each do |order|
    assert_equal order.parent_account, order.account.parent,
      "Order #{order.id} has mismatched tenant"
  end
end
```

### Good Candidates for Invariant Tests
- **State machine:** "records in status X always have field Y present"
- **Multi-tenancy:** "records for account A are never visible to account B"
- **Data integrity:** "no child record references a deleted parent"
- **Business rules:** "invoice totals always equal sum of line items"

## Coverage Targets
- Default: **80%** line coverage for changed/new code.

## Fixtures & Data
- Rails fixtures in `test/fixtures/` for test data.
- Tests independent & parallelizable (Minitest parallel execution enabled).
- Reset database state between tests automatically.

## Tooling (customize per project)
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

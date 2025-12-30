# Self-Review Checklist

Complete this checklist before requesting PR review or declaring a feature "done."

## Code Quality

- [ ] **Single Responsibility:** Each class/method does one thing well
- [ ] **DRY Principle:** No significant code duplication
- [ ] **Naming:** Variables, methods, classes have clear, descriptive names
- [ ] **Comments:** Code has YARD documentation for public methods
- [ ] **Complexity:** No overly complex methods (< 20 lines preferred)
- [ ] **Error Handling:** Appropriate rescue blocks with logging
- [ ] **Rails Conventions:** Follows Rails idioms and Jumpstart Pro patterns

## Performance

- [ ] **No N+1 Queries:** Database queries are optimized
- [ ] **Efficient Queries:** Using `pluck`, `select`, `includes` where appropriate
- [ ] **Background Jobs:** Long-running tasks queued (not blocking requests)
- [ ] **Caching:** Appropriate use of caching for expensive operations
- [ ] **Memory:** No obvious memory leaks or unbounded collections

## Security

- [ ] **No SQL Injection:** Using parameterized queries/ActiveRecord
- [ ] **No XSS:** User input properly escaped in views
- [ ] **Authorization:** Proper policy/scope checks (Pundit)
- [ ] **Authentication:** Routes protected with `authenticated` blocks
- [ ] **Secrets:** No credentials/API keys in code (use Rails credentials)
- [ ] **Input Validation:** User input validated before processing
- [ ] **Mass Assignment:** Strong parameters used in controllers

## Testing

- [ ] **Coverage:** ≥80% test coverage for new/changed code
- [ ] **Happy Path:** Success scenarios tested
- [ ] **Sad Path:** Error conditions tested
- [ ] **Edge Cases:** Boundary conditions tested
- [ ] **Integration:** Critical flows have integration tests
- [ ] **Test Quality:** Tests are readable, maintainable, independent

## Documentation

- [ ] **README:** Updated with new features/config requirements
- [ ] **RUNBOOK:** Updated with operational concerns (if applicable)
- [ ] **ADR:** Created for significant architectural decisions
- [ ] **Inline Docs:** YARD comments for public APIs
- [ ] **IMPLEMENTATION_PLAN:** Task marked complete with actual effort

## Browser/Manual Testing (if UI changes)

- [ ] **Browser Verification:** Playwright test created and passing
- [ ] **Screenshots:** Captured for visual confirmation
- [ ] **Responsive:** Works on mobile/tablet/desktop
- [ ] **Accessibility:** Keyboard navigation, ARIA labels (basic check)
- [ ] **Cross-browser:** Tested in Chrome (minimum)

## Quality Gates

- [ ] **Linting:** RuboCop passes with 0 violations
- [ ] **Tests:** All tests passing (unit + integration + system)
- [ ] **Security Scan:** Brakeman passes (or issues documented)
- [ ] **Quality Gate:** `scripts/quality_gate.sh` returns 0

## PR Readiness

- [ ] **Small PR:** < 400 LOC changed (split if larger)
- [ ] **Linked Issues:** SPEC/ADR linked in PR description
- [ ] **Acceptance Criteria:** All ACs met and documented
- [ ] **Commit Messages:** Clear, descriptive commit messages
- [ ] **Branch Clean:** Rebased on main, no merge conflicts

## Final Checklist

- [ ] I have reviewed my own code line-by-line
- [ ] I have manually tested the feature in development
- [ ] I have considered edge cases and error scenarios
- [ ] I have updated all relevant documentation
- [ ] This code is production-ready

---

**Reviewer Notes:**
(Add any specific concerns, tradeoffs, or decisions that reviewers should know)

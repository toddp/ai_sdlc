# 40 — Security & Privacy

## Data Classification (customize)
- Public / Internal / Confidential / Sensitive

## Threat Model Checklist
- Authn/Authz, least privilege
- Input validation & sanitization
- Secrets via env/vault; rotate regularly
- No secrets/PII in logs; correlation IDs
- Rate limiting & abuse controls on external endpoints
- Dependency SCA; pin versions; monitor CVEs
- **Client-side constraint bypass** — any rule enforced only in the UI (datepicker min dates, disabled buttons, JS validation) is trivially bypassed; see Client-Side Constraint Bypass section below

## Client-Side Constraint Bypass (CRITICAL)

**Any restriction shown in the UI must also be enforced on the server.**

The browser is untrusted. A user can:
- Open browser DevTools and modify form field values before submit
- Send a direct `curl` or Postman request with arbitrary values
- Replay a recorded HTTP request with modified parameters

### Common Bypassed Constraints
| UI Mechanism | What It Enforces | Server Must Also... |
|---|---|---|
| Datepicker `minDate` | Minimum booking date/time | Model `validate` the datetime is far enough in advance |
| Datepicker `disable` array | Blocked/holiday dates | Service returns `[]` for blocked dates; model rejects if blocked |
| `disabled` button/field | Feature toggle off | Controller/policy checks before processing |
| Dropdown limited options | Enum value set | Model `validates :field, inclusion:` |
| JS quantity cap | Max items | Model `validates :quantity, numericality:` |
| Date field `min` attribute | Minimum allowed date | Model validates date >= minimum |

### During Spec Review — Ask These Questions
1. "What happens if a user submits this form with DevTools to change a restricted value?"
2. "Is there a model validation that would reject this?" (If answer is no — add one.)
3. "Is there a service guard clause that would return early?" (If answer is no — add one.)
4. "Are there tests that call the model/service directly with the invalid value?" (If no — write them.)

See also: [§30 Server-Side Enforcement Rule](30-Testing-Standards.md) for the corresponding test requirement.

## SQL Injection Prevention (CRITICAL)

**ALWAYS use parameterized queries. NEVER use string interpolation in SQL.**

- Use `?` placeholders or hash conditions in ActiveRecord: `where("col = ?", val)` or `where(col: val)`
- Use `sanitize_sql_array` for raw SQL with dynamic values
- Use `connection.quote` for individual values in raw SQL
- NEVER use `#{}` interpolation or `+` concatenation in SQL strings
- PostGIS WKT strings must also be quoted with `connection.quote`

### SQL Code Review Checklist

Before merging any PR with SQL:
- [ ] All raw SQL uses `sanitize_sql_array` or `connection.quote`
- [ ] No string interpolation (`#{}`) in SQL strings
- [ ] No string concatenation (`+`) in SQL strings
- [ ] ActiveRecord query methods use `?` placeholders or hash conditions
- [ ] PostGIS WKT strings are quoted with `connection.quote`

## Pre-Commit Security Scanning

Before committing code changes, run Brakeman on changed Ruby files to catch security issues early:

```bash
# Scan only changed files (fast, targeted)
bundle exec brakeman --only-files $(git diff --name-only --diff-filter=d HEAD | grep '\.rb$' | tr '\n' ',') --no-summary --quiet

# Full scan (use for final validation or when quality gate runs)
make secscan
```

- Address any **critical** or **high** severity findings before committing.
- Medium/low findings should be reviewed but do not block commits.
- If a finding is a false positive, document it inline with `# brakeman:disable` and a justification comment.

## Secrets Policy
- Use `${VAR}` and document in RUNBOOK.
- Provide `.env.example` with placeholders.
- Never commit live secrets.

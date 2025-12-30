# 10 — Architecture Principles

- **Simplicity First:** Prefer boring tech, minimize moving parts.
- **Explicit Contracts:** Clear module boundaries; typed interfaces if available.
- **12-Factor:** Env config; stateless services; logs as streams.
- **Testable by Design:** Ports/adapters, DI seams, pure functions where feasible.
- **Observability:** Structured logs; minimal metrics; traces when needed.
- **Security Early:** Authn/authz, validation, least privilege, secure defaults.
- **Docs as Code:** README, RUNBOOK, ADRs in the repo.

## ADR Conventions
- Significant choices require an ADR in `docs/adrs/`.
- ADR lifecycle: Proposed → Accepted → Superseded → Rejected.

## Service Boundaries
- Keep business logic separate from I/O adapters.
- Favor composition over inheritance.

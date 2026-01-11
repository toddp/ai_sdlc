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

## Turbo Streams Response Checklist

When writing a Turbo Stream response for a form action, verify ALL UI state changes:

1. **Data display** — Is new/updated data appended/replaced in the list?
2. **Form reset** — Is the form cleared for the next entry?
3. **Modal/dialog** — If form was in a modal, is the modal closed?
4. **Flash/toast** — Is success/error feedback shown?
5. **Focus** — Where should focus go after the action?
6. **Loading states** — Are any loading indicators dismissed?
7. **Validation errors** — Are previous errors cleared on success?

Example for a create action with modal:
```erb
<%# 1. Add new item to list %>
<%= turbo_stream.append "items_list" do %>
  <%= render @item %>
<% end %>

<%# 2. Reset form %>
<%= turbo_stream.replace "item_form" do %>
  <%= render "form", item: Item.new %>
<% end %>

<%# 3. Close modal (via stimulus controller) %>
<%= turbo_stream.replace "modal_closer" do %>
  <div id="modal_closer" data-controller="modal-closer" ...></div>
<% end %>

<%# 4. Show toast %>
<%= turbo_stream.prepend "toasts" do %>
  <%= render ToastComponent.new(title: "Created") %>
<% end %>
```

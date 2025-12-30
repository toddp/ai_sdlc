# ARCHITECTURE.md

<!-- This file contains project-specific architecture details that Claude Code needs to know -->
<!-- Copy this to your project root and customize for your stack -->

## Overview

**Brief description of what this application does and its tech stack**

Jumpstart Pro Rails is a commercial multi-tenant SaaS starter application built with Rails 8. It provides subscription billing, team management, authentication, and modern Rails patterns for building subscription-based web applications.

**Current Project**: A predictive seller intent engine for real estate agents, focused on the South Florida region (Miami, Fort Lauderdale, West Palm Beach). The goal is to identify homeowners likely to list their property soon using publicly available data, enrichment APIs, and heuristic or ML-based scoring.


---

## Development Commands

**List the main commands developers need to know**

```bash
# Initial setup
bin/setup                    # Install dependencies and setup database

# Development server
bin/dev                      # Start development server with Overmind (includes Rails server, asset watching)
bin/rails server            # Standard Rails server only

# Database
bin/rails db:prepare         # Setup database (creates, migrates, seeds)
bin/rails db:migrate         # Run migrations
bin/rails db:seed           # Seed database

# Testing
bin/rails test              # Run test suite (Minitest)
bin/rails test:system       # Run system tests (Capybara + Selenium)

# Code quality
bin/rubocop                 # Run RuboCop linter (configured in .rubocop.yml)
bin/rubocop -a              # Auto-fix RuboCop issues
bin/brakeman                # Run security analysis
bin/bundler-audit           # Audit gems for security vulnerabilities

# Background jobs
bin/jobs                    # Start SolidQueue worker (if using SolidQueue)
bundle exec sidekiq         # Start Sidekiq worker (if using Sidekiq)
```

---

## Architecture

### Multi-tenancy System

**How multi-tenancy works in this application**

- **Account-based tenancy**: Users belong to Accounts (personal or team)
- **AccountUser model**: Join table managing user-account relationships with roles
- **Current account switching**: Users can switch between accounts via `switch_account(account)`
- **Authorization**: Pundit policies scope data by current account

### Modular Models

**Pattern for organizing model code**

Models use Ruby modules for organization:

```ruby
# app/models/user.rb
class User < ApplicationRecord
  include Accounts, Agreements, Authenticatable, Mentions, Notifiable, Searchable, Theme
end

# app/models/account.rb
class Account < ApplicationRecord
  include Billing, Domains, Transfer, Types
end
```

### Jumpstart Configuration System

**How feature flags and configuration work**

- **Dynamic configuration**: `config/jumpstart.yml` controls enabled features
- **Runtime gem loading**: `Gemfile.jumpstart` loads gems based on configuration
- **Feature toggles**: Payment processors, integrations, background jobs, etc.
- Access via `Jumpstart.config.payment_processors`, `Jumpstart.config.stripe?`, etc.

### Payment Architecture

**How payments are handled**

- **Pay gem (~11.0)**: Unified interface for multiple payment processors
- **Processor-agnostic**: Stripe, Paddle, Braintree, PayPal, Lemon Squeezy support
- **Per-seat billing**: Team accounts with usage-based pricing
- **Subscription management**: In `app/models/account/billing.rb`
- **Email delivery**: Mailgun, Mailpace, Postmark, and Resend use API gems instead of SMTP
- **API client errors**: Raise `UnprocessableContent` for 422 responses (rfc9110)

---

## Technology Stack

**Complete list of major technologies and versions**

- **Rails 8** with Hotwire (Turbo + Stimulus) and Hotwire Native
- **PostgreSQL** (primary), **SolidQueue** (jobs), **SolidCache** (cache), **SolidCable** (websockets)
- **Import Maps** for JavaScript (no Node.js dependency)
- **TailwindCSS v4** via tailwindcss-rails gem
- **Devise** for authentication with custom extensions
- **Pundit** for authorization
- **Minitest** for testing with parallel execution

---

## Testing

**Testing framework and conventions**

- **Minitest** with fixtures in `test/fixtures/`
- **System tests** use Capybara with Selenium WebDriver
- **Test parallelization** enabled via `parallelize(workers: :number_of_processors)`
- **WebMock** configured to disable external HTTP requests
- **Test database** reset between runs

---

## Routes Organization

**How routes are organized in this project**

Routes are modularized in `config/routes/`:
- `accounts.rb` - Account management, switching, invitations
- `billing.rb` - Subscription, payment, receipt routes
- `users.rb` - User profile, settings, authentication
- `api.rb` - API v1 endpoints with JWT authentication

---

## Key Directories

**Important directories and what they contain**

- `app/controllers/accounts/` - Account-scoped controllers
- `app/models/concerns/` - Shared model modules
- `app/policies/` - Pundit authorization policies
- `lib/jumpstart/` - Core Jumpstart engine and configuration
- `config/routes/` - Modular route definitions
- `app/components/` - View components for reusable UI

---

## Development Notes

**Important patterns and helpers**

- **Current account** available via `current_account` helper in controllers/views
- **Account switching** via `switch_account(account)` in tests
- **Billing features** conditionally loaded based on `Jumpstart.config.payments_enabled?`
- **Background jobs** configurable between SolidQueue and Sidekiq
- **Multi-database** setup with separate databases for cache, jobs, and cable

---

## Code Style Guidelines

### Service Objects

**How to write service objects in this project**

- Create in `app/services/` directory
- Name with verb + noun format ending with "Service" (e.g., `CreateUserService`)
- Use `class Service::ClassName` instead of nested modules
- Implement `run` method for main action
- Include YARD documentation
- Keep focused on single responsibility

### Testing Standards

**Testing conventions for this project**

- Use Minitest for all tests
- Use fixtures for test data
- Write descriptive test names with `test_` prefix
- Test both happy and sad paths
- Keep tests independent and idempotent
- Use `switch_account(account)` helper in integration tests

### Rails 8 Conventions

**Framework-specific patterns**

- Use Service Objects for complex business logic
- Use concerns for shared functionality
- Use `class Module::ClassName` instead of nested definitions
- Use positional arguments in enums
- Use `Rails.application.credentials` for secrets
- Pass models to jobs, not IDs
- Use `has_prefix_id` for models with UUIDs

---

## External Services

**Third-party integrations and APIs**

| Service | Purpose | Credentials | Documentation |
|---------|---------|-------------|---------------|
| Stripe | Payment processing | `STRIPE_PUBLISHABLE_KEY`, `STRIPE_SECRET_KEY` | [Stripe Docs](https://stripe.com/docs) |

---

## Environment Variables

**Required environment variables**

```bash
# Database
DATABASE_URL=postgresql://localhost/app_development

# Redis (for Sidekiq/SolidQueue/SolidCache)
REDIS_URL=redis://localhost:6379/0

# Google Cloud

# Payments (if enabled)
STRIPE_PUBLISHABLE_KEY=pk_test_...
STRIPE_SECRET_KEY=sk_test_...

# Email (if enabled)
MAILGUN_API_KEY=key-...
MAILGUN_DOMAIN=mg.yourdomain.com
```

---

## Deployment

**How this application is deployed**

- **Platform**: Heroku
- **Buildpacks**:
  - `heroku/ruby`
  - `heroku-community/chrome-for-testing` (for Ferrum web scraping)
  - `heroku-community/heroku-buildpack-ffmpeg` (for thumbnail extraction)
- **Addons**:
  - Heroku Postgres
  - Heroku Redis
- **Config Vars**: See Environment Variables section above

---

## Database Schema

**Key tables and relationships** (optional - useful for complex apps)

```ruby
# Users & Accounts (Multi-tenancy)
users: id, email, encrypted_password, ...
accounts: id, name, owner_id, ...
account_users: id, account_id, user_id, role, ...

# Application-Specific
```

---

## Background Job Architecture

**How async processing works**

- **Job Queue**: SolidQueue (Rails 8 default) or Sidekiq
- **Job Priority**: Default queue for most jobs, `critical` queue for user-facing operations
- **Retry Strategy**: 3 retries with exponential backoff
- **Timeout**: 10 minutes default, 30 minutes for video processing

**Key Jobs:**

---

## Monitoring & Observability

**How to monitor this application** (optional)

- **Logging**: Structured JSON logs via `Rails.logger`
- **Metrics**: (if applicable) StatsD/Datadog/NewRelic
- **Error Tracking**: (if applicable) Sentry/Rollbar/Honeybadger
- **APM**: (if applicable) Skylight/Scout/NewRelic

---

## Common Patterns

### Authorization Pattern

```ruby
# In controller
authorize @resource  # Pundit

# In policy
class ResourcePolicy < ApplicationPolicy
  def show?
    record.account == user.account
  end
end
```

### Service Object Pattern

```ruby
class ProcessThing
  def initialize(thing)
    @thing = thing
  end

  def call
    validate!
    process
    notify
  rescue => e
    handle_error(e)
  end

  private
  # implementation
end
```

### Background Job Pattern

```ruby
class ProcessThingJob < ApplicationJob
  queue_as :default

  def perform(thing)
    ProcessThing.new(thing).call
  end
end
```

---

## Troubleshooting

**Common issues and solutions**

### Issue: Tests failing in parallel
**Solution**: Check for shared state or temp file conflicts

### Issue: Background jobs not processing
**Solution**: Ensure Sidekiq/SolidQueue worker is running (`bin/jobs`)

### Issue: Asset not found in development
**Solution**: Restart server to rebuild import map

---

## Additional Resources

- [Jumpstart Pro Documentation](https://jumpstartrails.com/docs)
- [Rails 8 Guides](https://guides.rubyonrails.org/)
- [Team Wiki](https://your-wiki-url.com) (if applicable)
- [API Documentation](https://your-api-docs.com) (if applicable)

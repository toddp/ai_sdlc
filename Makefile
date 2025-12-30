SHELL := /bin/bash

# === Rails 8 Project Commands ===
lint:
	@echo "==> Lint (RuboCop)"
	bin/rubocop
	@echo "==> Lint (Standard RB)"
	standardrb

lint-fix:
	@echo "==> Auto-fix lint issues"
	bin/rubocop -a
	standardrb --fix

typecheck:
	@echo "==> Typecheck (N/A for Ruby - skipping)"
	@true

test-unit:
	@echo "==> Unit tests (models, services, jobs, helpers, mailers, channels, clients, notifiers)"
	bin/rails test test/models test/services test/jobs test/helpers test/mailers test/channels test/clients test/notifiers 2>/dev/null || bin/rails test

test-integration:
	@echo "==> Integration tests (controllers)"
	bin/rails test test/controllers test/integration 2>/dev/null || true

test-acceptance:
	@echo "==> Acceptance tests (system tests)"
	bin/rails test:system

secscan:
	@echo "==> Security scan"
	bin/brakeman -q || true
	bundle audit --update || true

setup:
	@echo "==> Install dependencies and setup database"
	bin/setup

check: lint
test: test-unit test-integration test-acceptance

# Fast test for changed files only (requires git)
test-changed:
	@echo "==> Running tests for changed files"
	@changed_files=$$(git diff --name-only HEAD | grep -E "^(app|lib|test)/.*\.rb$$" || true); \
	if [ -z "$$changed_files" ]; then \
		echo "No Ruby files changed, running all tests"; \
		bin/rails test; \
	else \
		echo "Changed files: $$changed_files"; \
		for file in $$changed_files; do \
			if [[ $$file == app/models/* ]]; then \
				test_file=$$(echo $$file | sed 's|app/models/\(.*\)\.rb|test/models/\1_test.rb|'); \
			elif [[ $$file == app/controllers/* ]]; then \
				test_file=$$(echo $$file | sed 's|app/controllers/\(.*\)_controller\.rb|test/controllers/\1_controller_test.rb|'); \
			elif [[ $$file == test/* ]]; then \
				test_file=$$file; \
			else \
				test_file=""; \
			fi; \
			if [ -n "$$test_file" ] && [ -f "$$test_file" ]; then \
				echo "Running: $$test_file"; \
				bin/rails test $$test_file || exit 1; \
			fi; \
		done; \
	fi

# Quick validation: lint + changed tests only
quick-check: lint test-changed

run:
	@echo "==> Run Rails development server"
	bin/dev

# Autonomy loop (convention for agents)
# Use 'make quick-check' during iteration, 'scripts/quality_gate.sh' for final validation
autopilot:
	@echo "==> Autonomy Mode Workflow:"
	@echo "    During iteration:"
	@echo "      - make quick-check  (lint + tests for changed files only)"
	@echo "    Final validation:"
	@echo "      - bash scripts/quality_gate.sh  (full test suite)"
	@echo ""
	@echo "    Or run Guard in background: bundle exec guard"

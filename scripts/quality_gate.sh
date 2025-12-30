#!/usr/bin/env bash
#
# Quality Gate Script
#
# This script runs all code quality checks that must pass before code is considered ready.
# Claude Code runs this in Autonomy Mode to verify implementations are complete.
#
# Usage:
#   bash scripts/quality_gate.sh                    # Run full quality gate
#   SKIP_SYSTEM_TESTS=true bash scripts/quality_gate.sh  # Skip slow system tests during iteration
#
# Exit codes:
#   0 - All checks passed
#   1 - One or more checks failed
#
# Customize this script for your project by updating the Makefile targets called below.

set -euo pipefail  # Exit on error, undefined variable, or pipe failure

# Configuration
# Allow skipping system tests during development iteration (they're slow)
# Always run full suite before declaring feature complete
SKIP_SYSTEM_TESTS="${SKIP_SYSTEM_TESTS:-false}"

echo "== Quality Gate (Rails 8) =="
echo ""

# Step 1: Lint - Check code style and formatting
# Ensures consistent code style across the project
# Customize: Update 'make lint' target in Makefile for your linting tools
echo "→ Lint (RuboCop)…"
make lint || exit 1

echo ""

# Step 2: Typecheck - Static type checking (if applicable)
# For Ruby: typically skipped (no built-in type checker)
# For TypeScript/Python: Run mypy, tsc, etc.
# Note: Using '|| true' means failure won't block the gate (optional check)
echo "→ Typecheck…"
make typecheck || true

echo ""

# Step 3: Unit Tests - Fast tests for individual components
# Tests models, services, jobs, helpers without external dependencies
# Customize: Update 'make test-unit' in Makefile to run your unit tests
echo "→ Unit tests…"
make test-unit || exit 1

echo ""

# Step 4: Integration Tests - Tests for component interactions
# Tests controllers, APIs, database interactions
# Customize: Update 'make test-integration' in Makefile
echo "→ Integration tests…"
make test-integration || exit 1

echo ""

# Step 5: System/Acceptance Tests - End-to-end browser tests
# Slowest tests, simulates real user interactions
# Can be skipped during iteration, but MUST run before completion
if [ "$SKIP_SYSTEM_TESTS" = "true" ]; then
  echo "→ System tests… SKIPPED (set SKIP_SYSTEM_TESTS=false to run)"
else
  echo "→ System tests…"
  make test-acceptance || exit 1
fi

echo ""

# Step 6: Security Scan - Check for known vulnerabilities
# Runs tools like Brakeman (Rails), bundler-audit, npm audit, etc.
# Customize: Update 'make secscan' in Makefile for your security tools
echo "→ Security scan…"
make secscan || exit 1

echo ""

# All checks passed!
echo "✅ QUALITY GATE: PASS"

# Reminder if system tests were skipped
if [ "$SKIP_SYSTEM_TESTS" = "true" ]; then
  echo ""
  echo "⚠️  Note: System tests were skipped. Run with SKIP_SYSTEM_TESTS=false for full validation."
fi

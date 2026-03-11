#!/usr/bin/env bash
# Validate an OpenAPI spec against Zalando rules.
# Usage: bash scripts/validate-spec.sh <path-to-spec.yaml>
#        bash scripts/validate-spec.sh --help
#
# Runs both Spectral (custom Zalando rules) and Redocly (general OAS checks).
# Requires: Node.js 18+, npx
#
# Exit codes:
#   0 — all checks passed (warnings are OK)
#   1 — Spectral or Redocly reported errors
#   2 — missing arguments or dependencies

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SPECTRAL_RULESET="$REPO_ROOT/validation/.spectral.yaml"

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" || -z "${1:-}" ]]; then
  cat <<'USAGE'
Usage: bash scripts/validate-spec.sh <path-to-spec.yaml>

Validates an OpenAPI 3.x specification against:
  1. Zalando custom rules (via Spectral)
  2. General OpenAPI checks (via Redocly)

Options:
  --help, -h    Show this help message

Examples:
  bash scripts/validate-spec.sh reference/golden-example.yaml
  bash scripts/validate-spec.sh my-api/openapi.yaml

Exit codes:
  0  All checks passed (warnings are OK)
  1  Spectral or Redocly reported errors
  2  Missing arguments or dependencies
USAGE
  exit 2
fi

SPEC_FILE="$1"

if [[ ! -f "$SPEC_FILE" ]]; then
  echo "Error: File not found: $SPEC_FILE" >&2
  exit 2
fi

if ! command -v npx &>/dev/null; then
  echo "Error: npx not found. Install Node.js 18+ to use this script." >&2
  exit 2
fi

ERRORS=0

echo "=== Spectral (Zalando rules) ==="
if npx @stoplight/spectral-cli lint "$SPEC_FILE" --ruleset "$SPECTRAL_RULESET" 2>&1; then
  echo "Spectral: PASSED"
else
  echo "Spectral: ERRORS FOUND" >&2
  ERRORS=1
fi

echo ""
echo "=== Redocly (general OAS) ==="
if npx @redocly/cli lint "$SPEC_FILE" 2>&1; then
  echo "Redocly: PASSED"
else
  echo "Redocly: ERRORS FOUND" >&2
  ERRORS=1
fi

echo ""
if [[ $ERRORS -eq 0 ]]; then
  echo "Result: ALL CHECKS PASSED"
else
  echo "Result: ERRORS DETECTED — fix and re-run" >&2
fi

exit $ERRORS

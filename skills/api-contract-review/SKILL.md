---
name: api-contract-review
description: >
  Use when reviewing or auditing an existing OpenAPI 3.1 specification for
  compliance with Zalando RESTful API Guidelines. Produces a structured checklist
  report (BLOCKER / WARNING / INFO severity) covering naming, security, HTTP usage,
  pagination, compatibility, and all other rule categories. Activate for API review,
  contract audit, or spec compliance checking tasks.
license: CC-BY-4.0 (derivative of Zalando RESTful API Guidelines by Zalando SE)
compatibility: Requires npx for Spectral/Redocly validation (Node.js 18+)
metadata:
  author: derived-from-zalando-se
  version: "1.0"
---

# API Contract Review

You are an API contract reviewer. Given an OpenAPI 3.1 specification, you
systematically check every applicable Zalando guideline rule and produce a
structured compliance report.

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| OpenAPI 3.1 YAML/JSON spec | Yes | The specification to review |
| x-audience context | No | Expected audience (external-public, external-partner, company-internal, component-internal) |
| Known exemptions | No | List of rule numbers the team has an approved exemption for |

## Severity Ratings

| Level | RFC 2119 | Meaning |
|-------|----------|---------|
| BLOCKER | MUST / MUST NOT | Specification is non-compliant; must be fixed before merge |
| WARNING | SHOULD / SHOULD NOT | Strong recommendation violated; document justification if skipped |
| INFO | MAY | Optional best practice; note for awareness |

## Review Checklist

Work through each section in order. For every check, emit one line:

- ✅ `PASS` — rule satisfied
- ❌ `FAIL (BLOCKER|WARNING|INFO)` — rule violated, with location and fix guidance
- ⬚ `N/A` — rule does not apply to this spec

---

### 1. Meta & General

| Check | Rule | Severity | What to verify |
|-------|------|----------|----------------|
| ✅/❌ OpenAPI 3.1 with info block | [#101], [#218] | BLOCKER | `openapi: "3.1.x"` present; `info.title`, `info.description`, `info.contact` populated |
| ✅/❌ Semantic version in info.version | [#116] | BLOCKER | `info.version` follows `MAJOR.MINOR.PATCH` semver |
| ✅/❌ x-api-id present | [#215] | BLOCKER | `info.x-api-id` is a valid UUID |
| ✅/❌ x-audience present | [#219] | BLOCKER | `info.x-audience` is one of: `external-public`, `external-partner`, `company-internal`, `component-internal` |
| ✅/❌ US English | [#103] | WARNING | All descriptions, summaries, and enum values use American English spelling |
| ✅/❌ Immutable remote refs | [#234] | BLOCKER | Any `$ref` pointing to a remote URL uses a version-pinned, immutable reference |
| ✅/❌ Published spec | [#192] | WARNING | Spec is stored in a discoverable location (API portal, repository) |

---

### 2. Security

| Check | Rule | Severity | What to verify |
|-------|------|----------|----------------|
| ✅/❌ All endpoints secured | [#104] | BLOCKER | Every operation has a `security` requirement or inherits a global one; no unprotected endpoints |
| ✅/❌ OAuth scopes defined | [#105] | BLOCKER | `securitySchemes` defines OAuth2 flows; scopes follow `<api-name>.<resource>.<access-mode>` naming |

---

### 3. Naming Conventions

| Check | Rule | Severity | What to verify |
|-------|------|----------|----------------|
| ✅/❌ snake_case properties | [#118] | BLOCKER | All schema property names use `snake_case` (no camelCase, no kebab-case) |
| ✅/❌ kebab-case paths | [#129] | BLOCKER | All path segments use `lowercase-kebab-case` |
| ✅/❌ snake_case query params | [#130] | BLOCKER | All query parameter names use `snake_case` |
| ✅/❌ Plural resource names | [#134] | WARNING | Collection resource path segments are plural nouns |
| ✅/❌ Verb-free URLs | [#141] | BLOCKER | No verbs in path segments; actions use HTTP methods or command resource pattern |
| ✅/❌ Domain-specific names | [#142] | WARNING | Property and resource names reflect the business domain, not generic terms |
| ✅/❌ UPPER_SNAKE_CASE enums | [#240] | WARNING | Enum values use `UPPER_SNAKE_CASE` unless representing domain literals |

---

### 4. Data Types & Formats

| Check | Rule | Severity | What to verify |
|-------|------|----------|----------------|
| ✅/❌ Number/integer format defined | [#171] | BLOCKER | Every `type: number` or `type: integer` has an explicit `format` (int32, int64, float, double, decimal) |
| ✅/❌ Date/time ISO 8601 | [#169] | BLOCKER | Date properties use `format: date` (RFC 3339 full-date) or `format: date-time` (RFC 3339 date-time with UTC offset) |
| ✅/❌ No null booleans | [#122] | BLOCKER | Boolean properties are required or have a default; never nullable |
| ✅/❌ No null empty arrays | [#124] | WARNING | Array properties return `[]` rather than `null` when empty |
| ✅/❌ Top-level JSON objects | [#110] | BLOCKER | All request and response bodies are JSON objects at the top level, never bare arrays or primitives |
| ✅/❌ Common money/address objects | [#173], [#249] | WARNING | Money amounts use a `Money` object with `amount` + `currency`; addresses follow standard structure |

---

### 5. HTTP Methods & Status Codes

| Check | Rule | Severity | What to verify |
|-------|------|----------|----------------|
| ✅/❌ Correct method usage | [#148] | BLOCKER | GET is safe/idempotent, PUT is idempotent full replace, PATCH is partial update, DELETE is idempotent, POST for creation/commands |
| ✅/❌ All responses specified | [#151] | BLOCKER | Every operation defines success and relevant error responses; no missing response codes |
| ✅/❌ Problem JSON for errors | [#176] | BLOCKER | All 4xx/5xx responses use `application/problem+json` (RFC 9457) with `type`, `title`, `status` |
| ✅/❌ No stack traces | [#177] | BLOCKER | Error response schemas do not include internal implementation details or stack traces |
| ✅/❌ Most specific status codes | [#220] | WARNING | Operations return the most specific status code (e.g., 201 for creation, 204 for no content, not just 200 everywhere) |

---

### 6. Pagination

| Check | Rule | Severity | What to verify |
|-------|------|----------|----------------|
| ✅/❌ Collections paginated | [#159] | BLOCKER | All list/collection endpoints support pagination via query parameters |
| ✅/❌ Cursor-based preferred | [#160] | WARNING | Large or frequently-updated collections use cursor-based pagination rather than offset-based |

---

### 7. Compatibility & Lifecycle

| Check | Rule | Severity | What to verify |
|-------|------|----------|----------------|
| ✅/❌ No breaking changes | [#106] | BLOCKER | If reviewing a diff: no removed endpoints, no removed required properties, no changed types |
| ✅/❌ REST maturity level 2 | [#162] | WARNING | API uses proper HTTP methods and status codes (Richardson maturity level 2+) |
| ✅/❌ Deprecated items marked | [#187] | WARNING | Any deprecated operations, parameters, or schemas have `deprecated: true` set |

---

## Review Procedure

```
START
│
├─ 1. Parse the OpenAPI spec
│     ├─ Valid YAML/JSON?  → if not, BLOCKER: spec is unparseable
│     └─ openapi: "3.1.x"? → if not, BLOCKER [#101]
│
├─ 2. Walk Meta & General checks (Section 1)
│     └─ For each check: emit ✅ PASS, ❌ FAIL (severity), or ⬚ N/A
│
├─ 3. Walk Security checks (Section 2)
│
├─ 4. Walk Naming checks (Section 3)
│     └─ Scan every path, parameter, property, and enum value
│
├─ 5. Walk Data checks (Section 4)
│     └─ Inspect every schema recursively
│
├─ 6. Walk HTTP checks (Section 5)
│     └─ Inspect every operation and response
│
├─ 7. Walk Pagination checks (Section 6)
│     └─ Identify collection endpoints (GET returning arrays)
│
├─ 8. Walk Compatibility checks (Section 7)
│     └─ If a previous version is provided, diff for breaking changes
│
└─ 9. Produce Report
```

## Output Format

```yaml
review:
  spec: "<filename or path>"
  date: "YYYY-MM-DD"
  summary:
    blockers: <count>
    warnings: <count>
    info: <count>
    pass: <count>
    not_applicable: <count>
  findings:
    - rule: "#NNN"
      check: "<check description>"
      result: "FAIL"
      severity: "BLOCKER | WARNING | INFO"
      location: "<JSON pointer or path in spec>"
      message: "<what is wrong>"
      fix: "<how to fix it>"
    # ... one entry per failing check
  passed:
    - rule: "#NNN"
      check: "<check description>"
    # ... one entry per passing check
  verdict: "APPROVED | CHANGES REQUESTED"
```

### Verdict Logic

```
if blockers > 0:
    verdict = "CHANGES REQUESTED"
else:
    verdict = "APPROVED"  # warnings are advisory
```

## Important Notes

- Every rule number `[#NNN]` in this skill maps to the Zalando RESTful API
  Guidelines rule catalog. Do not fabricate rule numbers.
- When a rule is not applicable (e.g., no collection endpoints to check
  pagination), mark it ⬚ N/A rather than ✅ PASS.
- If the spec includes `x-audience: component-internal`, some external-facing
  rules may be relaxed — note this in the report but still flag them as INFO.

---

*Derived from the [Zalando RESTful API Guidelines](https://opensource.zalando.com/restful-api-guidelines/) by Zalando SE, licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).*

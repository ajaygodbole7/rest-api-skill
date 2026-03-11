# Organization Customizations

> Use this file to document organization-specific overrides, extensions,
> or restrictions to the Zalando RESTful API Guidelines.
>
> Derived from [Zalando RESTful API Guidelines](https://opensource.zalando.com/restful-api-guidelines/) (CC-BY-4.0, Zalando SE).

## How to Use

1. Copy this file to your organization's repo or fork
2. Document your overrides in the tables below
3. Reference this file from your SKILL.md or CLAUDE.md instructions

## Rule Overrides

Override Zalando defaults where your organization has different standards.

| Rule | Default | Your Override | Rationale |
|------|---------|---------------|-----------|
| [#115] | MUST NOT use URL versioning | _e.g., Allow /v1/ prefix_ | _e.g., Legacy gateway requires it_ |
| [#160] | SHOULD prefer cursor-based pagination | _e.g., Allow offset-based_ | _e.g., Internal tooling needs random access_ |
| [#240] | SHOULD use UPPER_SNAKE_CASE enums | _e.g., Allow lowercase_ | _e.g., Existing enum convention_ |
| _add rows_ | | | |

## Sample Customization Patterns

- **Property naming [#118]** — Zalando mandates `snake_case`. If your org uses `camelCase`, override here and keep it consistent across your API surface.
  - Override [#118] in the Rule Overrides table
  - Change Spectral regex in `validation/.spectral.yaml` from `^[a-z][a-z0-9]*(_[a-z0-9]+)*$` to `^[a-z][a-zA-Z0-9]*$`

- **Prefixed IDs [#174]** — Type prefixes on identifiers (`ord_abc123`, `cus_xyz789`).
  - Define a prefix-to-resource mapping in `common-objects.yaml`
  - Update golden example to use prefixed IDs throughout

- **Error taxonomy [#176]** — Extend the Problem schema beyond RFC 9457.
  - Add fields to `common-objects.yaml`: `error_type` (e.g., `"validation_error"`), `error_code` (e.g., `"missing_field"`), `doc_url` (link to docs)
  - Update golden example error responses to include them

- **Expansion [#158]** — Inline related resources via query parameter.
  - Add `?expand[]=relationship_name` to GET endpoints
  - Mark expandable fields with `x-expandable: true` in schemas
  - Add examples to golden example

- **Metadata [#174]** — Freeform key-value object on every resource.
  - Add metadata schema to `common-objects.yaml`: `type: object`, `additionalProperties: string`, max 50 keys
  - Include on all resources in golden example

- **Idempotency [#229/#231]** — Define the full retry contract.
  - POST requests accept `Idempotency-Key` header (UUID)
  - Same key + same body = cached response (no re-execute)
  - Same key + different body = 422
  - Keys expire after 24 hours
  - Add to golden example POST endpoints

- **URL versioning [#115]** — Path versioning instead of media-type.
  - Override [#115] in the Rule Overrides table
  - Add `/v1` prefix to all paths in golden example
  - Remove `no-url-versioning` rule from `validation/.spectral.yaml`

## Additional Constraints

Add organization-specific rules not covered by the Zalando guidelines.

| ID | Constraint | Keyword | Rationale |
|----|-----------|---------|-----------|
| ORG-001 | _e.g., All APIs must include X-Request-ID header_ | MUST | _e.g., Distributed tracing requirement_ |
| _add rows_ | | | |

## Excluded Zalando-Internal Rules

The following rules are already excluded as Zalando-internal:

| Rule | Title | Rationale |
|------|-------|-----------|
| [#183] | Use only specified proprietary Zalando headers | Zalando-specific header registry |
| [#184] | Propagate proprietary headers | Zalando internal service mesh |
| [#223] | Use functional naming schema | Zalando API portal naming |
| [#224] | Follow naming convention for hostnames | Zalando DNS conventions |
| [#233] | Support X-Flow-ID | Zalando proprietary correlation ID |

Add any additional rules your organization chooses to exclude:

| Rule | Title | Rationale |
|------|-------|-----------|
| _add rows_ | | |

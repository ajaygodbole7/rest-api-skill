# Organization Customizations

> Use this file to document organization-specific overrides, extensions,
> or restrictions to the Zalando RESTful API Guidelines.
>
> Derived from [Zalando RESTful API Guidelines](https://opensource.zalando.com/restful-api-guidelines/) (CC-BY-4.0, Zalando SE).

## How to Use

1. Copy this file to your organization's repo or fork
2. Document your overrides in the sections below
3. Reference this file from your SKILL.md or CLAUDE.md instructions

## Sample Customization Patterns

- **Property naming [#118]** — Zalando mandates `snake_case`. If your org uses `camelCase`, override here and keep it consistent across your API surface.
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
  - Add `/v1` prefix to all paths in golden example
  - Remove `no-url-versioning` rule from `validation/.spectral.yaml`

- **Pagination [#160]** — Offset-based instead of cursor-based.
  - Use `offset`/`limit` query parameters instead of `cursor`/`limit`
  - Update golden example pagination responses accordingly

- **Enum casing [#240]** — Lowercase enums instead of `UPPER_SNAKE_CASE`.
  - Update Spectral `enum-upper-snake-case` rule or disable it
  - Update golden example enum values

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

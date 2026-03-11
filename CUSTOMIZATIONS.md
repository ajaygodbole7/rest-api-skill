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

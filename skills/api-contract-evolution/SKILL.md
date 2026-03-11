---
name: api-contract-evolution
description: >
  Use when evolving, versioning, or deprecating an existing OpenAPI 3.1 API
  contract. Guides backward-compatible extensions, breaking change assessment,
  media type versioning, deprecation lifecycle management, and event schema
  evolution per Zalando RESTful API Guidelines. Activate for tasks involving
  API versioning, deprecation planning, or contract migration.
license: CC-BY-4.0 (derivative of Zalando RESTful API Guidelines by Zalando SE)
compatibility: Requires npx for Spectral/Redocly validation (Node.js 18+)
metadata:
  author: derived-from-zalando-se
  version: "1.0"
---

# API Contract Evolution

You are an API evolution specialist. Given an existing OpenAPI 3.1 specification
and a set of requested changes, you determine the safest evolution path that
maintains backward compatibility per the Zalando guidelines.

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| Current OpenAPI 3.1 spec | Yes | The existing published API contract |
| Requested changes | Yes | New fields, removed fields, changed types, new endpoints, etc. |
| Consumer inventory | No | List of known clients and their usage patterns |
| Target timeline | No | Desired rollout date for the change |

## Phase 1: Compatibility Assessment

Before making any change, classify it.

### Decision Tree — Is This a Breaking Change?

```
START: Evaluate the proposed change
│
├─ Adding a new optional field to a response?
│   └─ NO — compatible extension [#107]
│
├─ Adding a new optional query parameter?
│   └─ NO — compatible extension [#107]
│
├─ Adding a new endpoint (path + method)?
│   └─ NO — compatible extension [#107]
│
├─ Adding a new enum value to an x-extensible-enum?
│   └─ NO — clients MUST use tolerant reader [#108], [#112]
│
├─ Adding a new required field to a request body?
│   └─ YES — breaks existing clients [#106]
│
├─ Removing a field from a response?
│   └─ YES — breaks clients depending on it [#106]
│
├─ Changing a field's type or format?
│   └─ YES — breaks clients [#106]
│
├─ Renaming a field or path?
│   └─ YES — breaks clients [#106]
│
├─ Narrowing validation (e.g., tighter regex, lower maxLength)?
│   └─ YES — breaks clients sending previously valid data [#106]
│
├─ Widening validation (e.g., broader regex, higher maxLength)?
│   └─ NO — existing data still valid [#107]
│
├─ Changing HTTP status codes?
│   └─ DEPENDS — adding new codes is safe if clients follow tolerant reader [#108];
│     removing or changing existing codes is breaking [#106]
│
├─ Removing an endpoint?
│   └─ YES — breaks clients [#106]; must follow deprecation lifecycle (Phase 4)
│
└─ Adding a new value to a closed enum (NOT x-extensible-enum)?
    └─ YES — breaks clients with strict validation [#106], [#112]
```

### Core Compatibility Rules

| Rule | ID | Requirement |
|------|----|-------------|
| Don't break backward compatibility | [#106] | MUST NOT introduce breaking changes to published APIs |
| Compatible extensions only | [#107] | MUST use only backward-compatible extensions for changes |
| Tolerant reader | [#108] | Clients MUST be prepared for compatible extensions (unknown fields, new enum values) |
| Treat API as distributed system | [#109] | MUST design for eventual consistency and partial failures |
| Top-level JSON objects | [#110] | MUST use top-level objects (not arrays) to allow future compatible extension |
| Open for extension | [#111] | MUST design schemas that can be extended without breaking |

---

## Phase 2: Extension Strategy

When the change is non-breaking, apply it as a compatible extension.

### Techniques

1. **Add optional response fields** [#107]
   - Add the new property to the schema
   - Do NOT make it required
   - Document it; existing clients will ignore it per tolerant reader [#108]

2. **Use x-extensible-enum** [#112]
   - For any enum that may grow, use `x-extensible-enum` instead of `enum`
   - Clients MUST handle unknown values gracefully [#108]
   - New values can be added without a breaking change
   ```yaml
   status:
     type: string
     x-extensible-enum:
       - ACTIVE
       - INACTIVE
       - ARCHIVED    # ← added safely
   ```

3. **Add new endpoints** [#107]
   - New paths and methods are always compatible
   - Follow all naming and design rules for the new endpoint

4. **Add optional request parameters** [#107]
   - New optional query parameters or optional body fields are safe
   - MUST NOT add new required request fields

5. **Widen constraints** [#107]
   - Increasing `maxLength`, broadening `pattern`, adding values to
     `x-extensible-enum` are all safe

### Extension Checklist

- ✅ New fields are optional (not required)
- ✅ New enum values use `x-extensible-enum` [#112]
- ✅ Response objects are top-level JSON objects [#110]
- ✅ Schemas are open for extension [#111]
- ✅ Change is documented in the spec's description or changelog
- ✅ `info.version` patch or minor version bumped [#116]

---

## Phase 3: Versioning (When Breaking Changes Are Unavoidable)

Versioning is a last resort. Exhaust all compatible extension options first.

### Versioning Rules

| Rule | ID | Requirement |
|------|----|-------------|
| Avoid versioning | [#113] | MUST avoid API versioning whenever possible; use extension and deprecation instead |
| Media type versioning | [#114] | If versioning is unavoidable, MUST use media type versioning (Accept header), not URL versioning |
| No URL versioning | [#115] | MUST NOT use URL path versioning (e.g., `/v1/`, `/v2/`) |
| Semantic versioning | [#116] | MUST use semantic versioning in `info.version` |

### Versioning Procedure

```
1. Confirm the change is truly breaking (re-check Phase 1 decision tree)
2. Explore alternatives:
   ├─ Can you add a new field instead of changing an existing one?
   ├─ Can you add a new endpoint instead of modifying the existing one?
   └─ Can you use x-extensible-enum instead of closed enum? [#112]
3. If still breaking:
   a. Bump info.version MAJOR component [#116]
   b. Use media type versioning via Accept/Content-Type headers [#114]
   c. Support the old version during a migration period
   d. Follow the deprecation lifecycle for the old version (Phase 4)
```

---

## Phase 4: Deprecation Lifecycle

When an endpoint, field, or entire API version must be retired, follow the
full deprecation workflow.

### Decision Tree — Deprecation Workflow

```
START: Decision to deprecate
│
├─ 1. Mark as deprecated in the spec [#187]
│     └─ Set `deprecated: true` on the operation, parameter, or schema
│
├─ 2. Obtain client approval [#185]
│     └─ For external-public / external-partner APIs:
│         notify all known consumers and obtain consent
│
├─ 3. Obtain partner consent [#186]
│     └─ For partner APIs: explicit written agreement from partners
│
├─ 4. Set Deprecation & Sunset headers [#189]
│     └─ Responses MUST include:
│         Deprecation: <date>          (RFC 8594)
│         Sunset: <date>               (RFC 8594)
│         Link: <migration-guide-url>  (optional, recommended)
│
├─ 5. Monitor usage [#188]
│     └─ Track call volume per consumer
│         ├─ If usage drops to zero → proceed to sunset
│         └─ If usage persists → extend timeline or escalate
│
├─ 6. Clients must monitor for deprecation [#190]
│     └─ Consuming agents SHOULD detect Deprecation/Sunset headers
│         and alert their teams
│
├─ 7. Don't use deprecated APIs [#191]
│     └─ Internal consumers MUST NOT build new integrations against
│         deprecated endpoints
│
├─ 8. Continue API usage monitoring [#193]
│     └─ Maintain monitoring through the full sunset period
│
└─ 9. Sunset
      └─ After the Sunset date: return 410 Gone, then remove the endpoint
```

### Deprecation Rules Reference

| Rule | ID | Severity | Requirement |
|------|----|----------|-------------|
| Mark deprecated in spec | [#187] | MUST | Set `deprecated: true` on all affected items |
| Obtain client approval | [#185] | MUST | Get agreement from external consumers before deprecating |
| Obtain partner consent | [#186] | MUST | Get explicit partner agreement for partner APIs |
| Monitor usage | [#188] | MUST | Track API usage throughout deprecation period |
| Deprecation/Sunset headers | [#189] | MUST | Include `Deprecation` and `Sunset` response headers |
| Clients monitor deprecation | [#190] | SHOULD | Consuming clients detect and react to deprecation headers |
| Don't use deprecated APIs | [#191] | MUST NOT | No new integrations against deprecated endpoints |
| API usage monitoring | [#193] | MUST | Maintain operational monitoring through sunset |

### Deprecation Spec Changes

```yaml
# Mark an operation as deprecated
paths:
  /orders/{order_id}/legacy-status:
    get:
      deprecated: true
      description: >
        **Deprecated** — use GET /orders/{order_id}/status instead.
        Sunset date: 2026-09-01.
      responses:
        "200":
          headers:
            Deprecation:
              schema:
                type: string
              example: "Sat, 01 Mar 2026 00:00:00 GMT"
            Sunset:
              schema:
                type: string
              example: "Mon, 01 Sep 2026 00:00:00 GMT"
```

---

## Phase 5: Event Evolution

When the API includes asynchronous event schemas (AsyncAPI or CloudEvents),
apply event-specific evolution rules.

### Event Compatibility Rules

| Rule | ID | Severity | Requirement |
|------|----|----------|-------------|
| Event backward compatibility | [#209] | MUST | Event schema changes MUST be backward compatible |
| Compatibility mode | [#245] | MUST | Event consumers MUST use a compatibility mode that tolerates extensions |
| Event schema versioning | [#246] | MUST | Event schemas MUST be versioned; consumers bind to a specific version |

### Event Evolution Procedure

```
1. Adding optional fields to event payload
   └─ Safe — consumers using tolerant reader will ignore unknown fields [#209], [#245]

2. Adding a new event type
   └─ Safe — consumers subscribe only to known types

3. Removing a field from an event payload
   └─ BREAKING — follow deprecation lifecycle (Phase 4) adapted for events

4. Changing field semantics or type
   └─ BREAKING — create a new event schema version [#246]

5. Version the event schema
   └─ Include schema version in the event metadata
   └─ Support parallel versions during migration [#246]
```

---

## Output Format

When you complete an evolution assessment, produce:

```yaml
evolution:
  spec: "<filename or path>"
  date: "YYYY-MM-DD"
  requested_changes:
    - description: "<what was requested>"
      breaking: true | false
      classification: "compatible-extension | breaking-change | deprecation"
      rules_applied:
        - "#NNN"
      action: "<what to do>"
  plan:
    phase: "extension | versioning | deprecation"
    steps:
      - step: 1
        action: "<specific change to the spec>"
        rule: "#NNN"
      # ...
    version_bump: "patch | minor | major"
    new_version: "X.Y.Z"
  warnings:
    - "<any risks or considerations>"
```

## Important Notes

- Every rule number `[#NNN]` in this skill maps to the Zalando RESTful API
  Guidelines rule catalog. Do not fabricate rule numbers.
- Always prefer compatible extensions over versioning [#113].
- Never skip the deprecation lifecycle — even for internal APIs [#187].
- Top-level JSON objects [#110] exist specifically to enable future compatible
  extension; enforcing this from day one prevents breaking changes later.

---

*Derived from the [Zalando RESTful API Guidelines](https://opensource.zalando.com/restful-api-guidelines/) by Zalando SE, licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).*

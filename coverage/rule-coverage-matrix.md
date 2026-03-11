# Rule Coverage Matrix

> Every Zalando rule mapped to the file(s) where it is referenced.
> Source: [Zalando RESTful API Guidelines](https://opensource.zalando.com/restful-api-guidelines/)
> License: CC-BY-4.0

## Legend

| Abbreviation | File |
|---|---|
| **GEN** | `skills/api-contract-generation/SKILL.md` |
| **GEN-naming** | `skills/api-contract-generation/reference/naming-conventions.md` |
| **GEN-http** | `skills/api-contract-generation/reference/http-methods-and-status-codes.md` |
| **GEN-data** | `skills/api-contract-generation/reference/data-formats-and-common-objects.md` |
| **GEN-pagination** | `skills/api-contract-generation/reference/pagination-and-filtering.md` |
| **GEN-compat** | `skills/api-contract-generation/reference/compatibility-and-versioning.md` |
| **GEN-hyper** | `skills/api-contract-generation/reference/hypermedia-and-performance.md` |
| **GEN-events** | `skills/api-contract-generation/reference/events.md` |
| **REV** | `skills/api-contract-review/SKILL.md` |
| **EVO** | `skills/api-contract-evolution/SKILL.md` |
| **CATALOG** | `rules/zalando-rules-catalog.yaml` |
| **GOLDEN** | `reference/golden-example.yaml` |
| **COMMON** | `reference/common-objects.yaml` |
| **SPECTRAL** | `validation/.spectral.yaml` |

## Coverage

| Rule | Title | Keyword | Target Files | Status |
|------|-------|---------|-------------|--------|
| [#100] | Follow API first principle | MUST | GEN, REV | ✅ |
| [#101] | Provide API specifications using OpenAPI | MUST | GEN, REV, GOLDEN | ✅ |
| [#102] | Provide API user manual | SHOULD | GEN | ✅ |
| [#103] | Write APIs using U.S. English | MUST | GEN, GEN-naming, REV | ✅ |
| [#104] | Secure endpoints | MUST | GEN, GEN-http, REV | ✅ |
| [#105] | Define and assign permissions (scopes) | MUST | GEN, GEN-http, GOLDEN | ✅ |
| [#106] | Not break backward compatibility | MUST | EVO, GEN-compat | ✅ |
| [#107] | Prefer compatible extensions | SHOULD | EVO, GEN-compat | ✅ |
| [#108] | Prepare clients to accept compatible API extensions | MUST | EVO, GEN-compat | ✅ |
| [#109] | Design APIs conservatively | SHOULD | EVO, GEN-compat | ✅ |
| [#110] | Always return JSON objects as top-level data structures | MUST | GEN, GEN-data, GOLDEN | ✅ |
| [#111] | Treat OpenAPI specification as open for extension by default | MUST | GEN-compat, EVO | ✅ |
| [#112] | Use open-ended list of values via examples for enumeration types | SHOULD | GEN-compat, GEN-data | ✅ |
| [#113] | Avoid versioning | SHOULD | EVO, GEN-compat | ✅ |
| [#114] | Use media type versioning | MUST | EVO, GEN-compat | ✅ |
| [#115] | Not use URL versioning | MUST | EVO, GEN-compat | ✅ |
| [#116] | Use semantic versioning | MUST | GEN, GOLDEN | ✅ |
| [#118] | Property names must be snake_case | MUST | GEN, GEN-naming, REV, SPECTRAL, GOLDEN | ✅ |
| [#120] | Pluralize array names | SHOULD | GEN-naming, GOLDEN | ✅ |
| [#122] | Not use null for boolean properties | MUST | GEN-data, REV | ✅ |
| [#123] | Use same semantics for null and absent properties | MUST | GEN-data | ✅ |
| [#124] | Not use null for empty arrays | SHOULD | GEN-data, REV | ✅ |
| [#127] | Use standard formats for time duration and interval properties | SHOULD | GEN-data | ✅ |
| [#129] | Use kebab-case for path segments | MUST | GEN, GEN-naming, REV, SPECTRAL, GOLDEN | ✅ |
| [#130] | Use snake_case for query parameters | MUST | GEN, GEN-naming, REV, SPECTRAL | ✅ |
| [#132] | Use kebab-case with uppercase separate words for HTTP headers | SHOULD | GEN-naming | ✅ |
| [#133] | Use standard headers | MAY | GEN-http | ✅ |
| [#134] | Pluralize resource names | MUST | GEN, GEN-naming, REV, SPECTRAL, GOLDEN | ✅ |
| [#135] | Not use /api as base path | SHOULD | GEN-naming, SPECTRAL | ✅ |
| [#136] | Use normalized paths without empty segments and trailing slashes | MUST | GEN-naming, SPECTRAL | ✅ |
| [#137] | Stick to conventional query parameters | MUST | GEN, GEN-pagination | ✅ |
| [#138] | Avoid actions — think about resources | MUST | GEN, REV | ✅ |
| [#139] | Model complete business processes | SHOULD | GEN | ✅ |
| [#140] | Define useful resources | SHOULD | GEN | ✅ |
| [#141] | Keep URLs verb-free | MUST | GEN, GEN-naming, REV, SPECTRAL | ✅ |
| [#142] | Use domain-specific resource names | MUST | GEN, GEN-naming | ✅ |
| [#143] | Identify resources and sub-resources via path segments | MUST | GEN, GEN-naming | ✅ |
| [#144] | Only use UUIDs if necessary | SHOULD | GEN-data | ✅ |
| [#145] | Consider using (non-) nested URLs | MAY | GEN-naming | ✅ |
| [#146] | Limit number of resource types | SHOULD | GEN, REV | ✅ |
| [#147] | Limit number of sub-resource levels | SHOULD | GEN-naming | ✅ |
| [#148] | Use HTTP methods correctly | MUST | GEN, GEN-http, GOLDEN | ✅ |
| [#149] | Fulfill common method properties | MUST | GEN-http | ✅ |
| [#150] | Only use most common HTTP status codes | SHOULD | GEN-http | ✅ |
| [#151] | Specify success and error responses | MUST | GEN, GEN-http, REV, GOLDEN | ✅ |
| [#152] | Use code 207 for batch or bulk requests | MUST | GEN-http | ✅ |
| [#153] | Use code 429 with headers for rate limits | MUST | GEN-http | ✅ |
| [#154] | Define collection format of header and query parameters | MUST | GEN-http | ✅ |
| [#155] | Reduce bandwidth needs and improve responsiveness | SHOULD | GEN-hyper | ✅ |
| [#156] | Use gzip compression | SHOULD | GEN-hyper | ✅ |
| [#157] | Support partial responses via filtering | SHOULD | GEN-hyper, GEN-pagination | ✅ |
| [#158] | Allow optional embedding of sub-resources | SHOULD | GEN-hyper, GEN-pagination | ✅ |
| [#159] | Support pagination | MUST | GEN, GEN-pagination, REV, GOLDEN | ✅ |
| [#160] | Prefer cursor-based pagination, avoid offset-based | SHOULD | GEN, GEN-pagination, GOLDEN | ✅ |
| [#161] | Use pagination links | SHOULD | GEN-pagination, GEN-hyper | ✅ |
| [#162] | Use REST maturity level 2 | MUST | GEN, REV | ✅ |
| [#163] | Use REST maturity level 3 — HATEOAS | MAY | GEN-hyper | ✅ |
| [#164] | Use common hypertext controls | MUST | GEN-hyper | ✅ |
| [#165] | Use simple hypertext controls for pagination and self-references | SHOULD | GEN-hyper, GEN-pagination | ✅ |
| [#166] | Not use link headers with JSON entities | MUST | GEN-hyper | ✅ |
| [#167] | Use JSON as payload data interchange format | MUST | GEN, GOLDEN | ✅ |
| [#168] | Pass non-JSON media types using data specific standard formats | MAY | GEN-data | ✅ |
| [#169] | Use standard formats for date and time properties | MUST | GEN-data, GOLDEN | ✅ |
| [#170] | Use standard formats for country, language and currency | MUST | GEN-data, COMMON | ✅ |
| [#171] | Define format for number and integer types | MUST | GEN-data, REV, SPECTRAL | ✅ |
| [#172] | Use standard media types | SHOULD | GEN-data | ✅ |
| [#173] | Use the common money object | MUST | GEN-data, COMMON, GOLDEN | ✅ |
| [#174] | Use common field names and semantics | MUST | GEN, GEN-naming, GOLDEN | ✅ |
| [#176] | Support problem JSON | MUST | GEN, GEN-http, GOLDEN, COMMON | ✅ |
| [#177] | Not expose stack traces | MUST | GEN-http, REV | ✅ |
| [#178] | Use Content-* headers correctly | MUST | GEN-http | ✅ |
| [#179] | Use Content-Location header | MAY | GEN-http | ✅ |
| [#180] | Use Location header instead of Content-Location header | SHOULD | GEN-http | ✅ |
| [#181] | Consider to support Prefer header | MAY | GEN-http | ✅ |
| [#182] | Consider to support ETag with If-Match/If-None-Match | MAY | GEN-http | ✅ |
| [#183] | Use only the specified proprietary Zalando headers | SHOULD | CATALOG | ⛔ Zalando-internal |
| [#184] | Propagate proprietary headers | MUST | CATALOG | ⛔ Zalando-internal |
| [#185] | Obtain approval of clients before API shut down | MUST | EVO | ✅ |
| [#186] | Collect external partner consent on deprecation time span | MUST | EVO | ✅ |
| [#187] | Reflect deprecation in API specifications | MUST | EVO, REV | ✅ |
| [#188] | Monitor usage of deprecated API scheduled for sunset | MUST | EVO | ✅ |
| [#189] | Add Deprecation and Sunset header to responses | SHOULD | EVO | ✅ |
| [#190] | Add monitoring for Deprecation and Sunset header | SHOULD | EVO | ✅ |
| [#191] | Not start using deprecated APIs | MUST | EVO | ✅ |
| [#192] | Publish OpenAPI specification for APIs | MUST | GEN, REV | ✅ |
| [#193] | Monitor API usage | SHOULD | EVO | ✅ |
| [#194] | Treat events as part of the service interface | MUST | GEN-events | ✅ |
| [#195] | Make event schema available for review | MUST | GEN-events | ✅ |
| [#196] | Ensure event schema conforms to OpenAPI schema object | MUST | GEN-events | ✅ |
| [#197] | Specify and register events as event types | MUST | GEN-events | ✅ |
| [#198] | Ensure that events conform to an event category | MUST | GEN-events | ✅ |
| [#199] | Ensure that events define useful business resources | MUST | GEN-events | ✅ |
| [#200] | Avoid writing sensitive data to events | SHOULD | GEN-events | ✅ |
| [#201] | Use general events to signal steps in business processes | MUST | GEN-events | ✅ |
| [#202] | Use data change events to signal mutations | MUST | GEN-events | ✅ |
| [#203] | Provide explicit event ordering for general events | SHOULD | GEN-events | ✅ |
| [#204] | Use the hash partition strategy for data change events | SHOULD | GEN-events | ✅ |
| [#205] | Ensure that data change events match the APIs resources | SHOULD | GEN-events | ✅ |
| [#207] | Indicate ownership of event types | MUST | GEN-events | ✅ |
| [#208] | Define events compliant with overall API guidelines | MUST | GEN-events | ✅ |
| [#209] | Maintain backwards compatibility for events | MUST | GEN-events, EVO | ✅ |
| [#210] | Avoid additionalProperties in event type schemas | SHOULD | GEN-events | ✅ |
| [#211] | Provide unique event identifiers | MUST | GEN-events | ✅ |
| [#212] | Design for idempotent out-of-order processing | SHOULD | GEN-events | ✅ |
| [#213] | Follow naming convention for event type names | MUST | GEN-events, GEN-naming | ✅ |
| [#214] | Be robust against duplicates when consuming events | MUST | GEN-events | ✅ |
| [#215] | Provide API identifiers | MUST | GEN, GOLDEN | ✅ |
| [#216] | Define maps using additionalProperties | SHOULD | GEN-data | ✅ |
| [#217] | Use full, absolute URI for resource identification | MUST | GEN-hyper | ✅ |
| [#218] | Contain API meta information | MUST | GEN, REV, GOLDEN | ✅ |
| [#219] | Provide API audience | MUST | GEN, GOLDEN | ✅ |
| [#220] | Use most specific HTTP status codes | MUST | GEN-http, REV | ✅ |
| [#223] | Use functional naming schema | MUST | CATALOG | ⛔ Zalando-internal |
| [#224] | Follow naming convention for hostnames | MUST | CATALOG | ⛔ Zalando-internal |
| [#225] | Follow naming convention for permissions (scopes) | MUST | GEN, GEN-http | ✅ |
| [#226] | Document implicit response filtering | MUST | GEN-http | ✅ |
| [#227] | Document cacheable GET, HEAD, and POST endpoints | MUST | GEN-hyper | ✅ |
| [#228] | Use URL-friendly resource identifiers | MUST | GEN-naming | ✅ |
| [#229] | Consider to design POST and PATCH idempotent | SHOULD | GEN-http | ✅ |
| [#230] | Consider to support Idempotency-Key header | MAY | GEN-http | ✅ |
| [#231] | Use secondary key for idempotent POST design | SHOULD | GEN-http | ✅ |
| [#233] | Support X-Flow-ID | MUST | CATALOG | ⛔ Zalando-internal |
| [#234] | Only use durable and immutable remote references | MUST | GEN, REV | ✅ |
| [#235] | Use naming convention for date/time properties | SHOULD | GEN-naming, GEN-data | ✅ |
| [#236] | Design simple query languages using query parameters | SHOULD | GEN-pagination | ✅ |
| [#237] | Design complex query languages using JSON | SHOULD | GEN-pagination | ✅ |
| [#238] | Use standard data formats | MUST | GEN-data | ✅ |
| [#240] | Declare enum values using UPPER_SNAKE_CASE string | SHOULD | GEN-naming, SPECTRAL | ✅ |
| [#241] | Expose compound keys as resource identifiers | MAY | GEN-naming | ✅ |
| [#242] | Provide explicit event ordering for data change events | MUST | GEN-events | ✅ |
| [#243] | Use official HTTP status codes | MUST | GEN-http | ✅ |
| [#244] | Use content negotiation | SHOULD | GEN-data | ✅ |
| [#245] | Carefully define the compatibility mode | MUST | GEN-events, EVO | ✅ |
| [#246] | Use semantic versioning of event type schemas | MUST | GEN-events, EVO | ✅ |
| [#247] | Provide mandatory event metadata | MUST | GEN-events | ✅ |
| [#248] | Use pagination response page object | SHOULD | GEN-pagination | ✅ |
| [#249] | Use the common address fields | MUST | GEN-data, COMMON | ✅ |
| [#250] | Be aware of services not fully supporting JSON/unicode | SHOULD | GEN-data | ✅ |
| [#251] | Not use redirection codes | SHOULD | GEN-http | ✅ |
| [#252] | Design single resource schema for reading and writing | SHOULD | GEN-data | ✅ |
| [#253] | Support asynchronous request processing | MAY | GEN-http | ✅ |
| [#254] | Avoid a total result count | SHOULD | GEN-pagination | ✅ |
| [#255] | Select appropriate date or date-time format | SHOULD | GEN-data | ✅ |

## Summary

- **Total rules:** 143
- **Applicable:** 138
- **Zalando-internal exclusions:** 5 (#183, #184, #223, #224, #233)
- **MUST:** 84 | **SHOULD:** 49 | **MAY:** 10
- **Coverage:** 100% — every rule is mapped to at least one file

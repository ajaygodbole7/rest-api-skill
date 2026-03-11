# Agent Skills

This repository contains AI agent skills for Zalando-compliant API contract design.

> Derived from [Zalando RESTful API Guidelines](https://opensource.zalando.com/restful-api-guidelines/) (CC-BY-4.0, Zalando SE).

## Available Skills

| Skill | Path | Purpose |
|-------|------|---------|
| [api-contract-generation](skills/api-contract-generation/SKILL.md) | `skills/api-contract-generation/` | Generate OpenAPI 3.1 contracts from requirements |
| [api-contract-review](skills/api-contract-review/SKILL.md) | `skills/api-contract-review/` | Review specs for Zalando guideline compliance |
| [api-contract-evolution](skills/api-contract-evolution/SKILL.md) | `skills/api-contract-evolution/` | Evolve APIs with backward compatibility |

## Reference Data

- [`rules/zalando-rules-catalog.yaml`](rules/zalando-rules-catalog.yaml) — Complete catalog of 143 Zalando rules
- [`reference/golden-example.yaml`](reference/golden-example.yaml) — Validated example OpenAPI 3.1 spec
- [`reference/common-objects.yaml`](reference/common-objects.yaml) — Reusable Money, Problem, Address schemas
- [`validation/.spectral.yaml`](validation/.spectral.yaml) — Automated Spectral rule checks
- [`coverage/rule-coverage-matrix.md`](coverage/rule-coverage-matrix.md) — Rule-to-file mapping

## Customization

See [CUSTOMIZATIONS.md](CUSTOMIZATIONS.md) for organization-specific overrides.

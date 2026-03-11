# Zalando RESTful API Guidelines — Agent Skills

This is a **derivative work** based on the [Zalando RESTful API Guidelines](https://github.com/zalando/restful-api-guidelines) by **Zalando SE**, reformatted into the [Agent Skills](https://agentskills.io) format for consumption by AI coding agents.

- **Original guidelines (rendered):** https://opensource.zalando.com/restful-api-guidelines/
- **Original repository:** https://github.com/zalando/restful-api-guidelines
- **Original author:** Zalando SE
- **License:** [CC-BY-4.0](LICENSE) (Creative Commons Attribution 4.0 International)

## Purpose

This repository packages the Zalando RESTful API Guidelines as AI agent skills for generating, reviewing, and evolving Zalando-compliant OpenAPI 3.1 contracts. The skills are designed to operate within an agentic SDLC pipeline, where an AI agent receives requirements upstream (user stories, domain models, plain English) and outputs complete OpenAPI 3.1 YAML consumed downstream (code generation, test generation, mocks, SDKs).

The rules catalog contains **143 rules** sourced from the Zalando guidelines. Of these, **138 are applicable** to general use and **5 are Zalando-internal** (excluded with documented rationale).

## Available Skills

| Skill | Description |
|-------|-------------|
| **[api-contract-generation](skills/api-contract-generation/SKILL.md)** | Generate compliant OpenAPI 3.1 specs from requirements. Accepts user stories, domain models, or plain English and produces a fully compliant contract with all Zalando rules applied as hard constraints. |
| **[api-contract-review](skills/api-contract-review/SKILL.md)** | Review existing OpenAPI specs for Zalando guideline compliance. Checks naming conventions, HTTP method usage, error handling, pagination, versioning, and all other rule categories. |
| **[api-contract-evolution](skills/api-contract-evolution/SKILL.md)** | Evolve APIs with backward compatibility. Guides adding fields, deprecating endpoints, and managing breaking vs. non-breaking changes per Zalando compatibility rules. |

## Project Structure

```
rest-api-skill/
├── AGENTS.md                           # Agent Skills entry point
├── README.md                           # This file
├── LICENSE                             # CC-BY-4.0 + derivative work header
├── CUSTOMIZATIONS.md                   # Template for org-specific overrides
├── skills/
│   ├── api-contract-generation/        # Primary skill
│   │   ├── SKILL.md
│   │   └── reference/                  # Deep reference per domain
│   ├── api-contract-review/
│   │   └── SKILL.md
│   └── api-contract-evolution/
│       └── SKILL.md
├── rules/
│   └── zalando-rules-catalog.yaml      # Every rule, structured YAML
├── reference/
│   ├── common-objects.yaml             # Money, Problem, Address schemas
│   └── golden-example.yaml             # Complete compliant spec
├── validation/
│   └── .spectral.yaml                  # Automatable rule checks
└── coverage/
    └── rule-coverage-matrix.md         # Every rule to file mapping
```

## Validation Commands

```bash
# Validate the golden example against Spectral rules
npx @stoplight/spectral-cli lint reference/golden-example.yaml --ruleset validation/.spectral.yaml

# Validate any generated spec
npx @redocly/cli lint <path-to-spec.yaml>

# Quick-check SKILL.md frontmatter (name + description present, name is kebab-case)
grep -A2 "^---" skills/*/SKILL.md
```

## Customization

Organizations can override or extend the Zalando rules for their own context. See [CUSTOMIZATIONS.md](CUSTOMIZATIONS.md) for a template covering rule overrides, additional constraints, and excluded rules.

## Attribution

This work is a derivative of the Zalando RESTful API Guidelines by Zalando SE, licensed under CC-BY-4.0. The original content has been restructured, compressed, and cross-referenced into the Agent Skills format. The underlying guidelines remain the intellectual property of Zalando SE.

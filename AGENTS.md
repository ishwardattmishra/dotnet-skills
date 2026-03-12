# AGENTS.md

This repo provides Cursor skills and rules for .NET development.

When adding/removing skills or rules, keep the router/index snippets up to date so downstream repos can copy/paste them.

Reference:
- `skills/skills-index-snippets/SKILL.md`

Maintenance:
1. Update skill or rule files directly (no central registry file)
2. Run `./scripts/validate-marketplace.sh`
3. Regenerate the compressed index: `./scripts/generate-skill-index-snippets.sh`

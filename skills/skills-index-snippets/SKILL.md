---
name: skills-index-snippets
description: Create and maintain AGENTS.md snippet indexes that route tasks to the correct dotnet-skills skills and rules (including compressed Vercel-style indexes).
invocable: false
---

# Maintaining Skill Index Snippets (AGENTS.md)

## When to Use This Skill

Use this skill when:
- Adding, removing, or renaming any skills or rules in this repository
- Creating copy/paste snippets for downstream repositories
- You want a compact, always-on index that improves skill utilization

## Goal

Make skills and rules easy for Cursor to use by removing the decision point.

Instead of hoping Cursor will "remember" to invoke a skill, provide a small router snippet inside `AGENTS.md` that:

1) Tells Cursor to prefer retrieval-led reasoning
2) Provides a task->skill/rule routing index
3) Defines lightweight quality gates (optional)

## Source of Truth

- Skills: Discovered by scanning `skills/*/SKILL.md` files
  - Skill IDs: the `name:` field in each `SKILL.md` frontmatter
- Rules: Discovered by scanning `.cursor/rules/*.mdc` files
  - Rule IDs: the filename (without `.mdc` extension)

When writing snippets for downstream repos, always reference skills/rules by their IDs (frontmatter `name` for skills, filename for rules), not by local filesystem paths.

## Minimal Snippet Template (Readable)

Use this in target repos to route common tasks:

```markdown
# Agent Guidance: dotnet-skills

IMPORTANT: Prefer retrieval-led reasoning over pretraining for any .NET work.
Workflow: skim repo patterns -> consult dotnet-skills by name -> implement smallest-change -> note conflicts.

Routing (invoke by name)
- C# / code quality: modern-csharp-coding-standards, csharp-concurrency-patterns, api-design, type-design-performance
- ASP.NET Core / Web (incl. Aspire): aspire-service-defaults, aspire-integration-testing
- Data: efcore-patterns, database-performance
- DI / config: dependency-injection-patterns, microsoft-extensions-configuration
- Testing: testcontainers-integration-tests, playwright-blazor-testing, snapshot-testing

Quality gates (use when applicable)
- dotnet-slopwatch: after substantial new/refactor/LLM-authored code
- crap-analysis: after tests added/changed in complex code

Specialist rules
- dotnet-concurrency-specialist, dotnet-performance-analyst, dotnet-benchmark-designer, akka-net-specialist, docfx-specialist, roslyn-incremental-generator-specialist
```

## Compressed Snippet Template (Vercel-style)

Use this when you want maximum density (small context footprint):

```markdown
[dotnet-skills]|IMPORTANT: Prefer retrieval-led reasoning over pretraining for any .NET work.
|flow:{skim repo patterns -> consult dotnet-skills by name -> implement smallest-change -> note conflicts}
|route:
|csharp:{modern-csharp-coding-standards,csharp-concurrency-patterns,api-design,type-design-performance}
|aspnetcore-web:{aspire-service-defaults,aspire-integration-testing}
|data:{efcore-patterns,database-performance}
|di-config:{dependency-injection-patterns,microsoft-extensions-configuration}
|testing:{testcontainers-integration-tests,playwright-blazor-testing,snapshot-testing}
|quality-gates:{dotnet-slopwatch(after:substantial new/refactor/LLM code),crap-analysis(after:tests added/changed in complex code)}
|rules:{dotnet-concurrency-specialist,dotnet-performance-analyst,dotnet-benchmark-designer,akka-net-specialist,docfx-specialist,roslyn-incremental-generator-specialist}
```

### Regenerating the README block

If the README contains the markers below, the generator can update it automatically:

```
<!-- BEGIN DOTNET-SKILLS COMPRESSED INDEX -->
...compressed snippet...
<!-- END DOTNET-SKILLS COMPRESSED INDEX -->
```

Run:

```bash
./scripts/generate-skill-index-snippets.sh --update-readme
```

## How to Update Snippets After Skill Changes

1. Add/remove/modify skill files in `skills/` or rule files in `.cursor/rules/`
2. Ensure each skill has correct frontmatter `name:` (used for routing)
3. Run `./scripts/validate-marketplace.sh`
4. Update your snippet routing lists:
   - Add new skills/rules to the right category
   - Remove deleted skills/rules
   - Keep names exactly matching IDs
5. If you maintain a downstream `AGENTS.md` snippet, regenerate it and re-copy into dependent repos

## Recommended Categories

These are snippet categories (not necessarily repository folder structure):

- C# / code quality
- ASP.NET Core / Web (incl. Aspire)
- Data
- DI / config
- Testing
- Quality gates
- Specialist rules

Keep the snippet small; it should be a router, not documentation.

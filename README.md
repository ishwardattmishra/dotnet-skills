# .NET Skills for Cursor

A comprehensive Cursor skills repository with **32 skills** and **6 specialist rules** for professional .NET development. Battle-tested patterns from production systems covering C#, Akka.NET, Aspire, EF Core, testing, and performance optimization.

## Installation

### Personal Skills (All Projects)

Copy skills to your personal Cursor skills directory:

```bash
# Clone the repository
git clone https://github.com/ishwardattmishra/dotnet-skills.git /tmp/dotnet-skills

# Copy skills to personal directory
mkdir -p ~/.cursor/skills
cp -r /tmp/dotnet-skills/skills/* ~/.cursor/skills/

# Optionally copy rules
mkdir -p ~/.cursor/rules
cp -r /tmp/dotnet-skills/.cursor/rules/* ~/.cursor/rules/
```

### Project-Level Skills

For project-specific use, copy skills to your project's `.cursor/skills/` directory:

```bash
# In your project root
git clone https://github.com/ishwardattmishra/dotnet-skills.git /tmp/dotnet-skills
mkdir -p .cursor/skills
cp -r /tmp/dotnet-skills/skills/* .cursor/skills/

# Optionally copy rules
mkdir -p .cursor/rules
cp -r /tmp/dotnet-skills/.cursor/rules/* .cursor/rules/
```

---

## Suggested AGENTS.md Snippet

Add this snippet to your project's `AGENTS.md` (in the root directory, next to your `.git` folder) to help Cursor route tasks to the right skills:

### Readable snippet (copy/paste)

```markdown
# Agent Guidance: dotnet-skills

IMPORTANT: Prefer retrieval-led reasoning over pretraining for any .NET work.
Workflow: skim repo patterns -> consult dotnet-skills by name -> implement smallest-change -> note conflicts.

Routing (invoke by name)
- C# / code quality: modern-csharp-coding-standards, csharp-concurrency-patterns, api-design, type-design-performance
- ASP.NET Core / Web (incl. Aspire): aspire-service-defaults, aspire-integration-testing, transactional-emails
- Data: efcore-patterns, database-performance
- DI / config: dependency-injection-patterns, microsoft-extensions-configuration
- Testing: testcontainers-integration-tests, playwright-blazor-testing, snapshot-testing

Quality gates (use when applicable)
- dotnet-slopwatch: after substantial new/refactor/LLM-authored code
- crap-analysis: after tests added/changed in complex code

Specialist rules
- dotnet-concurrency-specialist, dotnet-performance-analyst, dotnet-benchmark-designer, akka-net-specialist, docfx-specialist, roslyn-incremental-generator-specialist
```

### Compressed snippet (generated)

Run `./scripts/generate-skill-index-snippets.sh --update-readme` to refresh the block below.

<!-- BEGIN DOTNET-SKILLS COMPRESSED INDEX -->
```markdown
[dotnet-skills]|IMPORTANT: Prefer retrieval-led reasoning over pretraining for any .NET work.
|flow:{skim repo patterns -> consult dotnet-skills by name -> implement smallest-change -> note conflicts}
|route:
|akka:{akka-net-testing-patterns,akka-net-aspire-configuration,akka-net-management,akka-net-best-practices,akka-hosting-actor-patterns}
|csharp:{csharp-concurrency-patterns,modern-csharp-coding-standards,api-design,type-design-performance}
|aspnetcore-web:{mjml-email-templates,aspire-configuration,aspire-service-defaults,mailpit-integration,aspire-integration-testing}
|data:{database-performance,efcore-patterns}
|di-config:{dependency-injection-patterns,microsoft-extensions-configuration}
|testing:{snapshot-testing,playwright-ci-caching,verify-email-snapshots,testcontainers-integration-tests,playwright-blazor-testing}
|dotnet:{serialization,dotnet-project-structure,package-management,ilspy-decompile,dotnet-devcert-trust,dotnet-local-tools}
|quality-gates:{dotnet-slopwatch,crap-analysis}
|meta:{skills-index-snippets}
|rules:{akka-net-specialist,roslyn-incremental-generator-specialist,docfx-specialist,dotnet-performance-analyst,repo-guide,dotnet-benchmark-designer,dotnet-concurrency-specialist}
```
<!-- END DOTNET-SKILLS COMPRESSED INDEX -->

## Cursor Rules (Specialist Personas)

Rules are AI personas with deep domain expertise. They can be manually enabled in Cursor or set to `alwaysApply: true` for automatic activation.

| Rule                             | Expertise                                                              |
| -------------------------------- | ---------------------------------------------------------------------- |
| **akka-net-specialist**          | Actor systems, clustering, persistence, Akka.Streams, message patterns |
| **dotnet-concurrency-specialist**| Threading, async/await, race conditions, deadlock analysis             |
| **dotnet-benchmark-designer**    | BenchmarkDotNet setup, custom benchmarks, measurement strategies       |
| **dotnet-performance-analyst**   | Profiler analysis, benchmark interpretation, regression detection      |
| **docfx-specialist**             | DocFX builds, API documentation, markdown linting                      |
| **roslyn-incremental-generator-specialist** | Roslyn source generators, incremental pipelines, parser/emitter patterns |

---

## Skills Library

### Akka.NET

Production patterns for building distributed systems with Akka.NET.

| Skill                      | What You'll Learn                                                           |
| -------------------------- | --------------------------------------------------------------------------- |
| **best-practices**         | EventStream vs DistributedPubSub, supervision strategies, actor hierarchies |
| **testing-patterns**       | Akka.Hosting.TestKit, async assertions, TestProbe patterns                  |
| **hosting-actor-patterns** | Props factories, `IRequiredActor<T>`, DI scope management in actors         |
| **aspire-configuration**   | Akka.NET + .NET Aspire integration, HOCON with IConfiguration               |
| **management**             | Akka.Management, health checks, cluster bootstrap                           |

### C# Language

Modern C# patterns for clean, performant code.

| Skill                       | What You'll Learn                                                       |
| --------------------------- | ----------------------------------------------------------------------- |
| **coding-standards**        | Records, pattern matching, nullable types, value objects, no AutoMapper |
| **concurrency-patterns**    | When to use Task vs Channel vs lock vs actors                           |
| **api-design**              | Extend-only design, API/wire compatibility, versioning strategies       |
| **type-design-performance** | Sealed classes, readonly structs, static pure functions, Span&lt;T&gt;  |

### Data Access

Database patterns that scale.

| Skill                    | What You'll Learn                                               |
| ------------------------ | --------------------------------------------------------------- |
| **efcore-patterns**      | Entity configuration, migrations, query optimization            |
| **database-performance** | Read/write separation, N+1 prevention, AsNoTracking, row limits |

### .NET Aspire

Cloud-native application orchestration.

| Skill                   | What You'll Learn                                            |
| ----------------------- | ------------------------------------------------------------ |
| **integration-testing** | DistributedApplicationTestingBuilder, Aspire.Hosting.Testing |
| **service-defaults**    | OpenTelemetry, health checks, resilience, service discovery  |
| **mailpit-integration** | Email testing with Mailpit container, SMTP config, test assertions |

### ASP.NET Core

Web application patterns.

| Skill                    | What You'll Learn                                         |
| ------------------------ | --------------------------------------------------------- |
| **mjml-email-templates** | MJML syntax, responsive layouts, template renderer, composer pattern |

### .NET Ecosystem

Core .NET development practices.

| Skill                  | What You'll Learn                                                      |
| ---------------------- | ---------------------------------------------------------------------- |
| **project-structure**  | Solution layout, Directory.Build.props, layered architecture           |
| **package-management** | Central Package Management (CPM), shared version variables, dotnet CLI |
| **serialization**      | Protobuf, MessagePack, System.Text.Json source generators, AOT         |
| **local-tools**        | dotnet tool manifests, team-shared tooling                             |
| **slopwatch**          | Detect LLM-generated anti-patterns in your codebase                    |
| **devcert-trust**      | Install and trust development certificates for HTTPS                   |
| **ilspy-decompile**    | Decompile .NET assemblies with ILSpy                                   |

### Microsoft.Extensions

Dependency injection and configuration patterns.

| Skill                    | What You'll Learn                                                 |
| ------------------------ | ----------------------------------------------------------------- |
| **configuration**        | IOptions pattern, environment-specific config, secrets management |
| **dependency-injection** | IServiceCollection extensions, scope management, keyed services   |

### Testing

Comprehensive testing strategies.

| Skill                      | What You'll Learn                                             |
| -------------------------- | ------------------------------------------------------------- |
| **testcontainers**         | Docker-based integration tests, PostgreSQL, Redis, RabbitMQ   |
| **playwright-blazor**      | E2E testing for Blazor apps, page objects, async assertions   |
| **crap-analysis**          | CRAP scores, coverage thresholds, ReportGenerator integration |
| **snapshot-testing**       | Verify library, approval testing, API response validation     |
| **verify-email-snapshots** | Snapshot test email templates, catch rendering regressions    |
| **playwright-ci-caching**  | Cache Playwright browsers in CI/CD pipelines                  |

---

## Key Principles

These skills emphasize patterns that work in production:

- **Immutability by default** - Records, readonly structs, value objects
- **Type safety** - Nullable reference types, strongly-typed IDs
- **Composition over inheritance** - No abstract base classes, sealed by default
- **Performance-aware** - Span&lt;T&gt;, pooling, deferred enumeration
- **Testable** - DI everywhere, pure functions, explicit dependencies
- **No magic** - No AutoMapper, no reflection-heavy frameworks

---

## Repository Structure

```
dotnet-skills/
├── .cursor/rules/          # 6 specialist rules
│   ├── akka-net-specialist.mdc
│   ├── docfx-specialist.mdc
│   ├── dotnet-benchmark-designer.mdc
│   ├── dotnet-concurrency-specialist.mdc
│   ├── dotnet-performance-analyst.mdc
│   └── roslyn-incremental-generator-specialist.mdc
└── skills/                 # Flat structure (32 skills)
    ├── akka-best-practices/SKILL.md
    ├── akka-hosting-actor-patterns/SKILL.md
    ├── akka-aspire-configuration/SKILL.md
    ├── aspire-configuration/SKILL.md
    ├── aspire-integration-testing/SKILL.md
    ├── csharp-concurrency-patterns/SKILL.md
    ├── testcontainers/SKILL.md
    └── ...                 # (prefixed by category)
```

---

## Contributing

Want to add a skill or rule? PRs welcome!

1. Create `skills/<skill-name>/SKILL.md` (use prefixes like `akka-`, `aspire-`, `csharp-` for category)
2. Run `./scripts/validate-marketplace.sh` to verify
3. Run `./scripts/generate-skill-index-snippets.sh --update-readme` to update the index
4. Submit a PR

Skills should be comprehensive reference documents (10-40KB) with concrete examples and anti-patterns.

---

## Author & Contributors

**Original Author**: Created by [Aaron Stannard](https://aaronstannard.com/) ([@Aaronontheweb](https://github.com/Aaronontheweb))

Patterns drawn from production systems including [Akka.NET](https://getakka.net/), [Petabridge](https://petabridge.com/), and [Sdkbin](https://sdkbin.com/).

**Cursor Conversion**: Converted to Cursor skills format by [@ishwardattmishra](https://github.com/ishwardattmishra)

## License

MIT License - Copyright (c) 2025 Aaron Stannard

See [LICENSE](LICENSE) for full details.

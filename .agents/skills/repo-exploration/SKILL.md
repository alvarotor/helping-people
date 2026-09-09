---
name: repo-exploration
description: Explore an application or platform repository and produce an evidence-backed architecture, behavior, dependency, and verification map without modifying files.
---

# Repository Exploration

Use for discovery before planning or implementation.

1. Read the applicable `AGENTS.md` and `docs/foundation/WORKSPACE.md`.
2. Inventory source, tests, manifests, contracts, configuration, and deployment files with focused searches.
3. Trace the requested behavior from entry point through adapters, persistence, external services, and user-facing output.
4. Identify authoritative sources, duplicated assumptions, missing contracts, and relevant verification commands.
5. Report findings with file paths, evidence, open questions, risks, and a clear boundary around what was not inspected.

Default behavior is read-only. Do not edit, format, install dependencies, run destructive commands, or inspect secrets unless the user explicitly requests and authorizes it.

# Agent Roles

These role definitions describe responsibilities and boundaries. OpenCode adapters live in `.opencode/agents/`; Codex can use the same roles through explicit prompts and the portable skills in `.agents/skills/`.

## Roles

| Agent | Mode | Main responsibility | Default write authority |
|---|---|---|---|
| `explorer` | subagent | Read-only architecture and behavior map | none |
| `product-planner` | subagent | User journeys and acceptance criteria | proposals/docs only |
| `architect` | subagent | Boundaries, ownership, and decisions | proposals/docs only |
| `contract-designer` | subagent | OpenAPI, protobuf, JSON Schemas, compatibility | approved contract branch only |
| `ai-engineer` | subagent | Prompts, adapters, evaluations, provider behavior | approved application branch only |
| `platform-engineer` | subagent | Compose, deployment, observability, infrastructure | approved platform branch only |
| `test-reviewer` | subagent | Independent verification and regression review | none |
| `security-reviewer` | subagent | Security, privacy, abuse, and AI safety review | none |
| `release-reviewer` | subagent | Release evidence, rollback, and operational readiness | none |

Implementation roles may prepare isolated changes, but no role may merge its own work, approve its own proposal, deploy production, or modify production data.

## Handoff format

Every agent handoff should include:

- objective and OpenSpec change ID;
- repositories inspected or modified;
- files changed or proposed;
- decisions and assumptions;
- verification commands and results;
- unresolved risks and questions;
- recommended next owner.

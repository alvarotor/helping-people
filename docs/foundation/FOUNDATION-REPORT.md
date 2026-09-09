# HelpingPeopleNow Next — Foundation Report

Status: agreed foundation direction, before implementation
Date: 2026-09-10

## Purpose

This document records the decisions and working model agreed while planning a complete rebuild of HelpingPeopleNow. It is a durable briefing for future Codex and OpenCode sessions. It is a consolidated record of the conversation, not a raw transcript.

The existing HelpingPeopleNow codebase remains historical reference only. The rebuild uses a new workspace, new repositories, new infrastructure, and new data.

The following legacy material is explicitly excluded from the new system:

- the old `openspec/` directory;
- the old `email_sender/` directory;
- the old production/test server;
- the old database and fake users.

The legacy five repositories (`auth/`, `backend/`, `frontend/`, `helper/`, `infra/`) may be consulted for ideas, but no new implementation should depend on them by default.

## Product direction

HelpingPeopleNow is a simple, multilingual platform that helps people find trustworthy local tradespeople and handymen.

The primary experience should be simple enough for the user's mother to use:

1. Explain what help is needed in natural language.
2. Receive a short list of relevant nearby professionals.
3. Understand each professional easily.
4. Start a conversation on the platform.

Spain is the initial market. Spanish and English are required from the beginning. The domain should be ready for additional countries, languages, currencies, regions, and local service categories.

The product may change substantially from the existing site as long as this core idea remains easy and trustworthy.

## Identity and roles

A person is not permanently classified as a worker or client.

The domain is:

```text
User
├── optional ProfessionalProfile
├── ServiceRequests
├── Matches
├── ContactRequests
└── Conversations
```

Any user can:

- look for help;
- offer professional services;
- do both at the same time;
- use the platform as a client even when they are also a professional.

A plumber may offer plumbing services and search for a carpenter for their own home.

Professionals self-register. Professional onboarding should use a preview-and-publish flow:

```text
draft profile → review preview → explicit publish → public profile
```

Incomplete or AI-generated content must not become public automatically.

Initial contact is platform-first. Phone numbers and email addresses should not be exposed by default; any future sharing requires explicit consent and appropriate auditability.

## Initial product slice

The first meaningful vertical slice should be:

```text
Landing page
→ Spanish/English selection
→ magic-link login
→ describe a home-service need
→ receive suitable nearby professionals
→ open a simple professional profile
→ start a platform conversation
```

Professional onboarding follows closely:

```text
Create account
→ choose to offer services
→ describe profession and experience conversationally
→ preview profile
→ publish profile
→ receive contact requests
```

Do not build the complete admin system, sentiment analysis, complex messaging, or multiple LLM providers before this core journey is validated.

## Repository strategy

Use two new Git repositories inside a new workspace:

```text
HelpingPeopleNow-next/
├── helping-people/              # application repository
└── helping-people-platform/     # infrastructure repository
```

The application repository initially contains several independently deployable services in one monorepo:

```text
helping-people/
├── apps/
│   ├── web/                     # public frontend
│   ├── admin/                   # separate admin frontend
│   ├── api/                    # main application API
│   ├── auth/                   # authentication service
│   └── ai/                     # LLM and embedding adapter
├── packages/
│   └── contracts/              # OpenAPI, protobuf, schemas, generated clients
├── evals/                      # AI behavior and product evaluations
├── openspec/                   # system specifications and changes
├── .agents/skills/             # portable reusable skills
├── .opencode/agents/           # OpenCode-specific agent adapters
├── AGENTS.md
└── CODEOWNERS
```

The platform repository contains deployment and operations concerns:

```text
helping-people-platform/
├── compose/
├── observability/
├── deployment/
├── environments/
├── infrastructure/
└── AGENTS.md
```

Services and repositories are intentionally not one-to-one. A service is a runtime boundary; a repository is a development boundary. Services can later be extracted into separate repositories only when independent ownership, scaling, release cadence, or security isolation justifies the cost.

## Admin application

The admin UI should be a separate frontend application but initially live in the application monorepo:

```text
helpingpeople.cloud       → public application
admin.helpingpeople.cloud → admin application
api.helpingpeople.cloud   → backend API
```

The admin application must have:

- explicit backend authorization;
- separate deployment and security policy;
- audit logging for administrative actions;
- no reliance on hidden links or frontend-only access control;
- shared design-system components only where appropriate.

## OpenSpec ownership and workflow

OpenSpec will initially live in the application repository and serve as the system-level change record for both repositories.

```text
helping-people/openspec/
├── project.md
├── specs/
├── changes/
└── archive/
```

Platform changes are proposed in the application repository's OpenSpec area and implemented in the platform repository. This avoids duplicating system specifications at the beginning.

Examples:

```text
Application-only change:
  OpenSpec proposal → application PR

Platform-only change:
  OpenSpec proposal → platform PR

Cross-repository change:
  One OpenSpec change ID → application PR + platform PR
```

Every cross-repository PR references the same change ID, for example `CHG-0042`.

The lifecycle is:

```text
explore
→ classify
→ propose
→ human approval
→ implement
→ verify
→ human review
→ merge
→ optional explicit deployment
→ archive
```

OpenSpec is the governance and intent layer. OpenAPI, protobuf, database schemas, tests, and evaluation datasets are the machine-verifiable technical layers.

## Git and agent workflow

There is no implicit magic connecting sibling repositories. The relationship is explicit through:

- workspace-level documentation;
- repository `AGENTS.md` files;
- OpenSpec change IDs;
- shared contract artifacts;
- linked branches and pull requests;
- integration validation across both repositories.

Use one feature branch per approved change:

```text
change/CHG-0050-professional-publishing
```

For cross-repository work, use corresponding branches in both repositories and link their PRs.

Agents are proposal-only in the governance sense. They may:

- explore code and requirements;
- write plans and OpenSpec proposals;
- create isolated branches or worktrees;
- prepare code, tests, documentation, and patches;
- run verification;
- produce review reports.

Agents may not:

- merge their own changes;
- approve their own proposals;
- deploy production;
- modify production data;
- silently change a cross-service contract;
- commit secrets;
- perform destructive operations without explicit human approval.

The human owner approves architecture, proposals, merges, releases, and production operations.

## Agent and skill strategy

Do not create a large agent ecosystem before the first feature. Start with a small set:

- `explorer` — read-only investigation;
- `product-planner` — journeys and acceptance criteria;
- `architect` — boundaries and technical decisions;
- `spec-author` — OpenSpec proposals;
- `contract-designer` — OpenAPI, protobuf, schemas;
- `frontend-builder`;
- `backend-builder`;
- `ai-engineer`;
- `platform-engineer`;
- `test-reviewer`;
- `security-reviewer`;
- `release-reviewer`.

Portable skills should live in `.agents/skills/`. OpenCode-specific agent definitions may live in `.opencode/agents/`. Codex and OpenCode should share the same neutral project rules and skill procedures wherever possible.

The first skills should be:

- repository exploration;
- change classification;
- cross-repository change handling;
- OpenSpec proposal authoring;
- OpenAPI/protobuf contract design;
- database migration design;
- vertical-slice implementation;
- AI evaluation;
- security review;
- verification and release review.

## AI engineering strategy

Start with one primary hosted model provider and Ollama for local development. Keep a provider interface, but do not build a large production fallback chain initially.

AI outputs must be structured and schema-validated. Avoid fragile marker protocols such as `[FIELDS]...[/FIELDS]`.

Prompts should be canonical and versioned in Git. Runtime admin editing may be added through a controlled workflow:

```text
draft → evaluate → approve → publish → monitor → rollback
```

Every published prompt should have a version, author, provider/model, evaluation result, and rollback target.

The evaluation system must cover:

- profile extraction;
- multilingual Spanish/English behavior;
- search relevance;
- hallucination and missing information;
- unsafe or abusive input;
- provider failure behavior;
- latency and cost;
- regression between prompt/model versions.

## Deployment strategy

Start with Docker Compose on a cheap EC2-style Linux server.

Required from the beginning:

- separate local, development, staging, and production concepts even if initially only local and one server exist;
- health, liveness, readiness, logs, metrics, and backups;
- immutable images and explicit release records;
- migrations with rollback planning;
- explicit production approval;
- monitoring of CPU, memory, database capacity, request latency, AI latency, cost, and error rates.

Kubernetes is not an initial requirement. The project should keep a written migration-readiness record and measure the conditions that would justify Kubernetes: multiple replicas, independent scaling, zero-downtime rollout, workload isolation, or operational requirements that outweigh the added complexity.

## Work sequence

### Phase 0 — Foundation

- create the new workspace;
- create the two new repositories;
- write workspace and repository instructions;
- initialize OpenSpec in the application repository;
- define the domain vocabulary and ownership map;
- define agent permissions and review rules;
- scaffold Compose and CI without product features.

### Phase 1 — First vertical slice

- authentication;
- public web shell;
- API shell;
- one service request flow;
- one professional profile model;
- one search path;
- one platform conversation path;
- first AI evaluation dataset;
- local Compose verification.

### Phase 2 — Professional onboarding

- professional profile draft;
- AI-assisted intake;
- preview;
- explicit publish;
- public profile;
- profile editing.

### Phase 3 — Trust and operations

- contact request controls;
- reporting and blocking;
- admin application;
- audit logs;
- moderation workflows;
- operational dashboards.

### Phase 4 — Scale and intelligence

- improved matching;
- embeddings;
- provider experiments;
- background jobs;
- richer messaging;
- measured scaling decisions;
- Kubernetes evaluation only when justified by evidence.

## Immediate next step

The next action should be foundation scaffolding, not full feature development and not dozens of custom agents.

The complete execution checklist is maintained in [`REBUILD-ROADMAP.md`](./REBUILD-ROADMAP.md).

The first implementation task should create:

1. the two local Git repositories;
2. the workspace map;
3. the application `AGENTS.md`;
4. the platform `AGENTS.md`;
5. the initial OpenSpec configuration;
6. a small set of portable skills;
7. a few proposal-only agent definitions;
8. the first foundation OpenSpec change;
9. empty service directories and Compose validation;
10. a simple verification command for the workspace.

Only after that foundation is reviewed should we begin the login-to-search vertical slice.

## Decisions still open

- final product and repository names;
- initial hosted model provider;
- email delivery provider;
- exact first service categories;
- first development/staging hosting arrangement;
- whether platform messaging begins with simple inbox/thread functionality or a richer real-time system;
- exact local development command conventions.

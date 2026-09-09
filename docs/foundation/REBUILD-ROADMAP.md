# HelpingPeopleNow Next — Rebuild Roadmap

Status: Phase 9 complete locally; repositories public and pushed
Date: 2026-09-10

This is the execution checklist for rebuilding HelpingPeopleNow with proposal-driven AI engineering. Do not skip phases because later phases depend on the decisions and artifacts created earlier.

The old project is reference material only. The new project uses new repositories, new infrastructure, and new data.

## Operating rule

Every meaningful change follows:

```text
understand → classify → propose → human approve → implement → verify → review → merge → release
```

Agents may prepare proposals, branches, patches, tests, and reports. They do not approve, merge, deploy production, or perform destructive operations without explicit human approval.

## Phase 0 — Preserve the foundation decisions

### Purpose

Create durable project memory before creating code or agents.

### Work

- Review `FOUNDATION-REPORT.md`.
- Correct any product, repository, deployment, or agent-governance decisions that are inaccurate.
- Record new decisions in the report instead of relying on chat history.

### Deliverables

- Approved foundation report.
- List of open decisions.

### Approval gate

The human owner confirms that the product direction and engineering model are correct.

### Completion criteria

Future sessions can understand the project direction by reading the report alone.

## Phase 1 — Create the new workspace and repositories

### Purpose

Separate the rebuild from the legacy system and establish clean Git boundaries.

### Work

Create:

```text
HelpingPeopleNow-next/
├── WORKSPACE.md
├── helping-people/
└── helping-people-platform/
```

Initialize two independent Git repositories:

- `helping-people` for product code, contracts, evaluations, and OpenSpec;
- `helping-people-platform` for Compose, deployment, observability, and infrastructure.

Do not copy the old implementation into the new repositories. Copy only deliberately selected knowledge after review.

### Deliverables

- Two Git repositories.
- Initial `main` branches.
- Remote repository plan or remote repositories, if created.
- Workspace map.

### Approval gate

Confirm repository names, remotes, and whether the repositories should be public or private.

### Completion criteria

Both repositories can be cloned independently and their ownership boundaries are documented.

### Progress

Completed locally on 2026-09-10:

- created `helping-people/`;
- created `helping-people-platform/`;
- initialized independent Git repositories with `main` branches;
- added minimal repository READMEs;
- created initial commits;
- configured no remotes yet.

Pending human decisions:

- confirm final repository names;
- confirm GitHub organization and remotes;
- confirm public/private visibility;
- create or connect remote repositories.

## Phase 2 — Create workspace and repository instructions

### Purpose

Make Codex and OpenCode understand the relationship between the repositories.

### Work

Create `WORKSPACE.md` with:

- repository paths and remotes;
- application/platform ownership;
- cross-repository change rules;
- common commands;
- how to locate OpenSpec;
- how to validate both repositories.

Create application `AGENTS.md` with:

- product rules;
- application structure;
- service boundaries;
- contract rules;
- testing expectations;
- platform repository location.

Create platform `AGENTS.md` with:

- infrastructure ownership;
- Compose rules;
- environment and secret rules;
- deployment safety rules;
- application repository location.

Keep these files concise. Detailed procedures belong in skills and references.

### Deliverables

- `WORKSPACE.md`.
- `helping-people/AGENTS.md`.
- `helping-people-platform/AGENTS.md`.
- Initial `CODEOWNERS` plans.

### Approval gate

Confirm that an agent working in either repository can discover the other repository and knows when to inspect it.

### Completion criteria

A read-only exploration agent can map the workspace without relying on previous conversation context.

### Progress

Completed locally on 2026-09-10:

- created workspace-level `WORKSPACE.md`;
- created application `AGENTS.md`;
- created platform `AGENTS.md`;
- documented repository ownership and cross-repository inspection rules;
- documented OpenSpec location and Git workflow;
- documented agent permissions, contract rules, AI rules, security rules, and verification expectations.

Not yet committed. Changes will be reviewed and committed together when the foundation phase is complete.

## Phase 3 — Initialize OpenSpec

### Purpose

Create the specification and change-governance layer.

### Work

Initialize OpenSpec in `helping-people/` only.

Create and customize:

```text
helping-people/openspec/
├── config.yaml
├── project.md
├── specs/
├── changes/
└── archive/
```

Configure OpenSpec for Codex and OpenCode without making either tool the source of truth.

Write the project constitution covering:

- product mission;
- Spanish and English requirements;
- user/professional role model;
- preview-before-publish rule;
- platform-first contact;
- API and data ownership;
- no silent contract changes;
- proposal-only agents;
- production approval;
- testing and evaluation requirements.

### Deliverables

- Working OpenSpec configuration.
- Project constitution.
- Initial system specifications.
- Codex/OpenCode integrations or skills.

### Approval gate

Review the constitution before any product implementation proposal is accepted.

### Completion criteria

OpenSpec can create, validate, inspect, and archive a sample change without touching application code.

### Progress

Completed locally on 2026-09-10:

- moved the foundation report, roadmap, and workspace instructions into `docs/foundation/`;
- initialized OpenSpec 1.9.0 in the application repository;
- configured Codex and OpenCode integrations;
- generated OpenSpec skills and commands;
- added project context and artifact rules to `openspec/config.yaml`;
- added the HelpingPeopleNow OpenSpec constitution at `openspec/project.md`;
- ran `openspec doctor` successfully;
- ran `openspec validate --all --json` successfully with no changes or specs to validate yet.

Not yet committed. The foundation files will be reviewed and committed together later.

## Phase 4 — Establish the system model

### Purpose

Define the product and technical vocabulary before implementing features.

### Work

Document:

- user identity;
- optional professional profile;
- service requests;
- professional services and categories;
- location and geographic scope;
- matches;
- contact requests;
- conversations;
- publishing and moderation states;
- admin responsibilities;
- localization rules;
- consent and privacy boundaries.

Define data ownership by service. Decide which service owns each table, migration, write path, and public contract.

### Deliverables

- Domain glossary.
- Domain model.
- State-transition diagrams for profiles, requests, matches, and conversations.
- Data ownership map.
- Authorization matrix.

### Approval gate

Resolve ambiguous terms such as client, professional, request, match, contact, and published profile.

### Completion criteria

An agent can explain the product without using the old worker/client assumptions incorrectly.

### Progress

Completed locally on 2026-09-10:

- created `docs/domain/GLOSSARY.md`;
- created `docs/domain/MODEL.md`;
- created `docs/domain/LIFECYCLES.md`;
- created `docs/domain/DATA-OWNERSHIP.md`;
- created `docs/domain/AUTHORIZATION-MATRIX.md`;
- defined the user-centered role model;
- defined preview-before-publish professional profiles;
- defined service requests, matches, contact requests, conversations, and messages;
- defined initial lifecycle states and transitions;
- defined logical data ownership while allowing a shared PostgreSQL server;
- defined initial authorization actors and resource permissions;
- documented Spanish/English and future internationalization requirements.

Not yet committed. Domain documents require human review before becoming the basis for contracts and database design.

## Phase 5 — Define contracts and compatibility rules

### Purpose

Make service relationships machine-verifiable.

### Work

Create the initial contract layer:

```text
packages/contracts/
├── openapi/
├── proto/
├── schemas/
└── generated/
```

Define:

- public HTTP API;
- internal gRPC API, only where justified;
- error format;
- authentication and authorization requirements;
- health, liveness, and readiness behavior;
- localization fields;
- pagination and sorting;
- versioning and deprecation rules.

Prefer REST/OpenAPI for browser-facing APIs. Use gRPC only for internal interactions that benefit from it.

### Deliverables

- OpenAPI contract.
- Protobuf contract if needed.
- JSON schemas for structured AI outputs.
- Contract validation commands.
- Provider and consumer test strategy.

### Approval gate

No implementation begins for a cross-service feature until its contract is approved.

### Completion criteria

Contracts can be validated independently of the application implementation.

### Progress

Completed locally on 2026-09-10:

- created `packages/contracts/`;
- added application OpenAPI 3.1 contract;
- added authentication OpenAPI 3.1 contract;
- added versioned JSON Schemas for service requests, professional profiles, and structured AI responses;
- documented contract ownership and compatibility policy;
- defined the required backend-to-AI-adapter gRPC boundary in protobuf;
- documented that JSON Schemas remain the canonical semantic payload definitions while protobuf defines transport;
- added `tools/validate-contracts.sh` for JSON Schema and OpenAPI YAML syntax validation;
- validated all current JSON and YAML contract files successfully.

Not yet committed. Semantic OpenAPI validation, generated clients, and provider/consumer contract tests will be added with the implementation toolchain.

## Phase 6 — Design the AI quality system

### Purpose

Prevent LLM behavior from becoming untested product logic.

### Work

Create:

```text
evals/
├── datasets/
├── graders/
├── scenarios/
├── baselines/
└── README.md
```

Define evaluation cases for:

- Spanish conversations;
- English conversations;
- incomplete requests;
- ambiguous professions;
- unsafe or abusive content;
- profile extraction;
- professional search relevance;
- hallucination;
- provider errors;
- latency and cost.

Define prompt lifecycle:

```text
draft → evaluate → approve → publish → monitor → rollback
```

### Deliverables

- Initial evaluation dataset.
- Structured-output schemas.
- Grading criteria.
- Prompt versioning rules.
- Model/provider decision record.

### Approval gate

Agree on what “good enough” means for the first AI-powered journey.

### Completion criteria

An AI change can be compared against a baseline before release.

### Progress

Completed locally on 2026-09-10:

- created `evals/` structure for datasets, scenarios, graders, and baselines;
- added ten synthetic Spanish/English core scenarios;
- covered search, follow-up questions, profile extraction, safety, non-fabrication, dual-role users, and provider failure;
- added proposed scoring dimensions and initial release thresholds;
- defined critical failure rules;
- defined baseline metadata and comparison requirements;
- created initial prompt registry and prompt lifecycle documentation;
- added `tools/validate-evals.sh`;
- validated the dataset, rubric, prompt registry, contracts, and OpenSpec state successfully.

Not yet committed. Thresholds remain proposed until the first implementation and human review establish realistic baselines.

## Phase 7 — Create reusable skills and agents

### Purpose

Give agents repeatable procedures only after the project rules are stable.

### Work

Create initial portable skills:

- `repo-exploration`;
- `change-classification`;
- `cross-repository-change`;
- `openspec-proposal`;
- `contract-design`;
- `database-migration`;
- `vertical-slice`;
- `ai-evaluation`;
- `security-review`;
- `verification-review`;
- `release-review`.

Create initial agent definitions:

- `explorer`;
- `product-planner`;
- `architect`;
- `spec-author`;
- `contract-designer`;
- `frontend-builder`;
- `backend-builder`;
- `ai-engineer`;
- `platform-engineer`;
- `test-reviewer`;
- `security-reviewer`;
- `release-reviewer`.

Every agent definition must state:

- purpose;
- allowed repositories;
- allowed tools;
- whether it may edit files;
- required inputs;
- required outputs;
- verification responsibilities;
- forbidden actions.

### Deliverables

- Portable skills under `.agents/skills/`.
- OpenCode adapters under `.opencode/agents/`.
- Agent permission matrix.
- Example prompts and handoff format.

### Approval gate

Review agent permissions before allowing implementation agents to edit code.

### Completion criteria

An agent can produce a proposal and a verification report using only repository files and the current task.

### Progress

Completed locally on 2026-09-10:

- created eight portable skills under `.agents/skills/`;
- added repository exploration, change classification, cross-repository coordination, contract design, AI evaluation, vertical-slice, verification, and security workflows;
- created agent role documentation at `docs/agents/README.md`;
- created nine OpenCode subagent profiles under `.opencode/agents/`;
- kept implementation roles proposal-oriented and prohibited merge/deploy/self-approval behavior;
- validated all new skills with the Codex skill validator;
- validated OpenCode agent profile frontmatter.

Not yet committed. Agent permissions and workflows should be exercised against a realistic foundation proposal before being treated as stable.

## Phase 8 — Scaffold the application repository

### Purpose

Create the smallest runnable architecture without implementing product behavior.

### Work

Create empty or minimal services:

- public web frontend;
- admin frontend;
- API service;
- auth service;
- AI adapter;
- database integration;
- contracts package.

Add:

- Dockerfiles;
- local environment templates;
- Compose service definitions;
- health endpoints;
- structured logging;
- request IDs;
- basic error format;
- migration mechanism;
- CI checks.

### Deliverables

- Application repository builds.
- Services start locally.
- Compose healthchecks work.
- Contract validation works.
- CI runs without product features.

### Approval gate

Confirm the scaffold is understandable and not over-engineered.

### Completion criteria

A fresh checkout can run the skeleton with documented commands.

### Progress

Completed locally on 2026-09-10:

- created minimal public web and admin frontends using Preact + Vite;
- created a Go API service with health endpoints, JSON errors, structured logs, graceful shutdown, and Dockerfile;
- created a TypeScript auth service boundary with health endpoints and Dockerfile;
- created a Python gRPC AI adapter using the approved protobuf bindings, standard gRPC health, and an HTTP health sidecar;
- added tracked Dockerfiles, environment template, database ownership boundary, and scaffold verification script;
- verified contracts, evaluation fixtures, Go tests, Python syntax, and required scaffold files;
- verified the Go API starts and emits its startup log when run with the required permissions.

Known boundary: service dependencies are deliberately not implemented yet. PostgreSQL, Compose, migrations, CI, and production wiring belong to Phase 9 in the platform repository; business behavior is introduced only through OpenSpec changes.

## Phase 9 — Scaffold the platform repository

### Purpose

Make local and future cloud deployment reproducible.

### Work

Create:

- local Compose configuration;
- development environment templates;
- secrets handling rules;
- reverse proxy configuration;
- database service;
- observability foundation;
- backup and restore documentation;
- deployment scripts;
- image tagging and promotion rules.

Keep production and development configuration separate. Never commit live credentials.

### Deliverables

- Local stack definition.
- Platform validation command.
- Health and smoke-check command.
- Deployment plan.
- Rollback plan.

### Approval gate

No production infrastructure is created until the deployment and rollback plans are reviewed.

### Completion criteria

The platform can run the application skeleton locally and can be validated without production access.

### Progress

Completed locally on 2026-09-10:

- created platform Docker Compose with gateway, public web, admin, API, auth, AI, and PostgreSQL services;
- added environment template and ignore rules for local secrets;
- added nginx routing for web, admin, API, and auth paths with request ID forwarding;
- added service healthchecks and Compose dependency conditions;
- added platform verification script and local startup documentation;
- built all application images successfully from the platform repository;
- started the complete stack and verified all seven containers became healthy;
- verified the gateway health endpoint returned `{"status":"ok"}`;
- corrected the generated gRPC dependency and AI healthcheck compatibility issues found during the smoke test;
- committed and pushed both repositories as public repositories under `alvarotor`.

Follow-up work remains for production TLS, immutable image publishing, CI/CD, backups, observability, EC2 deployment, and Kubernetes readiness measurements.

## Phase 10 — Implement the first vertical slice

### Purpose

Validate the full architecture with one valuable user journey.

### Work

Implement:

- Spanish/English shell;
- magic-link authentication;
- user identity;
- service request creation;
- professional profile read model;
- simple professional matching;
- public professional profile;
- platform conversation creation;
- first AI evaluation scenarios;
- end-to-end test.

Do not add every old feature. Prefer a small complete journey over many disconnected screens.

### Deliverables

- Working local user journey.
- API and UI contract tests.
- End-to-end test.
- AI evaluation report.
- Accessibility and security review.

### Approval gate

Human review of the user experience and product usefulness.

### Completion criteria

A non-technical user can complete the journey without developer assistance.

## Phase 11 — Add professional onboarding

### Purpose

Allow professionals to self-register and publish trustworthy profiles.

### Work

Implement:

- professional profile draft;
- AI-assisted intake;
- structured field validation;
- preview page;
- explicit publish action;
- edit/unpublish flow;
- public profile quality rules.

### Deliverables

- Draft and published profile states.
- Preview-and-publish workflow.
- Profile evaluation cases.
- Tests for incomplete and malformed AI output.

### Approval gate

Confirm that no incomplete or unintended profile becomes public.

### Completion criteria

A professional can create, review, publish, edit, and unpublish a profile safely.

## Phase 12 — Add trust, admin, and moderation

### Purpose

Make the platform operable and safer before public exposure.

### Work

Implement:

- separate admin frontend;
- admin authorization;
- audit log;
- profile moderation;
- report and block flows;
- contact-request controls;
- abuse handling;
- feedback collection;
- operational dashboards.

### Deliverables

- Admin application.
- Authorization matrix tests.
- Audit log.
- Moderation workflows.
- Security review.

### Approval gate

Review privacy, abuse, and administrative access risks.

### Completion criteria

The system can be operated without direct database editing for normal administrative tasks.

## Phase 13 — Staging and controlled deployment

### Purpose

Prove that the system can be deployed and recovered safely.

### Work

Create separate environments:

- local;
- development;
- staging;
- production.

Add:

- immutable image promotion;
- migration checks;
- smoke tests;
- backups;
- restore test;
- monitoring and alert verification;
- rollback procedure;
- release record.

### Deliverables

- Staging deployment.
- Release checklist.
- Backup/restore evidence.
- Rollback evidence.
- Incident runbook.

### Approval gate

Explicit approval before any real public launch.

### Completion criteria

The same build artifact can move from development to staging and production with controlled configuration changes.

## Phase 14 — Measured evolution

### Purpose

Add complexity only when product or operational evidence requires it.

### Work

Measure:

- active users;
- request volume;
- database capacity;
- AI latency and cost;
- error rates;
- deployment frequency;
- recovery time;
- operator workload;
- messaging and search load.

Only then consider:

- additional AI providers;
- embeddings and advanced ranking;
- background job infrastructure;
- service extraction into separate repositories;
- multiple application replicas;
- Kubernetes.

### Deliverables

- Quarterly architecture review.
- Scaling decision records.
- Updated migration-readiness assessment.

### Completion criteria

Every added system component has a measured problem, an owner, a rollback path, and an operational cost estimate.

## Current next action

Begin Phase 1 only after reviewing this roadmap and confirming:

- the two repository names;
- whether remotes should be created now or later;
- whether the new workspace should be a private GitHub project;
- the preferred initial hosted AI provider.

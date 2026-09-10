# Feature Delivery Workflow

The standard workflow for taking a feature from an idea to production is:

```text
idea → exploration → OpenSpec proposal → design and contracts → human approval
→ implementation → verification → review → staging → production approval
→ deploy → observe → archive
```

The application repository owns product behavior, services, contracts, evaluations, and OpenSpec. The platform repository owns Compose, routing, environments, deployment, observability, and infrastructure. A cross-repository change uses one OpenSpec change ID and may produce one PR in each repository.

## 1. Describe the user need

Start with the user outcome, not a technical solution. Clarify who can use the feature, what they can see and change, authorization, failure behavior, languages, privacy, and existing-data implications.

Example: users need editable profiles with a name, photo, languages, location, description, and services; administrators need to review, moderate, and audit profiles.

Do not code while important product behavior remains unknown.

## 2. Explore the system

Open Codex or OpenCode from `helping-people/`. The exploration agent reads both repositories when needed and reports affected services, contracts, authorization, database work, AI involvement, tests, observability, deployment risks, and unknowns. Exploration does not modify production code.

## 3. Create one OpenSpec change

Run from the application repository:

```bash
cd helping-people
openspec new change user-profiles
```

Or use OpenCode:

```text
/opsx-propose Add editable user profiles for clients and professionals
```

The change contains planning artifacts such as `proposal.md`, `specs/`, `design.md`, and `tasks.md`. It identifies every affected service and repository. Platform-only and cross-repository changes are proposed in the application repository and implemented in the appropriate repository.

## 4. Specify behavior before implementation

Define observable behavior, permissions, validation, errors, compatibility, Spanish and English behavior, and lifecycle states. For profiles, specify ownership, public visibility, editing, admin review, suspension, audit history, and what anonymous visitors may see.

The API, frontend, admin application, and AI adapter must not invent conflicting interpretations.

## 5. Design the complete change

Cover every affected boundary.

### Data

Define tables, ownership, keys, indexes, uniqueness, nullable fields, timestamps, moderation state, audit history, and migration compatibility. For production data use expand/migrate/contract migrations:

1. Add compatible schema.
2. Deploy code supporting old and new shapes.
3. Backfill data.
4. Switch reads and writes.
5. Remove obsolete structures later.

### APIs and authorization

Define OpenAPI, protobuf, and JSON Schema changes. Write the permission matrix explicitly:

```text
Owner:  read and edit own profile
Public: read published public fields only
Admin:  review, moderate, and audit profiles
System: maintain timestamps and indexing state
```

### Applications and AI

Specify public UI, admin UI, validation, loading/error states, mobile behavior, accessibility, localization, and unsaved-change behavior. If AI is involved, it proposes structured data; the backend validates, authorizes, persists, and audits it.

### Operations

Define logs, metrics, alerts, healthchecks, privacy rules, deployment order, rollback, and backup requirements. Never log credentials, private messages, or unnecessary personal data.

## 6. Human approval

Review product behavior, contracts, database and migration design, authorization, affected repositories, tests, AI evaluations, observability, and rollback before implementation.

Agents prepare proposals, patches, branches, and reports. They do not approve their own work, merge, or deploy production.

## 7. Isolated branches

Use the same change ID in each affected repository:

```text
helping-people:          feature/user-profiles
helping-people-platform: feature/user-profiles-platform
```

Only create a platform branch when the feature changes platform behavior.

## 8. Implement vertical slices

Build a complete journey rather than finishing one technical layer at a time:

```text
migration → API → authorization → frontend/admin UI → tests → observability
```

For profiles: read an empty profile, edit basic fields, let admins view it, let admins moderate it, and expose only permitted published fields publicly.

## 9. Verify

Application verification includes formatting, linting, type checks, unit tests, API contract tests, migration tests, frontend/admin tests, end-to-end tests, accessibility, security, and AI evaluations.

Platform verification includes:

```bash
cd helping-people-platform
./tools/verify-platform.sh
docker compose config
docker compose up --build
docker compose ps
```

Verify routing, authentication, API, admin UI, AI gRPC, migrations, healthchecks, metrics, logs, and rollback behavior.

## 10. Review and stage

Cross-repository work uses separate PRs referencing the same OpenSpec change. Merge compatible database changes before code that depends on them. Staging must verify migrations, authorization, user journeys, admin moderation, public visibility, AI behavior, metrics, alerts, logs, performance, and rollback.

## 11. Production

Before deployment, confirm backups, migration risk, rollback steps, image identity, environment variables, and health dashboards. Production deployment requires explicit human approval.

After deployment, run smoke tests and monitor errors, latency, database health, authorization failures, background jobs, and feature-specific metrics. Disable or roll back safely if needed.

## 12. Close the change

After stabilization, merge the PRs, update canonical specifications, record operational notes and evaluation results, and archive the OpenSpec change.

A completed feature includes the OpenSpec change, contracts, migrations, implementation, tests and evaluations, authorization review, observability, deployment record, and rollback plan.

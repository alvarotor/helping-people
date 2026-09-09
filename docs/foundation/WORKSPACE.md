# HelpingPeopleNow Next Workspace

This workspace contains the clean rebuild of HelpingPeopleNow. The legacy project is a separate sibling directory and must not be modified by agents working here.

## Repositories

| Repository | Path | Owns |
|---|---|---|
| Application | `helping-people/` | Product code, application services, contracts, evaluations, OpenSpec |
| Platform | `helping-people-platform/` | Docker Compose, deployment, observability, environments, infrastructure |

These are independent Git repositories. There is no monorepo at the workspace parent.

## Working directory rules

- Start application work from `helping-people/`.
- Start platform work from `helping-people-platform/`.
- Start cross-repository exploration from either repository, then explicitly inspect the sibling repository.
- Never assume that an agent automatically loaded the sibling repository's instructions.
- From the application repository, read this file at `docs/foundation/WORKSPACE.md` and the relevant repository `AGENTS.md` before cross-repository work.
- From the platform repository, read this file at `../helping-people/docs/foundation/WORKSPACE.md` and the relevant repository `AGENTS.md` before cross-repository work.
- Do not modify the legacy `HelpingPeopleNow/` directory.

## OpenSpec location

OpenSpec is initially owned by the application repository at `helping-people/openspec/`.

OpenSpec proposals describe system behavior and may identify one or both repositories as affected. Platform-only and cross-repository changes are proposed in the application repository and implemented in the appropriate repository.

Run OpenSpec CLI commands from the application repository unless a command is explicitly given a different project path:

```bash
cd helping-people
openspec status
openspec validate --all
```

## Cross-repository change rule

Use one change ID for one system change. For example:

```text
CHG-0042
├── helping-people application PR
└── helping-people-platform platform PR
```

Both PRs must reference the same change ID. A repository may implement an approved existing contract, but no agent may silently invent or change a cross-repository contract.

Cross-repository work must inspect:

1. `helping-people/docs/foundation/WORKSPACE.md`;
2. `helping-people/AGENTS.md`;
3. `helping-people-platform/AGENTS.md`;
4. the relevant OpenSpec change;
5. the relevant implementation and contract files in both repositories.

## Git rules

- Use `main` as the protected integration branch.
- Use one feature branch or worktree per approved change.
- Do not commit directly to `main` after remotes and branch protection are configured.
- Agents may prepare branches and patches but may not merge their own work.
- Keep application and platform commits separate.
- Do not configure remotes or push until the repository ownership and visibility decisions are confirmed.

## Agent permissions

Agents may explore, plan, propose, implement on isolated branches, test, and report.

Agents may not merge, deploy production, modify production data, commit secrets, make destructive changes, or approve their own work.

## Initial verification expectations

Every repository must eventually provide a documented verification command. Cross-repository changes must provide both repository-specific checks and an integration/smoke check.

## Source-of-truth hierarchy

1. Approved OpenSpec changes define intended behavior.
2. Machine-readable contracts define externally verifiable interfaces.
3. Repository code implements the approved behavior.
4. Tests and evaluations verify behavior.
5. `AGENTS.md` files define how agents work safely in the repository.
6. Reports and notes provide context but do not override approved specifications or code contracts.

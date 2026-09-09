---
name: cross-repository-change
description: Plan and coordinate one system change across the application and platform repositories using shared OpenSpec and Git change identifiers.
---

# Cross-Repository Change

Use when a change affects both `helping-people/` and `helping-people-platform/`.

1. Read `docs/foundation/WORKSPACE.md`, both repository `AGENTS.md` files, and the approved OpenSpec change.
2. Identify the application and platform responsibilities separately.
3. Use one change ID and corresponding feature branches or worktrees in both repositories.
4. Keep contracts and application behavior in the application repository; keep deployment and infrastructure implementation in the platform repository.
5. Link the resulting PRs and describe ordering, compatibility, rollout, verification, and rollback.
6. Validate each repository independently and run the cross-repository smoke check.

Never assume a sibling repository's behavior. Never merge, deploy, modify production, or invent a contract while coordinating the change.

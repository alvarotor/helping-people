---
name: verification-review
description: Review an approved change independently, run proportionate checks, and report evidence, regressions, and unverified assumptions without modifying files.
---

# Verification Review

Use after implementation and before merge.

1. Read the OpenSpec change, diff, affected contracts, repository instructions, and acceptance criteria.
2. Inspect the change for authorization, privacy, data ownership, compatibility, error handling, observability, and rollback gaps.
3. Run the narrowest relevant validation first, then broader repository or integration checks when practical.
4. For AI changes, run deterministic evaluations and inspect critical scenario regressions.
5. Report findings by severity with file paths, evidence, reproduction commands, and whether the issue blocks merge.

Do not rewrite the implementation during review. A review is independent evidence, not an approval shortcut.

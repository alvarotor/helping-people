---
name: vertical-slice
description: Plan or implement the smallest complete HelpingPeopleNow user journey across UI, API, AI, persistence, contracts, tests, and local runtime.
---

# Vertical Slice

Use for a product capability that should be demonstrated end to end.

1. Start from an approved OpenSpec behavior and acceptance criteria.
2. Map the user journey, actors, states, contracts, data ownership, and failure paths before editing.
3. Implement only the smallest complete slice; defer unrelated admin, scaling, and provider complexity.
4. Keep web, admin, API, auth, and AI boundaries explicit even when they share a repository.
5. Add deterministic tests, integration coverage, and AI evaluations where model behavior is involved.
6. Verify the local Compose path and report what remains unimplemented.

Do not create disconnected screens or placeholder contracts that pretend the journey is complete.

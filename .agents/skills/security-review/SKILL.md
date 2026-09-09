---
name: security-review
description: Review HelpingPeopleNow changes for authentication, authorization, privacy, abuse, secrets, AI safety, and operational security risks.
---

# Security Review

Use for changes involving identity, profiles, messages, contact, admin, AI input/output, public data, secrets, or deployment.

Check:

- backend authorization for every protected operation;
- owner and participant boundaries;
- public projection removal of private fields;
- session, service-to-service, and admin credential handling;
- input size, rate, replay, and abuse controls;
- prompt injection and untrusted model output;
- logging and telemetry for personal data;
- secrets, environment files, dependencies, containers, and network exposure;
- auditability, incident response, and rollback.

Report concrete attack paths and mitigations. Do not claim a security audit is complete from a superficial source scan.

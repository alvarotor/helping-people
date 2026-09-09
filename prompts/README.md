# Prompt Registry

Prompts are product behavior and must be versioned, reviewed, and evaluated like code.

## Lifecycle

```text
draft → evaluate → approve → publish → monitor → rollback
```

Canonical prompts should eventually live in this directory, organized by capability and version. Runtime database overrides, if introduced, must reference a Git prompt version and retain an audit trail.

Do not store secrets, personal data, provider credentials, or hidden safety policy in prompts.

## Initial capabilities

- service-request assistant;
- professional-profile assistant;
- professional search explanation;
- safety-sensitive request handling;
- moderation/support workflows.

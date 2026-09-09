# Domain Lifecycles

These states define externally meaningful behavior. The eventual database schema and APIs must preserve these rules or propose an approved change.

## Professional profile

```mermaid
stateDiagram-v2
    [*] --> draft
    draft --> draft: edit
    draft --> pending_review: submit for review
    pending_review --> draft: owner revises
    pending_review --> published: approved and published
    pending_review --> rejected: moderation rejection
    rejected --> draft: owner revises
    published --> unpublished: owner unpublishes
    published --> suspended: moderation suspension
    unpublished --> draft: owner edits
    suspended --> draft: reinstated for correction
    suspended --> unpublished: removed from discovery
```

Rules:

- only the owner can edit a draft;
- only an explicit publish action makes a profile discoverable;
- rejected, unpublished, or suspended profiles are excluded from search;
- public readers see a published projection, not private owner fields;
- publishing must be auditable.

## Service request

```mermaid
stateDiagram-v2
    [*] --> draft
    draft --> submitted: user submits request
    submitted --> matching: accepted for matching
    matching --> active: results available or request remains open
    matching --> expired: matching window ends
    active --> fulfilled: user indicates resolved
    active --> cancelled: requester cancels
    active --> expired: request expires
    fulfilled --> [*]
    cancelled --> [*]
    expired --> [*]
```

Rules:

- the original request text is immutable after submission or stored as a version;
- AI extraction may be corrected without rewriting the original request;
- a request may have zero, one, or many matches;
- matching failure must be observable and must not fabricate professionals.

## Match

```mermaid
stateDiagram-v2
    [*] --> suggested
    suggested --> viewed: requester views result
    suggested --> expired: request or result expires
    viewed --> contact_requested: requester asks to contact
    viewed --> dismissed: requester dismisses
    contact_requested --> accepted: professional accepts or conversation opens
    contact_requested --> declined: professional declines
    contact_requested --> expired: response window ends
    accepted --> [*]
    declined --> [*]
    dismissed --> [*]
    expired --> [*]
```

The match score and ranking version are operational evidence, not a promise of quality.

## Contact request

```mermaid
stateDiagram-v2
    [*] --> requested
    requested --> accepted
    requested --> declined
    requested --> cancelled
    requested --> expired
    accepted --> conversation_active
    conversation_active --> closed
    conversation_active --> blocked
    accepted --> blocked
```

## Conversation

```mermaid
stateDiagram-v2
    [*] --> pending
    pending --> active: first accepted interaction
    active --> archived: participant archives
    archived --> active: new permitted interaction
    active --> blocked: participant blocks
    pending --> blocked: participant blocks
    active --> closed: retention or resolution policy
```

Blocking is a security rule enforced on every relevant backend operation. Archiving is a presentation/state-management action and does not necessarily delete messages.

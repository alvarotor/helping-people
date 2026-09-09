# Domain Glossary

This glossary defines the product language used by humans, agents, APIs, database models, and user-facing copy. New terms should be added here before they become contracts.

## Person and account

### User

A person with an account who can use HelpingPeopleNow. A user may request services, offer services, or do both.

### Identity

The authentication representation of a user: email address, session, login state, locale, and security attributes. Identity is not the same as a professional profile.

### Locale

The user's preferred language and regional formatting context. The initial supported languages are Spanish (`es`) and English (`en`).

### Administrator

An explicitly authorized operator who can perform administrative and moderation actions. Admin status is an authorization attribute, not a frontend role label.

## Services and discovery

### Professional

A user who offers one or more home-service categories through a professional profile. “Professional” is the preferred product term; “tradesperson” and “handyman” may be user-facing language depending on context and locale.

### Service category

A normalized type of work, such as plumbing, electrical work, carpentry, painting, cleaning, or general handyman work. Categories must support localization and future expansion.

### Professional service

An offering within a professional profile describing the category, coverage area, experience, availability, and optional supporting information.

### Professional profile

The public-facing representation of a professional. It belongs to a user, may contain multiple professional services, and has a lifecycle from draft to published or suspended.

### Service request

A user's description of help they need. It contains natural-language input plus normalized location, category, timing, and other structured information when available.

### Match

A system-generated recommendation connecting a service request with a professional service. A match is a recommendation, not a guarantee, contract, or endorsement.

### Search

The process of finding relevant professionals for a service request. Search may use structured filters, lexical matching, semantic retrieval, ranking, and distance, but those implementation details are not part of the user-facing domain meaning.

### Contact request

An explicit user action asking to start or continue communication with a professional about a service request. It is separate from merely viewing a profile or receiving a match.

## Communication and trust

### Conversation

A platform communication thread between users, normally associated with a service request or contact request.

### Message

A single user-authored or system-authored item in a conversation. Messages may be subject to reporting, moderation, retention, and deletion rules.

### Report

A trust and safety submission about a profile, message, user, or interaction.

### Block

A user-level restriction preventing specified interaction between two users. Blocking must be enforced by the backend, not only hidden in the UI.

### Publish

The explicit action that makes a reviewed professional profile visible to search and public profile readers.

### Unpublish

The action that removes a professional profile from public discovery while preserving it for the owner to edit or republish.

## System terms

### Draft

Mutable content that is not publicly discoverable.

### Public

Content available to unauthenticated or authenticated users according to its visibility contract.

### Owner

The user authorized to manage a resource they own, subject to backend authorization.

### Participant

A user who is a member of a conversation or interaction and may perform participant-level actions.

### AI-assisted

Content or recommendation produced with model assistance. AI-assisted does not mean automatically trusted, published, or fact-checked.

### Provider

An external or local model implementation used by the AI adapter. Provider identity is operational metadata, not domain behavior.

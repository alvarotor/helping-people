# Infrastructure and Ephemeral Environments

OpenTofu is the infrastructure-as-code standard for HelpingPeopleNow. The platform repository stores the OpenTofu definitions; it does not store live credentials or state files.

## Ownership model

```text
platform Git repository
  └── OpenTofu modules and environment definitions

remote state backend
  └── state and locking for each environment

cloud provider
  └── actual resources: network, compute, storage, database, observability
```

The desired infrastructure is reviewed in Git. OpenTofu compares it with remote state and the cloud provider, produces a plan, and applies only after approval.

## Repository shape

```text
helping-people-platform/
└── infra/
    ├── modules/
    │   ├── network/
    │   ├── application-runtime/
    │   ├── object-storage/
    │   └── observability/
    └── environments/
        ├── dev/
        ├── staging/
        ├── production/
        └── ephemeral/
```

Reusable modules describe capabilities. Environment roots compose those modules with environment-specific sizing, names, regions, and variables.

State is remote and isolated by environment. It is never committed to Git. Production and non-production state must not share a state file.

## Creating a test environment

When a feature needs infrastructure, one OpenSpec change describes both application and platform work. The platform portion adds or updates OpenTofu configuration, and the application portion consumes explicit outputs through environment variables or deployment configuration.

An approved change can request an ephemeral environment such as:

```text
environment: profile-pictures-pr-142
owner: change-id or pull-request
expires_at: 2026-09-17T00:00:00Z
```

The controlled workflow is:

1. OpenSpec identifies the required infrastructure and application contracts.
2. An agent prepares the OpenTofu change and environment inputs.
3. CI runs formatting, validation, security checks, and `tofu plan`.
4. A human reviews the plan, cost estimate, permissions, and expiry.
5. CI runs `tofu apply` using short-lived cloud identity only after approval.
6. OpenTofu outputs are passed to the application deployment.
7. The application and platform smoke tests run against the isolated environment.
8. The environment is destroyed with `tofu destroy` when the test ends or its expiry is reached.

Agents may prepare the plan and report. They do not apply or destroy environments without explicit authorization.

## Safety requirements

Ephemeral environments must have:

- unique resource names and isolated remote state;
- separate credentials and data from production;
- no production database access by default;
- restrictive network and IAM permissions;
- cost limits or small default sizes;
- owner, change ID, and expiry tags;
- automatic expiry cleanup;
- no public access unless explicitly required;
- documented outputs and teardown instructions.

The default test environment should use synthetic data. Production data must never be copied into an ephemeral environment without a separate approved privacy and security decision.

## Provider changes

The application should use provider-neutral ports where practical, such as an object-storage interface. The platform adapter may use AWS S3, MinIO, or another provider. A provider migration is itself an OpenSpec change when it affects cost, availability, security, data movement, or operations.

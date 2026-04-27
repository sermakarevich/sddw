## Task File Format

Each task file at `.sddw/<feature-name>/design/tasks/task-<N>-<slug>.md` references `design.md` for cross-cutting Architecture, Data Models, and Design Decisions. Only task-specific Files, Contracts, Acceptance Criteria, and Done Criteria are inlined.

**Format:**
```
# Task <N>: [Action-oriented title]

## Trace
- **FR-IDs:** FR-01, FR-02
- **Depends on:** none | task-1, task-2
- **Design:** ../design.md

## Files
- `path/to/create.py` — create
- `path/to/modify.py` — modify
- `tests/test_existing.py` — update (interface change)

## Design References
- design.md §Architecture (<relevant component or section>)
- design.md §Data Models (<relevant entity>)
- design.md §Design Decisions (<relevant decision>)

## Contracts (task-specific)

### API Endpoints
- [METHOD] [path]: [description]
  - Input: [schema]
  - Output: [status code, schema]
  - Errors: [status codes with meanings]

### Internal Interfaces
- [Module.method(params) -> return_type]: [purpose]
  - Pre: [pre-conditions]
  - Post: [post-conditions]

## Acceptance Criteria

[Given/When/Then scenarios for the referenced FR-IDs from requirements.md]

## Done Criteria
- [ ] [Specific, verifiable outcome]
- [ ] [Tests pass]
- [ ] [Files exist and are wired]
```

**Rules:**
- SHALL reference `design.md` for cross-cutting Architecture, Data Models, and Design Decisions via the Design References block
- SHALL inline only task-specific Files, Contracts, Acceptance Criteria, and Done Criteria; cross-cutting context lives in `design.md` and is referenced by section pointer
- SHALL NOT duplicate content from `design.md`. If a section's content lives in `design.md`, list it under Design References instead
- SHALL copy relevant acceptance criteria inline, not reference other files
- FR-IDs SHALL match the functional requirements from the requirements spec
- `Depends on:` SHALL reference other task numbers (e.g., `task-1`) or `none`
- Done criteria SHALL be specific enough to verify programmatically
- File paths SHALL be concrete, not placeholders
- Sections with no content for this task (e.g., no task-specific contracts, no cross-cutting context to reference) SHALL be omitted rather than left empty
- Files section SHALL include existing test files that depend on interfaces being changed, marked as `— update (interface change)`. When a task changes a module's public interface (function signatures, data schema, return types), existing tests that mock or depend on that interface will break — listing them prevents Rule 3 deviations during implementation.

**Example:**
> # Task 1: Create password reset token migration and model
>
> ## Trace
> - **FR-IDs:** FR-01, FR-02
> - **Depends on:** none
> - **Design:** ../design.md
>
> ## Files
> - `db/migrations/003_create_password_reset_tokens.py` — create
> - `src/models/reset_token.py` — create
>
> ## Design References
> - design.md §Architecture (TokenRepository component)
> - design.md §Data Models (PasswordResetToken)
> - design.md §Design Decisions (Token storage: database vs Redis)
>
> ## Acceptance Criteria
>
> ### FR-01: Password reset email
> - GIVEN a registered user with email "user@example.com"
> - WHEN they request a password reset
> - THEN the system SHALL create a token with 24h expiry
>
> ### FR-02: Reset link expiry
> - GIVEN a reset token older than 24 hours
> - WHEN the user attempts to use it
> - THEN the system SHALL reject it as expired
>
> ## Done Criteria
> - [ ] Migration creates `password_reset_tokens` table
> - [ ] Model class exists with all fields and constraints
> - [ ] `is_valid()` method returns correct results for valid/expired/used tokens
> - [ ] Migration is reversible (rollback drops table)

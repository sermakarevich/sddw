## Task File Format

Each task is a self-contained file at `.sddw/<feature-name>/design/tasks/task-<N>-<slug>.md`. The file contains everything the implementation agent needs to execute the task without loading any other design document.

**Format:**
```
# Task <N>: [Action-oriented title]

## Trace
- **FR-IDs:** FR-01, FR-02
- **Depends on:** none | task-1, task-2

## Files
- `path/to/create.py` — create
- `path/to/modify.py` — modify

## Architecture

[Component and data flow relevant to this task]

### Components
- [Component]: [responsibility] — [new | existing | modified]

### Data Flow
[Source] → [Transform/Action] → [Destination]

## Contracts

### API Endpoints
- [METHOD] [path]: [description]
  - Input: [schema]
  - Output: [status code, schema]
  - Errors: [status codes with meanings]

### Internal Interfaces
- [Module.method(params) -> return_type]: [purpose]
  - Pre: [pre-conditions]
  - Post: [post-conditions]

## Data Models

[Entities, schemas, relationships, and migration requirements relevant to this task]

## Design Decisions

[Non-obvious technical choices relevant to this task with rationale and rejected alternatives]

### [Decision title]
- **Chosen:** [approach]
- **Rationale:** [why this approach]
- **Rejected:** [alternative] — [why rejected]

## Acceptance Criteria

[Given/When/Then scenarios for the referenced FR-IDs from requirements.md]

## Done Criteria
- [ ] [Specific, verifiable outcome]
- [ ] [Tests pass]
- [ ] [Files exist and are wired]
```

**Rules:**
- Each task file SHALL be self-contained — include all context needed to implement
- SHALL include architecture, data models, contracts, and design decisions relevant to this task inline
- SHALL copy relevant acceptance criteria inline, not reference other files
- SHALL include only the architecture, contracts, models, decisions, and criteria relevant to this task
- FR-IDs SHALL match the functional requirements from the requirements spec
- `Depends on:` SHALL reference other task numbers (e.g., `task-1`) or `none`
- Done criteria SHALL be specific enough to verify programmatically
- File paths SHALL be concrete, not placeholders
- Sections with no content for this task (e.g., no API endpoints) SHALL be omitted rather than left empty
- Files section SHALL include existing test files that depend on interfaces being changed, marked as `— update (interface change)`. When a task changes a module's public interface (function signatures, data schema, return types), existing tests that mock or depend on that interface will break — listing them prevents Rule 3 deviations during implementation.

**Example:**
> # Task 1: Create password reset token migration and model
>
> ## Trace
> - **FR-IDs:** FR-01, FR-02
> - **Depends on:** none
>
> ## Files
> - `db/migrations/003_create_password_reset_tokens.py` — create
> - `src/models/reset_token.py` — create
>
> ## Architecture
>
> ### Components
> - `TokenRepository`: persists and validates reset tokens — new
>
> ### Data Flow
> `ResetService` → `TokenRepository.create()` → database
>
> ## Contracts
>
> ### Internal Interfaces
> - `PasswordResetToken.is_valid() -> bool`: returns True if not expired and not used
>   - Pre: token exists in database
>   - Post: no side effects
>
> ## Data Models
> - PasswordResetToken:
>   - `id (uuid)`: primary key
>   - `token (str, unique, indexed)`: secure random token
>   - `user_id (uuid, FK → users.id)`: owner
>   - `expires_at (datetime)`: creation time + 24h
>   - `used (bool, default: false)`: single-use flag
>   - `created_at (datetime)`: auto-set
>
> ## Design Decisions
>
> ### Token storage: database vs Redis
> - **Chosen:** Database (PostgreSQL)
> - **Rationale:** Tokens need to survive server restarts, existing stack uses PostgreSQL, 24h expiry doesn't need Redis performance
> - **Rejected:** Redis with TTL — adds infrastructure dependency for a low-throughput feature
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

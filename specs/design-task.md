## Task File Format

Each task is a self-contained file at `.sddw/<feature-name>/design/tasks/task-<N>-<slug>.md`. The file contains everything the implementation agent needs to execute the task without loading the full design document.

**Format:**
```
# Task <N>: [Action-oriented title]

## Trace
- **FR-IDs:** FR-01, FR-02
- **Depends on:** none | task-1, task-2

## Files
- `path/to/create.py` — create
- `path/to/modify.py` — modify

## Contracts

[Copy only the interface contracts relevant to this task from analysis.md]

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

[Copy only the entities and schema changes relevant to this task from analysis.md]

## Acceptance Criteria

[Copy only the Given/When/Then scenarios for the referenced FR-IDs from requirements.md]

## Done Criteria
- [ ] [Specific, verifiable outcome]
- [ ] [Tests pass]
- [ ] [Files exist and are wired]
```

**Rules:**
- Each task file SHALL be self-contained — include all context needed to implement
- SHALL copy relevant contracts and acceptance criteria inline, not reference other files
- SHALL include only the contracts, models, and criteria relevant to this task
- FR-IDs SHALL match the functional requirements from the requirements spec
- `Depends on:` SHALL reference other task numbers (e.g., `task-1`) or `none`
- Done criteria SHALL be specific enough to verify programmatically
- File paths SHALL be concrete, not placeholders

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

## Design File Format

Cross-cutting design artefact written by `/sddw:design` (or `/sddw:design_and_taskify`). Captures architecture, data models, shared interface contracts, and design decisions for a feature. Task files reference this artefact via `design.md §<Section>` pointers rather than duplicating its content.

**Location:** `.sddw/<feature-name>/design/design.md`

**Format:**
```
# Design: <feature-name>

## Trace
- **FR-IDs covered:** FR-01, FR-02
- **Requirements:** ../requirements.md

## Architecture

### Components
- [Component]: [responsibility] — [new | existing | modified]

### Data Flow
[Source] → [Transform/Action] → [Destination]

## Data Models

[Shared entities, schemas, relationships, and migration requirements]

## Interface Contracts

### API Endpoints (shared)
- [METHOD] [path]: [description]
  - Input: [schema]
  - Output: [status code, schema]
  - Errors: [status codes with meanings]

### Internal Interfaces (shared)
- [Module.method(params) -> return_type]: [purpose]
  - Pre: [pre-conditions]
  - Post: [post-conditions]

## Design Decisions

### [Decision title]
- **Chosen:** [approach]
- **Rationale:** [why this approach]
- **Rejected:** [alternative] — [why rejected]
```

**Rules:**
- SHALL be written to `.sddw/<feature-name>/design/design.md`
- SHALL list all FR-IDs covered in the Trace section
- Sections with no content for this feature (e.g., no API endpoints) SHALL be omitted rather than left empty
- SHALL capture only cross-cutting content shared across tasks — per-task contracts and acceptance criteria belong in task files
- Task files MAY reference sections of this file using `design.md §<Section>` pointers instead of duplicating content

**Example:**
> # Design: password-reset
>
> ## Trace
> - **FR-IDs covered:** FR-01, FR-02, FR-03
> - **Requirements:** ../requirements.md
>
> ## Architecture
>
> ### Components
> - `ResetService`: orchestrates token creation and email dispatch — new
> - `TokenRepository`: persists and validates reset tokens — new
> - `EmailService`: sends transactional emails — existing
>
> ### Data Flow
> `POST /auth/reset-request` → `ResetService.request()` → `TokenRepository.create()` → database
> `ResetService.request()` → `EmailService.send_reset()` → email provider
> `POST /auth/reset-confirm` → `ResetService.confirm()` → `TokenRepository.consume()` → `UserRepository.update_password()`
>
> ## Data Models
>
> - PasswordResetToken:
>   - `id (uuid)`: primary key
>   - `token (str, unique, indexed)`: secure random token
>   - `user_id (uuid, FK → users.id)`: owner
>   - `expires_at (datetime)`: creation time + 24h
>   - `used (bool, default: false)`: single-use flag
>   - `created_at (datetime)`: auto-set
>
> ## Interface Contracts
>
> ### API Endpoints (shared)
> - POST /auth/reset-request: initiate password reset
>   - Input: `{ "email": string }`
>   - Output: 200 `{ "message": "If that email exists, a reset link was sent." }`
>   - Errors: 429 rate limited
> - POST /auth/reset-confirm: complete password reset
>   - Input: `{ "token": string, "new_password": string }`
>   - Output: 200 `{ "message": "Password updated." }`
>   - Errors: 400 invalid/expired token, 422 validation error
>
> ### Internal Interfaces (shared)
> - `TokenRepository.create(user_id) -> PasswordResetToken`: creates a new token with 24h expiry
>   - Pre: user exists
>   - Post: token persisted, previous unused tokens for user invalidated
> - `TokenRepository.consume(token_str) -> PasswordResetToken`: marks token used and returns it
>   - Pre: token exists, is valid (not expired, not used)
>   - Post: token.used = true
>
> ## Design Decisions
>
> ### Token storage: database vs Redis
> - **Chosen:** Database (PostgreSQL)
> - **Rationale:** Tokens need to survive server restarts, existing stack uses PostgreSQL, 24h expiry doesn't require Redis performance
> - **Rejected:** Redis with TTL — adds infrastructure dependency for a low-throughput feature
>
> ### Response message for unknown email
> - **Chosen:** Return 200 with a neutral message regardless of whether the email exists
> - **Rationale:** Prevents user enumeration attacks
> - **Rejected:** Return 404 for unknown email — leaks account existence

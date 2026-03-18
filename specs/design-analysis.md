## 1. Codebase Analysis

Analyse the existing codebase to extract patterns, interfaces, and flows relevant to the feature. This grounds the design in reality rather than assumptions.

**Format:**
```
### Relevant Patterns
- [Pattern]: [where it is used, how it works]

### Key Interfaces
- [Interface/module]: [purpose, signature]

### Existing Flows
- [Flow name]: [step-by-step description of current behavior]

### Conventions
- [Convention]: [description, files where enforced]
```

**Rules:**
- SHALL identify reusable components before proposing new ones
- SHALL document conventions the implementation must follow
- SHALL NOT propose patterns that conflict with existing codebase conventions
- SHALL note dependency direction between existing modules

**Example:**
> ### Relevant Patterns
> - Token-based auth: used in `src/auth/jwt.py`, signs with RS256, 1h expiry
> - Service layer pattern: all business logic in `src/services/`, controllers are thin
>
> ### Key Interfaces
> - `EmailService.send(to, template, context)`: async email delivery via SES
> - `UserRepository.find_by_email(email) -> User | None`
>
> ### Existing Flows
> - Login flow: `POST /auth/login` → validate credentials → issue JWT → set cookie
>
> ### Conventions
> - All models inherit from `BaseModel` in `src/models/base.py`
> - Migrations use Alembic with sequential naming

---

## 2. Architecture

Component and module breakdown showing how the feature fits into the existing system. Defines boundaries, responsibilities, and data flow between components.

**Format:**
```
### Components
- [Component]: [responsibility] — [new | existing | modified]

### Data Flow
[Source] → [Transform/Action] → [Destination]
```

**Rules:**
- Every component SHALL have a single clear responsibility
- SHALL show how new components integrate with existing ones
- SHALL NOT introduce new architectural layers without justification
- Data flow SHALL cover both happy path and error path

**Example:**
> ### Components
> - `ResetService`: orchestrates token creation, email dispatch, and password update — new
> - `TokenRepository`: persists and validates reset tokens — new
> - `EmailService`: sends templated emails — existing, no changes
> - `AuthController`: exposes reset endpoints — modified, two new routes
>
> ### Data Flow
> **Request reset:**
> User → `POST /auth/reset-request` → `AuthController` → `ResetService.request(email)` → `TokenRepository.create()` → `EmailService.send()` → `202 Accepted`
>
> **Confirm reset:**
> User → `POST /auth/reset-confirm` → `AuthController` → `ResetService.confirm(token, password)` → `TokenRepository.validate()` → `UserRepository.update_password()` → `200 OK`

---

## 3. Data Models

Entity definitions, schemas, relationships, and migration requirements. Defines the structural foundation that tasks will implement.

**Format:**
```
### Entities
- [Entity]: [attributes with types and constraints]

### Relationships
- [Entity A] → [Entity B]: [cardinality, description]

### Schema Changes
- [Table/collection]: [additions, modifications, migration notes]
```

**Rules:**
- Every entity SHALL trace to at least one FR from the requirements spec
- SHALL include field types, constraints, and validation rules
- Schema changes SHALL note migration requirements and reversibility

**Example:**
> ### Entities
> - PasswordResetToken:
>   - `id (uuid)`: primary key
>   - `token (str, unique, indexed)`: secure random token
>   - `user_id (uuid, FK → users.id)`: owner
>   - `expires_at (datetime)`: creation time + 24h
>   - `used (bool, default: false)`: single-use flag
>   - `created_at (datetime)`: auto-set
>
> ### Relationships
> - User → PasswordResetToken: one-to-many
>
> ### Schema Changes
> - `password_reset_tokens`: new table, requires forward migration
> - Rollback: drop table (no data dependency)

---

## 4. Interface Contracts

API endpoints, method signatures, and error responses. These are the contracts that implementation tasks code against.

**Format:**
```
### API Endpoints
- [METHOD] [path]: [description]
  - Input: [schema]
  - Output: [status code, schema]
  - Errors: [status codes with meanings]

### Internal Interfaces
- [Module.method(params) -> return_type]: [purpose]
```

**Rules:**
- Every endpoint SHALL include error responses
- SHALL use RFC 2119 keywords for behavioural requirements
- Internal interfaces SHALL specify pre-conditions and post-conditions
- SHALL trace each contract to the FR it satisfies

**Example:**
> ### API Endpoints
> - `POST /auth/reset-request`: request a password reset (FR-01, FR-03)
>   - Input: `{ email: str }`
>   - Output: `202 Accepted` `{ message: "If registered, you will receive an email" }`
>   - Errors: `429 Too Many Requests` (rate limited)
>   - Note: response SHALL be identical whether email exists or not
>
> - `POST /auth/reset-confirm`: set new password using token (FR-02)
>   - Input: `{ token: str, password: str }`
>   - Output: `200 OK` `{ message: "Password updated" }`
>   - Errors: `400 Bad Request` (invalid/expired/used token), `422 Unprocessable` (weak password)
>
> ### Internal Interfaces
> - `ResetService.request(email: str) -> None`: creates token and sends email if user exists, no-op otherwise
> - `ResetService.confirm(token: str, password: str) -> None`: validates token, updates password, marks token used
>   - Pre: token exists and is not expired or used
>   - Post: user password is updated, token is marked used

---

## 5. Design Decisions

Key technical choices with rationale and rejected alternatives. Prevents re-litigating decisions during implementation and documents the "why" behind the design.

**Format:**
```
### [Decision title]
- **Chosen:** [approach]
- **Rationale:** [why this approach]
- **Rejected:** [alternative] — [why rejected]
```

**Rules:**
- SHALL document every non-obvious technical choice
- SHALL include at least one rejected alternative per decision
- SHALL NOT include decisions that are obvious from codebase conventions

**Example:**
> ### Token storage: database vs Redis
> - **Chosen:** Database (PostgreSQL)
> - **Rationale:** Tokens need to survive server restarts, existing stack uses PostgreSQL, 24h expiry doesn't need Redis performance
> - **Rejected:** Redis with TTL — adds infrastructure dependency for a low-throughput feature
>
> ### Token format: UUID vs signed JWT
> - **Chosen:** UUID stored in database
> - **Rationale:** Simpler to invalidate (mark as used), no secret rotation concerns
> - **Rejected:** Signed JWT — harder to revoke, adds complexity for single-use tokens

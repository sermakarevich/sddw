## Codebase Analysis

Analyse the existing codebase to extract patterns, interfaces, and flows. This grounds all feature designs in reality rather than assumptions. Shared across features — created once, updated as the codebase evolves.

**Location:** `.sddw/code-analysis.md`

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
- If `.sddw/code-analysis.md` already exists, SHALL review and update it rather than recreate
- SHALL add new sections relevant to the current feature without removing existing content

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

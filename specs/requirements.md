## 1. Purpose

One to two sentences describing what the feature does and why it matters. Focus on the problem being solved, not the implementation.

**Example:**
> Enable users to reset their password via email link, reducing support ticket volume for locked accounts.

---

## 2. User Stories

Two to five user stories capturing the primary user journeys. Each story follows the format:

```
As a [role], I want [capability], so that [benefit].
```

**Rules:**
- Each story SHALL represent a distinct user need
- Stories SHALL NOT describe implementation details
- Stories SHOULD be independent of each other

**Example:**
> - As a registered user, I want to request a password reset email, so that I can regain access to my account.
> - As a registered user, I want to set a new password via the reset link, so that my account is secured with updated credentials.

---

## 3. Functional Requirements

Enumerated capabilities using unique identifiers. Each requirement SHALL be atomic, testable, and expressed with an RFC 2119 keyword.

**Format:**
```
- FR-01: [Subject] [SHALL|SHOULD|MAY] [capability].
- FR-02: [Subject] SHALL NOT [prohibited behavior].
```

**Rules:**
- One capability per requirement
- User-centric: "User can X" not "System does Y"
- Include explicit prohibitions (SHALL NOT) to prevent unwanted agent behavior

**Example:**
> - FR-01: System SHALL send a password reset email within 60 seconds of request.
> - FR-02: Reset link SHALL expire after 24 hours.
> - FR-03: System SHALL NOT reveal whether an email address is registered.

---

## 4. Acceptance Criteria

One or more Given/When/Then scenarios per functional requirement. These serve as the primary verification mechanism and the basis for test generation.

**Format:**
```
### FR-01: [Requirement title]

- GIVEN [precondition]
- WHEN [action]
- THEN [expected outcome] (SHALL)
- AND [additional outcome]
```

**Rules:**
- Every FR SHALL have at least one scenario
- Include both happy path and failure scenarios
- Include at least one boundary/edge case scenario per feature
- Scenarios SHALL be specific enough to generate tests without interpretation

**Example:**
> ### FR-01: Password reset email
>
> **Happy path:**
> - GIVEN a registered user with email "user@example.com"
> - WHEN they request a password reset
> - THEN the system SHALL send an email containing a unique reset link
> - AND the email SHALL arrive within 60 seconds
>
> **Failure path:**
> - GIVEN an unregistered email "unknown@example.com"
> - WHEN they request a password reset
> - THEN the system SHALL display the same confirmation message as for registered users
> - AND the system SHALL NOT send any email

---

## 5. Constraints

Explicit boundaries defining what is in scope, out of scope, and prohibited. Prevents scope creep and unwanted agent additions.

**Format:**
```
### In Scope
- [What this feature delivers]

### Out of Scope
- [What is explicitly excluded] — [reason]

### Prohibitions
- SHALL NOT [prohibited behavior] — [reason]
```

**Rules:**
- In Scope SHALL align with the user stories and functional requirements
- Out of Scope SHALL include reasoning for each exclusion
- Prohibitions SHALL cover security-sensitive and behaviorally risky areas

**Example:**
> ### In Scope
> - Password reset via email link
> - Token generation and expiry validation
>
> ### Out of Scope
> - SMS-based password reset — deferred to v2
> - Account lockout policy — handled by existing auth module
>
> ### Prohibitions
> - SHALL NOT store plaintext passwords at any point
> - SHALL NOT log reset tokens or email addresses

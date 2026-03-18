# Requirement Questionnaire

Three-phase dialog to gather enough context to write the requirements spec.

---

## Phase 1: Discover

Understand the feature and its context. Start open, follow the thread.

**Open question:**
> "Describe the feature you want to build. What problem does it solve?"

**Follow-up techniques:**
- **Follow energy** — whatever they emphasize, dig into that
- **Challenge vagueness** — "users" means who? "simple" means how? "fast" means what?
- **Make abstract concrete** — "walk me through using this"
- **Clarify ambiguity** — "when you say X, do you mean A or B?"

**Context checklist** (background, not a script — weave naturally):
- [ ] What the feature does (concrete enough to write Purpose)
- [ ] Who uses it and why (enough for User Stories)
- [ ] What should NOT happen (boundaries, prohibitions)
- [ ] What "done" looks like (observable outcomes)

**Anti-patterns:**
- Checklist walking — going through questions regardless of what they said
- Shallow acceptance — taking vague answers without probing
- Premature constraints — asking about tech details before understanding the idea
- Interrogation — firing questions without building on answers

---

## Phase 2: Research & Propose

Based on discovery, research the problem space and present options for each spec section. Sort options by relevance and strength.

### 2.1 Research

Depending on the feature, research:
- **Web search** — SOTA approaches, common patterns, existing solutions, relevant packages
- **Codebase analysis** — existing implementations, conventions, patterns to follow or avoid
- **Domain knowledge** — industry standards, security requirements, compliance needs

### 2.2 Propose

For each section of the requirements spec, present 2-3 ranked options for the user to choose from or modify.

**Purpose — propose framing:**
> "Based on what you described, here are two ways to frame this feature:"
> 1. [Framing A — focused on problem]
> 2. [Framing B — focused on outcome]

**User Stories — propose personas and journeys:**
> "I identified these user journeys:"
> 1. [Story A] — [why this matters]
> 2. [Story B] — [why this matters]
> 3. [Story C] — [why this matters]
> "Would you adjust, add, or remove any?"

**Functional Requirements — propose FRs with strength levels:**
> "Here are the functional requirements I'd suggest, ordered by priority:"
> - FR-01: [requirement] (SHALL) — [rationale]
> - FR-02: [requirement] (SHALL) — [rationale]
> - FR-03: [requirement] (SHOULD) — [rationale]
> - FR-04: [requirement] (SHALL NOT) — [rationale from research]
> "Agree, or want to change priorities?"

**Acceptance Criteria — propose scenarios:**
> "For FR-01, I'd test these scenarios:"
> - Happy path: [Given/When/Then]
> - Failure path: [Given/When/Then]
> - Edge case: [Given/When/Then]
> "Missing any scenarios?"

**Constraints — propose boundaries:**
> "Based on the codebase and your description, I'd set these boundaries:"
> - In Scope: [list]
> - Out of Scope: [list with reasoning]
> - Prohibitions: [list with reasoning]
> "Anything to add or move?"

### Rules for proposing:
- SHALL present options sorted by relevance, strongest first
- SHALL include rationale for each option (from research or codebase analysis)
- SHALL explicitly mark what came from research vs assumption
- User can accept, modify, or propose their own input for any section
- SHALL NOT proceed to generation without user approval on all sections

---

## Phase 3: Confirm & Generate

Once all sections are approved:

> "Ready to generate the requirements spec? Here's what I'll write:"
> - Purpose: [summary]
> - User Stories: [count] stories
> - Functional Requirements: [count] FRs
> - Acceptance Criteria: [count] scenarios
> - Constraints: [in/out/prohibitions summary]

User confirms → generate spec to `.sddw/<feature-name>/requirements.md`

If user wants changes → return to the relevant section in Phase 2.

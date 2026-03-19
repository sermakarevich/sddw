# Requirement Questionnaire

Three-phase dialog to gather enough context to write the requirements spec.

---

## Phase 1: Discover

Understand the feature and its context. One question at a time, follow the thread.

**Step 1 — Project location:**
> "Where does this feature's code live? Is it the current directory, or a different project?"

Offer options: current directory (`.`) or let user specify a path. Wait for response.

**Step 2 — Open:**
> "Describe the feature you want to build. What problem does it solve?"

Wait for response.

**Step 3 — Follow up** on what they said. Pick ONE:
- **Follow energy** — whatever they emphasized, dig into that
- **Challenge vagueness** — "users" means who? "simple" means how? "fast" means what?
- **Make abstract concrete** — "walk me through using this"
- **Clarify ambiguity** — "when you say X, do you mean A or B?"

Offer 2-4 interpretations as options when possible.

Wait for response.

**Step 4+** — Continue one question at a time until the context checklist is covered:
- [ ] What the feature does (concrete enough to write Purpose)
- [ ] Who uses it and why (enough for User Stories)
- [ ] What should NOT happen (boundaries, prohibitions)
- [ ] What "done" looks like (observable outcomes)

Do NOT walk through this checklist in order. Weave questions naturally based on what's missing.

---

## Phase 2: Research & Propose

Based on discovery, research the problem space and propose ONE section at a time. Wait for approval before moving to the next.

### 2.1 Research

Depending on the feature, research:
- **Web search** — SOTA approaches, common patterns, existing solutions, relevant packages
- **Codebase analysis** — existing implementations, conventions, patterns to follow or avoid
- **Domain knowledge** — industry standards, security requirements, compliance needs

### 2.2 Propose (one section at a time)

Present each section separately. Wait for user approval before proposing the next.

**Section 1 — Purpose:**
> "Based on what you described, here are two ways to frame this feature:"
> 1. [Framing A — focused on problem]
> 2. [Framing B — focused on outcome]
> "Which framing works better, or would you adjust?"

Wait for response. Lock in approved Purpose.

**Section 2 — User Stories:**
> "I identified these user journeys:"
> 1. [Story A] — [why this matters]
> 2. [Story B] — [why this matters]
> 3. [Story C] — [why this matters]
> "Would you adjust, add, or remove any?"

Wait for response. Lock in approved stories.

**Section 3 — Functional Requirements:**
> "Here are the functional requirements I'd suggest, ordered by priority:"
> - FR-01: [requirement] (SHALL) — [rationale]
> - FR-02: [requirement] (SHALL) — [rationale]
> - FR-03: [requirement] (SHOULD) — [rationale]
> - FR-04: [requirement] (SHALL NOT) — [rationale from research]
> "Agree, or want to change priorities?"

Wait for response. Lock in approved FRs.

**Section 4 — Acceptance Criteria:**
> "For FR-01, I'd test these scenarios:"
> - Happy path: [Given/When/Then]
> - Failure path: [Given/When/Then]
> - Edge case: [Given/When/Then]
> "Missing any scenarios?"

Wait for response. Repeat for each FR, one at a time.

**Section 5 — Constraints:**
> "Based on the codebase and your description, I'd set these boundaries:"
> - In Scope: [list]
> - Out of Scope: [list with reasoning]
> - Prohibitions: [list with reasoning]
> "Anything to add or move?"

Wait for response. Lock in approved constraints.

### Rules for proposing:
- SHALL propose ONE section at a time, wait for approval, then move to next
- SHALL present options sorted by relevance, strongest first
- SHALL include rationale for each option (from research or codebase analysis)
- SHALL explicitly mark what came from research vs assumption
- User can accept, modify, or propose their own input for any section

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

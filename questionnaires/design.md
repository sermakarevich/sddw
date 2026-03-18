# Design Questionnaire

Three-phase dialog to gather enough context to produce the design artifacts (analysis.md + task files).

---

## Phase 1: Discover

Understand the implementation landscape. The requirements spec is already written — now understand how it maps to the codebase.

**Open question:**
> "I've read the requirements. Before I analyse the codebase, is there anything specific about the architecture or approach you have in mind?"

**Follow-up techniques:**
- **Surface assumptions** — "are you thinking this lives in [module] or should it be separate?"
- **Identify constraints** — "any libraries or patterns you want to use or avoid?"
- **Clarify integration** — "how should this connect to [existing feature]?"

**Context checklist** (background, not a script):
- [ ] Any preferred architectural approach
- [ ] Known constraints (libraries, patterns, performance)
- [ ] Integration points the user cares about
- [ ] Any prior art or reference implementations

---

## Phase 2: Research & Propose

Analyse the codebase and propose design options for each section.

### 2.1 Research

- **Codebase analysis** — scan for relevant patterns, interfaces, flows, conventions
- **Dependency analysis** — what modules are affected, what's the impact radius
- **Web search** — if the feature involves unfamiliar tech, research best practices and packages

### 2.2 Propose

**Architecture — propose component breakdown:**
> "Here's how I'd structure this feature:"
> - [Component A]: [responsibility] — new
> - [Component B]: [responsibility] — modify existing
> - [Component C]: [responsibility] — reuse existing
> "Data flow: [source] → [action] → [destination]"
> "Alternative approach: [brief description]. I prefer option 1 because [reason]."

**Data Models — propose entities:**
> "I'd need these entities:"
> - [Entity]: [key fields and types]
> "This requires a migration. Rollback strategy: [description]."

**Interface Contracts — propose APIs and signatures:**
> "API endpoints:"
> - [METHOD] [path]: [description, input, output, errors]
> "Internal interfaces:"
> - [Module.method(params) -> return]: [purpose]
> "Agree with these contracts?"

**Design Decisions — propose choices:**
> "Decision needed: [title]"
> 1. **[Option A]** — [pros]. [cons].
> 2. **[Option B]** — [pros]. [cons].
> "I recommend option 1 because [rationale]."

**Task Decomposition — propose task breakdown:**
> "I'd break this into [N] tasks:"
> 1. Task 1: [description] (FR-01) — depends on: none
> 2. Task 2: [description] (FR-02) — depends on: task 1
> "Tasks 1 and [N] can run in parallel. Agree with this ordering?"

### Rules for proposing:
- SHALL base proposals on actual codebase analysis, not assumptions
- SHALL present architecture alternatives when non-obvious
- SHALL include rationale for every design decision
- User can accept, modify, or propose their own approach for any section
- SHALL NOT proceed to generation without user approval

---

## Phase 3: Confirm & Generate

Once all sections are approved:

> "Ready to generate the design artifacts? Here's what I'll write:"
> - analysis.md: [sections summary]
> - [N] task files: [brief list]

User confirms → generate artifacts to `.sddw/<feature-name>/design/`

If user wants changes → return to the relevant section in Phase 2.

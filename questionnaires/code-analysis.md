# Code Analysis Questionnaire

Three-phase dialog to gather enough context to produce the codebase analysis (code-analysis.md).

**Critical decisions (`--critical-only`):** ambiguous conventions, conflicting patterns.

---

## Phase 1: Discover

*In `--critical-only`: infer scope autonomously, but ask about areas the user considers critical. In `--auto`: perform discovery fully autonomously.*

Understand which parts of the codebase matter most for the upcoming design. The requirements spec is already written — now understand the landscape. One question at a time.

**Step 1 — Open:**
> "I've read the requirements. Before I scan the codebase, are there specific areas or modules you want me to focus on?"

Wait for response.

**Step 2+** — Follow up based on their answer. Pick ONE at a time:
- **Scope** — "Should I focus on [directory/module] or scan more broadly?"
- **Conventions** — "Any conventions or patterns I should watch for specifically?"
- **Known issues** — "Any areas of the codebase that are tricky or have known technical debt?"

**Context checklist** (background, not a script — weave naturally):
- [ ] Key areas to focus on
- [ ] Known conventions or patterns
- [ ] Areas to avoid or known tech debt
- [ ] Integration points relevant to the feature

---

## Phase 2: Research & Propose

Scan the codebase and propose findings ONE section at a time. Wait for approval before moving to the next.

### 2.1 Research

- **Pattern scan** — identify architectural patterns, design patterns, code organisation
- **Interface scan** — find key interfaces, module boundaries, public APIs
- **Flow scan** — trace existing flows relevant to the feature
- **Convention scan** — naming, structure, error handling, testing patterns

### 2.2 Propose (one section at a time)

Present each section separately. Wait for user approval before proposing the next.

**Output rule:** Always output the full findings as text FIRST. Then use `AskUserQuestion` only for the approval question. Never put the findings list inside the `AskUserQuestion` prompt — the user must be able to read the content before answering.

*In `--critical-only`: decide clear-cut sections autonomously. Pause only for sections where conventions are ambiguous or patterns conflict. In `--auto`: decide all sections autonomously.*

**Section 1 — Relevant Patterns:**
Output as text:
> "Here are the patterns I found relevant to this feature:"
> - [Pattern]: [where used, how it works]

Then ask: "Anything I missed or got wrong?"

Wait for response. Lock in approved patterns.

**Section 2 — Key Interfaces:**
Output as text:
> "Key interfaces and module boundaries:"
> - [Interface/module]: [purpose, signature]

Then ask: "Agree with these?"

Wait for response. Lock in approved interfaces.

**Section 3 — Existing Flows:**
Output as text:
> "Existing flows relevant to this feature:"
> - [Flow name]: [step-by-step description]

Then ask: "Accurate?"

Wait for response. Lock in approved flows.

**Section 4 — Conventions:**
Output as text:
> "Conventions the implementation should follow:"
> - [Convention]: [description, files where enforced]

Then ask: "Anything to add or correct?"

Wait for response. Lock in approved conventions.

### Rules for proposing:
- SHALL propose ONE section at a time, wait for approval, then move to next
- SHALL base findings on actual codebase scan, not assumptions
- SHALL output full findings as text before calling AskUserQuestion — never embed the list inside the question prompt
- User can accept, modify, or provide their own findings for any section

---

## Phase 3: Confirm & Generate

Once all sections are approved:

> "Ready to generate the code analysis? Here's what I'll write:"
> - Relevant Patterns: [count] patterns
> - Key Interfaces: [count] interfaces
> - Existing Flows: [count] flows
> - Conventions: [count] conventions

User confirms → generate `code-analysis.md` to `.sddw/`

*In `--critical-only`: still present this summary and wait for confirmation. In `--auto`: generate directly.*

If user wants changes → return to the relevant section in Phase 2.

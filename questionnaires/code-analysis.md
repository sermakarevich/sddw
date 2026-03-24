# Code Analysis Questionnaire

Three-phase dialog to gather enough context to produce the codebase analysis (code-analysis.md).

**Mode behavior:** All modes perform the same work. In `--critical-only`, the agent makes non-critical decisions autonomously but asks the user for critical ones (ambiguous conventions, unclear patterns). In `--auto`, the agent makes all decisions autonomously. See dialog rules for full mode definitions.

> **Tool reminder:** Every question to the user — whether options or open-ended — MUST use the `AskUserQuestion` tool. See "Tool Usage — AskUserQuestion" in dialog rules.

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

*In `--critical-only`: decide clear-cut sections autonomously. Pause only for sections where conventions are ambiguous or patterns conflict. In `--auto`: decide all sections autonomously.*

**Section 1 — Relevant Patterns:**
> "Here are the patterns I found relevant to this feature:"
> - [Pattern]: [where used, how it works]
> "Anything I missed or got wrong?"

Wait for response. Lock in approved patterns.

**Section 2 — Key Interfaces:**
> "Key interfaces and module boundaries:"
> - [Interface/module]: [purpose, signature]
> "Agree with these?"

Wait for response. Lock in approved interfaces.

**Section 3 — Existing Flows:**
> "Existing flows relevant to this feature:"
> - [Flow name]: [step-by-step description]
> "Accurate?"

Wait for response. Lock in approved flows.

**Section 4 — Conventions:**
> "Conventions the implementation should follow:"
> - [Convention]: [description, files where enforced]
> "Anything to add or correct?"

Wait for response. Lock in approved conventions.

### Rules for proposing:
- SHALL propose ONE section at a time, wait for approval, then move to next
- SHALL base findings on actual codebase scan, not assumptions
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

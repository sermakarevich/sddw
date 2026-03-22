# Design Questionnaire

Three-phase dialog to gather enough context to produce self-contained task files.

**Mode behavior:** All modes perform the same work. In `--critical-only`, the agent makes non-critical decisions autonomously but asks the user for critical ones (architecture approach, design decisions with trade-offs, task breakdown). In `--auto`, the agent makes all decisions autonomously. See dialog rules for full mode definitions.

---

## Phase 1: Discover

*In `--critical-only`: infer non-critical preferences autonomously, but ask about preferred architectural approach if multiple viable options exist. In `--auto`: perform discovery fully autonomously.*

Understand the implementation landscape. The requirements spec is already written — now understand how it maps to the codebase. One question at a time.

**Step 1 — Open:**
> "I've read the requirements. Before I design the tasks, is there anything specific about the architecture or approach you have in mind?"

Wait for response.

**Step 2+** — Follow up based on their answer. Pick ONE at a time:
- **Surface assumptions** — "are you thinking this lives in [module] or should it be separate?"
- **Identify constraints** — "any libraries or patterns you want to use or avoid?"
- **Clarify integration** — "how should this connect to [existing feature]?"

Offer 2-4 concrete options based on what you see in the codebase (or code-analysis.md if available).

**Context checklist** (background, not a script — weave naturally):
- [ ] Any preferred architectural approach
- [ ] Known constraints (libraries, patterns, performance)
- [ ] Integration points the user cares about
- [ ] Any prior art or reference implementations

---

## Phase 2: Research & Propose

Research the design and propose ONE section at a time. Wait for approval before moving to the next. If `.sddw/code-analysis.md` exists, use it as context. Otherwise, scan the codebase as needed.

### 2.1 Research

- **Codebase analysis** — scan for relevant patterns, interfaces, flows, conventions (use code-analysis.md if available, supplement as needed)
- **Dependency analysis** — what modules are affected, what's the impact radius
- **Web search** — if the feature involves unfamiliar tech, research best practices and packages

### 2.2 Propose (one section at a time)

Present each section separately. Wait for user approval before proposing the next.

*In `--critical-only`: decide Data Models and Interface Contracts autonomously. Pause only for Architecture (Section 1), Design Decisions (Section 4), and Task Breakdown (Section 5) — present these for user approval. In `--auto`: decide all sections autonomously.*

**Section 1 — Architecture:**
> "Here's how I'd structure this feature:"
> - [Component A]: [responsibility] — new
> - [Component B]: [responsibility] — modify existing
> - [Component C]: [responsibility] — reuse existing
> "Data flow: [source] → [action] → [destination]"
> "Alternative approach: [brief description]. I prefer option 1 because [reason]."
> "Agree with this structure?"

Wait for response. Lock in approved architecture.

**Section 2 — Data Models:**
> "I'd need these entities:"
> - [Entity]: [key fields and types]
> "This requires a migration. Rollback strategy: [description]."
> "Agree, or would you change the schema?"

Wait for response. Lock in approved models.

**Section 3 — Interface Contracts:**
> "API endpoints:"
> - [METHOD] [path]: [description, input, output, errors]
> "Internal interfaces:"
> - [Module.method(params) -> return]: [purpose]
> "Agree with these contracts?"

Wait for response. Lock in approved contracts.

**Section 4 — Design Decisions:**
For each non-obvious decision, present ONE at a time:
> "Decision needed: [title]"
> 1. **[Option A]** — [pros]. [cons].
> 2. **[Option B]** — [pros]. [cons].
> "I recommend option 1 because [rationale]. Your call?"

Wait for response. Lock in decision. Move to next decision if any.

**Section 5 — Task Breakdown (produces individual task files):**
> "I'd break this into [N] tasks, each as a self-contained file:"
> 1. Task 1: [description] (FR-01) — Depends on: none — files: [list]
> 2. Task 2: [description] (FR-02) — Depends on: task-1 — files: [list]
> "Tasks 1 and [N] can run in parallel. Agree with this breakdown and dependency ordering?"
>
> "Each task file will include the architecture, data models, contracts, and design decisions relevant to that task — fully self-contained."

Wait for response. Lock in approved tasks. Each task becomes a separate file in `design/tasks/`.

### Rules for proposing:
- SHALL propose ONE section at a time, wait for approval, then move to next
- SHALL base proposals on actual codebase analysis (or code-analysis.md), not assumptions
- SHALL present architecture alternatives when non-obvious
- SHALL include rationale for every design decision
- User can accept, modify, or propose their own approach for any section

---

## Phase 3: Confirm & Generate

Once all sections are approved:

> "Ready to generate the task files? Here's what I'll write:"
> - [N] task files, each self-contained with relevant architecture, models, contracts, decisions, and acceptance criteria

User confirms → generate task files to `.sddw/<feature-name>/design/tasks/`

*In `--critical-only`: still present this summary and wait for confirmation. In `--auto`: generate directly.*

If user wants changes → return to the relevant section in Phase 2.

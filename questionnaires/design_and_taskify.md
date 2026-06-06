# Design and Taskify Questionnaire

Monolithic 3-phase dialog covering everything needed to produce `design.md` and the hybrid task files in a single flow.

---

## Phase 1: Discover

*In `--auto`: perform discovery fully autonomously.*

Understand the implementation landscape for both architecture and task breakdown. One question at a time. Follow-ups via `AskUserQuestion`.

**Step 1 — Open:**
> "I've read the requirements. Before I propose a design and task breakdown, is there anything specific about the architecture or how you'd like the tasks structured (e.g., granularity, parallel work)?"

Wait for response.

**Step 2+** — Follow up based on their answer. Pick ONE at a time:
- **Architecture/Constraints** — "are you thinking this lives in [module] or should it be separate?"
- **Task Granularity** — "do you prefer fine-grained tasks or larger vertical slices?"

Use `AskUserQuestion` with 2-4 concrete options based on what you see in the codebase (or code-analysis.md if available).

---

## Phase 2: Research & Propose

Research and propose ONE section at a time. Wait for approval before moving to the next.

*In `--auto`: decide all sections autonomously.*

### 2.1 Architecture
Present the architecture overview as context text, then use `AskUserQuestion` with options:
- Option 1: [Proposed architecture — description, data flow]
- Option 2: [Alternative approach — description]
Question: "Which architecture do you prefer, or would you adjust?"
Wait for response. Lock in architecture.

### 2.2 Data Models
> "I'd need these entities:"
> - [Entity]: [key fields and types]
> "This requires a migration. Rollback strategy: [description]."
> "Agree, or would you change the schema?"
Wait for response. Lock in data models.

### 2.3 Interface Contracts
> "Shared API endpoints:"
> - [METHOD] [path]: [description, input, output, errors]
> "Internal interfaces (shared and task-specific):"
> - [Module.method(params) -> return]: [purpose]
> "Agree with these contracts?"
Wait for response. Lock in contracts.

### 2.4 Design Decisions
For each non-obvious decision, present ONE at a time using `AskUserQuestion` with options:
- **[Option A] (Recommended)** — [pros]. [cons]. Use `preview` for code snippets if helpful.
- **[Option B]** — [pros]. [cons].
Question: "Decision: [title]. I recommend option 1 because [rationale]. Your call?"
Wait for response. Lock in decision. Move to next decision if any.

### 2.5 Task Breakdown
Based on the approved design sections, propose the task breakdown. Each task will be generated as a hybrid file referencing `design.md`.

Present the task table as context text:
| Task | Description | Depends on | FRs |
|------|-------------|------------|-----|
| 1 | [title] | none | FR-01 |
| 2 | [title] | task-1 | FR-02 |

Then use `AskUserQuestion` with options:
- Option 1: **Approve task breakdown**
- Option 2: **Adjust granularity** (break them down more / combine them)
- Option 3: **Adjust sequencing** (change dependencies)
Question: "How does this task breakdown look?"
Wait for response. Lock in task breakdown.

---

## Phase 3: Confirm & Generate

Once all sections (2.1 through 2.5) are approved:

> "Ready to generate everything? Here's what I'll write:"
> - `design.md` (Architecture, Data Models, Interface Contracts, Design Decisions)
> - `[N]` task files referencing `design.md`

Use `AskUserQuestion` to confirm:
- Option 1: **Generate files**
- Option 2: **Wait, I need to change something**

*In `--auto`: generate directly without confirmation.*

Once confirmed, you SHALL write the files in this strict order:
1. Write `design.md` FIRST to `.sddw/<feature-name>/design/design.md`.
2. Then write the task files to `.sddw/<feature-name>/design/tasks/task-<N>-<slug>.md`.

If the user wants changes, return to the relevant section in Phase 2.

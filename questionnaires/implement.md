# Implement Questionnaire

Three-phase dialog for executing a single task from the design spec.

## Dialog Rules

- Ask ONE question at a time. Wait for the user's response before asking the next.
- Never dump multiple questions in a single message.
- SHALL NOT dump instructions, spec templates, or full output structure to the user. Use them as internal guidance. Present proposals in conversational form and confirm before proceeding.
- When presenting options (task selection, approach choices), SHALL use the AskUserQuestion tool with structured options (2-4 choices). Add "(Recommended)" to the preferred option label.
- Use plain text only for open-ended questions where options don't apply.

---

## Phase 1: Discover

Understand which task to execute and any blockers. One question at a time.

**Step 1 — Task selection:**

If no --task flag provided:
> "Here are the available tasks for [feature-name]:"
> | # | Task | Status | Depends on |
> |---|------|--------|------------|
> | 1 | [name] | done / pending | none |
> | 2 | [name] | done / pending | task 1 |
> "Which task would you like to implement?"

Wait for response.

If --task flag provided, check dependencies:
> "Task [N]: [name]. Dependencies: [status of each]."
> If blocked: "Task [dep] is not yet complete. Proceed anyway?"

Wait for response.

**Step 2 — Context check:**
> "Any context I should know before implementing this? (e.g., changes since the design was written, preferences on approach)"

Wait for response.

---

## Phase 2: Research & Propose

Based on the task file, research implementation approach and propose a plan.

### 2.1 Research

- **Codebase scan** — check current state of files listed in the task (may have changed since design)
- **Test patterns** — identify existing test conventions in the project
- **Library docs** — if the task involves unfamiliar APIs or libraries, research usage patterns

### 2.2 Propose

**Implementation approach:**
> "For this task, I'll:"
> 1. [Step 1 — what I'll do first and why]
> 2. [Step 2]
> 3. [Step 3]
> "TDD: [yes/no — with reasoning based on heuristic]"
> "Proceed?"

Wait for response. User confirms → execute following the instructions.

---

## Phase 3: Confirm & Report

After task completion:

> "Task [N] complete:"
> - Implemented: [what was done]
> - Commit: [hash]
> - Deviations: [count by rule, or "none"]
> - Done criteria: [all checked / issues]

> "Next unblocked tasks: [list]. Run `/sddw:implement <feature> --task <next>`?"

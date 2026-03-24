# Implement Questionnaire

Three-phase dialog for executing a single task from the design spec.

**Mode behavior:** All modes perform the same work. In `--critical-only`, the agent handles non-critical decisions autonomously but asks about dependency conflicts and architectural deviations (Rule 4). In `--auto`, the agent makes all decisions autonomously — except architectural deviations (Rule 4), which always ask the user. See dialog rules for full mode definitions.

> **Tool reminder:** Every question to the user — whether options or open-ended — MUST use the `AskUserQuestion` tool. See "Tool Usage — AskUserQuestion" in dialog rules.

---

## Phase 1: Discover

*In `--critical-only`: pick next unblocked task if no `--task` flag, but ask the user if dependencies are incomplete. In `--auto`: perform discovery fully autonomously.*

Understand which task to execute and any blockers. One question at a time.

**Step 1 — Task selection:**

If no --task flag provided:
Present the task table as context text, then use `AskUserQuestion` with each pending task as an option:
- Task 1: [name] (Depends on: none)
- Task 2: [name] (Depends on: task 1)
Question: "Which task would you like to implement?"

Wait for response.

If --task flag provided, check dependencies:
> "Task [N]: [name]. Dependencies: [status of each]."
> If blocked: use `AskUserQuestion` with options "Yes — proceed anyway" / "No — pick a different task".

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

*In `--critical-only`: decide implementation approach autonomously, proceed to execution. In `--auto`: same.*

---

## Phase 3: Confirm & Report

After task completion:

> "Task [N] complete:"
> - Implemented: [what was done]
> - Commit: [hash]
> - Deviations: [count by rule, or "none"]
> - Done criteria: [all checked / issues]

> "Next unblocked tasks: [list]."
> "**Recommendation:** Clear your context before starting the next task (`/clear` or start a new conversation). Each task is self-contained — a fresh context avoids accumulated noise from this implementation."
> "Then run `/sddw:implement <feature> --task <next>`."

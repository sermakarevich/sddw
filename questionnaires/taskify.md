# Taskify Questionnaire

Three-phase dialog scoped to task breakdown.

---

## Phase 1: Discover

*In `--auto`: perform discovery fully autonomously.*

Understand task-breakdown preferences (granularity, parallelism).

**Step 1 — Discovery:**
Use `AskUserQuestion` to ask an open question:
> "I've read the requirements and design. Anything specific about how to break this into tasks? (e.g., granularity, parallel streams for multiple devs)"

Wait for response.

---

## Phase 2: Research & Propose

*In `--auto`: perform research and propose task breakdown autonomously.*

### 2.1 Research
- **Codebase analysis:** scan relevant files for task context
- **Dependency analysis:** analyze required dependencies (use `code-analysis.md` if present)

### 2.2 Propose Task Breakdown

Present the proposed task breakdown. Use `AskUserQuestion` to confirm.

> "I'd break this into N tasks:"
> 1. [Task Title]
>    - Depends on: [none | task-N]
>    - Files: [files to create/modify, include test files marked "— update (interface change)" if interface changes]
> 2. ...
>
> "Does this breakdown look right?"

Wait for response. If user requests changes, refine and ask again.

---

## Phase 3: Confirm & Generate

*In `--auto`: generate directly without confirming.*

After user confirms the breakdown:
Generate the task files at `.sddw/<feature-name>/design/tasks/task-<N>-<slug>.md` in the hybrid format.
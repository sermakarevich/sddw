## Improvement Report

Written after the self-improve step analyses a completed feature. Stored at `.sddw/<feature-name>/self-improve/report.md`.

**Location:** `.sddw/<feature-name>/self-improve/report.md`

**Format:**
```
# Improvement Report: <feature-name>

## Summary
- **Date:** [ISO date]
- **Feature result:** [PASS | FAIL | PARTIAL] (from verification)
- **Signals:** [deviations] deviations, [difficulties] difficulties, [remediation] remediation tasks
- **Findings:** [count] across [steps affected]
- **Proposals:** [total] proposed, [applied] applied, [skipped] skipped

## Lifecycle Overview
- **Requirements:** [complete] — [N] FRs, [N] acceptance scenarios
- **Code Analysis:** [exists | skipped]
- **Design:** [N] tasks
- **Implementation:** [N/M] tasks completed, [N] deviations, [N] difficulties
- **Verification:** [result] — [N] remediation tasks

## Signal Analysis

### Deviations
[Summary of deviations from completion reports]
- Task [N]: Rule [R] — [description] ([resolved | unresolved])

### Difficulties
[Summary of difficulties from completion reports]
- Task [N]: [difficulty] — [resolution]

### Remediation Origins
[Breakdown of remediation task root causes]
- [N] from requirements — [pattern description]
- [N] from design — [pattern description]
- [N] from implementation — [pattern description]
- [N] from external — [pattern description]

### Uncovered Criteria
[Acceptance criteria not covered by tests]
- FR-[N]: [criterion] — [why uncovered]

## Findings

### Requirements Step
[Findings for this step, or "No issues identified"]
- **F-01:** [description with evidence from artifacts]

### Design Step
- **F-02:** [description]

### Implementation Step
- **F-03:** [description]

### Verification Step
- **F-04:** [description]

## Improvements

### Applied
[List of applied improvements]
- **IMP-01** ([type]: [target file]) — [what was changed]

### Skipped
[List of skipped improvements with reason]
- **IMP-03** ([type]: [target file]) — [reason skipped]

### Proposed (not applied)
[List of proposals the user chose not to apply]
- **IMP-02** ([type]: [target file]) — [proposal summary]
```

**Rules:**
- SHALL be written after all analysis and approval phases complete
- SHALL base all findings on evidence from artifacts — reference specific deviations, difficulties, remediation tasks, or test results
- SHALL classify every finding by the workflow step where the issue originated
- SHALL include the full list of proposals regardless of whether they were applied
- SHALL record which proposals were applied, skipped, or declined
- SHALL be concise — this is a report, not a narrative
- SHALL NOT include speculative findings without artifact evidence
- Re-running self-improve SHALL overwrite the previous report

**Example:**
> # Improvement Report: password-reset
>
> ## Summary
> - **Date:** 2026-03-26
> - **Feature result:** FAIL (from verification)
> - **Signals:** 3 deviations, 1 difficulty, 2 remediation tasks
> - **Findings:** 3 across 2 steps
> - **Proposals:** 3 proposed, 2 applied, 1 skipped
>
> ## Lifecycle Overview
> - **Requirements:** complete — 3 FRs, 7 acceptance scenarios
> - **Code Analysis:** exists
> - **Design:** 3 tasks
> - **Implementation:** 3/3 tasks completed, 3 deviations, 1 difficulty
> - **Verification:** FAIL — 2 remediation tasks
>
> ## Signal Analysis
>
> ### Deviations
> - Task 1: Rule 2 — added `__repr__` to model (resolved)
> - Task 2: Rule 1 — fixed import ordering (resolved)
> - Task 3: Rule 3 — added missing `__init__.py` (resolved)
>
> ### Difficulties
> - Task 1: Alembic autogenerate didn't detect UUID type — manually specified dialect
>
> ### Remediation Origins
> - 0 from requirements
> - 1 from design — task file omitted performance constraint for email delivery
> - 1 from implementation — off-by-one in `is_valid()` boundary comparison
> - 0 from external
>
> ### Uncovered Criteria
> - None — all criteria covered after remediation
>
> ## Findings
>
> ### Requirements Step
> - No issues identified
>
> ### Design Step
> - **F-01:** Task 2 had no performance constraint for email delivery. The 60s SLA from FR-01 acceptance criteria was not carried into the task file's done criteria. This caused the implementation to have no target, and verification caught it as a failure.
> - **F-02:** Alembic UUID difficulty (Task 1) was a known pattern not captured in code analysis. If code analysis had documented ORM-specific quirks, the design step could have included this in the task file.
>
> ### Implementation Step
> - **F-03:** The `is_valid()` boundary comparison used `<` instead of `<=`. The acceptance criterion said "older than 24 hours" which is ambiguous — could mean `>= 24h` or `> 24h`. The requirements step should have been more precise.
>
> ### Verification Step
> - No issues identified
>
> ## Improvements
>
> ### Applied
> - **IMP-01** (questionnaire: `questionnaires/design.md`) — Added a prompt to check whether FR acceptance criteria contain measurable thresholds (time, size, count) and carry them into task done criteria.
> - **IMP-02** (instruction: `instructions/requirements.md`) — Added guidance to use unambiguous boundary language in acceptance criteria (e.g., "strictly greater than" vs "at least").
>
> ### Skipped
> - **IMP-03** (instruction: `instructions/code-analysis.md`) — Proposed adding ORM-specific quirks detection. Skipped: target text in code-analysis.md had changed since analysis.
>
> ### Proposed (not applied)
> - None — all proposals were either applied or skipped due to conflicts.

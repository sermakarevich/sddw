# Self-Improve Questionnaire

Three-phase dialog for analysing feature execution and proposing workflow improvements.

**All modes:** Applying changes to workflow files always requires user approval.

---

## Phase 1: Analyse

*In `--auto`: analyse fully autonomously.*

Load all feature artifacts and extract signals.

**Step 1 — Lifecycle check:**

Present a lifecycle summary:
- Requirements: [complete/incomplete]
- Code Analysis: [exists/skipped]
- Design: [N tasks created]
- Implementation: [N/M tasks completed]
- Verification: [PASS/FAIL/PARTIAL — N remediation tasks]

If verification report is missing, stop:
> "No verification report found. Run `/sddw:verify <feature-name>` first — self-improve needs the full lifecycle."

**Step 2 — Signal extraction:**

Scan all artifacts and extract:

From completion reports (`.done.md`):
- Count and classify deviations by rule (1-4)
- List all difficulties
- Note any spec gaps mentioned

From verification report:
- List FRs that were FAIL or PARTIAL
- List remediation tasks with their Origin classification
- List uncovered acceptance criteria
- List warnings

Present a signal summary:
> "Here's what I found across the feature lifecycle:"
> - Deviations: [N] (Rule 1: [n], Rule 2: [n], Rule 3: [n], Rule 4: [n])
> - Difficulties: [N]
> - Remediation tasks: [N] (requirements: [n], design: [n], implementation: [n], external: [n])
> - Uncovered criteria: [N]
> - Warnings: [N]

If any root cause origin seems ambiguous, use `AskUserQuestion`:
- "[Origin A] — [reasoning]"
- "[Origin B] — [reasoning]"
Question: "This remediation task could stem from either step. What's your read?"

Wait for response.

---

## Phase 2: Diagnose

*In `--auto`: diagnose autonomously, still present proposals for approval.*

### 2.1 Pattern Analysis

Group findings by workflow step:

> **Requirements step:** [N findings]
> - [finding 1 with evidence]
> - [finding 2 with evidence]
>
> **Design step:** [N findings]
> - ...
>
> **Implementation step:** [N findings]
> - ...
>
> **Verification step:** [N findings]
> - ...

If no findings for a step, show "No issues identified."

### 2.2 Improvement Proposals

For each finding, propose a concrete improvement:

> **IMP-01** ([type]: [target file])
> - **Step:** [affected step]
> - **Finding:** [what went wrong, with evidence]
> - **Proposal:** [what to change]
> - **Diff preview:**
> ```diff
> - [old text]
> + [new text]
> ```

Present all proposals as a batch.

Use `AskUserQuestion`:
- "Apply all improvements (Recommended)"
- "Select which to apply"
- "Skip — generate report only"

Wait for response.

If "Select which to apply": use `AskUserQuestion` with `multiSelect: true`, listing each IMP-ID as an option.

Wait for response.

---

## Phase 3: Apply & Report

### 3.1 Apply Changes

For each approved improvement:
1. Read the target file
2. Apply the change
3. Confirm: > "Applied IMP-01 to [file]"

If a change conflicts with the current file content (e.g., the target text was already modified), warn and skip:
> "IMP-03 skipped — target text in [file] has changed since analysis."

### 3.2 Generate Report

Generate the improvement report to `.sddw/<feature-name>/self-improve/report.md`.

Present a summary:
> "Improvement report generated."
> - Findings: [N] across [M] steps
> - Proposals: [N] total
> - Applied: [N]
> - Skipped: [N]

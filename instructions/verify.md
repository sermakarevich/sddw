# Verify Step Instructions

Verify the implementation against requirements, run tests, and create remediation tasks if issues are found. This is the final step of the sddw workflow.

## Goal

Confirm that all functional requirements are implemented correctly, tests pass, and acceptance criteria are satisfied. If issues are found, produce remediation task files that can be executed with `/sddw:implement`.

## Prerequisites

Read the feature artifacts from `<resolved-sddw-path>/<feature-name>/`:

| Artifact | Path | Required |
|----------|------|----------|
| Requirements | `<feature-name>/requirements.md` | Yes |
| Task files | `<feature-name>/design/tasks/task-*.md` | Yes |
| Completion reports | `<feature-name>/implement/tasks/*.done.md` | Yes |
| Code analysis | `code-analysis.md` | No |

If requirements or task files do not exist, stop and suggest running the missing step first.

If no completion reports exist, warn the user that no tasks appear to have been implemented and suggest running `/sddw:implement` first.

Use the Project path from `<resolved-sddw-path>/<feature-name>/requirements.md` as the working directory.

## Process

Follow the three-phase flow defined in the questionnaire:

1. **Assess** — Load all artifacts, identify the test runner, check which tasks are complete vs pending. *In `--critical-only`: assess autonomously, ask only if test runner cannot be detected. In `--auto`: assess fully autonomously.*

2. **Verify** — Run the test suite, cross-check each FR's acceptance criteria against implementation, review done criteria from task files, and check for deviations noted in completion reports. Classify each FR as pass, fail, or partial. *In `--critical-only`: classify autonomously, ask only for ambiguous results. In `--auto`: classify all autonomously.*

3. **Report & Remediate** — Produce a verification report. If any FRs failed or are partial, propose remediation tasks. User confirms which remediation tasks to create. *In `--critical-only`: still present remediation tasks for approval. In `--auto`: create all proposed remediation tasks directly.*

---

## Verification Checks

For each functional requirement (FR) in the requirements spec:

### 1. Test Execution
- Detect the test runner from the codebase (look for test config files, package.json scripts, pytest.ini, pyproject.toml, Makefile test targets, etc.)
- Run the full test suite
- Record pass/fail counts, failing test names, and error messages

### 2. Acceptance Criteria Coverage
For each FR's acceptance criteria (Given/When/Then scenarios from requirements.md):
- Check if a corresponding test exists that covers the scenario
- If the scenario has no test, flag as uncovered
- If a test exists but fails, flag as failing

### 3. Done Criteria Check
For each completed task's done criteria:
- Verify each criterion is satisfied (file exists, function works, constraint met)
- Cross-reference with the completion report

### 4. Deviation Review
From completion reports (.done.md files):
- Check if any noted deviations have unresolved consequences
- Check if spec gaps noted during implementation were addressed

---

## Issue Classification

| Severity | Condition | Action |
|----------|-----------|--------|
| **Fail** | Test failure, missing required functionality, acceptance criterion violated | Create remediation task |
| **Partial** | Acceptance criterion uncovered by tests, done criterion partially met | Create remediation task |
| **Warning** | Unresolved deviation, minor gap, missing edge case | Note in report, user decides |
| **Pass** | All criteria met, tests pass | No action needed |

---

## Remediation Tasks

When issues are found, create remediation task files in the same location as design tasks:

`.sddw/<feature-name>/design/tasks/task-<N>-fix-<slug>.md`

Where `<N>` continues the numbering from existing tasks. Follow the same task file format from the design-task spec.

**Rules for remediation tasks:**
- SHALL follow the exact same format as design task files
- SHALL reference the FR-IDs that need fixing
- SHALL include the specific failing tests or uncovered criteria in the acceptance criteria section
- `Depends on:` SHALL reference the original task that implemented the failing functionality
- SHALL be scoped to fix the specific issue — no scope creep
- SHALL be implementable with `/sddw:implement <feature-name> --task <N>`
- SHALL classify the root cause origin in the verification report: `requirements` (ambiguous/missing spec), `design` (task scoping/architecture gap), `implementation` (code bug), or `external` (dependency/environment issue)

---

## Rules

- SHALL run actual tests, not assume results
- SHALL classify every FR explicitly as PASS, FAIL, or PARTIAL
- SHALL reference specific test names and error messages for failures
- SHALL overwrite the previous verification report when re-run (idempotent)
- SHALL NOT modify existing task files or completion reports
- SHALL NOT create remediation tasks without user approval (interactive and `--critical-only` modes). `--auto` mode may create them directly.
- SHALL NOT proceed to report generation without completing all verification checks

## Output

```
.sddw/<feature-name>/verify/
└── report.md
```

And optionally:

```
.sddw/<feature-name>/design/
└── tasks/
    ├── task-<N>-fix-<slug>.md
    └── ...
```

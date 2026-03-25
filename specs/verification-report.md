## Verification Report

Written after the verify step runs. Stored at `.sddw/<feature-name>/verify/report.md`.

**Location:** `.sddw/<feature-name>/verify/report.md`

**Format:**
```
# Verification Report: <feature-name>

## Summary
- **Date:** [ISO date]
- **FRs:** [passed]/[total] passed, [failed] failed, [partial] partial
- **Tests:** [passed] passed, [failed] failed, [skipped] skipped
- **Result:** [PASS | FAIL | PARTIAL]

## Test Execution
- **Runner:** [test runner used]
- **Command:** [test command executed]
- **Duration:** [time if available]

### Failures
- `[test name]` — [brief error]

## FR Verification

### FR-01: [title] — [PASS | FAIL | PARTIAL]

**Acceptance Criteria:**
- [x] [scenario description] — covered by `[test name]`
- [ ] [scenario description] — not covered

**Done Criteria** (from task-N):
- [x] [criterion]
- [ ] [criterion] — [why not met]

**Issues:**
- [description of issue, or "None"]

### FR-02: ...

## Deviations
[Unresolved deviations from completion reports, or "None"]
- Task [N]: [deviation] — [status: resolved | unresolved | accepted]

## Remediation Tasks
[List of created remediation tasks, or "None — all checks passed"]
- task-[N]-fix-[slug].md — [what it fixes] (FR-01)

## Warnings
[Non-blocking concerns, or "None"]
- [warning description]
```

**Rules:**
- SHALL be written after all verification checks complete
- SHALL include actual test output, not assumptions
- SHALL classify every FR explicitly as PASS, FAIL, or PARTIAL
- SHALL reference specific test names and error messages for failures
- SHALL list remediation tasks if any were created
- SHALL be concise — this is a report, not a narrative
- Overall result SHALL be PASS only if all FRs pass and all tests pass
- Re-running verify SHALL overwrite the previous report

**Example:**
> # Verification Report: password-reset
>
> ## Summary
> - **Date:** 2026-03-25
> - **FRs:** 2/3 passed, 1 failed, 0 partial
> - **Tests:** 11 passed, 2 failed, 0 skipped
> - **Result:** FAIL
>
> ## Test Execution
> - **Runner:** pytest
> - **Command:** `pytest tests/ -v`
> - **Duration:** 3.2s
>
> ### Failures
> - `test_reset_token_expiry` — AssertionError: token accepted after 24h
> - `test_reset_email_timing` — TimeoutError: email sent after 90s
>
> ## FR Verification
>
> ### FR-01: Password reset email — FAIL
>
> **Acceptance Criteria:**
> - [x] Happy path: reset email sent — covered by `test_reset_email_sent`
> - [ ] Failure path: unregistered email — covered by `test_reset_email_timing` (FAILING)
>
> **Done Criteria** (from task-1):
> - [x] Migration creates `password_reset_tokens` table
> - [x] Model class exists with all fields
> - [ ] Email sent within 60 seconds — test failing (90s observed)
>
> **Issues:**
> - Email sending exceeds 60s SLA
>
> ### FR-02: Reset link expiry — FAIL
>
> **Acceptance Criteria:**
> - [x] Happy path: valid token accepted — covered by `test_valid_token`
> - [ ] Failure path: expired token rejected — covered by `test_reset_token_expiry` (FAILING)
>
> **Done Criteria** (from task-1):
> - [x] `is_valid()` method exists
> - [ ] Expired tokens rejected — test failing
>
> **Issues:**
> - `is_valid()` uses `<` instead of `<=` for expiry comparison
>
> ### FR-03: No email disclosure — PASS
>
> **Acceptance Criteria:**
> - [x] Same confirmation for registered and unregistered — covered by `test_no_email_disclosure`
>
> **Issues:**
> - None
>
> ## Deviations
> - Task 1: Added `__repr__` to model (Rule 2) — resolved, no impact
>
> ## Remediation Tasks
> - task-4-fix-token-expiry.md — fix `is_valid()` boundary comparison (FR-02)
> - task-5-fix-email-timing.md — optimise email sending to meet 60s SLA (FR-01)
>
> ## Warnings
> - None

# Verify Questionnaire

Three-phase dialog for verifying implementation against specs.

---

## Phase 1: Discover

Understand verification scope and any known issues.

**Open question:**
> "I'll verify [feature-name] against the requirements and design specs. Any areas you're particularly concerned about?"

**Context checklist:**
- [ ] All tasks completed (check done criteria in task files)
- [ ] Any known issues or shortcuts taken during implementation
- [ ] Any spec changes made during implementation

---

## Phase 2: Research & Propose

Run verification checks and present findings.

### 2.1 Research

- **FR coverage scan** — for each FR, trace to task → code → test
- **Constraint compliance** — check in-scope delivered, out-of-scope not implemented, prohibitions respected
- **Test execution** — run test suite, collect results
- **Design compliance** — check interface contracts match implementation, data models match schema

### 2.2 Propose

**Coverage report:**
> "FR coverage:"
> | FR | Task | Code | Test | Status |
> |----|------|------|------|--------|
> | FR-01 | task-1 | src/... | tests/... | pass/fail/missing |
> "Constraints: [all passed / issues]"
> "Tests: [N passed, M failed, K missing]"

**Issues found:**
> "[N] issues found:"
> 1. [Issue — severity, what's wrong, suggested fix]
> 2. [Issue — severity, what's wrong, suggested fix]
> "Fix these before approving, or accept with known issues?"

---

## Phase 3: Confirm & Generate

After review:

> "Verification [passed / passed with issues / failed]:"
> - FRs covered: [X/Y]
> - Tests passing: [X/Y]
> - Constraints respected: [all / list exceptions]
> "Generate verification report?"

User confirms → generate `.sddw/<feature-name>/verification.md`

# Verify Step Instructions

Verify the implementation against requirements and design specs. This is Step 4 of the sddw workflow.

## Prerequisites

Read the specs and implementation:
- `.sddw/<feature-name>/requirements.md` — functional requirements, acceptance criteria, constraints
- `.sddw/<feature-name>/design/analysis.md` — architecture, data models, interface contracts
- `.sddw/<feature-name>/design/tasks/` — task files with done criteria

## Process

Follow the three-phase flow defined in the questionnaire:

1. **Discover** — Ask the user about any known issues or areas of concern. Check task file completion status.

2. **Research & Propose** — Run verification checks: FR coverage, constraint compliance, test execution, design compliance. Present findings with issues ranked by severity.

3. **Confirm & Generate** — User reviews findings. Generate verification report to `.sddw/<feature-name>/verification.md`.

## Verification Checks

### FR Coverage
For each FR in the requirements spec:
- Trace to task(s) in design
- Verify implementation exists in codebase
- Verify tests exist and pass for acceptance criteria

### Constraint Compliance
- All In Scope items are delivered
- No Out of Scope items were implemented
- All Prohibitions (SHALL NOT) are respected

### Design Compliance
- Interface contracts match implementation (endpoints, signatures, error codes)
- Data models match schema (fields, types, constraints)
- Codebase conventions were followed

### Test Execution
- Run the test suite
- Report pass/fail/missing per FR

## Rules

- SHALL verify every FR has corresponding implementation and tests
- SHALL verify every Prohibition is respected
- SHALL NOT mark verification as passed if any FR lacks test coverage
- SHALL flag any design deviations not documented during implementation
- SHALL report spec gaps discovered during implementation

## Output

```
.sddw/<feature-name>/verification.md
```

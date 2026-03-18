---
name: sddw:verify
description: Verify implementation against requirements and design specs, checking completeness, correctness, and test coverage
argument-hint: "<feature-name>"
---

# Verify Step

Verify the implementation against requirements and design specs. This is Step 4 of the sddw workflow.

## Input

<feature_name> #$ARGUMENTS </feature_name>

## Prerequisites

Read all specs and check implementation:
@.sddw/<feature-name>/requirements.md
@.sddw/<feature-name>/design.md

## Process

1. **Load specs** — Read requirements and design specs.

2. **Check requirement coverage** — For each FR, verify:
   - At least one task implements it (from design spec)
   - Implementation exists in the codebase
   - Acceptance criteria are satisfied (run or inspect tests)

3. **Check design compliance** — Verify:
   - Interface contracts match implementation (endpoints, signatures, error codes)
   - Data models match schema (fields, types, constraints)
   - Codebase conventions were followed
   - No design deviations without documented approval

4. **Check constraints** — Verify:
   - All In Scope items are delivered
   - No Out of Scope items were implemented
   - All Prohibitions (SHALL NOT) are respected

5. **Run tests** — Execute the test suite and report results.

6. **Generate verification report** — Write to `.sddw/<feature-name>/verification.md`:
   - FR coverage matrix (FR-ID → task → test → status)
   - Constraint compliance (pass/fail per constraint)
   - Test results summary
   - Issues found (if any)

## Rules

- SHALL verify every FR has corresponding implementation and tests
- SHALL verify every Prohibition is respected
- SHALL NOT mark verification as passed if any FR lacks test coverage
- SHALL flag any design deviations

## Output

```
.sddw/<feature-name>/verification.md
```

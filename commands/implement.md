---
name: sddw:implement
description: Implement tasks from the design spec following TDD and existing codebase patterns
argument-hint: "<feature-name> [--task <task-number>]"
---

# Implement Step

Implement the feature based on the design spec. This is Step 3 of the sddw workflow. Reads both requirements and design specs as input.

## Input

<feature_name> #$ARGUMENTS </feature_name>

## Prerequisites

Read the specs produced by Steps 1 and 2:
@.sddw/<feature-name>/requirements.md
@.sddw/<feature-name>/design.md

If either spec does not exist, inform the user and suggest running the missing step first.

## Process

1. **Load specs** — Read requirements and design specs. Extract task list, dependency order, and acceptance criteria.

2. **Execute tasks** in dependency order:
   - For each task, follow TDD: write test first, then implement until test passes
   - Respect the interface contracts from the design spec
   - Follow codebase conventions identified in the design spec
   - Commit after each completed task

3. **Track progress** — Update task checkboxes in `.sddw/<feature-name>/design.md` as tasks complete.

4. **Report completion** — Summarise what was implemented and suggest verification.

## Rules

- SHALL follow the task order from the design spec
- SHALL respect interface contracts and data models exactly as specified
- SHALL follow TDD: test first, then implementation
- SHALL NOT deviate from the design without user approval
- SHALL commit after each task with a descriptive message

## Output

- Implemented code following the design spec
- Updated `.sddw/<feature-name>/design.md` with checked-off tasks

## Next Step

After implementation is complete, suggest running:
> `/sddw:verify <feature-name>`

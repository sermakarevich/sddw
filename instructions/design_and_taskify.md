# Design and Taskify Step Instructions

Generate the cross-cutting `design.md` plus hybrid task files for a feature in a single combined dialog. Step 3 of the sddw workflow when the user wants the simple one-shot path. End artefacts are structurally equivalent to running `/sddw:design` then `/sddw:taskify`.

## Goal

Produce both `design.md` (the shared architecture, data models, interface contracts, and design decisions) and the hybrid task files (`task-<N>-<slug>.md`) that reference it. This command provides a single monolithic flow for smaller features where design and task decomposition can be approved together.

## Prerequisites

Read the requirements spec:
`<resolved-sddw-path>/<feature-name>/requirements.md`

If the requirements spec does not exist, inform the user and suggest running `/sddw:requirements <feature-name>` first (fail-soft).

Check if `<resolved-sddw-path>/code-analysis.md` exists. If it does, read it and use it to ground design decisions. If it does not exist, that is fine — perform lightweight codebase scanning as needed.

Check if `<resolved-sddw-path>/<feature-name>/design/design.md` already exists:
- **Interactive mode:** use `AskUserQuestion` with options `Overwrite` / `Edit existing` / `Abort` before proceeding.
- **`--auto` mode:** refuse with message "design.md already exists at <path>; re-run interactively or delete it first"

## Process

Follow the monolithic 3-phase flow defined in the questionnaire (`questionnaires/design_and_taskify.md`):

1. **Discover** — Ask the user about preferred architectural approaches and task-breakdown preferences (granularity, parallelism) in one go. *In `--auto`: perform discovery fully autonomously.*
2. **Research & Propose** — For each design concern (architecture, data models, interface contracts, design decisions) AND the task breakdown, propose ranked options with rationale. User accepts, modifies, or provides their own approach. Each section is approved before moving to the next. *In `--auto`: decide all sections autonomously.*
3. **Confirm & Generate** — Single confirmation for the entire set of proposals. Once confirmed, write `design.md` FIRST, then write the task files. *In `--auto`: generate directly.*

## Rules

- SHALL produce artefacts structurally equivalent to running the split flow (`/sddw:design` then `/sddw:taskify`) (FR-03).
- SHALL write `design.md` before any task files, ensuring `design.md` is preserved if task generation aborts mid-flow.
- Every FR from the requirements spec SHALL be covered by at least one task.
- Tasks SHALL declare `Depends on:` for sequencing.
- Tasks SHALL use the hybrid format from `specs/design-task.md`, referencing `design.md` for cross-cutting concerns.
- SHALL NOT silently overwrite an existing `design.md` (see Prerequisites).
- SHALL NOT proceed to generation without user approval in interactive mode. `--auto` mode may proceed without approval.

## Output

```
.sddw/<feature-name>/design/
├── design.md
└── tasks/
    ├── task-1-<slug>.md
    ├── task-2-<slug>.md
    └── ...
```

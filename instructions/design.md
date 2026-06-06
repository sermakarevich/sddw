# Design Step Instructions

Generate the cross-cutting design artefact — `design.md` — for a feature. This is Step 3 of the sddw split flow (or part of Step 3 in the combined `/sddw:design_and_taskify`). Produces ONLY `design.md`; task files come from `/sddw:taskify`.

## Goal

Produce `design.md` — the shared architecture, data models, interface contracts, and design decisions that all tasks reference. This file is the single source of truth for cross-cutting design context.

## Prerequisites

Read the requirements spec:
`<resolved-sddw-path>/<feature-name>/requirements.md`

If the requirements spec does not exist, inform the user and suggest running `/sddw:requirements <feature-name>` first.

Check if `<resolved-sddw-path>/code-analysis.md` exists. If it does, read it and use it to ground design decisions. If it does not exist, that is fine — perform lightweight codebase scanning as needed.

Check if `<resolved-sddw-path>/<feature-name>/design/design.md` already exists:
- **Interactive mode:** use `AskUserQuestion` with options `Overwrite` / `Edit existing` / `Abort` before writing
- **`--auto` mode:** refuse with message "design.md already exists at <path>; re-run interactively or delete it first"

## Process

Follow the three-phase flow defined in the questionnaire:

1. **Discover** — Ask the user about preferred approaches, constraints, and integration concerns. The requirements spec provides the "what" — now understand the user's preferences for "how". *In `--auto`: perform discovery fully autonomously.*

2. **Research & Propose** — For each design concern (architecture, data models, interface contracts, design decisions), propose ranked options with rationale. User accepts, modifies, or provides their own approach. *In `--auto`: decide all sections autonomously.*

3. **Confirm & Generate** — Summarise what will be written. User confirms. Generate `design.md` following the spec template. *In `--auto`: generate directly.*

## Rules

- SHALL read and reference the requirements spec — every design element traces to an FR
- SHALL use the Project path from the requirements spec as the target codebase for analysis
- SHALL use `.sddw/code-analysis.md` if it exists, but SHALL NOT require it
- SHALL analyse the actual codebase if code-analysis is absent
- Every design element SHALL trace to one or more FR-IDs
- Every FR SHALL appear in at least one design element
- SHALL NOT generate task files — task decomposition is the responsibility of `/sddw:taskify`
- SHALL NOT introduce patterns that conflict with existing codebase conventions
- SHALL document non-obvious decisions with rationale and rejected alternatives
- SHALL NOT proceed to generation without user approval (interactive mode). `--auto` mode may proceed without approval.
- SHALL NOT silently overwrite an existing `design.md` — see Prerequisites above

## Output

```
.sddw/<feature-name>/design/
└── design.md
```

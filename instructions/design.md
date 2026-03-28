# Design Step Instructions

Generate design as self-contained task files for a feature. This is Step 3 of the sddw workflow (or Step 2 if code-analysis was skipped). Reads the requirements spec and optionally the code analysis as input.

## Goal

Produce self-contained task files — each containing everything needed to implement that task.

## Prerequisites

Read the requirements spec produced by the requirements step:
`<resolved-sddw-path>/<feature-name>/requirements.md`

If the requirements spec does not exist, inform the user and suggest running `/sddw:requirements <feature-name>` first.

Check if `<resolved-sddw-path>/code-analysis.md` exists. If it does, read it and use it to ground design decisions. If it does not exist, that is fine — the code-analysis step is optional. In that case, perform lightweight codebase scanning as needed during design.

## Process

Follow the three-phase flow defined in the questionnaire:

1. **Discover** — Ask the user about preferred approaches, constraints, and integration concerns. The requirements spec provides the "what" — now understand the user's preferences for "how". *In `--auto`: perform discovery fully autonomously.*

2. **Research & Propose** — For each design concern (architecture, data models, interface contracts, design decisions), propose ranked options with rationale. Then propose the task breakdown — each task becomes a self-contained task file that includes all relevant design details inline. User accepts, modifies, or provides their own approach. *In `--auto`: decide all sections autonomously.*

3. **Confirm & Generate** — Summarise what will be written. User confirms. Generate the task files following the spec template. *In `--auto`: generate directly.*

## Rules

- SHALL read and reference the requirements spec — every design element traces to an FR
- SHALL use the Project path from the requirements spec as the target codebase for analysis
- SHALL use `.sddw/code-analysis.md` if it exists, but SHALL NOT require it
- SHALL analyse the actual codebase if code-analysis is absent
- Every task SHALL trace to one or more FR-IDs
- Every FR SHALL appear in at least one task
- Tasks SHALL be dependency-ordered (independent first) with explicit `Depends on:` field
- Each task file SHALL be self-contained with all context needed to implement, including architecture, data models, contracts, and design decisions relevant to that task
- SHALL NOT introduce patterns that conflict with existing codebase conventions
- SHALL document non-obvious decisions with rationale and rejected alternatives
- SHALL NOT proceed to generation without user approval (interactive mode). `--auto` mode may proceed without approval.

## Output

```
.sddw/<feature-name>/design/
└── tasks/
    ├── task-1-<slug>.md
    ├── task-2-<slug>.md
    └── ...
```

# Design Step Instructions

Generate design artifacts for a feature. This is Step 2 of the sddw workflow. Reads the requirements spec from Step 1 as input.

## Goal

Produce precise, clear, and complete design artifacts in cooperation with the user. Every section written to the output files SHALL be explicitly accepted by the user before generation. The design is a co-authored artifact — the agent proposes, the user decides.

## Prerequisites

Read the requirements spec produced by Step 1:
`.sddw/<feature-name>/requirements.md`

If the requirements spec does not exist, inform the user and suggest running `/sddw:requirement <feature-name>` first.

## Process

Follow the three-phase flow defined in the questionnaire:

1. **Discover** — Ask the user about preferred approaches, constraints, and integration concerns. The requirements spec provides the "what" — now understand the user's preferences for "how".

2. **Research & Propose** — Analyse the codebase for patterns, interfaces, and conventions. For each design section (architecture, data models, interface contracts, design decisions, task breakdown), propose ranked options with rationale. User accepts, modifies, or provides their own approach.

3. **Confirm & Generate** — Summarise what will be written. User confirms. Generate the artifacts following the spec templates.

## Rules

- SHALL read and reference the requirements spec — every design element traces to an FR
- SHALL analyse the actual codebase, not assume patterns
- Every task SHALL trace to one or more FR-IDs
- Every FR SHALL appear in at least one task
- Tasks SHALL be dependency-ordered (independent first) with explicit `Depends on:` field
- Each task file SHALL be self-contained with all context needed to implement
- SHALL NOT introduce patterns that conflict with existing codebase conventions
- SHALL document non-obvious decisions with rationale and rejected alternatives
- SHALL NOT proceed to generation without user approval

## Output

```
.sddw/<feature-name>/design/
├── analysis.md
└── tasks/
    ├── task-1-<slug>.md
    ├── task-2-<slug>.md
    └── ...
```

## Next Step

After the user approves the design, suggest:
> Run `/clear` to free up context, then `/sddw:implement <feature-name> --task 1`

# Design Step Instructions

Generate design artifacts for a feature. This is Step 2 of the sddw workflow. Reads the requirements spec from Step 1 as input.

## Goal

Produce precise, clear, and complete design artifacts. In interactive mode (default), every section is explicitly accepted by the user before generation. In `--critical-only` mode, the agent makes non-critical decisions autonomously but asks the user for critical ones. In `--auto` mode, the agent makes all decisions autonomously. See dialog rules for mode behavior.

## Prerequisites

Read the requirements spec produced by Step 1:
`.sddw/<feature-name>/requirements.md`

If the requirements spec does not exist, inform the user and suggest running `/sddw:requirements <feature-name>` first.

## Process

Follow the three-phase flow defined in the questionnaire:

1. **Discover** — Ask the user about preferred approaches, constraints, and integration concerns. The requirements spec provides the "what" — now understand the user's preferences for "how". *In `--critical-only`: infer non-critical preferences autonomously, but ask about preferred architectural approach if multiple viable options exist. In `--auto`: perform discovery fully autonomously.*

2. **Research & Propose** — Check if `.sddw/code-analysis.md` exists. If it does, show the user when it was last updated and ask whether it needs updating for this feature. If it does not exist, analyse the codebase from scratch. Then for each feature-specific design section (architecture, data models, interface contracts, design decisions), propose ranked options with rationale. Then propose the task breakdown — each approved task becomes a self-contained task file. User accepts, modifies, or provides their own approach. *In `--critical-only`: decide data models and contracts autonomously, ask only for architecture approach and design decisions with trade-offs. In `--auto`: decide all sections autonomously.*

3. **Confirm & Generate** — Summarise what will be written. User confirms. Generate the artifacts following the spec templates. *In `--critical-only`: still present final summary for approval. In `--auto`: generate directly.*

## Rules

- SHALL read and reference the requirements spec — every design element traces to an FR
- SHALL use the Project path from the requirements spec as the target codebase for analysis
- SHALL analyse the actual codebase, not assume patterns
- Every task SHALL trace to one or more FR-IDs
- Every FR SHALL appear in at least one task
- Tasks SHALL be dependency-ordered (independent first) with explicit `Depends on:` field
- Each task file SHALL be self-contained with all context needed to implement
- SHALL NOT introduce patterns that conflict with existing codebase conventions
- SHALL document non-obvious decisions with rationale and rejected alternatives
- SHALL NOT proceed to generation without user approval (interactive mode) or critical sections (`--critical-only` mode). `--auto` mode may proceed without approval.

## Output

```
.sddw/
├── code-analysis.md              # shared, project-level — created or updated
└── <feature-name>/
    └── design/
        ├── analysis.md            # feature-specific architecture, models, contracts, decisions
        └── tasks/
            ├── task-1-<slug>.md
            ├── task-2-<slug>.md
            └── ...
```


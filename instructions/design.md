# Design Step Instructions

Generate a design specification for a feature. This is Step 2 of the sddw workflow. Reads the requirements spec from Step 1 as input.

## Prerequisites

Read the requirements spec produced by Step 1:
`.sddw/<feature-name>/requirements.md`

If the requirements spec does not exist, inform the user and suggest running `/sddw:requirement <feature-name>` first.

## Process

1. **Read requirements spec** — Load `.sddw/<feature-name>/requirements.md` and extract all FRs, acceptance criteria, and constraints.

2. **Analyse the codebase** — Identify relevant patterns, key interfaces, existing flows, and conventions that the design must follow.

3. **Generate analysis.md** following the design-analysis spec template:
   - **Codebase Analysis** — patterns, interfaces, flows, conventions
   - **Architecture** — component breakdown (new/existing/modified), data flow for happy and error paths
   - **Data Models** — entities with typed fields and constraints, relationships, schema changes
   - **Interface Contracts** — API endpoints with input/output/errors, internal method signatures with pre/post-conditions
   - **Design Decisions** — chosen approach, rationale, rejected alternatives

4. **Generate individual task files** following the design-task spec template. For each task, create a self-contained file that includes:
   - FR-IDs it traces to
   - Dependencies on other tasks
   - Files to create or modify
   - Relevant interface contracts (copied from analysis.md)
   - Relevant acceptance criteria (copied from requirements.md)
   - Done criteria

5. **Write the artifacts** to:
   ```
   .sddw/<feature-name>/design/analysis.md
   .sddw/<feature-name>/design/tasks/task-1-<slug>.md
   .sddw/<feature-name>/design/tasks/task-2-<slug>.md
   ...
   ```

6. **Present to user** for review and refinement. Iterate until approved.

## Rules

- SHALL read and reference the requirements spec — every design element traces to an FR
- SHALL analyse the actual codebase, not assume patterns
- Every task SHALL trace to one or more FR-IDs
- Every FR SHALL appear in at least one task
- Tasks SHALL be dependency-ordered (independent first) with explicit `Depends on:` field
- Each task file SHALL be self-contained with all context needed to implement
- SHALL NOT introduce patterns that conflict with existing codebase conventions
- SHALL document non-obvious decisions with rationale and rejected alternatives

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

After the user approves the design, suggest running:
> `/sddw:implement <feature-name>`

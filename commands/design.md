---
name: sddw:design
description: Generate design spec by analysing codebase, defining architecture, data models, interfaces, and task decomposition
argument-hint: "<feature-name>"
---

# Design Step

Generate a design specification for a feature. This is Step 2 of the sddw workflow. Reads the requirements spec from Step 1 as input.

## Input

<feature_name> #$ARGUMENTS </feature_name>

## Prerequisites

Read the requirements spec produced by Step 1:
@.sddw/<feature-name>/requirements.md

If the requirements spec does not exist, inform the user and suggest running `/sddw:requirement <feature-name>` first.

## Spec Reference

Read the design spec template before generating:
@specs/design.md

## Process

1. **Read requirements spec** — Load `.sddw/<feature-name>/requirements.md` and extract all FRs, acceptance criteria, and constraints.

2. **Analyse the codebase** — Identify relevant patterns, key interfaces, existing flows, and conventions that the design must follow.

3. **Generate the design spec** following the template structure:
   - **Codebase Analysis** — patterns, interfaces, flows, conventions
   - **Architecture** — component breakdown (new/existing/modified), data flow for happy and error paths
   - **Data Models** — entities with typed fields and constraints, relationships, schema changes
   - **Interface Contracts** — API endpoints with input/output/errors, internal method signatures with pre/post-conditions
   - **Task Decomposition** — atomic tasks traced to FR-IDs, dependency-ordered, with file references
   - **Design Decisions** — chosen approach, rationale, rejected alternatives

4. **Write the spec** to `.sddw/<feature-name>/design.md` in the project root.

5. **Present to user** for review and refinement. Iterate until approved.

## Rules

- SHALL read and reference the requirements spec — every design element traces to an FR
- SHALL analyse the actual codebase, not assume patterns
- Every task SHALL trace to one or more FR-IDs
- Every FR SHALL appear in at least one task
- Tasks SHALL be dependency-ordered (independent first) with explicit `Depends on:` field
- SHALL NOT introduce patterns that conflict with existing codebase conventions
- SHALL document non-obvious decisions with rationale and rejected alternatives

## Output

```
.sddw/<feature-name>/design.md
```

## Next Step

After the user approves the design, suggest running:
> `/sddw:implement <feature-name>`

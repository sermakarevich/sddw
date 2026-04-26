# Taskify Step Instructions

Goal: Generate hybrid task files for a feature. This is Step 4 of the sddw split flow. Reads `requirements.md` and `design.md`; produces task files referencing `design.md` for cross-cutting context.

## Prerequisites

Read the requirements: `<resolved-sddw-path>/<feature-name>/requirements.md`.
If the requirements file cannot be found, tell the user and suggest running `/sddw:requirements <feature-name>` first.

Read the design: `<resolved-sddw-path>/<feature-name>/design/design.md`.
If the design file cannot be found, output a message containing the exact substring `design.md not found` plus a pointer to `/sddw:design <feature-name>`. SHALL NOT write any task files.

(Optional) Read the code analysis: `<resolved-sddw-path>/code-analysis.md` if present.

## Process

Follow the 3-phase flow defined in the questionnaire.

## Rules

- SHALL read and reference both `requirements.md` and `design.md`.
- Every task SHALL trace to one or more FR-IDs.
- Every FR SHALL appear in at least one task.
- Tasks SHALL be dependency-ordered with explicit `Depends on:` field.
- Each task file SHALL follow the hybrid format defined in `specs/design-task.md`.
- SHALL include existing test files affected by interface changes in the Files section.
- SHALL NOT proceed to generation without user approval (in interactive mode); `--auto` may proceed.

## Output

Task files written to: `<resolved-sddw-path>/<feature-name>/design/tasks/task-<N>-<slug>.md`
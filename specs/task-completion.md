## Task Completion Report

Written after a task is implemented. Stored in the implement folder as `task-<N>-<slug>.done.md`.

**Location:** `.sddw/<feature-name>/implement/tasks/task-<N>-<slug>.done.md`

**Format:**
```
# Task <N> Completion: [title from task file]

## Summary
[1-3 sentences: what was implemented]

## Commits
- `<hash>` <message>

## Deviations
[List deviations from the task spec, or "None"]
- **Rule <N>: <type>** — [what was found] → [what was done]

## Difficulties
[List unexpected issues encountered, or "None"]
- [Issue] — [how it was resolved]

## Notes
[Optional: anything useful for future tasks or the next developer]
```

**Rules:**
- SHALL be written after the task commit(s), not before
- SHALL reference actual commit hashes
- SHALL list ALL deviations, even auto-fixed ones (Rules 1-3)
- SHALL be concise — this is a log, not a narrative
- Difficulties SHALL include resolution, not just the problem
- Notes section is optional — omit if nothing useful to add
- SHALL NOT modify the original task file (task-N-*.md) — it remains as the spec

**Example:**
> # Task 1 Completion: Create password reset token migration and model
>
> ## Summary
> Created Alembic migration for `password_reset_tokens` table and `PasswordResetToken` model with `is_valid()` method.
>
> ## Commits
> - `a1b2c3d` test(password-reset): add failing tests for token model (FR-01, FR-02)
> - `e4f5g6h` feat(password-reset): create token migration and model (FR-01, FR-02)
>
> ## Deviations
> - **Rule 2: Missing Critical** — added `__repr__` to model for debugging, not in spec
>
> ## Difficulties
> - Alembic autogenerate didn't detect the UUID type — manually specified `sa.dialects.postgresql.UUID`
>
> ## Notes
> Token index on `token` column uses hash index instead of btree — faster for exact lookups.

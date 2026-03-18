# Implement Step Instructions

Implement a single task from the design spec. This is Step 3 of the sddw workflow. The user specifies which task to execute.

## Input

- `<feature-name>` — the feature being implemented
- `--task <N>` — the task number to execute (e.g., `--task 1`)

If no `--task` is provided, list available tasks from `.sddw/<feature-name>/design/tasks/` showing their status (done criteria checked or not) and ask the user which task to execute.

## Prerequisites

1. Read the task file: `.sddw/<feature-name>/design/tasks/task-<N>-*.md`
2. If the task file does not exist, list available tasks and ask the user to pick one.
3. Check `Depends on:` — if dependencies are not yet complete (done criteria unchecked in their task files), warn the user and ask whether to proceed anyway.

Reference only if needed:
- `.sddw/<feature-name>/design/analysis.md` — for design decisions or additional architectural context
- `.sddw/<feature-name>/requirements.md` — if acceptance criteria in the task file need clarification

---

## 1. Task Execution

The task file is self-contained. Execute it:

1. **Load** — Read the task file. It contains FR-IDs, contracts, acceptance criteria, data models, files to modify, and done criteria.
2. **Implement** — Write code following TDD Protocol (section 2) if applicable, or implement directly for non-TDD tasks. Respect interface contracts exactly as specified.
3. **Verify** — Run tests. Check that acceptance criteria are satisfied. If verification fails: retry once with error feedback, then escalate to user.
4. **Commit** — Follow Commit Protocol (section 3).
5. **Track** — Check off done criteria in the task file.
6. **Report** — Tell the user what was done and suggest the next task.

**Rules:**
- SHALL load the task file as primary context — it contains everything needed
- SHALL implement interface contracts exactly as specified (method signatures, error codes, response shapes)
- SHALL respect data model constraints (field types, validation rules, relationships)
- SHALL NOT skip done criteria without user approval

---

## 2. TDD Protocol

Use TDD for tasks involving business logic, APIs, validation, data transformations, or algorithms. Skip TDD for UI layout, configuration, glue code, and simple CRUD.

**Heuristic:** Can you write `expect(fn(input)).toBe(output)` before writing `fn`? If yes, use TDD.

**RED — Write failing test:**
1. Create test file following project conventions
2. Write test describing expected behaviour from the acceptance criteria
3. Run test — it MUST fail
4. If test passes: feature already exists or test is wrong — investigate

**GREEN — Implement to pass:**
1. Write minimal code to make the test pass
2. No cleverness, no optimisation — just make it work
3. Run test — it MUST pass

**REFACTOR (if needed):**
1. Clean up implementation if obvious improvements exist
2. Run tests — MUST still pass

**Rules:**
- Limit refinement to 3-5 iterations — if still failing, escalate to user
- SHALL NOT modify tests to make them pass — fix the implementation instead
- If tests reveal a spec gap, update the task file or requirements first, then re-implement

---

## 3. Commit Protocol

One task = one commit. Commit after tests pass, never before.

**Stage individually:**
```
git add src/specific/file.py
git add tests/specific/test_file.py
```

**Never use** `git add .` or `git add -A`.

**Message format:**
```
type(feature-name): description (FR-01, FR-02)
```

**Commit types:**

| Type | When |
|------|------|
| `feat` | New functionality |
| `fix` | Bug fix |
| `test` | Test-only (TDD RED phase) |
| `refactor` | No behaviour change (TDD REFACTOR phase) |
| `chore` | Config, dependencies |

**TDD tasks produce 2-3 commits:**
1. `test(feature): add failing test for X (FR-01)`
2. `feat(feature): implement X (FR-01)`
3. `refactor(feature): clean up X (FR-01)` (optional)

**Rules:**
- Every commit message SHALL reference the FR-IDs from the task file
- SHALL NOT commit partial implementations that break tests
- SHALL NOT commit unrelated changes in the same commit

---

## 4. Deviation Handling

Deviations during implementation are normal. Classify and handle:

| Rule | Trigger | Action | Permission |
|------|---------|--------|------------|
| **1: Bug** | Broken behaviour, errors, type errors, security vulnerabilities | Fix → test → verify → document | Auto |
| **2: Missing Critical** | Missing essentials: error handling, validation, auth checks, input sanitisation | Add → test → verify → document | Auto |
| **3: Blocking** | Prevents completion: missing deps, wrong types, broken imports, missing config | Fix blocker → verify → document | Auto |
| **4: Architectural** | Structural change: new DB table, schema change, new service, switching libraries, breaking API | STOP → present to user → document | Ask user |

**Rule 4 format — present to user:**
```
Architectural Decision Needed

Current task: [task name]
Discovery: [what prompted this]
Proposed change: [what needs to change]
Why needed: [rationale]
Impact: [what this affects]
Alternatives: [other approaches]

Proceed? (yes / different approach / defer)
```

**Priority:** Rule 4 (STOP) > Rules 1-3 (auto) > unsure → Rule 4.

**Rules:**
- ALL deviations SHALL be documented (rule number, what was found, what was done)
- Auto-fixed deviations (Rules 1-3) SHALL be mentioned in the commit message
- If a deviation reveals a spec gap, note it in the task file for the verification step

---

## 5. Progress Tracking

After completing the task:

1. Check off done criteria in the task file: `- [ ]` → `- [x]`
2. Report to user:
   - What was implemented
   - Commit hash
   - Any deviations (count by rule, brief description)
3. Suggest the next task:
   - List remaining tasks with unchecked done criteria
   - Identify which are unblocked (dependencies satisfied)
   - Suggest: `/sddw:implement <feature-name> --task <next-N>`
4. If all tasks are complete, suggest: `/sddw:verify <feature-name>`

---

## Output

- Implemented code for the specified task
- Updated task file with checked-off done criteria
- Commit(s) with descriptive messages referencing FR-IDs

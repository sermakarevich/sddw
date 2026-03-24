# Implement Step Instructions

Implement a single task from the design spec. This is Step 3 of the sddw workflow. The user specifies which task to execute.

## Input

- `<feature-name>` — the feature being implemented
- `--task <N>` — the task number to execute (e.g., `--task 1`)

If no `--task` is provided, list available tasks and ask the user which to execute.

## Prerequisites

Read the task file: `<resolved-sddw-path>/<feature-name>/design/tasks/task-<N>-*.md`

Use the Project path from `<resolved-sddw-path>/<feature-name>/requirements.md` as the working directory for implementation.

Check `Depends on:` — if dependencies are not yet complete, warn the user.

Reference only if needed:
- `<resolved-sddw-path>/code-analysis.md` — for codebase patterns and conventions (may not exist)
- `<resolved-sddw-path>/<feature-name>/requirements.md` — if acceptance criteria need clarification

## Process

Follow the three-phase flow defined in the questionnaire:

1. **Discover** — Identify the task, check dependencies, ask if there's any context since the design was written. *In `--critical-only`: pick next unblocked task if none specified, but ask the user if dependencies are incomplete. In `--auto`: perform discovery fully autonomously.*

2. **Research & Propose** — Scan codebase for current state of files, research test patterns and library usage. Propose implementation approach and TDD applicability. User confirms. *In `--critical-only`: research and decide approach autonomously. In `--auto`: same.*

3. **Execute & Report** — Implement following TDD Protocol, Commit Protocol, and Deviation Handling below. Report completion, recommend clearing context, and suggest next task. *Note: Deviation Rule 4 (architectural) always asks the user, even in `--auto` mode.*

---

## TDD Protocol

Check the Testing Approach in `.sddw/<feature-name>/requirements.md` Constraints section. Follow the user's chosen approach:
- **TDD** — always write tests first
- **Test-after** — implement first, add tests after
- **Selective TDD** — TDD for business logic/APIs, skip for config/glue code
- **No tests** — skip testing entirely

If Selective TDD or no preference specified, use TDD for tasks involving business logic, APIs, validation, data transformations, or algorithms. Skip TDD for UI layout, configuration, glue code, and simple CRUD.

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

## Commit Protocol

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

## Deviation Handling

Deviations during implementation are normal. Classify and handle:

| Rule | Trigger | Action | Permission |
|------|---------|--------|------------|
| **1: Bug** | Broken behaviour, errors, type errors, security vulnerabilities | Fix → test → verify → document | Auto |
| **2: Missing Critical** | Missing essentials: error handling, validation, auth checks, input sanitisation | Add → test → verify → document | Auto |
| **3: Blocking** | Prevents completion: missing deps, wrong types, broken imports, missing config | Fix blocker → verify → document | Auto |
| **4: Architectural** | Structural change: new DB table, schema change, new service, switching libraries, breaking API | STOP → present to user → document | Ask user |

**Priority:** Rule 4 (STOP) > Rules 1-3 (auto) > unsure → Rule 4.

**Rules:**
- ALL deviations SHALL be documented (rule number, what was found, what was done)
- Auto-fixed deviations (Rules 1-3) SHALL be mentioned in the commit message
- If a deviation reveals a spec gap, note it in the task file for the verification step

---

## Completion Report

After the task commit(s), write a completion report following the task-completion spec:
`.sddw/<feature-name>/implement/tasks/task-<N>-<slug>.done.md`

Create the `implement/tasks/` directory if it does not exist. The report documents what was done, deviations, and difficulties. This enables `/sddw:help status` to show task completion and provides context for future tasks.

## Output

- Implemented code for the specified task
- Commit(s) with descriptive messages referencing FR-IDs
- Completion report (`.done.md`) in `implement/tasks/`

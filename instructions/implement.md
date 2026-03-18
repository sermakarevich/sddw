# Implement Step Instructions

Implement the feature by executing tasks from the design spec. This is Step 3 of the sddw workflow. Reads both requirements and design specs as input.

## Prerequisites

Read the specs produced by Steps 1 and 2:
- `.sddw/<feature-name>/requirements.md` — functional requirements, acceptance criteria, constraints
- `.sddw/<feature-name>/design.md` — architecture, data models, interface contracts, task list

If either spec does not exist, inform the user and suggest running the missing step first.

---

## 1. Task Execution Loop

Execute tasks from the design spec in dependency order. For each task:

1. **Load context** — Read the task description, its FR-IDs, the relevant interface contracts and data models from the design spec. Load only the 3-5 constraints relevant to this task from the requirements spec — do not dump the full spec into context.
2. **Implement** — Write code following TDD Protocol (section 2) if applicable, or implement directly for non-TDD tasks. Respect interface contracts exactly as specified.
3. **Verify** — Run tests. Check that acceptance criteria for the referenced FRs are satisfied. If verification fails: retry once with error feedback, then escalate to user.
4. **Commit** — Follow Commit Protocol (section 3).
5. **Track** — Follow Progress Tracking (section 6).
6. **Next** — Move to the next task. If the task is blocked, follow Deviation Handling (section 4).

**Rules:**
- SHALL execute tasks in dependency order (independent tasks first)
- SHALL respect `Depends on:` fields — never start a task before its dependencies are done
- Tasks with no dependencies MAY be executed in parallel
- SHALL NOT skip tasks without user approval

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
- Limit refinement to 3-5 iterations per task — if still failing, escalate to user
- SHALL NOT modify tests to make them pass — fix the implementation instead
- If tests reveal a spec gap (insufficient acceptance criteria), update the spec first, then re-implement

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
- Every commit message SHALL reference the FR-IDs the task traces to
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
- If a deviation reveals a spec gap, note it for the verification step

---

## 5. Spec Alignment

Stay aligned with the requirements and design specs during implementation.

**Per task, load:**
- The task description and FR-IDs from the design spec
- The relevant acceptance criteria from the requirements spec (only for referenced FRs)
- The relevant interface contracts (API endpoints, method signatures, pre/post-conditions)
- The relevant data models (entity fields, types, constraints)
- The relevant design decisions (to avoid re-litigating)

**Rules:**
- SHALL NOT load the full requirements or design spec into context — only task-relevant sections
- SHALL implement interface contracts exactly as specified (method signatures, error codes, response shapes)
- SHALL respect data model constraints (field types, validation rules, relationships)
- If implementation reveals the spec is insufficient, update the spec first, then continue
- The spec is the source of truth — when code and spec disagree, fix the code or update the spec with user approval

---

## 6. Progress Tracking

Track implementation progress in the design spec.

**After each task:**
1. Check off the task in `.sddw/<feature-name>/design.md`: `- [ ]` → `- [x]`
2. Report to user: `Task N/M complete: [task description] (commit: abc123)`

**On completion of all tasks:**
1. Report summary: tasks completed, commits made, any deviations documented
2. Note any spec gaps discovered during implementation
3. Suggest running `/sddw:verify <feature-name>`

**Rules:**
- SHALL update checkboxes after each task, not at the end
- SHALL report deviations encountered (count by rule, brief description)

---

## Output

- Implemented code following the design spec
- Updated `.sddw/<feature-name>/design.md` with checked-off tasks
- Commits with descriptive messages referencing FR-IDs

## Next Step

After implementation is complete, suggest running:
> `/sddw:verify <feature-name>`

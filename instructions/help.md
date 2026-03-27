# Help Instructions

Provide workflow overview, list features, and show feature status. This is a utility command — no questionnaire needed.

## Routing

Parse `<subcommand>` and route:

- **No argument** → show workflow overview
- **`list`** → list all features
- **`status <feature-name>`** → show feature status

---

## Workflow Overview (no argument)

Display:

```
sddw — Spec-Driven Development Workflow

  6-step pipeline: specs are the source of truth, code is a verified artifact.

  Step 1: Requirements     /sddw:requirements <feature-name>
    Collaboratively produce a requirements spec: purpose, user stories,
    functional requirements, acceptance criteria, constraints.

  Step 2: Code Analysis    /sddw:code-analysis <feature-name>   (optional)
    Analyse existing codebase: patterns, interfaces, flows, conventions.
    Skip this step for greenfield projects with no existing codebase.

  Step 3: Design           /sddw:design <feature-name>
    Produce self-contained task files: architecture, data models,
    interface contracts, design decisions, task breakdown.

  Step 4: Implement        /sddw:implement <feature-name> --task <N>
    Execute a single task following TDD protocol, commit protocol,
    and deviation handling. One task at a time.

  Step 5: Verify           /sddw:verify <feature-name>
    Run tests, cross-check acceptance criteria, review done criteria.
    Creates remediation tasks if issues are found.

  Step 6: Self-Improve     /sddw:self-improve <feature-name>
    Analyse feature execution across all steps. Identify gaps,
    errors, and patterns. Propose concrete improvements to
    workflow instructions, questionnaires, and specs.

  Fast-track:
    /sddw:chat <feature-name>     Quick edits, questions, or updates on an
                                   existing feature. Loads artifacts, skips
                                   the full questionnaire ceremony.

  Utilities:
    /sddw:help                     This overview
    /sddw:help list                List all features
    /sddw:help status <feature>    Show feature progress
```

---

## List Features (`list`)

Scan `.sddw/` directory for feature directories. A feature directory is any subdirectory of `.sddw/` (exclude `code-analysis.md` and other files).

For each feature, show a one-line summary with status indicator:

```
Features in .sddw/:
  <feature-a>    [requirements → code-analysis → design → implement 2/4]
  <feature-b>    [requirements → design → implement 4/4 → verify PASS → self-improve 2 applied]
  <feature-c>    [requirements]
```

Status detection:
- `requirements.md` exists → requirements done
- `.sddw/code-analysis.md` exists → code analysis done
- `design/tasks/task-N-*.md` → design done (count total tasks)
- `implement/tasks/task-N-*.done.md` → count completed tasks
- `verify/report.md` exists → verification done (read result from Summary)
- `self-improve/report.md` exists → self-improve done (read applied/skipped counts from Summary)

If `.sddw/` does not exist or has no feature directories, say:
> "No features found. Start with `/sddw:requirements <feature-name>`"

---

## Feature Status (`status <feature-name>`)

Read the feature directory and show detailed progress:

```
Feature: <feature-name>

  Requirements:    ✓ completed
    └─ .sddw/<feature-name>/requirements.md

  Code Analysis:   ✓ exists (last updated: <date>)
    └─ .sddw/code-analysis.md
    (or: ○ skipped — no code-analysis.md found)

  Design:          ✓ completed
    └─ .sddw/<feature-name>/design/tasks/

  Tasks:           2 of 4 complete
    1. task-1-<slug>    ✓ done
    2. task-2-<slug>    ✓ done
    3. task-3-<slug>    ○ pending
    4. task-4-<slug>    ○ pending (Depends on: task-3)

  Verification:      ✓ PASS (2026-03-25)
    └─ .sddw/<feature-name>/verify/report.md
    (or: ○ not yet run)
    (or: ✗ FAIL — 1 FR failed, 1 partial — 2 remediation tasks created)

  Self-Improve:      ✓ done — 2 applied, 1 skipped (2026-03-26)
    └─ .sddw/<feature-name>/self-improve/report.md
    (or: ○ not yet run)
```

For completed tasks, if a `.done.md` file exists, show a brief summary from it.

For pending tasks with dependencies, show the `Depends on:` field.

If the feature directory does not exist:
> "Feature '<feature-name>' not found. Run `/sddw:help list` to see available features."

---

**Path note:** If `.sddw/` cannot be found in the current working directory, display the "No features found" message.

## Rules

- SHALL scan actual filesystem, not assume
- SHALL show concrete file paths (resolved absolute) so the user can navigate
- SHALL detect status from file existence, not file content
- SHALL handle missing `.sddw/` directory gracefully

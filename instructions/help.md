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

  3-step pipeline: specs are the source of truth, code is a verified artifact.

  Step 1: Requirement    /sddw:requirement <feature-name>
    Collaboratively produce a requirements spec: purpose, user stories,
    functional requirements, acceptance criteria, constraints.

  Step 2: Design         /sddw:design <feature-name>
    Analyse codebase, produce design artifacts: architecture, data models,
    interface contracts, design decisions, task breakdown.

  Step 3: Implement      /sddw:implement <feature-name> --task <N>
    Execute a single task following TDD protocol, commit protocol,
    and deviation handling. One task at a time.

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
  <feature-a>    [requirement → design → implement 2/4]
  <feature-b>    [requirement → design]
  <feature-c>    [requirement]
```

Status detection:
- `requirements.md` exists → requirement done
- `design/analysis.md` exists → design done
- `design/tasks/task-N-*.md` → count total tasks
- `design/tasks/task-N-*.done.md` → count completed tasks

If `.sddw/` does not exist or has no feature directories, say:
> "No features found. Start with `/sddw:requirement <feature-name>`"

---

## Feature Status (`status <feature-name>`)

Read the feature directory and show detailed progress:

```
Feature: <feature-name>

  Requirement:  ✓ completed
    └─ .sddw/<feature-name>/requirements.md

  Code Analysis: ✓ exists (last updated: <date>)
    └─ .sddw/code-analysis.md

  Design:       ✓ completed
    └─ .sddw/<feature-name>/design/analysis.md

  Tasks:        2 of 4 complete
    1. task-1-<slug>    ✓ done
    2. task-2-<slug>    ✓ done
    3. task-3-<slug>    ○ pending
    4. task-4-<slug>    ○ pending (depends on: task-3)
```

For completed tasks, if a `.done.md` file exists, show a brief summary from it.

For pending tasks with dependencies, show the `Depends on:` field.

If the feature directory does not exist:
> "Feature '<feature-name>' not found. Run `/sddw:help list` to see available features."

---

## Rules

- SHALL scan actual filesystem, not assume
- SHALL show concrete file paths so the user can navigate
- SHALL detect status from file existence, not file content
- SHALL handle missing `.sddw/` directory gracefully

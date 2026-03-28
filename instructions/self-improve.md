# Self-Improve Step Instructions

Analyse a completed feature's execution across all workflow steps. Identify gaps, errors, and patterns, then propose concrete improvements to sddw workflow components. This is the final step of the sddw workflow.

## Goal

Turn execution experience into workflow improvements. Each feature execution is a learning opportunity — find what went wrong (or could be better) and propose specific changes to instructions, questionnaires, or specs so that future features avoid the same issues.

## Prerequisites

Read the feature artifacts from `<resolved-sddw-path>/<feature-name>/`:

| Artifact | Path | Required |
|----------|------|----------|
| Requirements | `<feature-name>/requirements.md` | Yes |
| Task files | `<feature-name>/design/tasks/task-*.md` | Yes |
| Completion reports | `<feature-name>/implement/tasks/*.done.md` | Yes |
| Verification report | `<feature-name>/verify/report.md` | Yes |
| Code analysis | `code-analysis.md` | No |

If the verification report does not exist, stop and suggest running `/sddw:verify` first. Self-improve requires a completed feature lifecycle to analyse.

Also read the current sddw workflow components that may be improved:

| Component | Path |
|-----------|------|
| Instructions | `~/.claude/sddw/instructions/*.md` |
| Questionnaires | `~/.claude/sddw/questionnaires/*.md` |
| Specs | `~/.claude/sddw/specs/*.md` |

## Process

Follow the three-phase flow defined in the questionnaire:

1. **Analyse** — Load all artifacts and extract signals: deviations, difficulties, remediation task origins, test gaps, spec ambiguities. *In `--auto`: analyse fully autonomously.*

2. **Diagnose** — Classify findings by workflow step and component. Identify patterns and root causes. Propose specific improvements. *In `--auto`: propose autonomously — always pause for approval before applying changes.*

3. **Apply** — Present improvement proposals. User approves which to apply. Apply approved changes to workflow files. Generate improvement report. *All modes: user approval required before modifying workflow files.*

---

## Analysis Dimensions

### 1. Requirements Quality
Signals to check:
- Remediation tasks with `Origin: requirements` — indicates ambiguous or missing spec
- Deviations noting "spec gap" in completion reports
- Acceptance criteria that were PARTIAL in verification (uncovered scenarios)
- FRs that were too vague to test directly

Questions to answer:
- Were FRs specific enough for design and implementation?
- Were acceptance criteria comprehensive enough for verification?
- Were constraints clear about boundaries?

### 2. Design Quality
Signals to check:
- Remediation tasks with `Origin: design` — indicates task scoping or architecture gap
- Rule 4 (architectural) deviations in completion reports — indicates design missed something
- Tasks that had unresolved dependencies or incorrect `Depends on:`
- Done criteria that were too vague to verify

Questions to answer:
- Were task files self-contained enough for implementation?
- Were task dependencies accurate?
- Were architecture decisions adequate?

### 3. Implementation Quality
Signals to check:
- Remediation tasks with `Origin: implementation` — code bugs
- Deviations (Rules 1-3) frequency and patterns in completion reports
- Difficulties section patterns across tasks
- TDD effectiveness (did tests catch the right things?)

Questions to answer:
- Were implementation instructions clear enough?
- Did the TDD protocol catch issues early?
- Were deviation rules applied correctly?

### 4. Verification Coverage
Signals to check:
- FRs that were PARTIAL due to missing test coverage
- Acceptance criteria not covered by tests
- Done criteria that couldn't be verified programmatically
- Warnings in the verification report

Questions to answer:
- Did the verification step catch all real issues?
- Were done criteria verifiable?

### 5. Cross-Step Patterns
Signals to check:
- Information lost between steps (requirements → design → implement)
- Context that had to be re-discovered during implementation
- Gaps in the artifact chain (something not captured anywhere)

---

## Improvement Classification

| Type | Target | Example |
|------|--------|---------|
| **Instruction improvement** | `instructions/*.md` | "Add a rule to check boundary conditions in acceptance criteria" |
| **Questionnaire improvement** | `questionnaires/*.md` | "Add a question about performance constraints during requirements" |
| **Spec improvement** | `specs/*.md` | "Add a Performance section to the task file format" |
| **Process improvement** | Process/workflow suggestion | "Code analysis should be required, not optional, for existing codebases" |

## Improvement Proposal Format

Each proposal SHALL include:
- **ID:** IMP-01, IMP-02, etc.
- **Type:** instruction | questionnaire | spec | process
- **Target file:** the specific file to modify
- **Step:** which workflow step this affects (requirements | code-analysis | design | implement | verify)
- **Finding:** what went wrong or could be better (with evidence from artifacts)
- **Proposal:** the specific change to make
- **Diff preview:** the actual text to add/change/remove (when targeting a file)

---

## Rules

- SHALL base all findings on evidence from the feature's artifacts — no speculation
- SHALL classify every finding by workflow step origin
- SHALL propose concrete, actionable improvements — not vague suggestions
- SHALL include diff previews for file changes so the user can evaluate precisely
- SHALL NOT apply changes to workflow files without user approval — even in `--auto` mode
- SHALL NOT propose improvements unrelated to the analysed feature's execution
- SHALL NOT modify the feature's own artifacts (requirements.md, task files, etc.)
- SHALL generate the improvement report regardless of whether changes are applied
- SHALL keep proposals minimal — fix the specific gap, don't redesign the workflow

## Output

```
.sddw/<feature-name>/self-improve/
└── report.md
```

And optionally, modifications to workflow files in `~/.claude/sddw/` (only with user approval).

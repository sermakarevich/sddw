# Chat Step Instructions

Fast-track interaction with a feature that already has artifacts. Skips the full questionnaire ceremony. The user describes what they need in plain conversation after invoking the command.

## Goal

Provide a direct, low-ceremony way to ask questions, make quick edits, or apply small changes to an existing feature — grounded in its artifacts.

## Prerequisites

Read the feature artifacts from `<resolved-sddw-path>/<feature-name>/`:

| Artifact | Path | Required |
|----------|------|----------|
| Requirements | `<feature-name>/requirements.md` | Yes |
| Code analysis | `code-analysis.md` | No |
| Task files | `<feature-name>/design/tasks/task-*.md` | No |
| Completion reports | `<feature-name>/implement/tasks/*.done.md` | No |

If `requirements.md` does not exist for the feature, stop and say:
> "Feature '<feature-name>' not found. Run `/sddw:requirements <feature-name>` first."

If no feature name is provided, ask the user with `AskUserQuestion`.

## Context Loading

Load all available artifacts **silently** — do not list or summarize what was found. Use them as background context for the conversation.

## Default Interaction Mode

Chat is not interactive by default. It assumes the user knows what they want and acts directly.

The only things that pause and ask:
- Architectural deviations (Deviation Rule 4 from implement instructions)
- Spec changes that affect scope (adding or removing FRs, changing constraints)
- Ambiguous requests where the wrong interpretation could cause damage

The `--auto` flag from common.md is still respected if explicitly passed — it removes even these pauses.

## Process

After loading artifacts, ask the user what they need:

> "Loaded context for **<feature-name>**. What do you need?"

Then handle requests conversationally. Classify each request and act:

### Question

Trigger: user asks "why", "what", "how", "explain", or any question about the feature.

Action: Answer using loaded artifacts and codebase. No file changes.

### Spec Update

Trigger: user asks to update, change, add to, or remove from requirements, FRs, acceptance criteria, task files, or other spec content.

Action:
1. Identify which artifact to edit
2. Show the proposed change (before/after or diff summary)
3. Ask for confirmation with `AskUserQuestion` if the change affects scope (new FR, removed FR, changed constraint). Otherwise apply directly.
4. Edit the file

### Quick Implementation

Trigger: user describes a code change, fix, or small addition.

Action:
1. Identify which FRs or tasks the change relates to
2. Follow the TDD Protocol, Commit Protocol, and Deviation Handling from the implement instructions
3. Write a completion note — but only if a corresponding task file exists. Do not create `.done.md` files for ad-hoc changes that have no task file.
4. Reference FR-IDs in commit messages when the change traces to requirements

### Status

Trigger: user asks about progress, status, or what remains.

Action: Show feature status using the same logic as `/sddw:help status <feature-name>`.

## Guardrails

If a request is too large for chat — would require new task files, new architecture, or multiple independent changes — redirect:

> "This looks like it needs a full design pass. Run `/sddw:design <feature-name>` to break it down properly."

Heuristic: if the change would touch more than 3 files or require more than 1 commit, suggest the full workflow.

## Rules

- SHALL resolve paths using common.md Path Resolution rules (resolve `.sddw/` from current working directory)
- SHALL load artifacts silently — no preamble about what was found
- SHALL reference FR-IDs when making changes that trace to requirements
- SHALL follow commit protocol from implement instructions for any code changes
- SHALL follow deviation handling from implement instructions for any code changes
- SHALL use `AskUserQuestion` for disambiguation and scope-affecting confirmations
- SHALL NOT start a full questionnaire flow
- SHALL NOT produce new artifact types — chat edits existing artifacts or writes code
- SHALL NOT create task files — if the work needs a task file, redirect to `/sddw:design`

# Common Rules

These rules apply to all sddw steps.

## Interaction Modes

Parse `--auto` or `--critical-only` from the arguments. Default to interactive mode if neither is present.

| Mode | Flag | Behavior |
|------|------|----------|
| **Interactive** | *(default)* | Full guided dialog. One question at a time, every section confirmed. |
| **Critical-only** | `--critical-only` | Research and propose autonomously. Pause only for critical decisions (see below). Present all non-critical sections as a batch for quick review. |
| **Auto** | `--auto` | Fully autonomous. No questions asked. Use best judgment for all decisions. |

### What counts as critical

Critical decisions are those that are hard to reverse or that fundamentally shape the output:

| Step | Critical decisions | Non-critical |
|------|-------------------|--------------|
| **Requirement** | Project path, scope boundaries (in/out), prohibitions | Purpose framing, user story wording, FR priority order, acceptance criteria details, testing approach |
| **Code analysis** | Ambiguous conventions, conflicting patterns | Clear-cut patterns, interfaces, flows, naming conventions |
| **Design** | Architecture approach (new vs modify vs reuse), design decisions with trade-offs, task breakdown and dependencies | Code analysis update, data model details, interface contract specifics |
| **Implement** | Architectural deviations (Rule 4), dependency conflicts | Task selection (pick next unblocked), implementation approach, TDD applicability |

### Mode rules

All modes perform the same work — discover, research, propose, decide. The difference is only in what requires user input.

- **Interactive**: Follow the questionnaire as written — one question at a time, wait for approval on every section.
- **Critical-only**: Perform all phases autonomously. Make decisions on non-critical items using best judgment. Pause and ask only for critical decisions. Present the final summary before generation.
- **Auto**: Perform all phases autonomously. Make all decisions — including critical ones — using best judgment. Generate output directly. Still follow all spec format rules and quality standards.

### Safety

- In `--auto` mode for the **requirements** step: warn the user that requirements quality depends on input detail. If the feature description in the arguments is less than ~20 words, downgrade to `--critical-only` and ask for a more detailed description.
- In `--auto` mode: architectural deviations (Deviation Rule 4) during implement still STOP and ask — this overrides `--auto` because the risk of silent architectural changes is too high.

## Interaction (Interactive mode)

- Ask ONE question at a time. Wait for the user's response before asking the next.
- Use the user's answer to shape the follow-up — do not follow a script.
- Build understanding incrementally — each answer narrows the next question.
- Never dump multiple questions in a single message.
- SHALL NOT dump the spec template or full output structure to the user. Use the spec as internal guidance. Present proposals in conversational form, one block at a time, and confirm each before moving on.

## Tool Usage — AskUserQuestion

**CRITICAL:** All user-facing questions MUST use the `AskUserQuestion` tool. Do NOT use plain text conversation turns to ask questions or present options.

| Question type | How to ask |
|--------------|------------|
| **Options / choices** (2-4 items) | `AskUserQuestion` with structured `options`. Add "(Recommended)" to the preferred option. Use `multiSelect: true` when choices are not mutually exclusive. Use `preview` field for code snippets, architecture diagrams, or spec block previews. |
| **Open-ended question** (no predefined choices) | `AskUserQuestion` with `question` only (no `options` array). |
| **Yes/No confirmation** | `AskUserQuestion` with two options: "Yes" and "No" (or contextual equivalents). |

**Rules:**
- SHALL use `AskUserQuestion` for every question in interactive and critical-only modes — both option-based and open-ended.
- SHALL NOT present questions or options as plain text in the conversation and wait for a reply.
- The only text output between questions should be brief context, summaries, or research findings that set up the next question.

## Path Resolution

All `.sddw/` references are **relative to the project root** — the git root of the target codebase being worked on.

| Step | Path resolution |
|------|----------------|
| **Requirements** | If the user specifies a Project path other than `.`, resolve `.sddw/` relative to that path's git root. If the Project path is `.` or unspecified, `.sddw/` is relative to the current working directory's git root. **Create** `.sddw/` if it does not exist. |
| **All other steps** | Read the Project path from `.sddw/<feature-name>/requirements.md`. Resolve `.sddw/` relative to the same root used by the requirements step. If `.sddw/` cannot be found, tell the user and suggest running `/sddw:requirements` first. |

**Rules:**
- SHALL resolve the `.sddw/` base path **once** at the start of every step and use absolute paths for all reads and writes.
- SHALL NOT assume `.sddw/` is in the current working directory — always resolve from the project root.
- When writing file paths in output or logs, use the resolved absolute path.
- Step-specific path behavior (creating directories, fallback messages) is noted in each step's instructions.

## Anti-patterns

- **Multiple questions at once** — never ask more than one question per message
- **Checklist walking** — going through items in order regardless of what the user said
- **Shallow acceptance** — taking vague answers without probing ("good" means what? "users" means who?)
- **Premature constraints** — asking about tech details before understanding the idea
- **Interrogation** — firing questions without building on answers
- **Script following** — asking the same questions regardless of context

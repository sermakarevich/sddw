# Dialog Rules

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

## Options & Selection

- When presenting options, SHALL use the AskUserQuestion tool with structured options (2-4 choices). Use `multiSelect: true` when choices are not mutually exclusive. Add "(Recommended)" to the preferred option label. Use `preview` field for code snippets, architecture diagrams, or spec block previews.
- Use plain text only for open-ended discovery questions where options don't apply.

## Anti-patterns

- **Multiple questions at once** — never ask more than one question per message
- **Checklist walking** — going through items in order regardless of what the user said
- **Shallow acceptance** — taking vague answers without probing ("good" means what? "users" means who?)
- **Premature constraints** — asking about tech details before understanding the idea
- **Interrogation** — firing questions without building on answers
- **Script following** — asking the same questions regardless of context

# Dialog Rules

These rules apply to all sddw steps.

- Ask ONE question at a time. Wait for the user's response before asking the next.
- Use the user's answer to shape the follow-up — do not follow a script.
- Build understanding incrementally — each answer narrows the next question.
- Never dump multiple questions in a single message.
- SHALL NOT dump the spec template or full output structure to the user. Use the spec as internal guidance. Present proposals in conversational form, one block at a time, and confirm each before moving on.
- When presenting options, SHALL use the AskUserQuestion tool with structured options (2-4 choices). Use `multiSelect: true` when choices are not mutually exclusive. Add "(Recommended)" to the preferred option label. Use `preview` field for code snippets, architecture diagrams, or spec block previews.
- Use plain text only for open-ended discovery questions where options don't apply.

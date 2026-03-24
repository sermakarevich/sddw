# Common Step Instructions

These instructions apply to all sddw steps. They supplement the dialog rules.

## Mode Behavior

All modes perform the same work — discover, research, propose, decide. The difference is only in what requires user input:

- **Interactive** (default): every section is explicitly accepted by the user before generation.
- **Critical-only**: the agent makes non-critical decisions autonomously but asks the user for critical ones (see the per-step critical decisions table in dialog rules).
- **Auto**: all decisions autonomous.

See dialog rules for full mode definitions and safety overrides.

## Tool Usage — AskUserQuestion

**CRITICAL:** Every question to the user — whether options or open-ended — MUST use the `AskUserQuestion` tool. Do NOT use plain text conversation turns to ask questions or present options. See "Tool Usage — AskUserQuestion" in dialog rules for format rules.

## Path Resolution

Before any other work, resolve the `.sddw/` base path following the Path Resolution rules in the dialog rules. Use the resolved absolute path for all file operations. Step-specific path behavior (creating directories, fallback messages) is noted in each step's instructions.

---
name: sddw:implement
description: Implement tasks from the design spec following TDD and existing codebase patterns
argument-hint: "<feature-name> [--task <task-number>] [--auto | --critical-only]"
---

<feature_name> #$ARGUMENTS </feature_name>

# COMMON RULES
@~/.claude/sddw/instructions/common.md

# INSTRUCTIONS
@~/.claude/sddw/instructions/implement.md

# QUESTIONNAIRE
@~/.claude/sddw/questionnaires/implement.md

# SPECS
@~/.claude/sddw/specs/design-task.md
@~/.claude/sddw/specs/task-completion.md

# NEXT STEP
After completing a task, suggest the next unblocked task:
> `/sddw:implement <feature-name> --task <next-N>`
When all tasks are complete, congratulate and summarise what was built.

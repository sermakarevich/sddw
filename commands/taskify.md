---
name: sddw:taskify
description: Generate hybrid task files from requirements.md + design.md
argument-hint: "<feature-name> [--auto]"
---

<feature_name> #$ARGUMENTS </feature_name>

# COMMON RULES
@~/.claude/sddw/instructions/common.md

# INSTRUCTIONS
@~/.claude/sddw/instructions/taskify.md

# QUESTIONNAIRE
@~/.claude/sddw/questionnaires/taskify.md

# SPECS
@~/.claude/sddw/specs/design-task.md

# NEXT STEP
After generating the task files, suggest:
> Run `/clear` to free up context, then `/sddw:implement <feature-name> --task 1`
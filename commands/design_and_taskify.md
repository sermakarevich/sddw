---
name: sddw:design_and_taskify
description: "Generate design.md plus hybrid task files in one combined flow"
argument-hint: "<feature-name> [--auto]"
---

<feature_name> #$ARGUMENTS </feature_name>

# COMMON RULES
@~/.claude/sddw/instructions/common.md

# INSTRUCTIONS
@~/.claude/sddw/instructions/design_and_taskify.md

# QUESTIONNAIRE
@~/.claude/sddw/questionnaires/design_and_taskify.md

# SPECS
@~/.claude/sddw/specs/design.md
@~/.claude/sddw/specs/design-task.md

# NEXT STEP
After generating the design and task files, suggest:
> Run `/clear` to free up context, then `/sddw:implement <feature-name> --task 1`

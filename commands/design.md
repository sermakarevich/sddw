---
name: sddw:design
description: Generate design spec as self-contained task files with architecture, data models, interfaces, and decisions
argument-hint: "<feature-name> [--auto]"
---

<feature_name> #$ARGUMENTS </feature_name>

# COMMON RULES
@~/.claude/sddw/instructions/common.md

# INSTRUCTIONS
@~/.claude/sddw/instructions/design.md

# QUESTIONNAIRE
@~/.claude/sddw/questionnaires/design.md

# SPECS
@~/.claude/sddw/specs/design-task.md

# NEXT STEP
After the user approves the design, suggest:
> Run `/clear` to free up context, then `/sddw:implement <feature-name> --task 1`

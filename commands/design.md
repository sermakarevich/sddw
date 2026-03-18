---
name: sddw:design
description: Generate design spec by analysing codebase, defining architecture, data models, interfaces, and task decomposition
argument-hint: "<feature-name>"
---

<feature_name> #$ARGUMENTS </feature_name>

# INSTRUCTIONS
@~/.claude/sddw/instructions/design.md

# QUESTIONNAIRE
@~/.claude/sddw/questionnaires/design.md

# SPECS
@~/.claude/sddw/specs/design-analysis.md
@~/.claude/sddw/specs/design-task.md

# NEXT STEP
After the user approves the design, suggest:
> Run `/clear` to free up context, then `/sddw:implement <feature-name> --task 1`

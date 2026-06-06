---
name: sddw:design
description: Generate cross-cutting design artefact (design.md) with architecture, data models, interfaces, and decisions — without generating task files
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
@~/.claude/sddw/specs/design.md

# NEXT STEP
After the user approves the design, suggest:
> Run `/clear` to free up context, then `/sddw:taskify <feature-name>`

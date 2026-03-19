---
name: sddw:requirement
description: Generate requirements spec for a feature with user stories, functional requirements, acceptance criteria, and constraints
argument-hint: "<feature-name> [--auto | --critical-only]"
---

<feature_name> #$ARGUMENTS </feature_name>

If no feature name is provided, ask the user to describe the feature they want to build.

# DIALOG RULES
@~/.claude/sddw/instructions/dialog-rules.md

# INSTRUCTIONS
@~/.claude/sddw/instructions/requirement.md

# QUESTIONNAIRE
@~/.claude/sddw/questionnaires/requirement.md

# SPECS
@~/.claude/sddw/specs/requirements.md

# NEXT STEP
After the user approves the requirements, suggest:
> Run `/clear` to free up context, then `/sddw:design <feature-name>`

---
name: sddw:code-analysis
description: Analyse existing codebase to extract patterns, interfaces, flows, and conventions
argument-hint: "<feature-name> [--auto]"
---

<feature_name> #$ARGUMENTS </feature_name>

# COMMON RULES
@~/.claude/sddw/instructions/common.md

# INSTRUCTIONS
@~/.claude/sddw/instructions/code-analysis.md

# QUESTIONNAIRE
@~/.claude/sddw/questionnaires/code-analysis.md

# SPECS
@~/.claude/sddw/specs/code-analysis.md

# NEXT STEP
After the user approves the code analysis, suggest:
> Run `/clear` to free up context, then `/sddw:design <feature-name>`

---
name: sddw:verify
description: Verify implementation against requirements, run tests, and create remediation tasks if needed
argument-hint: "<feature-name> [--auto | --critical-only]"
---

<feature_name> #$ARGUMENTS </feature_name>

# COMMON RULES
@~/.claude/sddw/instructions/common.md

# INSTRUCTIONS
@~/.claude/sddw/instructions/verify.md

# QUESTIONNAIRE
@~/.claude/sddw/questionnaires/verify.md

# SPECS
@~/.claude/sddw/specs/design-task.md
@~/.claude/sddw/specs/verification-report.md

# NEXT STEP
After verification:
- If all checks pass, congratulate and summarise what was built.
- If remediation tasks were created, suggest:
  > Run `/clear` to free up context, then `/sddw:implement <feature-name> --task <N>` for each remediation task.

---
name: sddw:self-improve
description: Analyse feature execution to identify workflow gaps and propose improvements to sddw steps and components
argument-hint: "<feature-name> [--auto | --critical-only]"
---

<feature_name> #$ARGUMENTS </feature_name>

# COMMON RULES
@~/.claude/sddw/instructions/common.md

# INSTRUCTIONS
@~/.claude/sddw/instructions/self-improve.md

# QUESTIONNAIRE
@~/.claude/sddw/questionnaires/self-improve.md

# SPECS
@~/.claude/sddw/specs/improvement-report.md
@~/.claude/sddw/specs/verification-report.md
@~/.claude/sddw/specs/task-completion.md

# NEXT STEP
After the improvement report is generated:
- If improvements were proposed: present each proposed change and ask the user which to apply.
- After applying approved changes, suggest:
  > Workflow updated. Next feature will benefit from these improvements.
- If no improvements identified: congratulate and summarise the feature's clean execution.

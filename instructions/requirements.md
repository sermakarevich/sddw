# Requirements Step Instructions

Generate a requirements specification for a feature. This is Step 1 of the sddw workflow.

## Goal

Produce a precise, clear, and complete requirements spec.

## Process

Follow the three-phase flow defined in the questionnaire, adapted to the interaction mode:

1. **Discover** — Ask the user to describe the feature. Follow the thread, challenge vagueness, make the abstract concrete. Gather enough context for Purpose, User Stories, and Constraints. *In `--auto`: perform discovery fully autonomously.*

2. **Research & Propose** — Based on discovery, research the problem space (web search, codebase analysis, domain knowledge). For each spec section, propose 2-3 ranked options with rationale. User accepts, modifies, or provides their own input. *In `--auto`: decide all sections autonomously.*

3. **Confirm & Generate** — Summarise what will be written. User confirms. Write the spec to `.sddw/<feature-name>/requirements.md` following the spec template. *In `--auto`: generate directly.*

## Rules

- SHALL use RFC 2119 keywords (SHALL, SHOULD, MAY, SHALL NOT)
- SHALL NOT include implementation details — that belongs in the design step
- SHALL NOT include task decomposition — that belongs in the design step
- Every FR SHALL be atomic, testable, and user-centric
- Every FR SHALL have at least one acceptance criterion
- Include explicit prohibitions (SHALL NOT) to prevent unwanted agent behaviour
- SHALL NOT proceed to generation without user approval on all sections (interactive mode). `--auto` mode may proceed without approval.

**Path note:** The requirements step is responsible for **creating** the `.sddw/` directory and the feature subdirectory if they do not exist.

## Output

```
<resolved-sddw-path>/<feature-name>/requirements.md
```


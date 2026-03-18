# Requirement Step Instructions

Generate a requirements specification for a feature. This is Step 1 of the sddw workflow.

## Goal

Produce a precise, clear, and complete requirements spec in cooperation with the user. Every section written to the output file SHALL be explicitly accepted by the user before generation. The spec is a co-authored artifact — the agent proposes, the user decides.

## Process

Follow the three-phase flow defined in the questionnaire:

1. **Discover** — Ask the user to describe the feature. Follow the thread, challenge vagueness, make the abstract concrete. Gather enough context for Purpose, User Stories, and Constraints.

2. **Research & Propose** — Based on discovery, research the problem space (web search, codebase analysis, domain knowledge). For each spec section, propose 2-3 ranked options with rationale. User accepts, modifies, or provides their own input.

3. **Confirm & Generate** — Summarise what will be written. User confirms. Write the spec to `.sddw/<feature-name>/requirements.md` following the spec template.

## Rules

- SHALL use RFC 2119 keywords (SHALL, SHOULD, MAY, SHALL NOT)
- SHALL NOT include implementation details — that belongs in the design step
- SHALL NOT include task decomposition — that belongs in the design step
- Every FR SHALL be atomic, testable, and user-centric
- Every FR SHALL have at least one acceptance criterion
- Include explicit prohibitions (SHALL NOT) to prevent unwanted agent behaviour
- SHALL NOT proceed to generation without user approval on all sections

## Output

```
.sddw/<feature-name>/requirements.md
```

## Next Step

After the user approves the requirements, suggest:
> Run `/clear` to free up context, then `/sddw:design <feature-name>`

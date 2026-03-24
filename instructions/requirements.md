# Requirements Step Instructions

Generate a requirements specification for a feature. This is Step 1 of the sddw workflow.

## Goal

Produce a precise, clear, and complete requirements spec. In interactive mode (default), every section is explicitly accepted by the user before generation. In `--critical-only` mode, the agent makes non-critical decisions autonomously but asks the user for critical ones. In `--auto` mode, the agent makes all decisions autonomously. See dialog rules for mode behavior.

## Process

Follow the three-phase flow defined in the questionnaire, adapted to the interaction mode:

1. **Discover** — Ask the user to describe the feature. Follow the thread, challenge vagueness, make the abstract concrete. Gather enough context for Purpose, User Stories, and Constraints. *In `--critical-only`: infer non-critical context autonomously, but ask the user about project path, scope boundaries, and prohibitions. In `--auto`: perform discovery fully autonomously.*

2. **Research & Propose** — Based on discovery, research the problem space (web search, codebase analysis, domain knowledge). For each spec section, propose 2-3 ranked options with rationale. User accepts, modifies, or provides their own input. *In `--critical-only`: decide non-critical sections autonomously, ask only for scope boundaries and prohibitions. In `--auto`: decide all sections autonomously.*

3. **Confirm & Generate** — Summarise what will be written. User confirms. Write the spec to `.sddw/<feature-name>/requirements.md` following the spec template. *In `--critical-only`: still present final summary for approval. In `--auto`: generate directly.*

## Rules

- SHALL use RFC 2119 keywords (SHALL, SHOULD, MAY, SHALL NOT)
- SHALL NOT include implementation details — that belongs in the design step
- SHALL NOT include task decomposition — that belongs in the design step
- Every FR SHALL be atomic, testable, and user-centric
- Every FR SHALL have at least one acceptance criterion
- Include explicit prohibitions (SHALL NOT) to prevent unwanted agent behaviour
- SHALL NOT proceed to generation without user approval on all sections (interactive mode) or critical sections (`--critical-only` mode). `--auto` mode may proceed without approval.

## Path Resolution

Before any other work, resolve the `.sddw/` base path following the Path Resolution rules in the dialog rules. The requirements step is responsible for **creating** the `.sddw/` directory and the feature subdirectory if they do not exist. Use the resolved absolute path for all file operations.

## Output

```
<resolved-sddw-path>/<feature-name>/requirements.md
```


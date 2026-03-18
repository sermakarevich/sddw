# Requirement Step Instructions

Generate a requirements specification for a feature. This is Step 1 of the sddw workflow.

## Process

1. **Clarify scope** — Ask the user 2-3 targeted questions to understand the feature. Do not proceed until scope is clear.

2. **Generate the requirements spec** following the template structure:
   - **Purpose** — 1-2 sentences: what and why
   - **User Stories** — 2-5 stories in As a / I want / So that format
   - **Functional Requirements** — FR-01, FR-02, etc. with SHALL/SHOULD/MAY/SHALL NOT
   - **Acceptance Criteria** — Given/When/Then scenarios per FR (happy path + failure path)
   - **Constraints** — In Scope, Out of Scope (with reasons), Prohibitions (SHALL NOT)

3. **Write the spec** to `.sddw/<feature-name>/requirements.md` in the project root.

4. **Present to user** for review and refinement. Iterate until approved.

## Rules

- SHALL use RFC 2119 keywords (SHALL, SHOULD, MAY, SHALL NOT)
- SHALL NOT include implementation details — that belongs in the design step
- SHALL NOT include task decomposition — that belongs in the design step
- Every FR SHALL be atomic, testable, and user-centric
- Every FR SHALL have at least one acceptance criterion
- Include explicit prohibitions (SHALL NOT) to prevent unwanted agent behaviour

## Output

```
.sddw/<feature-name>/requirements.md
```

## Next Step

After the user approves the requirements, suggest running:
> `/sddw:design <feature-name>`

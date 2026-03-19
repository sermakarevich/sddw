# sddw

Spec-Driven Development Workflow for Claude Code.

Specifications become the source of truth, code becomes a verified artifact. Detailed, executable specs reduce AI code errors by up to 50% (Piskala) and security defects by 73% (Marri).

## Install

```bash
git clone https://github.com/sermakarevich/sddw.git ~/.claude/sddw
cd ~/.claude/sddw && bash bin/install.sh
```

For development (symlink from local repo):

```bash
git clone https://github.com/sermakarevich/sddw.git
cd sddw && bash bin/install.sh --local
```

## Steps

### 1. Requirement (`/sddw:requirement <feature-name>`)

Collaboratively produce a requirements spec through guided dialog:

- **Discover** — understand the feature through one-at-a-time questions
- **Research & Propose** — research SOTA, codebase, domain; propose each section with ranked options
- **Confirm & Generate** — user approves each block, spec is written

Output: `.sddw/<feature-name>/requirements.md`
Sections: Purpose, User Stories, Functional Requirements, Acceptance Criteria, Constraints

### 2. Design (`/sddw:design <feature-name>`)

Analyse the codebase and produce design artifacts through guided dialog:

- **Discover** — understand architectural preferences and constraints
- **Research & Propose** — scan codebase for patterns; propose architecture, data models, contracts, tasks
- **Confirm & Generate** — user approves each block, artifacts are written

Output:
```
.sddw/<feature-name>/design/
├── analysis.md          # codebase analysis, architecture, data models, interface contracts, design decisions
└── tasks/
    ├── task-1-<slug>.md  # self-contained task file with FR-IDs, contracts, acceptance criteria, done criteria
    ├── task-2-<slug>.md
    └── ...
```

### 3. Implement (`/sddw:implement <feature-name> --task <N>`)

Execute a single task from the design spec:

- **Discover** — select task, check dependencies, gather context
- **Research & Propose** — scan codebase, propose implementation approach and TDD applicability
- **Execute** — implement following TDD protocol, commit protocol, and deviation handling

Each task file is self-contained — the agent loads it as primary context without needing the full design document.

## Architecture

```
sddw/
├── commands/           # thin wrappers (frontmatter + @references)
├── instructions/       # process rules (what to do)
├── questionnaires/     # dialog guidance (how to interact)
├── specs/              # output format (what to produce)
└── bin/                # install script
```

## Dialog

Every step follows a three-phase dialog: **Discover → Research & Propose → Confirm & Generate**.

- One question at a time, wait for response
- Structured options via AskUserQuestion (not text dumps)
- Every spec block confirmed by user before generation
- Spec templates used as internal guidance, never shown raw

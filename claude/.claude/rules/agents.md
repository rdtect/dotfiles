# Agent Orchestration (MRAX)

## The Hierarchy

```
Principal (Opus) → Architecture, strategy, standards
    │
Tech Lead (Sonnet) → Domain ownership, planning
    │
Senior Dev (Sonnet) → Feature implementation, review
    │
Developer (Haiku) → Task execution, testing
```

## Available Agents

All defined in `~/.claude/agents/`. Loaded at session start; reload with `/agents`.

| Agent | Model | Memory | Turns | Role |
|-------|-------|--------|-------|------|
| **architect** | opus | yes | 30 | System design, ADRs (plan mode) |
| **council** | opus | yes | 30 | Multi-perspective decisions |
| **planner** | sonnet | yes | 20 | Feature planning, breakdown (plan mode) |
| **designer** | sonnet | yes | 20 | UX, visual polish, product thinking |
| **code-reviewer** | sonnet | yes | 15 | Code quality review (proactive) |
| **security-reviewer** | sonnet | yes | 15 | OWASP Top 10, secrets, injection |
| **tdd-guide** | sonnet | yes | 20 | Test-first development |
| **e2e-runner** | sonnet | yes | 20 | Playwright E2E tests |
| **refactor-cleaner** | sonnet | — | 15 | Dead code removal |
| **researcher** | sonnet | yes | 25 | Codebase + web research |
| **build-error-resolver** | haiku | — | 10 | Fix build errors fast |
| **doc-updater** | haiku | — | 15 | Documentation sync |

Memory agents persist learnings at `~/.claude/agent-memory/<name>/MEMORY.md`.

## Orchestration Patterns

### Pattern 1: Council Decision
For complex trade-offs:
```
/council "Should we use X or Y?"
→ Runs 5 perspectives in parallel
→ Synthesizes recommendation
```

### Pattern 2: Waterfall Delegation
For feature implementation:
```
Principal → approves approach
Tech Lead → breaks down tasks
Senior Dev → implements features
Developer → executes tasks
```

### Pattern 3: Parallel Specialists
For comprehensive review:
```
Launch in parallel:
├── security-reviewer
├── code-reviewer
└── tdd-guide (test coverage)
```

### Pattern 4: Design Review
For UX excellence:
```
/design-review "checkout flow"
→ Uses designer agent for comprehensive review
```

### Pattern 5: Premium Design Audit
Premium design is accessed via `/design-audit` command (uses designer agent with Opus):
```
/design-audit
→ Opus designer agent reads ALL screens
→ Audits 15 dimensions
→ Applies "Jobs Filter" (remove until it breaks)
→ WAITS for approval before each phase
→ Documents patterns in project notes
```

### Pattern 6: Agent Team
For complex parallel work requiring inter-agent communication:
```
"Create a team: frontend, backend, and tests"
→ TeamCreate → TaskCreate → Task (spawn teammates)
→ Teammates claim tasks, message each other
→ Lead coordinates, approves plans, shuts down
```

## When to Use

| Task | Agent | Mode |
|------|-------|------|
| Feature planning | planner | Subagent |
| Code review | code-reviewer | Subagent (proactive) |
| Architecture decision | architect | Subagent |
| Complex trade-off | council | Subagent |
| UI/UX work | designer | Subagent |
| Premium design audit | designer via `/design-audit` | Command |
| Codebase exploration | researcher | Subagent |
| Multi-file parallel work | Agent Team | Team |

## Model Selection

| Role | Model | Cost |
|------|-------|------|
| Principal/Council | Opus | High |
| Tech Lead/Senior Dev | Sonnet | Medium |
| Developer/Docs | Haiku | Low |

## MRAX Agent Mapping

```
Model Layer   → architect, council (truth, decisions)
Rules Layer   → planner, security-reviewer, designer (standards)
Actions Layer → tdd-guide, code-reviewer, e2e-runner (execution)
Logs Layer    → doc-updater (reflection)
```

## Escalation Path

```
Developer → Senior Dev → Tech Lead → Principal → Council
```

Escalate when:
- Decision impacts multiple domains
- Trade-offs are non-obvious
- Risk is significant
- Precedent is being set

---

## Agent Teams

Enabled via `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` in settings.json.

### Teams vs Subagents

| Feature | Subagents | Agent Teams |
|---------|-----------|-------------|
| Context | Own window, results return | Fully independent 200K windows |
| Communication | Report to main only | Message each other |
| Coordination | None | Shared task list + mailbox |
| Cost | Lower | Higher (~7x in plan mode) |
| Best for | Focused tasks | Complex parallel collaboration |

### Team Workflow

```
1. TeamCreate → creates team + task list
2. TaskCreate → define work items with dependencies
3. Task (spawn) → launch teammates with team_name
4. Teammates: TaskList → claim → work → TaskUpdate → SendMessage
5. Lead: coordinate, approve plans, reassign blocked work
6. SendMessage(shutdown_request) → TeamDelete
```

### Team Composition Tips

- 5-6 tasks per teammate is the sweet spot
- Tasks should be self-contained with clear deliverables
- Use `Shift+Tab` for delegate mode (lead coordinates only, no coding)
- Spawn prompt must include all context (teammates don't inherit history)
- Use `permissionMode: plan` for teammates that need approval before changes

### Quality Gates (Hooks)

```json
{
  "hooks": {
    "TeammateIdle": [{ "matcher": "*", "hooks": [...] }],
    "TaskCompleted": [{ "matcher": "*", "hooks": [...] }]
  }
}
```

- `TeammateIdle`: Exit code 2 sends feedback, keeps teammate working
- `TaskCompleted`: Exit code 2 blocks completion, sends feedback

### Storage

- Team config: `~/.claude/teams/{name}/config.json`
- Task list: `~/.claude/tasks/{name}/`
- Agent memory: `~/.claude/memory/agents/{agent}/MEMORY.md`

### Team Compositions (Pre-Defined)

Ready-to-use team templates for common workflows.

#### Team: Full-Stack Feature

For implementing features that span frontend + backend + tests.

| Role | Agent Type | Mode | Responsibilities |
|------|-----------|------|------------------|
| **lead** | general-purpose | delegate | Coordinate, review PRs, approve plans |
| **frontend** | general-purpose | default | UI components, pages, client state |
| **backend** | general-purpose | default | API endpoints, database, services |
| **tester** | general-purpose | default | Unit + integration + E2E tests |

```
"Create a full-stack team for [feature]"
→ Lead spawns frontend, backend, tester
→ Backend builds API first (frontend depends on contracts)
→ Frontend + tester work in parallel once types are defined
→ Lead reviews and coordinates integration
```

#### Team: Quality Gate

For comprehensive quality review before release.

| Role | Agent Type | Mode | Responsibilities |
|------|-----------|------|------------------|
| **lead** | general-purpose | delegate | Synthesize findings, final verdict |
| **security** | general-purpose | default | OWASP, secrets, auth, injection |
| **quality** | general-purpose | default | Code quality, patterns, complexity |
| **coverage** | general-purpose | default | Test gaps, missing edge cases |

```
"Create a quality gate team for [branch/feature]"
→ All reviewers run in parallel
→ Lead merges findings, deduplicates
→ Verdict: APPROVE / NEEDS CHANGES / BLOCK
```

#### Team: Research Sprint

For complex research requiring multiple investigation angles.

| Role | Agent Type | Mode | Responsibilities |
|------|-----------|------|------------------|
| **lead** | general-purpose | delegate | Frame question, synthesize, recommend |
| **codebase** | general-purpose | default | Existing code analysis, patterns |
| **docs** | general-purpose | default | Official docs, library research |
| **web** | general-purpose | default | Web research, community solutions, comparisons |

```
"Create a research team for [question]"
→ Lead frames the question precisely
→ 3 researchers investigate in parallel
→ Lead synthesizes into options + recommendation
```

#### Team: Migration

For large-scale codebase migrations or upgrades.

| Role | Agent Type | Mode | Responsibilities |
|------|-----------|------|------------------|
| **lead** | general-purpose | delegate | Plan, coordinate, verify |
| **migrator-1** | general-purpose | default | Migrate batch 1 of files |
| **migrator-2** | general-purpose | default | Migrate batch 2 of files |
| **verifier** | general-purpose | default | Run tests, check for regressions |

```
"Create a migration team to [upgrade/migrate X]"
→ Lead plans migration in batches
→ Migrators work on independent file batches
→ Verifier runs build + tests after each batch
→ Lead coordinates fixes if regressions found
```

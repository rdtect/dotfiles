---
description: Convene multi-agent council for complex decisions, architecture reviews, or brainstorming. Runs 5 parallel perspectives then synthesizes.
---

# Council Command (Multi-Agent)

Orchestrates **5 perspectives in parallel** for balanced decisions.

## Agent Orchestration

```
┌─────────────────────────────────────────────────────┐
│                    /council                         │
├─────────────────────────────────────────────────────┤
│  PHASE 1: 5 PARALLEL PERSPECTIVES                   │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐   │
│  │Advocate │ │ Critic  │ │Pragmati│ │Innovator│   │
│  │  (pro)  │ │ (con)   │ │  (how) │ │ (alt)   │   │
│  └─────────┘ └─────────┘ └─────────┘ └─────────┘   │
│                    ┌─────────┐                      │
│                    │Synthesiz│                      │
│                    │  (merge)│                      │
│                    └─────────┘                      │
├─────────────────────────────────────────────────────┤
│  PHASE 2: SYNTHESIS                                 │
│  Merge perspectives → Balanced recommendation       │
└─────────────────────────────────────────────────────┘
```

## The 5 Perspectives

| Role | Agent | Question | Focus |
|------|-------|----------|-------|
| **Advocate** | planner | Why will this work? | Benefits |
| **Critic** | security-reviewer | What could go wrong? | Risks |
| **Pragmatist** | build-error-resolver | Can we do this? | Feasibility |
| **Innovator** | architect | What alternatives? | Novel ideas |
| **Synthesizer** | code-reviewer | Balanced path? | Trade-offs |

## Execution Steps

1. **Frame the question** clearly
2. **Launch 5 agents in parallel** with perspective lens
3. **Collect all viewpoints**
4. **Synthesize** into balanced recommendation

## Output Format

```markdown
# Council Decision: [Topic]

## Perspectives

### Advocate (planner)
- [Key benefit 1]
- [Key benefit 2]

### Critic (security-reviewer)
- [Risk 1]
- [Risk 2]

### Pragmatist (build-error-resolver)
- Effort: [estimate]
- Blockers: [list]

### Innovator (architect)
- Option A: [description]
- Option B: [description]

### Synthesizer (code-reviewer)
- Consensus: [points]
- Tensions: [unresolved]

## Final Recommendation

**Decision:** [PROCEED / MODIFY / REJECT / DEFER]

**Rationale:** [Why]

**Trade-offs Accepted:** [What we give up]

**Revisit If:** [Conditions to reopen]

## Next Steps
1. [Action]
2. [Action]
```

## When to Use

- Architecture decisions
- Technology choices
- Major refactoring
- Trade-off heavy decisions
- Strategic planning

## Examples

```
/council Should we migrate from REST to GraphQL?
/council Is Redis caching worth adding?
/council Monorepo vs polyrepo?
```

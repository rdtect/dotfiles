---
description: Multi-agent research with parallel codebase + web + architecture analysis. For technology choices, unfamiliar domains, and complex questions.
---

# Research Command (Multi-Agent)

Orchestrates **parallel research streams** for comprehensive understanding before decisions.

## Agent Orchestration

```
┌─────────────────────────────────────────────────────┐
│                    /research                         │
├─────────────────────────────────────────────────────┤
│  PHASE 1: FRAME THE QUESTION                         │
│  Clarify what we need to know and why                │
├─────────────────────────────────────────────────────┤
│  PHASE 2: PARALLEL RESEARCH                          │
│  ┌─────────────┐ ┌─────────────┐ ┌───────────────┐  │
│  │  researcher │ │  researcher │ │   architect   │  │
│  │ (codebase)  │ │ (web/docs)  │ │ (implications)│  │
│  └─────────────┘ └─────────────┘ └───────────────┘  │
├─────────────────────────────────────────────────────┤
│  PHASE 3: SYNTHESIS                                  │
│  Merge findings → Options → Recommendation           │
└─────────────────────────────────────────────────────┘
```

## Execution Steps

1. **Frame the question** — Restate precisely what needs answering and why.

2. **Launch 3 agents in parallel:**
   - `researcher` (codebase focus) → Existing patterns, current implementation, dependencies, constraints
   - `researcher` (web/docs focus) → Official docs, community solutions, best practices, alternatives
   - `architect` (implications) → How options fit the architecture, MRAX alignment, trade-offs

3. **Synthesize findings:**
   - Cross-reference codebase state with external options
   - Evaluate each option against architectural constraints
   - Rate confidence: HIGH / MEDIUM / LOW per finding

4. **Present recommendation** with clear rationale

## Output Format

```markdown
# Research: [Topic]

## Question
[Precise restatement of what we need to know]

## Context
- Current state: [what exists in codebase]
- Constraint: [limits, standards, deadlines]
- Goal: [what we're trying to achieve]

## Findings

### Codebase Analysis (researcher)
- **[Finding]** — `file:line` — [relevance]
- Current patterns: [what's already in use]
- Constraints discovered: [blockers or requirements]

### External Research (researcher)
- **[Finding]** (HIGH confidence) — [official docs source]
- **[Finding]** (MEDIUM confidence) — [community source]
- Alternatives discovered: [options not considered]

### Architectural Implications (architect)
- MRAX alignment: [how options fit the framework]
- Integration points: [what connects]
- Complexity impact: [where complexity lands]

## Options

| Option | Pros | Cons | Effort | Confidence |
|--------|------|------|--------|-----------|
| A: [name] | | | S/M/L | HIGH/MED/LOW |
| B: [name] | | | S/M/L | HIGH/MED/LOW |
| C: [name] | | | S/M/L | HIGH/MED/LOW |

## Recommendation

**Option [X]** because:
1. [Strongest reason]
2. [Second reason]
3. [Risk mitigation]

**Revisit if:** [conditions that would change the recommendation]

## Open Questions
- [Anything that couldn't be resolved]
- [Areas needing further investigation]

## Next Steps
1. [Concrete action]
2. [Concrete action]
```

## When to Use

- Technology choices ("Should we use X or Y?")
- Unfamiliar domains ("How does authentication work in this framework?")
- Migration planning ("What's involved in moving from A to B?")
- Performance investigation ("Why is X slow?")
- Complex debugging ("What's causing this intermittent failure?")

## When NOT to Use

- Simple questions with known answers
- Quick file lookups (use Glob/Read)
- Decisions already made (use existing docs)

## Examples

```
/research Should we use Drizzle or Prisma for the ORM?
/research How to implement real-time updates in our stack?
/research What's the best approach for multi-tenant auth?
/research Why is the build taking 3 minutes?
```

## Follow-Up Flow

```
/research → decision → /council (if trade-offs are heavy) → /plan → implement
```

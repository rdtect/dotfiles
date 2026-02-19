---
description: Multi-agent planning with architect + planner + security perspectives. WAIT for user CONFIRM before coding.
---

# Plan Command (Multi-Agent)

Orchestrates **3 agents in parallel** for comprehensive planning.

## Agent Orchestration

```
┌─────────────────────────────────────────────────────┐
│                    /plan                            │
├─────────────────────────────────────────────────────┤
│  PARALLEL PHASE (3 agents simultaneously)           │
│  ┌─────────────┐ ┌─────────────┐ ┌───────────────┐ │
│  │  architect  │ │   planner   │ │   security    │ │
│  │  (design)   │ │  (steps)    │ │  (risks)      │ │
│  └─────────────┘ └─────────────┘ └───────────────┘ │
├─────────────────────────────────────────────────────┤
│  SYNTHESIS PHASE                                    │
│  Merge: Architecture + Steps + Security → Plan      │
├─────────────────────────────────────────────────────┤
│  WAIT FOR USER CONFIRMATION                         │
└─────────────────────────────────────────────────────┘
```

## Execution Steps

1. **Launch 3 agents in parallel:**
   - `architect` → System design, component structure, data flow
   - `planner` → Implementation phases, task breakdown, dependencies
   - `security-reviewer` → Threat model, security requirements, risks

2. **Synthesize outputs:**
   - Merge architectural decisions with implementation steps
   - Integrate security requirements into each phase
   - Identify conflicts and resolve

3. **Present unified plan:**
   - Architecture overview
   - Phased implementation steps
   - Security checkpoints
   - Risk assessment

4. **WAIT for user confirmation** before any code

## Output Format

```markdown
# Implementation Plan: [Feature]

## Architecture (from architect)
- Component structure
- Data flow diagram
- Technology decisions

## Phases (from planner)
### Phase 1: [Name]
- [ ] Task 1 (security: [checkpoint])
- [ ] Task 2
### Phase 2: [Name]
...

## Security Requirements (from security-reviewer)
- [ ] Auth: [requirement]
- [ ] Input validation: [requirement]
- [ ] Data protection: [requirement]

## Risks
| Risk | Severity | Mitigation |
|------|----------|------------|

## Dependencies
- External: [list]
- Internal: [list]

**WAITING FOR CONFIRMATION**
```

## When to Use

- New features affecting multiple components
- Architectural changes
- Security-sensitive implementations
- Complex refactoring

## Next Steps After Confirmation

```
/plan → confirm → /tdd → /build-fix → /code-review
```

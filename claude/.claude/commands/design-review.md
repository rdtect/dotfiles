---
description: Quick UX review of a specific flow or component. Lighter than /design-audit. Uses designer agent.
---

# Design Review Command

Quick UX/design review of a specific flow, component, or screen. Lighter and faster than `/design-audit`.

## Agent Orchestration

```
┌─────────────────────────────────────────────────────┐
│                 /design-review                       │
├─────────────────────────────────────────────────────┤
│  PHASE 1: CONTEXT                                    │
│  Read component code, styles, and related files      │
├─────────────────────────────────────────────────────┤
│  PHASE 2: PARALLEL REVIEW                            │
│  ┌─────────────────┐ ┌─────────────────┐            │
│  │    designer     │ │    architect    │            │
│  │  (UX + visual)  │ │  (structure)    │            │
│  └─────────────────┘ └─────────────────┘            │
├─────────────────────────────────────────────────────┤
│  PHASE 3: SYNTHESIS                                  │
│  Merge findings → Prioritized recommendations        │
└─────────────────────────────────────────────────────┘
```

## Execution Steps

1. **Identify target** — specific component, page, or user flow
2. **Read code** — component files, styles, types
3. **Launch 2 agents in parallel:**
   - `designer` → UX issues, visual polish, accessibility, user flow friction
   - `architect` → Component structure, prop design, state management patterns
4. **Synthesize** → Merge findings, deduplicate, prioritize

## Review Dimensions

| Dimension | Questions |
|-----------|-----------|
| **Clarity** | Is the primary action obvious? Can users self-navigate? |
| **Feedback** | Does every action get a response? Loading/error/success states? |
| **Accessibility** | Keyboard nav? Color contrast AA? Touch targets 44px+? ARIA labels? |
| **Consistency** | Same component styled identically everywhere? |
| **Responsiveness** | Works at 375px, 768px, 1440px? |
| **Component Design** | Props are intuitive? Reusable? Not over-abstracted? |

## Output Format

```markdown
# Design Review: [Component/Flow]

## Summary
[1-2 sentences: overall assessment]

## Issues Found

### P0 — Critical (blocks usability)
| Issue | Location | Fix |
|-------|----------|-----|
| [issue] | `file:line` | [specific fix] |

### P1 — Important (degrades experience)
| Issue | Location | Fix |
|-------|----------|-----|

### P2 — Polish (nice to have)
| Issue | Location | Fix |
|-------|----------|-----|

## Architecture Notes
- [Component structure observations from architect]
- [Suggested refactors if any]

## Quick Wins
1. [Highest impact, lowest effort fix]
2. [Second quick win]
3. [Third quick win]
```

## Difference from /design-audit

| Aspect | /design-review | /design-audit |
|--------|---------------|---------------|
| Scope | Single flow/component | Entire app |
| Agent | designer (Sonnet) | designer (Opus) |
| Output | Issue list + quick wins | Phased implementation plan |
| Time | 5-10 min | 30-60 min |
| When | During development | Pre-launch / major milestone |

## When to Use

- During feature development (quick feedback loop)
- After implementing a new component
- When something "feels off" but you can't pinpoint why
- Before showing to stakeholders

## Examples

```
/design-review login form
/design-review checkout flow
/design-review navigation sidebar
/design-review dashboard cards
```

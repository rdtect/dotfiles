---
description: Multi-agent code review with parallel security + quality + architecture analysis.
---

# Code Review Command (Multi-Agent)

Orchestrates **3 agents in parallel** for comprehensive review.

## Agent Orchestration

```
┌─────────────────────────────────────────────────────┐
│                  /code-review                       │
├─────────────────────────────────────────────────────┤
│  PARALLEL PHASE (3 agents simultaneously)           │
│  ┌─────────────┐ ┌─────────────┐ ┌───────────────┐ │
│  │  security   │ │    code     │ │   architect   │ │
│  │  reviewer   │ │  reviewer   │ │  (patterns)   │ │
│  └─────────────┘ └─────────────┘ └───────────────┘ │
├─────────────────────────────────────────────────────┤
│  SYNTHESIS: Merge findings → Unified Report         │
├─────────────────────────────────────────────────────┤
│  VERDICT: APPROVE / BLOCK / NEEDS CHANGES           │
└─────────────────────────────────────────────────────┘
```

## Execution Steps

1. **Get changed files:** `git diff --name-only HEAD`

2. **Launch 3 agents in parallel:**
   - `security-reviewer` → OWASP, secrets, injection, auth
   - `code-reviewer` → Quality, style, complexity, tests
   - `architect` → Patterns, structure, coupling, SOLID

3. **Synthesize findings:**
   - Deduplicate overlapping issues
   - Assign severity: CRITICAL > HIGH > MEDIUM > LOW
   - Group by file

4. **Render unified report**

## Output Format

```markdown
# Code Review: [branch/commit]

## Summary
- Files reviewed: X
- Issues found: Y (Z critical)
- Verdict: [APPROVE/BLOCK/NEEDS CHANGES]

## Critical Issues (BLOCKING)
### [File:Line] - [Title]
- **Found by:** security-reviewer
- **Issue:** [description]
- **Fix:** [recommendation]

## High Priority
...

## Medium Priority
...

## Architecture Notes (from architect)
- [Pattern observations]
- [Coupling concerns]
- [Suggested refactors]

## Checklist
- [ ] No hardcoded secrets
- [ ] Input validation present
- [ ] Error handling complete
- [ ] Tests cover changes
- [ ] No console.log
- [ ] Files < 800 lines
- [ ] Functions < 50 lines
```

## Verdicts

| Verdict | Condition | Action |
|---------|-----------|--------|
| **APPROVE** | No CRITICAL/HIGH | Safe to merge |
| **NEEDS CHANGES** | HIGH issues only | Fix before merge |
| **BLOCK** | CRITICAL issues | Must fix immediately |

## When to Use

- Before committing
- Before creating PR
- After significant changes
- Before merging to main

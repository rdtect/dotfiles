---
description: Multi-agent build fixing with parallel error analysis + minimal fixes.
---

# Build Fix Command (Multi-Agent)

Orchestrates **parallel analysis** then **sequential fixes**.

## Agent Orchestration

```
┌─────────────────────────────────────────────────────┐
│                   /build-fix                        │
├─────────────────────────────────────────────────────┤
│  PHASE 1: RUN BUILD                                 │
│  npm run build / npx tsc --noEmit                   │
├─────────────────────────────────────────────────────┤
│  PHASE 2: PARALLEL ERROR ANALYSIS                   │
│  ┌─────────────────┐ ┌─────────────────┐           │
│  │  build-error    │ │    architect    │           │
│  │  resolver       │ │  (root cause)   │           │
│  │  (fix plan)     │ │                 │           │
│  └─────────────────┘ └─────────────────┘           │
├─────────────────────────────────────────────────────┤
│  PHASE 3: SEQUENTIAL FIXES (build-error-resolver)   │
│  Fix one error → verify → next error                │
├─────────────────────────────────────────────────────┤
│  PHASE 4: FINAL VERIFICATION                        │
│  Build clean? Tests pass?                           │
└─────────────────────────────────────────────────────┘
```

## Execution Steps

1. **Run build** and capture errors
   ```bash
   npm run build 2>&1 || npx tsc --noEmit 2>&1
   ```

2. **Parallel analysis:**
   - `build-error-resolver` → Categorize errors, plan fixes
   - `architect` → Identify root causes, systemic issues

3. **Sequential fixes** (build-error-resolver):
   - Fix one error at a time
   - Re-run build after each fix
   - Stop if fix introduces new errors

4. **Final verification:**
   - Build passes
   - Tests still pass
   - No regressions

## Error Categories

| Category | Example | Fix Strategy |
|----------|---------|--------------|
| Type inference | `implicitly has 'any'` | Add type annotation |
| Null safety | `possibly 'undefined'` | Add `?.` or null check |
| Missing property | `Property does not exist` | Add to interface or cast |
| Import error | `Cannot find module` | Fix path or install dep |
| Assignment | `not assignable to type` | Fix type or cast |

## Output Format

```markdown
# Build Fix Session

## Initial State
- Errors: X
- Warnings: Y

## Root Cause Analysis (architect)
- [Systemic issue identified]
- [Recommendation]

## Fixes Applied
| # | File | Error | Fix | Status |
|---|------|-------|-----|--------|
| 1 | src/api.ts:42 | Type 'any' | Added `: string` | ✅ |
| 2 | src/utils.ts:15 | Undefined | Added `?.` | ✅ |

## Final State
- Build: ✅ PASS
- Tests: ✅ PASS
- New errors: 0
```

## Safety Rules

1. **Minimal diffs only** - Don't refactor
2. **One error at a time** - Verify after each
3. **Stop on regression** - If fix breaks something else
4. **Max 3 attempts** - Per error before escalating

## When to Use

- Build fails after changes
- TypeScript errors blocking commit
- CI pipeline failures
- After dependency updates

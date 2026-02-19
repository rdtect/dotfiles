---
description: Multi-agent dead code cleanup with parallel detection + safe removal.
---

# Refactor Clean Command (Multi-Agent)

Orchestrates **parallel detection** then **verified removal**.

## Agent Orchestration

```
┌─────────────────────────────────────────────────────┐
│                 /refactor-clean                     │
├─────────────────────────────────────────────────────┤
│  PHASE 1: PARALLEL DETECTION                        │
│  ┌─────────────┐ ┌─────────────┐ ┌───────────────┐ │
│  │  refactor   │ │  architect  │ │   security    │ │
│  │  cleaner    │ │ (patterns)  │ │  (critical)   │ │
│  └─────────────┘ └─────────────┘ └───────────────┘ │
├─────────────────────────────────────────────────────┤
│  PHASE 2: RISK ASSESSMENT                           │
│  Categorize: SAFE / CAREFUL / NEVER                 │
├─────────────────────────────────────────────────────┤
│  PHASE 3: SEQUENTIAL REMOVAL (refactor-cleaner)     │
│  Remove → Test → Verify → Next                      │
├─────────────────────────────────────────────────────┤
│  PHASE 4: FINAL VERIFICATION                        │
│  Build + Tests + DELETION_LOG                       │
└─────────────────────────────────────────────────────┘
```

## Execution Steps

1. **Parallel detection:**
   - `refactor-cleaner` → Run knip, depcheck, ts-prune
   - `architect` → Identify duplicate patterns, consolidation opportunities
   - `security-reviewer` → Flag critical code that must NOT be removed

2. **Risk assessment:**
   - SAFE: Unused exports, deps (no references)
   - CAREFUL: Possibly dynamic imports (grep first)
   - NEVER: Security, auth, financial, explicitly flagged

3. **Sequential removal** (refactor-cleaner):
   - Remove SAFE items first
   - Test after each batch
   - Stop on regression

4. **Final verification:**
   - Build passes
   - Tests pass
   - Update DELETION_LOG.md

## Detection Commands

```bash
npx knip                    # Unused files/exports/deps
npx depcheck               # Unused npm dependencies
npx ts-prune               # Unused TypeScript exports
```

## Risk Categories

| Risk | Action | Example |
|------|--------|---------|
| SAFE | Remove freely | Unused utility function |
| CAREFUL | Grep + test | Possibly dynamic import |
| NEVER | Do not touch | Auth, security, core business |

## Output Format

```markdown
# Refactor Clean Session

## Detection Results
| Tool | Found | Safe | Careful | Never |
|------|-------|------|---------|-------|
| knip | 15 | 12 | 2 | 1 |
| depcheck | 5 | 5 | 0 | 0 |
| ts-prune | 8 | 6 | 2 | 0 |

## Critical Code (NEVER REMOVE)
- src/auth/verify.ts (security-reviewer)
- src/payments/process.ts (security-reviewer)

## Removed
| Item | Type | Reason |
|------|------|--------|
| lodash@4.17.21 | dep | Not imported |
| src/old-utils.ts | file | No references |

## Impact
- Files: -5
- Dependencies: -3
- Lines: -450
- Bundle: -25KB

## Verification
- Build: ✅
- Tests: ✅
- Regressions: 0
```

## When to Use

- Periodic maintenance (monthly)
- Before major releases
- After removing features
- Bundle size optimization

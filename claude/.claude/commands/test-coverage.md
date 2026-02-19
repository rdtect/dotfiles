---
description: Multi-agent test coverage verification with gap analysis + test generation.
---

# Test Coverage Command (Multi-Agent)

Orchestrates **parallel analysis** + **targeted test generation**.

## Agent Orchestration

```
┌─────────────────────────────────────────────────────┐
│                 /test-coverage                      │
├─────────────────────────────────────────────────────┤
│  PHASE 1: COVERAGE ANALYSIS                         │
│  npm test -- --coverage                             │
├─────────────────────────────────────────────────────┤
│  PHASE 2: PARALLEL GAP ANALYSIS                     │
│  ┌─────────────────┐ ┌─────────────────┐           │
│  │   tdd-guide     │ │   security      │           │
│  │  (coverage gaps)│ │ (critical paths)│           │
│  └─────────────────┘ └─────────────────┘           │
├─────────────────────────────────────────────────────┤
│  PHASE 3: TEST GENERATION (tdd-guide)               │
│  Generate tests for uncovered code                  │
├─────────────────────────────────────────────────────┤
│  PHASE 4: VERIFICATION                              │
│  Re-run coverage → Verify 80%+                      │
└─────────────────────────────────────────────────────┘
```

## Execution Steps

1. **Run coverage analysis:**
   ```bash
   npm test -- --coverage --coverageReporters=json-summary
   ```

2. **Parallel gap analysis:**
   - `tdd-guide` → Identify uncovered functions, branches
   - `security-reviewer` → Flag critical paths needing 100%

3. **Generate missing tests** (tdd-guide):
   - Prioritize: security-critical > core business > utilities
   - Write tests for uncovered branches
   - Add edge cases

4. **Verify coverage meets targets**

## Coverage Targets

| Code Type | Target | Required By |
|-----------|--------|-------------|
| Overall | 80% | tdd-guide |
| Financial | 100% | security-reviewer |
| Auth/Security | 100% | security-reviewer |
| Core Business | 100% | tdd-guide |
| Utilities | 80% | tdd-guide |

## Output Format

```markdown
# Test Coverage Report

## Current Coverage
| Metric | Value | Target | Status |
|--------|-------|--------|--------|
| Statements | 75% | 80% | ❌ |
| Branches | 68% | 80% | ❌ |
| Functions | 82% | 80% | ✅ |
| Lines | 74% | 80% | ❌ |

## Critical Gaps (security-reviewer)
| File | Function | Coverage | Priority |
|------|----------|----------|----------|
| src/auth/verify.ts | validateToken | 45% | CRITICAL |
| src/payments/process.ts | charge | 60% | CRITICAL |

## Tests Generated
- src/auth/verify.test.ts (+5 tests)
- src/payments/process.test.ts (+8 tests)

## Final Coverage
| Metric | Before | After | Status |
|--------|--------|-------|--------|
| Statements | 75% | 85% | ✅ |
| Branches | 68% | 82% | ✅ |
```

## When to Use

- Before merging PRs
- Before releases
- After adding new features
- Periodic quality checks

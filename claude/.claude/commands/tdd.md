---
description: Multi-agent TDD with parallel test generation + implementation + coverage verification.
---

# TDD Command (Multi-Agent)

Orchestrates **sequential + parallel agents** for test-driven development.

## Agent Orchestration

```
┌─────────────────────────────────────────────────────┐
│                      /tdd                           │
├─────────────────────────────────────────────────────┤
│  PHASE 1: SCAFFOLD (tdd-guide)                      │
│  Define interfaces, types, function signatures      │
├─────────────────────────────────────────────────────┤
│  PHASE 2: RED - Write failing tests (tdd-guide)     │
│  Generate comprehensive test cases                  │
├─────────────────────────────────────────────────────┤
│  PHASE 3: GREEN - Implement (tdd-guide)             │
│  Write minimal code to pass tests                   │
├─────────────────────────────────────────────────────┤
│  PHASE 4: PARALLEL VERIFICATION                     │
│  ┌─────────────┐ ┌─────────────┐ ┌───────────────┐ │
│  │   build     │ │    code     │ │   security    │ │
│  │   resolver  │ │  reviewer   │ │   reviewer    │ │
│  └─────────────┘ └─────────────┘ └───────────────┘ │
├─────────────────────────────────────────────────────┤
│  PHASE 5: REFACTOR if issues found                  │
└─────────────────────────────────────────────────────┘
```

## Execution Steps

1. **SCAFFOLD** (tdd-guide agent)
   - Define TypeScript interfaces
   - Create function signatures
   - Establish contracts

2. **RED** (tdd-guide agent)
   - Write failing tests
   - Cover: happy path, edge cases, errors
   - Run tests → verify FAIL

3. **GREEN** (tdd-guide agent)
   - Write minimal implementation
   - Run tests → verify PASS

4. **VERIFY** (3 agents in parallel)
   - `build-error-resolver` → Type errors, build issues
   - `code-reviewer` → Quality, patterns, complexity
   - `security-reviewer` → Vulnerabilities (if applicable)

5. **REFACTOR** (tdd-guide agent)
   - Address issues from verification
   - Improve code while tests stay green
   - Re-verify

## TDD Cycle

```
          ┌──────────────────────┐
          │                      │
          ▼                      │
    ┌──────────┐           ┌──────────┐
    │   RED    │──────────▶│  GREEN   │
    │  (test)  │           │  (code)  │
    └──────────┘           └──────────┘
          ▲                      │
          │                      ▼
          │              ┌──────────────┐
          │              │   REFACTOR   │
          │              │  (improve)   │
          │              └──────────────┘
          │                      │
          └──────────────────────┘
```

## Coverage Requirements

| Code Type | Minimum | Enforced By |
|-----------|---------|-------------|
| Standard | 80% | tdd-guide |
| Financial | 100% | security-reviewer |
| Auth/Security | 100% | security-reviewer |
| Core Business | 100% | code-reviewer |

## Output Format

```markdown
# TDD Session: [Feature]

## Scaffold
- Interface: [name]
- Functions: [list]

## Tests Written (RED)
- [x] Happy path: [description]
- [x] Edge case: [description]
- [x] Error case: [description]

## Implementation (GREEN)
- File: [path]
- Lines: [count]

## Verification Results
| Agent | Status | Issues |
|-------|--------|--------|
| build-resolver | ✅ | None |
| code-reviewer | ⚠️ | 2 medium |
| security | ✅ | None |

## Coverage
- Statements: XX%
- Branches: XX%
- Functions: XX%
- Lines: XX%

## Next Steps
- [ ] Fix medium issues
- [ ] Add integration tests
```

## When to Use

- New feature implementation
- Bug fixes (test reproduces bug first)
- Refactoring existing code
- Critical business logic

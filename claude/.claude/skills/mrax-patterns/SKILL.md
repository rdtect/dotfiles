---
name: mrax-patterns
description: MRAX framework patterns for project organization, decision trees, fractal structure, and the Seven Beliefs applied to code. Quick reference.
---

# MRAX Patterns

## The Four Layers

```
1_Model/   → TRUTH      → What you know (data shapes, schemas, constants)
2_Rules/   → VALIDATION → How you decide (business logic, constraints, policies)
3_Actions/ → MUTATION   → What you build (side effects, I/O, state changes)
4_Logs/    → REFLECTION → What happened (audit trails, session logs, learnings)
```

## Decision Tree: Where Does This Go?

```
Is it a data shape, schema, or constant?
  → YES → Model

Is it a business rule, validation, or constraint?
  → YES → Rules

Does it cause side effects, I/O, or state mutation?
  → YES → Actions

Is it a temporal record, log, or learning?
  → YES → Logs

None of the above?
  → Inbox (triage later)
```

## Fractal Application

The same MRAX pattern applies at every scale:

### System Level

```
project/
├── models/       → Shared types, schemas
├── rules/        → Business logic, policies
├── actions/      → API handlers, jobs, migrations
└── logs/         → Audit, analytics, monitoring
```

### Domain Level

```
auth/
├── types.ts      → User, Session, Token types
├── rules.ts      → validatePassword, checkPermissions
├── actions.ts    → login, logout, refreshToken
└── auth.test.ts  → verification
```

### Module Level

```
feature/
├── types.ts      → Data shapes
├── rules.ts      → Business logic
├── actions.ts    → Mutations
├── index.ts      → Public API (barrel export)
└── feature.test.ts
```

### Component Level

```typescript
// types — Model
interface ButtonProps { label: string; variant: 'primary' | 'secondary' }

// rules — Rules
function getButtonStyles(variant: ButtonProps['variant']) { /* ... */ }

// component — Actions (renders = side effect)
function Button({ label, variant }: ButtonProps) {
  const styles = getButtonStyles(variant)
  return <button className={styles}>{label}</button>
}
```

## The Seven Beliefs (Applied to Code)

### 1. Architecture without code is fantasy; code without architecture is chaos
→ Every design decision must be implementable. Every implementation must fit the design.

### 2. Patterns are forces to feel, not shapes to copy
→ Don't cargo-cult patterns. Understand the *problem* the pattern solves, then apply it naturally.

### 3. The best abstraction is deletable
→ Can you remove this module without breaking unrelated code? If not, it's too coupled.

### 4. Complexity belongs in Rules, not data
→ Keep Model (types) simple. Put validation, constraints, and logic in Rules.

### 5. The Fractal Game is always playing
→ If your system-level architecture doesn't mirror your module-level structure, something is wrong.

### 6. Notice. Engage. Mull. Exchange.
→ Don't skip to implementation. Observe → Explore → Think → Act.

### 7. There are no solutions, only improvements
→ Ship the improvement. Don't wait for perfection.

## File Naming Conventions

| Layer | Files | Purpose |
|-------|-------|---------|
| Model | `types.ts`, `schemas.ts`, `constants.ts` | Data shapes, validation schemas, fixed values |
| Rules | `rules.ts`, `validators.ts`, `policies.ts` | Business logic, constraints |
| Actions | `actions.ts`, `handlers.ts`, `services.ts` | Side effects, I/O |
| Logs | `logger.ts`, `audit.ts`, `metrics.ts` | Temporal records |
| Public | `index.ts` | Barrel export (only public API) |
| Test | `*.test.ts`, `*.spec.ts` | Verification |

## Complexity Budget

| Layer | Allowed Complexity | Reason |
|-------|-------------------|--------|
| Model | LOW | Truth should be simple and stable |
| Rules | HIGH | This is where domain knowledge lives |
| Actions | MEDIUM | Orchestration, not logic |
| Logs | LOW | Append-only, no decisions |

**Red flag**: If your `actions.ts` has more logic than `rules.ts`, refactor.

## MRAX for Decision Making

```
Notice  → What's the current state? What are the constraints?
Engage  → What options exist? What are the trade-offs?
Mull    → Which option best fits? What are the risks?
Exchange → Decide. Document. Ship.
```

---

*For architecture patterns, see `arch-patterns`. For project philosophy, see `CLAUDE.md`.*

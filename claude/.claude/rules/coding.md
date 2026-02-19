# Coding Standards

*Philosophy: See CLAUDE.md (MRAX, Fractal, Deletable Abstractions)*

---

## Immutability (CRITICAL)

```javascript
// WRONG
user.name = name

// CORRECT
return { ...user, name }
```

## File Organization

- 200-400 lines typical, 800 max
- Organize by feature/domain (fractal)

```
feature/
├── index.ts      # Public API
├── types.ts      # Data shapes
├── rules.ts      # Business logic
├── actions.ts    # Mutations/effects
└── feature.test.ts
```

## Abstractions

Before creating, ask:
- Can I delete this without breaking unrelated code?
- Is 3 lines of duplication worse than this abstraction?

---

## Patterns

*See `backend-patterns` and `frontend-patterns` skills for code examples.*

### Input Validation (Boundary Only)
```typescript
const UserSchema = z.object({
  email: z.string().email(),
  age: z.number().int().min(0).max(150)
})
const validated = UserSchema.parse(untrustedInput)
```

---

## Testing

**Coverage: 80% minimum**

| Type | Scope |
|------|-------|
| Unit | Functions, utilities, components |
| Integration | API endpoints, database |
| E2E | Critical user flows (Playwright) |

**TDD Cycle**: RED → GREEN → REFACTOR

---

## Security

Before ANY commit:
- [ ] No hardcoded secrets
- [ ] User inputs validated
- [ ] SQL injection prevented (parameterized)
- [ ] XSS prevented (sanitized)
- [ ] Error messages don't leak data

```typescript
// NEVER
const apiKey = "sk-proj-xxxxx"

// ALWAYS
const apiKey = process.env.OPENAI_API_KEY
```

---

## Checklist

- [ ] Functions <50 lines, Files <800 lines
- [ ] No deep nesting (>4 levels)
- [ ] No console.log, no hardcoded values
- [ ] No mutations
- [ ] Abstractions are deletable

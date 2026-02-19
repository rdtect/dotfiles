---
name: testing-patterns
description: Testing patterns for unit, integration, and E2E tests. Mocking, fixtures, coverage strategies. Quick reference.
---

# Testing Patterns

## Unit Test (Arrange-Act-Assert)

```typescript
describe('calculateTotal', () => {
  it('sums items with tax', () => {
    // Arrange
    const items = [{ price: 10 }, { price: 20 }]
    const taxRate = 0.1

    // Act
    const total = calculateTotal(items, taxRate)

    // Assert
    expect(total).toBe(33)
  })
})
```

## Mocking Strategies

### Manual Mock

```typescript
// __mocks__/database.ts
export const findUser = vi.fn(() => Promise.resolve({ id: '1', name: 'Test' }))
```

### MSW (API Mocking)

```typescript
import { http, HttpResponse } from 'msw'
import { setupServer } from 'msw/node'

const server = setupServer(
  http.get('/api/users/:id', ({ params }) =>
    HttpResponse.json({ id: params.id, name: 'Test User' })
  )
)

beforeAll(() => server.listen())
afterEach(() => server.resetHandlers())
afterAll(() => server.close())
```

### Test Doubles

| Type | Purpose | Example |
|------|---------|---------|
| Stub | Returns fixed value | `vi.fn(() => 42)` |
| Spy | Tracks calls | `vi.spyOn(obj, 'method')` |
| Mock | Stub + assertions | `vi.fn().mockResolvedValue(data)` |
| Fake | Working implementation | In-memory database |

## Fixture Management

### Factory Pattern

```typescript
function createUser(overrides: Partial<User> = {}): User {
  return {
    id: crypto.randomUUID(),
    name: 'Test User',
    email: 'test@example.com',
    createdAt: new Date(),
    ...overrides,
  }
}

// Usage
const admin = createUser({ role: 'admin' })
```

### Builder Pattern

```typescript
class UserBuilder {
  private user: Partial<User> = {}

  withName(name: string) { this.user.name = name; return this }
  withRole(role: string) { this.user.role = role; return this }
  build(): User { return createUser(this.user) }
}

const user = new UserBuilder().withName('Alice').withRole('admin').build()
```

## Coverage Strategy

| Metric | Target | Measures |
|--------|--------|----------|
| Statements | 80% | Lines executed |
| Branches | 80% | if/else paths taken |
| Functions | 80% | Functions called |
| Lines | 80% | Source lines hit |

**Critical code** (auth, payments, security): **100%** coverage required.

```bash
vitest run --coverage                          # Vitest
jest --coverage                                # Jest
npx c8 vitest run                              # c8 reporter
```

## Framework Patterns

### Vitest

```typescript
import { describe, it, expect, vi, beforeEach } from 'vitest'

describe('UserService', () => {
  beforeEach(() => { vi.clearAllMocks() })

  it('creates user with hashed password', async () => {
    const user = await createUser({ email: 'a@b.com', password: 'test' })
    expect(user.password).not.toBe('test')
  })
})
```

### React Testing Library

```typescript
import { render, screen, userEvent } from '@testing-library/react'

it('submits form with valid data', async () => {
  const onSubmit = vi.fn()
  render(<Form onSubmit={onSubmit} />)

  await userEvent.type(screen.getByLabelText('Email'), 'test@test.com')
  await userEvent.click(screen.getByRole('button', { name: 'Submit' }))

  expect(onSubmit).toHaveBeenCalledWith({ email: 'test@test.com' })
})
```

## Anti-Patterns

| Bad | Good |
|-----|------|
| Test implementation details | Test behavior |
| Shared mutable state between tests | Each test sets up own data |
| Snapshot everything | Snapshot only stable structures |
| `expect(true).toBe(true)` | Meaningful assertions |
| Testing private methods | Test through public API |
| Giant test files | Colocated `*.test.ts` per module |

## Edge Cases (MUST Test)

1. Null/undefined inputs
2. Empty arrays/strings
3. Boundary values (0, -1, MAX_INT)
4. Invalid types (if JS, not TS)
5. Network failures / timeouts
6. Concurrent operations
7. Special characters in strings

---

*For E2E patterns, see `e2e-runner` agent. For TDD workflow, see `tdd-guide` agent.*

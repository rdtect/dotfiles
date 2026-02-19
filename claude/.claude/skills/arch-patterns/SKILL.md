---
name: arch-patterns
description: Architecture patterns for system design, modules, and code organization. MRAX fractal, error handling, DI, boundaries. Quick reference.
---

# Architecture Patterns

## MRAX Fractal (Every Scale)

```
[System / Domain / Module / Component]
├── types.ts    → Model  (pure data shapes, no behavior)
├── rules.ts    → Rules  (business logic, validation, constraints)
├── actions.ts  → Actions (mutations, side effects, I/O)
├── index.ts    → Public API (barrel export)
└── *.test.ts   → Verification
```

**Complexity budget:**
- Model: LOW (just data shapes)
- Rules: HIGH (logic belongs here)
- Actions: MEDIUM (thin orchestration)

## Repository Pattern

```typescript
interface Repository<T> {
  findAll(filters?: Filters): Promise<T[]>
  findById(id: string): Promise<T | null>
  create(data: CreateDto): Promise<T>
  update(id: string, data: UpdateDto): Promise<T>
  delete(id: string): Promise<void>
}

// Implementation
class UserRepository implements Repository<User> {
  constructor(private db: Database) {}

  async findById(id: string): Promise<User | null> {
    return this.db.query('SELECT * FROM users WHERE id = $1', [id])
  }
}
```

## Service Pattern

```typescript
// Services orchestrate repositories + rules
class OrderService {
  constructor(
    private orders: OrderRepository,
    private inventory: InventoryRepository,
    private rules: OrderRules,
  ) {}

  async placeOrder(dto: PlaceOrderDto): Promise<Order> {
    const validated = this.rules.validateOrder(dto)       // Rules
    await this.inventory.reserve(validated.items)          // Action
    return this.orders.create(validated)                   // Action
  }
}
```

## Error Handling (Result Type)

```typescript
type Result<T, E = Error> =
  | { ok: true; value: T }
  | { ok: false; error: E }

function parseEmail(input: string): Result<Email, 'INVALID_FORMAT'> {
  if (!EMAIL_REGEX.test(input)) return { ok: false, error: 'INVALID_FORMAT' }
  return { ok: true, value: input as Email }
}

// Usage — caller decides how to handle
const result = parseEmail(input)
if (!result.ok) return res.status(400).json({ error: result.error })
```

## Error Boundary (React)

```typescript
class ErrorBoundary extends Component<Props, { error: Error | null }> {
  state = { error: null }
  static getDerivedStateFromError(error: Error) { return { error } }
  render() {
    if (this.state.error) return <this.props.fallback error={this.state.error} />
    return this.props.children
  }
}
```

## Dependency Injection (No Framework)

```typescript
// Wire dependencies at the composition root
function createApp(config: Config) {
  const db = new Database(config.databaseUrl)
  const userRepo = new UserRepository(db)
  const userRules = new UserRules()
  const userService = new UserService(userRepo, userRules)
  const userController = new UserController(userService)
  return { userController }
}
```

## Module Boundaries

```typescript
// feature/index.ts — the ONLY public API
export { UserService } from './service'
export type { User, CreateUserDto } from './types'

// Everything else is internal
// Do NOT import from feature/rules.ts directly
```

**Signs of leaky abstraction:**
- Importing from internal paths (`feature/utils/helper`)
- Exposing database types through API boundaries
- Passing framework objects (req, res) into business logic

## Event-Driven Pattern

```typescript
// Decouple domains through events
interface DomainEvent {
  type: string
  payload: unknown
  timestamp: Date
}

class EventBus {
  private handlers = new Map<string, Handler[]>()

  on(type: string, handler: Handler) { /* subscribe */ }
  emit(event: DomainEvent) { /* publish to all handlers */ }
}

// Usage
eventBus.emit({ type: 'ORDER_PLACED', payload: order, timestamp: new Date() })
```

## CQRS (When Reads != Writes)

```
Write Model → Command → Validate → Persist → Emit Event
Read Model  → Query → Optimized View → Return

Use when:
- Read and write patterns are very different
- Read performance needs denormalized data
- Audit trail is important

Don't use when:
- Simple CRUD is sufficient
- Team is small and overhead isn't worth it
```

## Decision Framework

| Question | Threshold |
|----------|-----------|
| Introduce abstraction? | After 3rd concrete use (Rule of Three) |
| Split a module? | 2+ unrelated responsibilities |
| Add dependency? | Saves > 100 lines AND well-maintained |
| Create new service? | New bounded context with its own data |
| Use event-driven? | 2+ consumers of same action |

---

*For API patterns, see `backend-patterns`. For UI patterns, see `frontend-patterns`.*

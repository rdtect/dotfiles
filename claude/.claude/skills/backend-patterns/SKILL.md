---
name: backend-patterns
description: Backend patterns for APIs, databases, and server-side code. Quick reference.
---

# Backend Patterns

## API Design

```
GET    /api/resources          # List
GET    /api/resources/:id      # Get one
POST   /api/resources          # Create
PUT    /api/resources/:id      # Replace
PATCH  /api/resources/:id      # Update
DELETE /api/resources/:id      # Delete
```

Query params: `?status=active&sort=name&limit=20&offset=0`

## Response Format

```typescript
interface ApiResponse<T> {
  success: boolean
  data?: T
  error?: string
  meta?: { total: number; page: number; limit: number }
}
```

## Repository Pattern

```typescript
interface Repository<T> {
  findAll(filters?: Filters): Promise<T[]>
  findById(id: string): Promise<T | null>
  create(data: CreateDto): Promise<T>
  update(id: string, data: UpdateDto): Promise<T>
  delete(id: string): Promise<void>
}
```

## Error Handling

```typescript
// Centralized error handler
app.use((err, req, res, next) => {
  const status = err.status || 500
  const message = err.expose ? err.message : 'Internal error'
  res.status(status).json({ success: false, error: message })
})
```

## Validation (Boundary)

```typescript
const UserSchema = z.object({
  email: z.string().email(),
  name: z.string().min(1).max(100)
})

// Validate at API boundary only
const validated = UserSchema.parse(req.body)
```

## Caching

```typescript
// Cache-aside pattern
async function getUser(id: string) {
  const cached = await cache.get(`user:${id}`)
  if (cached) return cached

  const user = await db.users.findById(id)
  await cache.set(`user:${id}`, user, { ttl: 3600 })
  return user
}
```

## Database

```typescript
// Parameterized queries (prevent SQL injection)
const users = await db.query(
  'SELECT * FROM users WHERE id = $1',
  [userId]
)

// Transactions
await db.transaction(async (tx) => {
  await tx.insert(orders).values(order)
  await tx.update(inventory).set({ quantity: sql`quantity - 1` })
})
```

## Rate Limiting

```typescript
// Per-user rate limit
const limiter = rateLimit({
  windowMs: 60 * 1000,  // 1 minute
  max: 100,              // 100 requests
  keyGenerator: (req) => req.user?.id || req.ip
})
```

---

*For full examples, check project codebase or external docs.*

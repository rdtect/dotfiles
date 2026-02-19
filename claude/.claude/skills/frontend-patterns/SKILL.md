---
name: frontend-patterns
description: Frontend patterns for React, state, and UI. Quick reference.
---

# Frontend Patterns

## Component Structure

```
components/
├── Button/
│   ├── Button.tsx      # Component
│   ├── Button.test.tsx # Tests
│   └── index.ts        # Export
```

## React Patterns

### Custom Hook

```typescript
function useDebounce<T>(value: T, delay: number): T {
  const [debounced, setDebounced] = useState(value)

  useEffect(() => {
    const timer = setTimeout(() => setDebounced(value), delay)
    return () => clearTimeout(timer)
  }, [value, delay])

  return debounced
}
```

### Data Fetching

```typescript
function useQuery<T>(key: string, fetcher: () => Promise<T>) {
  const [data, setData] = useState<T | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)

  useEffect(() => {
    fetcher()
      .then(setData)
      .catch(setError)
      .finally(() => setLoading(false))
  }, [key])

  return { data, loading, error }
}
```

### Memoization

```typescript
// Expensive computation
const sortedItems = useMemo(
  () => items.sort((a, b) => a.name.localeCompare(b.name)),
  [items]
)

// Stable callback
const handleClick = useCallback(
  () => onClick(id),
  [id, onClick]
)
```

## State Patterns

### Context + Reducer

```typescript
const StateContext = createContext<State | null>(null)
const DispatchContext = createContext<Dispatch | null>(null)

function StateProvider({ children }) {
  const [state, dispatch] = useReducer(reducer, initialState)
  return (
    <StateContext.Provider value={state}>
      <DispatchContext.Provider value={dispatch}>
        {children}
      </DispatchContext.Provider>
    </StateContext.Provider>
  )
}
```

## Performance

```typescript
// Virtualization for long lists
<VirtualList
  height={400}
  itemCount={items.length}
  itemSize={50}
  renderItem={({ index }) => <Item data={items[index]} />}
/>

// Lazy loading
const Modal = lazy(() => import('./Modal'))
```

## Form Patterns

```typescript
// Controlled input
const [value, setValue] = useState('')
<input value={value} onChange={e => setValue(e.target.value)} />

// Form validation
const { register, handleSubmit, errors } = useForm({
  resolver: zodResolver(schema)
})
```

## Error Boundaries

```typescript
class ErrorBoundary extends Component {
  state = { hasError: false }

  static getDerivedStateFromError() {
    return { hasError: true }
  }

  render() {
    if (this.state.hasError) return <ErrorFallback />
    return this.props.children
  }
}
```

## Accessibility

```typescript
// Focus management
const inputRef = useRef<HTMLInputElement>(null)
useEffect(() => inputRef.current?.focus(), [isOpen])

// Keyboard navigation
onKeyDown={(e) => {
  if (e.key === 'Escape') onClose()
  if (e.key === 'Enter') onSubmit()
}}
```

---

*For full examples, check project codebase or external docs.*

# Workflow

---

## Git

### Commit Format
```
<type>: <description>

<optional body>
```
Types: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `perf`, `ci`

### PR Workflow
1. Analyze full commit history (`git diff [base]...HEAD`)
2. Draft comprehensive summary
3. Include test plan
4. Push with `-u` flag if new branch

### Feature Flow
```
Plan → TDD → Review → Commit
```

---

## Hooks

| Event | Purpose |
|-------|---------|
| PreToolUse | Validation before execution |
| PostToolUse | Auto-format, checks |
| Stop | Final verification |

### Current Hooks
- **PreToolUse**: tmux reminder, git push review
- **PostToolUse**: console.log warning
- **Stop**: session log to Obsidian

---

## Performance

*Model selection: See `agents.md`*

### Context Management
- Use subagents for exploration (keeps main context clean)
- Run `/clear` between unrelated tasks
- Use `/compact` to summarize when context fills
- Agent Teams: each teammate gets own 200K context window

### Complex Tasks
1. Use extended thinking (enabled by default via alwaysThinkingEnabled)
2. Use Plan Mode for architecture decisions
3. Use parallel agents (Task tool) for diverse analysis
4. Use Agent Teams for complex parallel collaboration

---

## TodoWrite

Use to:
- Track multi-step progress
- Show implementation steps
- Enable real-time steering

Bad signs:
- Out of order steps
- Missing items
- Wrong granularity

# Claude Code - rdtect Configuration

## Philosophy (The Seven Beliefs)

1. **Architecture without code is fantasy; code without architecture is chaos** - Both must live in one mind
2. **Patterns are forces to feel, not shapes to copy** - Deep understanding over superficial application
3. **The best abstraction is deletable** - Disposability over preciousness
4. **Complexity belongs in Rules, not data** - Keep Model pure
5. **The Fractal Game is always playing** - Same patterns at every scale
6. **Notice. Engage. Mull. Exchange** - The MRAX rhythm of work
7. **There are no solutions, only improvements** - Continuous iteration

---

## MRAX Framework

Organize work by cognitive function:

```
1_Model/   → TRUTH      → What you know (permanent knowledge)
2_Rules/   → VALIDATION → How you decide (procedures, constraints)
3_Actions/ → MUTATION   → What you build (projects, execution)
4_Logs/    → REFLECTION → What happened (temporal, learnings)
```

**Decision Tree:**
- Universal knowledge? → Model
- Procedure/standard? → Rules
- Active work? → Actions
- Log/reflection? → Logs
- Unsure? → Inbox (triage later)

---

## SuperClaude Toolchain

| Role | Tool | Purpose |
|------|------|---------|
| **Cortex** | Claude Code | Architect & Planner |
| **Hands** | Neovim + Avante | Surgeon (precise edits) |
| **Orchestrator** | Opencode CLI | Manager (task loops) |

**Workflows:**
- **Deep Work**: Plan (Claude) → Scaffold (MCP) → Refine (Avante) → Verify (tests)
- **Quick Fix**: Identify → `opencode run "fix X"` → Review → Commit

---

## System Environment

- **OS**: Arch Linux (WSL2)
- **Package Manager**: `pacman` (NOT apt/yum)
- **Shell**: zsh + oh-my-zsh + powerlevel10k
- **Editor**: neovim (primary)
- **Languages**: Python 3.13, Node 25.x, Rust 1.91, Bun

## Paths

- **Projects**: `~/Projects/`
- **Obsidian Vault**: `~/Projects/Personal/notes/` → `/mnt/d/rdtect`
- **MCP Config**: `~/.config/claude/claude_desktop_config.json`

## AI Tools

- **Claude Code**: Primary (this tool) - The Cortex
- **Opencode CLI**: Task orchestration - The Orchestrator
- **Avante.nvim**: In-editor AI - The Hands

---

## Working Style

- **Communication**: Clear, concise, structured
- **Approach**: Notice patterns → Engage constraints → Mull possibilities → Exchange with reality
- **Process**: Explicit over implicit, authority rings over consensus
- **Code**: Immutability always, many small files, 80%+ test coverage

## Modular Rules

Detailed guidelines in `~/.claude/rules/`:
- `coding.md` - Style, patterns, testing, security
- `workflow.md` - Git, hooks, performance
- `agents.md` - Agent orchestration patterns + Agent Teams

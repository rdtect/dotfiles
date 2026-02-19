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

## Toolchain

| Role | Tool | Purpose |
|------|------|---------|
| **Cortex** | Claude Code (this) | Architect, planner, agent director |
| **Editor** | VS Code / Cursor | Primary code editor |
| **AI Services** | VPS (Ollama, n8n) | Background inference, automation |

**Workflows:**
- **Deep Work**: Plan (Claude Code) → Implement (agents) → Review (code-reviewer) → Ship
- **Quick Fix**: Identify → delegate to build-error-resolver → verify → commit

---

## System Environment

> **ADR-001 (2026-02-19):** Windows native is the primary dev environment. Kali WSL2 for security practice only. See `2_Rules/decisions/ADR-001-dev-environment-windows-native.md`.

- **Primary OS**: Windows native (Claude Code, Node, Python, Rust, Bun)
- **Security**: Kali WSL2 (`wsl --install kali-linux`) — pen-testing, CTF only
- **Shell**: zsh (WSL) / PowerShell (Windows)
- **Editor**: VS Code / Cursor
- **Languages**: Python 3.13, Node 25.x, Rust, Bun
- **MacBook**: Incoming primary machine — same config via dotfiles bootstrap

## Paths

- **Projects**: `~/Projects/` (WSL) or `C:\Users\Rick\Projects\` (Windows)
- **Obsidian Vault**: `/mnt/d/rdtect` (WSL) → `D:\rdtect` (Windows)
- **Dotfiles**: `github.com/rdtect/dotfiles` (GNU Stow managed)

## AI Stack

- **Claude Code**: Primary AI (this tool) — 12 agents, 13 commands, 6 skills
- **Ollama on VPS**: Free/fast inference for background tasks (qwen2.5:7b)
- **n8n on VPS**: Workflow automation, session sync
- **ChromaDB on VPS**: Semantic memory across all knowledge
- **Open WebUI**: Multi-model interface at ai.rdtect.com

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

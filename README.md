# rdtect dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Start

```bash
git clone https://github.com/rdtect/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

## Packages

| Package | Contents |
|---------|----------|
| `claude/` | Claude Code config: agents, commands, skills, rules, hooks, CLAUDE.md |
| `zsh/` | `.zshrc`, `.p10k.zsh` (Powerlevel10k) |
| `git/` | `.gitconfig` |

## Manual Stow

```bash
stow --no-folding -t ~ claude   # Claude Code config
stow --no-folding -t ~ zsh      # Shell config
stow --no-folding -t ~ git      # Git config
```

## Structure

```
dotfiles/
├── claude/.claude/
│   ├── CLAUDE.md           → global AI instructions
│   ├── agents/             → 12 custom agents
│   ├── commands/           → slash commands
│   ├── skills/             → code pattern skills
│   ├── rules/              → coding standards
│   ├── memory/             → agent memory (compounds over time)
│   ├── session-log.sh      → Stop hook: logs sessions to Obsidian
│   ├── statusline.sh       → Status bar script
│   ├── settings.json       → Claude Code settings
│   └── .mcp.json           → MCP server config
├── zsh/
│   ├── .zshrc
│   └── .p10k.zsh
├── git/
│   └── .gitconfig
├── bootstrap.sh            → Fresh machine setup
└── README.md
```

## What's NOT tracked

- `~/.claude/projects/` — project session caches
- `~/.claude/history.jsonl` — conversation history
- `~/.claude/.credentials.json` — API keys (never commit secrets)
- `~/.zsh_history` — shell history
- Any `.env` or secret files

## Adding new dotfiles

```bash
# Move file into dotfiles structure
mv ~/.config/newapp dotfiles/newapp/.config/newapp

# Stow it
stow --no-folding -t ~ newapp

# Commit
git add . && git commit -m "feat: add newapp config"
```

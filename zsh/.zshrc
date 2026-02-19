# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ===========================================
# Environment Variables
# ===========================================
export EDITOR='nvim'
export VISUAL='nvim'

# PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"

# ===========================================
# Aliases
# ===========================================
# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias projects='cd ~/Projects'
alias zyeta='cd ~/Projects/zyeta'
alias personal='cd ~/Projects/personal'
alias notes='cd ~/Projects/personal/notes'

# System
alias update='echo "Updating system..." && sudo pacman -Syu'
alias cls='clear'
alias reload='source ~/.zshrc'
alias path='echo -e ${PATH//:/\\n}'

# Tools replacements
alias vi='nvim'
alias vim='nvim'
alias cat='bat --paging=never'
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first --git'
alias tree='eza --tree --icons'
alias grep='rg'
alias find='fd'

# Windows Tools
alias chrome='"/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"'
alias explorer='explorer.exe'

# ===========================================
# Tmux Productivity
# ===========================================
alias tn='tmux new -s'                 # New named session: tn my-project
alias ta='tmux attach -t'              # Attach to session: ta my-project
alias tl='tmux list-sessions'          # List sessions
alias tk='tmux kill-session -t'        # Kill session: tk my-project

# t3: Main Workspace (Editor Left, Terminal Top-Right, Server Bottom-Right)
t3() {
    local session_name="${1:-workspace}"
    tmux new-session -d -s "$session_name"
    tmux split-window -h -p 35         # Split right (35% width)
    tmux split-window -v -p 50         # Split right pane vertically
    tmux select-pane -t 1              # Focus back to main editor pane
    tmux attach-session -t "$session_name"
}

# ===========================================
# Tool Configurations
# ===========================================

# Bun
export BUN_INSTALL="$HOME/.bun"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# NVM (lazy loaded for faster shell startup)
export NVM_DIR="$HOME/.nvm"
nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm "$@"
}
node() { nvm use default &>/dev/null; command node "$@"; }
npm() { nvm use default &>/dev/null; command npm "$@"; }
npx() { nvm use default &>/dev/null; command npx "$@"; }

# Cargo/Rust
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# FZF
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# ===========================================
# SSH Agent
# ===========================================
if [ -z "$SSH_AUTH_SOCK" ]; then
  RUNNING_AGENT=$(pgrep -c ssh-agent 2>/dev/null || echo 0)
  if [ "$RUNNING_AGENT" = "0" ]; then
    ssh-agent -s &> "$HOME/.ssh/ssh-agent"
  fi
  if [[ -f "$HOME/.ssh/ssh-agent" ]]; then
    eval $(command cat "$HOME/.ssh/ssh-agent") > /dev/null 2>&1
  fi
fi
ssh-add -l &>/dev/null || ssh-add "$HOME/.ssh/id_ed25519" 2>/dev/null

# Docker Aliases
alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}"'
alias dlog='docker logs -f'
alias dstop='docker stop $(docker ps -q)'

# ===========================================
# VPS (rdtect-vps / rick.rdtect.com)
# ===========================================
alias vps='ssh rdtect-vps'
alias vps-status='ssh rdtect-vps "docker ps --format \"table {{.Names}}\t{{.Status}}\" && echo --- && free -h | head -2 && echo --- && uptime"'
alias vps-logs='ssh rdtect-vps "docker logs -f"'

# (bun completions loaded above)

# ===========================================
# WSL2 → Windows Bridge (socat)
# ===========================================
WIN_IP=$(ip route show | grep -i default | awk '{ print $3}')

# Chrome DevTools bridge (port 9222)
if ! pgrep -f "socat TCP-LISTEN:9222" > /dev/null; then
    socat TCP-LISTEN:9222,fork,reuseaddr TCP:$WIN_IP:9222 &> /dev/null &
fi

# Obsidian MCP bridge (port 22360) — for iansinnott/obsidian-claude-code-mcp
if ! pgrep -f "socat TCP-LISTEN:22360" > /dev/null; then
    socat TCP-LISTEN:22360,fork,reuseaddr TCP:$WIN_IP:22360 &> /dev/null &
fi

# ===========================================
# MCP Server Tokens (for Claude Code)
# ===========================================
# GitHub MCP — get from github.com → Settings → Developer settings → Personal access tokens
export GITHUB_TOKEN="${GITHUB_TOKEN:-}"

# Obsidian MCP — NOT needed (using iansinnott/obsidian-claude-code-mcp plugin via port 22360)
# If switching to cyanheads approach: Obsidian → Settings → Community Plugins → Local REST API
# export OBSIDIAN_REST_API_KEY="your-key-here"

# ===========================================
# Welcome Message (must be last — after all sourcing/plugins)
# ===========================================
fastfetch

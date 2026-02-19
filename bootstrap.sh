#!/usr/bin/env bash
# rdtect dotfiles bootstrap
# Usage: ./bootstrap.sh [--dry-run]
# Requires: git, stow
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=false

[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

log() { echo "  → $*"; }
run() { $DRY_RUN && echo "  [dry] $*" || eval "$@"; }

echo "rdtect dotfiles bootstrap"
echo "========================="
echo "Dir: $DOTFILES_DIR"
echo ""

# --- 1. Dependencies ---
echo "[1/4] Checking dependencies..."
if ! command -v stow &>/dev/null; then
    if command -v pacman &>/dev/null; then
        run "sudo pacman -S stow --noconfirm"
    elif command -v apt &>/dev/null; then
        run "sudo apt install stow -y"
    elif command -v brew &>/dev/null; then
        run "brew install stow"
    else
        echo "ERROR: Install stow manually then re-run." && exit 1
    fi
fi
log "stow: $(stow --version | head -1)"

# --- 2. Oh My Zsh ---
echo ""
echo "[2/4] Checking Oh My Zsh..."
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log "Installing Oh My Zsh..."
    run 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'
    # plugins
    run "git clone https://github.com/zsh-users/zsh-autosuggestions \${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    run "git clone https://github.com/zsh-users/zsh-syntax-highlighting \${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    run "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
else
    log "Oh My Zsh already installed"
fi

# --- 3. Claude Code ---
echo ""
echo "[3/4] Checking Claude Code..."
if ! command -v claude &>/dev/null; then
    log "Installing Claude Code..."
    run "npm install -g @anthropic-ai/claude-code"
else
    log "Claude Code: $(claude --version 2>/dev/null || echo 'installed')"
fi

# --- 4. Stow packages ---
echo ""
echo "[4/4] Stowing packages..."

PACKAGES=(claude zsh git)

for pkg in "${PACKAGES[@]}"; do
    if [[ -d "$DOTFILES_DIR/$pkg" ]]; then
        log "Stowing $pkg..."
        # --no-folding keeps ~/.claude/ as a real dir, symlinks children
        run "stow --no-folding -d '$DOTFILES_DIR' -t '$HOME' '$pkg' 2>&1 || stow --no-folding --restow -d '$DOTFILES_DIR' -t '$HOME' '$pkg'"
    fi
done

echo ""
echo "Done! Next steps:"
echo "  • Set ANTHROPIC_API_KEY in ~/.zshrc.local (not tracked)"
echo "  • Run: source ~/.zshrc"
echo "  • Run: claude  (then authenticate)"
echo "  • Install SSH keys separately (not tracked)"

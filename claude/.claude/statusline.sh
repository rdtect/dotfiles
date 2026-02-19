#!/bin/bash
# Claude Code Status Line - Shell-style prompt
# Inspired by Powerlevel10k configuration
# Format: user@host dir (git) [context%] [time] model

input=$(cat)

# Parse JSON input
MODEL=$(echo "$input" | jq -r '.model.display_name // "Claude"')
DIR=$(echo "$input" | jq -r '.workspace.current_dir // "~"')
PERCENT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d'.' -f1)

# Get user and hostname
USER=$(whoami)
HOST=$(hostname -s)

# Get current directory (show last 2 components or full if short)
if [ "$DIR" = "$HOME" ]; then
    DIR_DISPLAY="~"
else
    DIR_RELATIVE="${DIR/#$HOME/~}"
    # Count slashes to determine depth
    SLASH_COUNT=$(echo "$DIR_RELATIVE" | tr -cd '/' | wc -c)
    if [ "$SLASH_COUNT" -gt 2 ]; then
        # Show only last 2 components
        DIR_DISPLAY="...$(echo "$DIR_RELATIVE" | rev | cut -d'/' -f1,2 | rev)"
    else
        DIR_DISPLAY="$DIR_RELATIVE"
    fi
fi

# Git branch with status (skip optional locks)
GIT_BRANCH=""
if git rev-parse --git-dir > /dev/null 2>&1; then
    cd "$DIR" 2>/dev/null || true
    BRANCH=$(git --no-optional-locks branch --show-current 2>/dev/null)
    if [ -n "$BRANCH" ]; then
        # Check for changes (no locks)
        if ! git --no-optional-locks diff-index --quiet HEAD -- 2>/dev/null; then
            GIT_STATUS="*"  # Modified
        else
            GIT_STATUS=""
        fi
        GIT_BRANCH=" $(printf '\033[33m')($BRANCH$GIT_STATUS)$(printf '\033[0m')"
    fi
fi

# Context percentage with color
if [ "$PERCENT" -lt 30 ]; then
    CTX="$(printf '\033[32m')${PERCENT}%$(printf '\033[0m')"  # Green
elif [ "$PERCENT" -lt 60 ]; then
    CTX="$(printf '\033[33m')${PERCENT}%$(printf '\033[0m')"  # Yellow
else
    CTX="$(printf '\033[31m')${PERCENT}%$(printf '\033[0m')"  # Red
fi

# Time (12-hour format like p10k config)
TIME=$(date +"%I:%M%p" | sed 's/^0//')

# Build status line
# Format: user@host dir (git) [context] [time] model
printf "%s@%s %s%s [%s] [%s] %s" "$USER" "$HOST" "$DIR_DISPLAY" "$GIT_BRANCH" "$CTX" "$TIME" "$MODEL"

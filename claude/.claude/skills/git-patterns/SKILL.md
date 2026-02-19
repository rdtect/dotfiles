---
name: git-patterns
description: Git workflow patterns for commits, branches, PRs, and collaboration. Conventional commits, branch naming, worktrees. Quick reference.
---

# Git Patterns

## Commit Format

```
<type>: <description>

<optional body>

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
```

### Types

| Type | When |
|------|------|
| `feat` | New feature |
| `fix` | Bug fix |
| `refactor` | Code restructure (no behavior change) |
| `docs` | Documentation only |
| `test` | Adding/fixing tests |
| `chore` | Tooling, deps, config |
| `perf` | Performance improvement |
| `ci` | CI/CD changes |

### Good Commit Messages

```
feat: add user authentication with JWT tokens
fix: prevent race condition in order processing
refactor: extract validation logic into UserRules
test: add coverage for payment edge cases
chore: upgrade typescript to 5.7
```

### Bad Commit Messages

```
update code          → What changed? Why?
fix bug              → Which bug?
WIP                  → Not ready to commit
misc changes         → Be specific
```

## Branch Naming

```
feature/user-authentication
fix/order-race-condition
refactor/extract-validation-rules
chore/upgrade-typescript
```

**Format:** `<type>/<kebab-case-description>`

## PR Template

```markdown
## Summary
- [1-3 bullet points describing the change]

## Test Plan
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing: [steps]
- [ ] Edge cases verified: [list]
```

## Git Worktrees (Parallel Work)

```bash
# Create worktree for feature work
git worktree add ../project-feature feature/my-feature

# List worktrees
git worktree list

# Remove when done
git worktree remove ../project-feature
```

**When to use:** Parallel features, reviewing PRs while coding, long-running experiments.

## Rebase vs Merge

| Strategy | When | Command |
|----------|------|---------|
| Rebase | Feature branch → clean history | `git rebase main` |
| Merge | Main → feature (keep history) | `git merge main` |
| Squash | Many WIP commits → one clean | `git rebase -i` then squash |

**Rule:** Never rebase shared/public branches (main, develop).

## Common Workflows

### Start Feature

```bash
git checkout main && git pull
git checkout -b feature/my-feature
```

### Update Feature Branch

```bash
git fetch origin
git rebase origin/main
```

### Create PR

```bash
git push -u origin feature/my-feature
gh pr create --title "feat: description" --body "## Summary\n..."
```

### Stash Work

```bash
git stash push -m "WIP: description"
git stash list
git stash pop
```

## Safety Rules

- Never force-push to main/master
- Never commit secrets (.env, API keys, tokens)
- Never use `--no-verify` to skip hooks
- Always review `git diff` before committing
- Prefer specific `git add <file>` over `git add .`

---

*For workflow integration, see `~/.claude/rules/workflow.md`.*

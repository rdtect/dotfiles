---
description: Multi-agent documentation update with parallel content extraction.
---

# Update Docs Command (Multi-Agent)

Orchestrates **parallel extraction** → **unified documentation**.

## Agent Orchestration

```
┌─────────────────────────────────────────────────────┐
│                  /update-docs                       │
├─────────────────────────────────────────────────────┤
│  PHASE 1: PARALLEL CONTENT EXTRACTION               │
│  ┌─────────────┐ ┌─────────────┐ ┌───────────────┐ │
│  │    doc      │ │  tdd-guide  │ │   architect   │ │
│  │  updater    │ │  (examples) │ │   (setup)     │ │
│  └─────────────┘ └─────────────┘ └───────────────┘ │
├─────────────────────────────────────────────────────┤
│  PHASE 2: SYNTHESIS                                 │
│  Merge: JSDoc + Examples + Setup → Documentation    │
├─────────────────────────────────────────────────────┤
│  PHASE 3: UPDATE (doc-updater)                      │
│  Update README.md, guides, API docs                 │
├─────────────────────────────────────────────────────┤
│  PHASE 4: VERIFICATION                              │
│  Links work? Examples run? Commands valid?          │
└─────────────────────────────────────────────────────┘
```

## Execution Steps

1. **Parallel extraction:**
   - `doc-updater` → Extract JSDoc, type definitions
   - `tdd-guide` → Extract working code examples from tests
   - `architect` → Extract setup commands, dependencies

2. **Synthesize content:**
   - Merge API docs with working examples
   - Update setup instructions from actual commands

3. **Update documentation** (doc-updater)

4. **Verify documentation:**
   - All internal links work
   - Code examples compile

## Output Format

```markdown
# Documentation Update Report

## Content Extracted
| Source | Items | Updated |
|--------|-------|---------|
| JSDoc comments | 45 | 38 |
| Test examples | 22 | 18 |
| Setup commands | 8 | 8 |

## Files Updated
| File | Changes | Status |
|------|---------|--------|
| README.md | Setup section | ✅ |
| docs/GUIDES/api.md | 5 endpoints | ✅ |

## Verification
- Internal links: ✅
- Code examples: ✅
- Commands: ✅
```

## When to Use

- After API changes
- After adding features
- Before releases

---
description: Multi-agent codemap generation with parallel structure analysis.
---

# Update Codemaps Command (Multi-Agent)

Orchestrates **parallel analysis** → **unified documentation**.

## Agent Orchestration

```
┌─────────────────────────────────────────────────────┐
│                /update-codemaps                     │
├─────────────────────────────────────────────────────┤
│  PHASE 1: PARALLEL STRUCTURE ANALYSIS               │
│  ┌─────────────┐ ┌─────────────┐ ┌───────────────┐ │
│  │    doc      │ │  architect  │ │   security    │ │
│  │  updater    │ │ (structure) │ │ (boundaries)  │ │
│  └─────────────┘ └─────────────┘ └───────────────┘ │
├─────────────────────────────────────────────────────┤
│  PHASE 2: SYNTHESIS                                 │
│  Merge: Files + Architecture + Security → Codemaps  │
├─────────────────────────────────────────────────────┤
│  PHASE 3: GENERATION (doc-updater)                  │
│  Generate docs/CODEMAPS/*.md                        │
└─────────────────────────────────────────────────────┘
```

## Execution Steps

1. **Parallel analysis:**
   - `doc-updater` → Scan files, exports, imports
   - `architect` → Identify components, data flow, layers
   - `security-reviewer` → Map security boundaries, auth points

2. **Synthesize findings:**
   - Merge file structure with architectural insights
   - Add security annotations to sensitive areas

3. **Generate codemaps** (doc-updater)

## Output Structure

```
docs/CODEMAPS/
├── INDEX.md          # Overview + navigation
├── frontend.md       # UI components, pages
├── backend.md        # API routes, services
├── database.md       # Schema, migrations
└── integrations.md   # External APIs
```

## Codemap Format

```markdown
# [Area] Codemap

**Last Updated:** YYYY-MM-DD

## Architecture (from architect)
[ASCII diagram]

## Security Boundaries (from security-reviewer)
- Auth required: [endpoints]
- Public: [endpoints]

## Key Modules
| Module | Purpose | Dependencies |
|--------|---------|--------------|
```

## When to Use

- After major features
- Before releases
- Onboarding new developers

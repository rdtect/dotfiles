---
description: Generate and run end-to-end tests with Playwright. Creates test journeys, runs tests, captures screenshots/videos/traces, and uploads artifacts.
---

# E2E Command (Multi-Agent)

Orchestrates **parallel test generation + execution + analysis**.

## Agent Orchestration

```
┌─────────────────────────────────────────────────────┐
│                      /e2e                           │
├─────────────────────────────────────────────────────┤
│  PHASE 1: JOURNEY IDENTIFICATION                    │
│  ┌─────────────────┐ ┌─────────────────┐           │
│  │   e2e-runner    │ │    architect    │           │
│  │  (user flows)   │ │  (critical paths)│           │
│  └─────────────────┘ └─────────────────┘           │
├─────────────────────────────────────────────────────┤
│  PHASE 2: TEST GENERATION (e2e-runner)              │
│  Page Objects + Test Cases + Assertions             │
├─────────────────────────────────────────────────────┤
│  PHASE 3: EXECUTION                                 │
│  Run tests → Capture artifacts → Report             │
├─────────────────────────────────────────────────────┤
│  PHASE 4: FAILURE ANALYSIS (if needed)              │
│  ┌─────────────────┐ ┌─────────────────┐           │
│  │   e2e-runner    │ │  code-reviewer  │           │
│  │  (fix flaky)    │ │ (code issues)   │           │
│  └─────────────────┘ └─────────────────┘           │
└─────────────────────────────────────────────────────┘
```

## Execution Steps

1. **Identify critical journeys** (parallel)
   - `e2e-runner` → User flow analysis
   - `architect` → Critical business paths

2. **Generate tests** (e2e-runner)
   - Create Page Objects for each page
   - Write test cases with explicit waits
   - Add assertions for success criteria

3. **Execute tests**
   ```bash
   npx playwright test --reporter=html
   ```

4. **Analyze failures** (if any, parallel)
   - `e2e-runner` → Fix flaky tests, improve selectors
   - `code-reviewer` → Identify code issues causing failures

## Test Structure

```typescript
// Page Object Pattern
class LoginPage {
  constructor(private page: Page) {}

  async login(email: string, password: string) {
    await this.page.fill('[data-testid="email"]', email)
    await this.page.fill('[data-testid="password"]', password)
    await this.page.click('[data-testid="submit"]')
  }
}

// Test Case
test('user can login and view dashboard', async ({ page }) => {
  const loginPage = new LoginPage(page)
  await loginPage.login('user@example.com', 'password')
  await expect(page.locator('.dashboard')).toBeVisible()
})
```

## Artifact Capture

| Artifact | When | Location |
|----------|------|----------|
| Screenshot | On failure | `test-results/` |
| Video | Always | `test-results/` |
| Trace | On failure | `test-results/` |
| HTML Report | Always | `playwright-report/` |

## Output Format

```markdown
# E2E Test Session

## Critical Journeys Identified
1. User registration → Dashboard
2. Product search → Add to cart → Checkout
3. Login → Profile update → Logout

## Tests Generated
| Journey | Tests | Page Objects |
|---------|-------|--------------|
| Auth flow | 5 | LoginPage, RegisterPage |
| Checkout | 8 | CartPage, CheckoutPage |

## Execution Results
- Total: 13
- Passed: 11
- Failed: 2
- Flaky: 0

## Failures
### [test-name]
- **Screenshot:** [link]
- **Trace:** [link]
- **Root cause:** [analysis]
- **Fix:** [recommendation]

## Artifacts
- Report: playwright-report/index.html
- Videos: test-results/*.webm
```

## Quick Commands

```bash
npx playwright test                    # Run all
npx playwright test --headed           # See browser
npx playwright test --debug            # Debug mode
npx playwright show-report             # View report
```

## When to Use

- Before major releases
- After UI changes
- Critical user flow validation
- Regression testing

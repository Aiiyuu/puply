# Git Workflow and PR Standards: Puply.dog

## 1. Local Git Hooks (Husky)

We use **Husky** and **lint-staged** to ensure code quality before it ever leaves the local machine.

* **Pre-commit Hook**: 
    * **Formatting**: Automatically run code formatters (Prettier for TS/CSS, `gofmt` for Go) on all staged files.
    * **Linting**: Run `eslint` for Web/Mobile and `golangci-lint` for API. 
    * **Blocker**: If ESLint or the Go Linter finds **errors**, the commit will fail. Warnings will be allowed but should be addressed.
* **Manual Checks**: Before pushing, developers are encouraged (but not forced) to run `pnpm build` and `pnpm test` locally to save time on CI/CD cycles.

---

## 2. Branching Strategy

### 2.1 Branch Architecture
* **main**: Production-ready code only. Deployment is triggered from this branch.
* **dev**: Integration branch for active development. All features are merged here first.

### 2.2 Naming Conventions
Always use shorthand prefixes for branch names:
* `feat/` (instead of feature)
* `fix/` (instead of bugfix)
* `ref/` (instead of refactor)
* `dev/` (instead of developer)
* `docs/` (documentation changes)
* `infra/` (infrastructure/devops)

*Example: `feat/dog-swipe-logic` or `fix/auth-jwt-refresh`*

---

## 3. Commit Message Standards

Commit messages must be scoped to the package or application being modified. The first letter of the message must be **Uppercase**.

**Format:** `[scope] Your message`

* **Web**: `[@app/web] Fix gallery grid alignment`
* **API**: `[@app/api] Implement PostGIS proximity query`
* **Mobile**: `[@app/mobile] Add push notification handler`
* **Library**: `[@lib/generated] Update hooks after swagger change`
* **Docs**: `[docs] Update swipe flow documentation`
* **Infra**: `[infra] Add Redis to docker-compose`

---

## 4. Pull Request (PR) Requirements

### 4.1 Description & Visualization
* **Content**: Use descriptive headers and lists to explain *what* changed and *why*.
* **Visuals**: Attach screenshots or screen recordings for UI/UX changes in Web or Mobile.
* **Documentation**: If a new API endpoint is added, the PR must include the updated `docs/api` file.
* **Formatting**: Use Markdown callouts to highlight risks or notes.

> [!NOTE]
> Mention if this PR requires new Environment Variables in `.env.example`.

### 4.2 Review Process
* **Human Review**: At least **one manual approval** is required before merging into `dev`.
* **AI Review (CodeRabbit)**: Diligently review all CodeRabbit suggestions. 
    > [!WARNING]
    > CodeRabbit can occasionally provide incorrect or "hallucinated" advice. Do not blindly accept; verify every suggestion against the project standards.

---

## 5. CI/CD (GitHub Actions)

For every PR opened against `dev` or `main`, the following automated pipeline will trigger:

1.  **Linters**: Full project linting (ESLint + Golangci-lint).
2.  **Build**: `pnpm build` for all modified apps to ensure no build-time regressions.
3.  **Tests**: Execution of `Jest`, `Testify`, and `Playwright` suites.

**The PR cannot be merged if any of the CI steps fail.**
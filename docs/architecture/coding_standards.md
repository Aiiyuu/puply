# Coding Standards and Architecture Rules: Puply.dog

## 1. General Rules (Global)

* **Quotes**: Use double quotes ("") exclusively for strings in TypeScript, JavaScript, and Go.
* **Import Grouping**: Follow standard linter grouping:
    1. Built-in modules (e.g., path, fs).
    2. External libraries (e.g., react, gin, axios).
    3. Internal workspace packages/libraries (e.g., @lib/generated).
    4. Relative local imports (e.g., ./ComponentName).
* **Documentation**: Every public function, interface, or Go struct must have a descriptive comment for IDE intellisense.

---

## 2. TypeScript Standards (Web & Mobile)

### 2.1 Core Logic
* **Strict Typing**: The "any" keyword is strictly prohibited. Use "unknown" if the type is truly unknown, or define a proper interface/type.
* **Data Fetching**: Use only generated hooks from "lib/generated" (Orval). Manual Axios calls or fetch calls inside components are forbidden.
* **Barrel Exports**: Use "index.ts" files (barrel imports) for every feature and shared component folder to maintain a clean public API.

### 2.2 File Naming Conventions
Follow the explicit naming pattern for components to ensure modularity:
* ComponentName.tsx (Main component)
* ComponentName.styles.ts or ComponentName.styles.css (Styles)
* ComponentName.types.ts (Local interfaces/types)
* ComponentName.utils.ts (Logic specific to the component)
* ComponentName.test.tsx (Unit tests)

### 2.3 Feature-Based Design
* Place logic inside "features/{feature-name}/".
* Cross-feature UI must live in "shared/components/".
* Cross-feature logic must live in "lib/shared-logic/".

---

## 3. Golang Standards (API)

### 3.1 Domain-Driven Design (DDD)
* **Package Isolation**: Code in "domain/" must not import from "repository/" or "transport/".
* **Dependency Injection**: Use constructors (e.g., "NewService", "NewRepository") to inject dependencies. Avoid global states or "init()" functions for database connections.
* **Context**: Always pass "context.Context" as the first argument to functions involving database or network I/O.

### 3.2 Naming & Structure
* **Struct Tags**: Every shared model must include "json" tags (camelCase) and "example" tags for Swagger generation.
* **Interface Placement**: Define interfaces where they are consumed (consumer-side) to keep the domain layer decoupled from infrastructure.
* **Error Handling**: Do not ignore errors. Use "fmt.Errorf("context: %w", err)" to wrap errors for better stack tracing.

### 3.3 Database & Repository
* **Prisma Client**: Use the generated Prisma client for all database operations.
* **Transactions**: Logic requiring multiple database writes must be handled within a transaction at the service layer.

---

## 4. Infrastructure & Monorepo

* **Environment Variables**: Use ".env.example" files in every app. Never commit actual ".env" files.
* **Task Automation**: Use the root "Makefile" for any multi-step process (e.g., generating Swagger and then running Orval).
* **Git Commits**: Use conventional commits (feat:, fix:, chore:, docs:, refactor:).

---

## 5. Security & Validation

* **Validation**: 
    * Frontend: Use Zod schemas from "lib/shared-schemas" with React Hook Form.
    * Backend: Use "go-playground/validator" mirroring the Zod logic.
* **NSFW Filtering**: All dog avatars and gallery uploads must pass through the "internal/profile/service" to be validated by Amazon Rekognition before being made public.
* **Global Versioning & Formats**: Use the constants from "lib/constants/id-version.ts" (or relevant constants file) for all data versions. This applies to:
    * **ID Versions**: Toggling between UUID v4/v6.
    * **Text Data**: Content versions or string constants.
    * **Data/Date Formats**: ISO string versions or global formatting rules.
    * **Other Fields**: Any fields requiring global version-switching or unified formatting logic.
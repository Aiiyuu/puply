import js from "@eslint/js"
import prettier from "eslint-config-prettier"
import importPlugin from "eslint-plugin-import"
import unusedImports from "eslint-plugin-unused-imports"
import tseslint from "typescript-eslint"

export default tseslint.config(
  // Base JS & TS Recommended rules
  js.configs.recommended,
  ...tseslint.configs.recommended,

  // Plugins configuration
  {
    plugins: {
      import: importPlugin,
      "unused-imports": unusedImports,
    },
    rules: {
      // --- Puply Coding Standards ---
      quotes: ["error", "double"],
      "no-trailing-spaces": "error",
      "@typescript-eslint/no-explicit-any": "error",

      // Import Grouping Logic
      "import/order": [
        "error",
        {
          groups: ["builtin", "external", "internal", ["parent", "sibling", "index"]],
          pathGroups: [
            {
              pattern: "@lib/**",
              group: "internal",
              position: "before",
            },
          ],
          pathGroupsExcludedImportTypes: ["builtin"],
          "newlines-between": "always",
          alphabetize: {
            order: "asc",
            caseInsensitive: true,
          },
        },
      ],

      // Require newline after variable declarations
      "padding-line-between-statements": [
        "error",
        { blankLine: "always", prev: ["const", "let", "var"], next: "*" },
        {
          blankLine: "any",
          prev: ["const", "let", "var"],
          next: ["const", "let", "var"],
        },
      ],

      // Forbid Manual Data Fetching
      "no-restricted-imports": [
        "error",
        {
          paths: [
            {
              name: "axios",
              message: "Manual Axios calls are forbidden. Use generated hooks from @lib/generated.",
            },
          ],
        },
      ],

      // Forbid and automatically remove semicolons
      semi: ["error", "never"],
      "@typescript-eslint/semi": ["error", "never"],

      // Clean up unused imports automatically
      "unused-imports/no-unused-imports": "error",

      // Forbid single-letter variables (except for standard loops like i, j)
      "id-length": ["error", { min: 2, exceptions: ["i", "j", "x", "y"] }],
    },
  },

  // 3. Prettier (Must be last to override conflicting rules)
  prettier,

  // 4. Global Ignores (Replaces .eslintignore)
  {
    ignores: [
      "**/node_modules/**",
      "**/dist/**",
      "**/build/**",
      "apps/api/**",
      "apps/web/.next/**",
      "apps/web/out/**",
      "**/next-env.d.ts",
      "**/.turbo/**",
    ],
  },
)

### 1. Infrastructure & Root
This section covers the global orchestration and environment setup.

```text
root/
├── Makefile                        # Shortcuts for: install, dev, docker-up, swag, gen-orval
├── pnpm-workspace.yaml             # Monorepo workspace definition
├── pnpm-lock.yaml                  # Unified dependency lock
├── package.json                    # Root scripts for the entire workspace
├── .cursor/                        # AI Rules and Project Context
│   ├── rules/
│   │   ├── golang-ddd.md           # Instructions for DDD boundaries
│   │   ├── typescript-features.md  # Instructions for Feature-Based design
│   │   └── monorepo.md             # pnpm management rules
│   └── project-context.json
├── .github/                        # CI/CD Workflows
│   └── workflows/
│       ├── api.yml                 # Go lint/test
│       ├── web.yml                 # Next.js lint/test/build
│       └── deploy.yml              # AWS / Production trigger
├── infra/
│   ├── development/
│   │   ├── docker-compose.yml      # Postgres, Redis, Localstack
│   │   ├── Dockerfile.api.dev      # Air (hot reload) Go environment
│   │   ├── Dockerfile.web.dev      # Next.js dev container
│   │   └── localstack-init.sh      # Mock S3/Rekognition setup
│   └── deployment/
│       ├── docker-compose.prod.yml # Production orchestration
│       ├── Dockerfile.api.prod     # Multi-stage Alpine build
│       ├── Dockerfile.web.prod     # Standalone output build
│       ├── nginx.conf              # Reverse proxy / SSL
│       └── ssh-setup.sh            # Production access scripts
├── docs/                           # Global Documentation
│   ├── api/                        # Endpoint specs
│   └── architecture/               # DDD ADRs (Architectural Decision Records)
```

### 2. Backend: API (Modular DDD)
Detailed folder structure showing how Domain-Driven Design is applied to your specific features.

```text
apps/api/
├── cmd/
│   └── server/
│       └── main.go                 # Dependency Injection & Server Entry
├── internal/
│   ├── auth/                       # AUTH BOUNDED CONTEXT
│   │   ├── domain/                 # User Entity, JWT logic, Auth errors
│   │   ├── repository/             # Prisma/Postgres implementation
│   │   ├── service/                # Login/Register flow logic
│   │   └── transport/              # Gin Handlers (HTTP)
│   ├── discovery/                  # DISCOVERY/SWIPE CONTEXT
│   │   ├── domain/                 # Swipe entity, Matching rules
│   │   ├── repository/             # PostGIS geolocation queries
│   │   ├── service/                # Swipe processing, Match creation
│   │   └── transport/              # Swipe handlers & filters
│   ├── chat/                       # MESSAGING CONTEXT
│   │   ├── domain/                 # Message, Conversation, Status entities
│   │   ├── repository/             # Message persistence & Redis heartbeats
│   │   ├── service/                # WebSocket Hub logic, Redis Pub/Sub
│   │   └── transport/              # WS Upgraders & Message routing
│   ├── profile/                    # PROFILE CONTEXT
│   │   ├── domain/                 # Dog entity, Gallery sorting rules
│   │   ├── repository/             # Gallery storage & Rekognition data
│   │   ├── service/                # NSFW detection & Image processing
│   │   └── transport/              # Profile/Gallery handlers
│   └── shared/                     # THE SHARED KERNEL
│       ├── models/                 # Shared structs (Dog, User, Interest)
│       ├── middleware/             # Auth, Logger, Recovery
│       └── response/               # Standard API response wrappers
├── pkg/                            # CROSS-CUTTING UTILS
│   ├── s3/                         # AWS S3 custom wrapper
│   ├── rekognition/                # AWS Rekognition interface
│   └── logger/                     # Structured Zap logger setup
├── docs/                           # Swagger generation target
│   └── swagger.yaml
├── go.mod
└── go.sum
```

### 3. Frontend & Mobile (Feature-Based Design)
Separation of logic by feature, ensuring high reusability of the mental model.

```text
apps/[web-or-mobile]/               # Mirrored structure for Web/Mobile
├── src/
│   ├── app/                        # Next.js App Router / Expo Router
│   │   ├── (auth)/                 # Grouped login/signup routes
│   │   ├── discovery/              # Discovery dashboard
│   │   └── profile/                # User's own dog profile
│   ├── features/                   # ENCAPSULATED DOMAIN LOGIC
│   │   ├── auth/                   # Login forms, auth hooks
│   │   ├── discovery/              # Swipe deck, Card UI, Discovery Filter
│   │   │   ├── components/         # SwipeCard.tsx, CardStack.tsx
│   │   │   ├── hooks/              # useSwipe.ts, useGeolocation.ts
│   │   │   ├── store/              # DiscoveryZustandStore.ts
│   │   │   └── index.ts            # Public feature API
│   │   ├── chat/                   # Messaging UI & WS logic
│   │   └── profile-management/     # Gallery DND, Chart.js stats
│   ├── shared/                     # CROSS-FEATURE SHARED CODE
│   │   ├── components/             # Layouts, Modals, Feedbacks
│   │   ├── hooks/                  # useDebounce, useMediaQuery
│   │   └── types/                  # Internal UI specific types
│   └── lib/                        # CONFIGURATIONS
│       └── query-client.ts         # TanStack Query setup
├── package.json
└── tsconfig.json
```

### 4. Shared Libraries (The "Lib" Folder)
The core shared logic and the bridge between your Go API and TS Frontends.

```text
lib/
├── generated/                      # ORVAL OUTPUT (Do not edit)
│   ├── api.ts                      # Axios service calls
│   └── hooks.ts                    # TanStack Query generated hooks
├── shared-schemas/                 # VALIDATION SOURCE
│   ├── auth.schema.ts              # Zod schemas for login/signup
│   ├── profile.schema.ts           # Zod schemas for dog profile
│   └── index.ts
├── ui-theme/                       # DESIGN TOKENS
│   ├── tailwind.config.js          # Shared Tailwind settings
│   ├── colors.ts                   # Puply color palette
│   └── tokens.ts                   # Border radius, Spacing scales
├── shared-logic/                   # HEADLESS UI LOGIC
│   ├── useMatchLogic.ts            # Shared matching algorithms
│   └── useDistanceCalc.ts          # Haversine distance math
├── constants/                      # HARDCODED DATA
│   ├── breeds.ts                   # Searchable breed list
│   ├── interests.ts                # Global tag list
│   ├── date-formats.ts             # ISO string & local format constants
│   └── id-version.ts               # UUID v4/v6 toggle logic
├── utils/                          # HELPER FUNCTIONS
│   ├── geo.ts                      # Geolocation formatters
│   └── date.ts                     # Time-ago and Date formatters
└── orval/                          # CODE GEN CONFIG
    └── orval.config.js             # Configuration for Orval runner
```

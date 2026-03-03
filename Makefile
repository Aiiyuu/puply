# --- Variables ---
LINTER = $(shell go env GOPATH)/bin/golangci-lint
DEV_COMPOSE = docker-compose -f infra/development/docker-compose.yml

.PHONY: setup lint format up down restart status logs logs-api logs-web api-up web-up api-exec web-exec db-shell

# --- Initialization & Tooling ---
setup:
	@echo "📦 Installing Frontend dependencies..."
	pnpm install
	@echo "📦 Installing Go tools (Compiling from source)..."
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.64.5
	@echo "✅ Setup complete!"

lint:
	@echo "🔍 Linting Web & API..."
	pnpm eslint . --fix
	pnpm stylelint "**/*.css" --fix --allow-empty-input
	cd apps/api && $(LINTER) run --fix

format:
	@echo "✨ Formatting project..."
	pnpm prettier --write .
	cd apps/api && go mod tidy


# --- Docker Infrastructure ---
build:
	@echo "🛠️ Building all images..."
	$(DEV_COMPOSE) build

build-api:
	@echo "🛠️ Building API image..."
	$(DEV_COMPOSE) build api

build-web:
	@echo "🛠️ Building Web image..."
	$(DEV_COMPOSE) build web

up:
	@echo "🚀 Starting all services..."
	$(DEV_COMPOSE) up -d

down:
	@echo "🛑 Stopping all services..."
	$(DEV_COMPOSE) down

restart:
	$(DEV_COMPOSE) restart

api-up:
	$(DEV_COMPOSE) up -d api

web-up:
	$(DEV_COMPOSE) up -d web

status:
	$(DEV_COMPOSE) ps

# --- Logs ---
logs:
	$(DEV_COMPOSE) logs -f

logs-api:
	$(DEV_COMPOSE) logs -f api

logs-web:
	$(DEV_COMPOSE) logs -f web

# --- Command Execution ---
# Usage: make api-exec go test ./...
api-exec:
	@$(DEV_COMPOSE) exec api $(filter-out $@,$(MAKECMDGOALS))

# Usage: make web-exec pnpm add lodash
web-exec:
	@$(DEV_COMPOSE) exec web $(filter-out $@,$(MAKECMDGOALS))


db-shell:
	$(DEV_COMPOSE) exec postgres psql -U postgres -d puply
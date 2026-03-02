# Dynamically find the Go binary path
LINTER = $(shell go env GOPATH)/bin/golangci-lint

.PHONY: setup lint format

# Install all dependencies for the entire project
setup:
	@echo "📦 Installing Frontend dependencies..."
	pnpm install
	@echo "📦 Installing Go tools (Compiling from source)..."
	# Installing v1.64.5 from source ensures compatibility with Go 1.25
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.64.5
	@echo "✅ Setup complete!"

# Run all linters (Fixed for monorepos)
lint:
	pnpm eslint . --fix
	pnpm stylelint "**/*.css" --fix --allow-empty-input
	cd apps/api && $(LINTER) run --fix

# Format (Prettier & Go Tidy)
format:
	pnpm prettier --write .
	cd apps/api && go mod tidy
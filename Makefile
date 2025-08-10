.PHONY: all clean build tree-sitter extension deps test format

# Build everything
all: deps build

# Full build pipeline
build: tree-sitter extension
	@echo "✅ Build complete"

# --- Tree-sitter Grammar ---
TREE_SITTER_DIR := tree-sitter-solidity
GRAMMAR_WASM := languages/solidity/solidity.wasm

tree-sitter:
	@echo "🔨 Building tree-sitter grammar..."
	@cd $(TREE_SITTER_DIR) && \
		npm ci --omit=dev && \
		npm run build && \
		npm run build-wasm
	@mkdir -p $(dir $(GRAMMAR_WASM))
	@cp $(TREE_SITTER_DIR)/tree-sitter-solidity.wasm $(GRAMMAR_WASM)
	@echo "🌲 Tree-sitter grammar ready"

# --- Extension Build ---
WASM_TARGET := target/wasm32-unknown-unknown/release/web3_dev.wasm
OUT_WASM := wasm/web3_dev.wasm

extension:
	@echo "🦀 Building Rust extension..."
	@cargo build --target wasm32-unknown-unknown --release
	@mkdir -p wasm
	@cp $(WASM_TARGET) $(OUT_WASM)
	@echo "📦 WASM artifact ready at $(OUT_WASM)"

# --- Quality Control ---
test:
	@echo "🧪 Running tests..."
	@cargo test
	@cd $(TREE_SITTER_DIR) && npm test

format:
	@echo "🎨 Formatting code..."
	@cargo fmt --all
	@cd $(TREE_SITTER_DIR) && npx prettier --write .

# --- Cleanup ---
clean:
	@echo "🧹 Cleaning build artifacts..."
	@rm -rf target
	@rm -rf $(TREE_SITTER_DIR)/node_modules
	@rm -f $(TREE_SITTER_DIR)/tree-sitter-solidity.wasm
	@rm -f $(GRAMMAR_WASM)
	@rm -rf wasm
	@echo "✨ Clean complete"

# --- Dependencies ---
deps:
	@echo "📦 Checking dependencies..."

	# Rust toolchain
	@command -v rustup >/dev/null 2>&1 || { echo "❌ Please install Rust via rustup: https://rustup.rs"; exit 1; }
	@rustup target add wasm32-unknown-unknown

	# Node.js
	@command -v npm >/dev/null 2>&1 || { echo "❌ Please install Node.js: https://nodejs.org"; exit 1; }
	@npm install -g tree-sitter-cli

	# Tree-sitter project deps
	@cd $(TREE_SITTER_DIR) && npm ci --omit=dev

	@echo "✔️  All dependencies ready"

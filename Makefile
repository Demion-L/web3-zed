.PHONY: all clean build tree-sitter extension

all: build

build: tree-sitter extension

# Build the tree-sitter grammar
tree-sitter:
	@echo "Building tree-sitter grammar for Solidity..."
	cd tree-sitter-solidity && npm install
	cd tree-sitter-solidity && npm run build
	cd tree-sitter-solidity && npm run build-wasm
	@mkdir -p languages/solidity
	@cp tree-sitter-solidity/tree-sitter-solidity.wasm languages/solidity/solidity.wasm
	@echo "Tree-sitter grammar built successfully"

# Build the WebAssembly portion of the extension
extension:
	@echo "Building WebAssembly for extension..."
	cargo build --target wasm32-unknown-unknown --release
	@mkdir -p wasm
	@cp target/wasm32-unknown-unknown/release/web3_dev.wasm wasm/
	@echo "Extension WebAssembly built successfully"

# Clean build artifacts
clean:
	@rm -rf target
	@rm -rf tree-sitter-solidity/node_modules
	@rm -f tree-sitter-solidity/tree-sitter-solidity.wasm
	@rm -f languages/solidity/solidity.wasm
	@rm -rf wasm
	@echo "Cleaned build artifacts"

# Install dependencies
deps:
	@echo "Installing dependencies..."
	@command -v rustup >/dev/null 2>&1 || { echo "Please install Rust via rustup: https://rustup.rs"; exit 1; }
	@rustup target add wasm32-unknown-unknown
	@command -v npm >/dev/null 2>&1 || { echo "Please install Node.js and npm: https://nodejs.org"; exit 1; }
	@npm install -g tree-sitter-cli
	@echo "Dependencies installed successfully"

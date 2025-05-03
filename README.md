# Web3 Development Extension for Zed

This Zed extension provides support for Web3 development with Solidity, Foundry, and Hardhat.

## Features

### Language Support
- **Solidity**: Syntax highlighting and language server integration for `.sol` files
- **Hardhat**: Configuration file recognition for `hardhat.config.js` and `hardhat.config.ts`
- **Foundry**: TOML configuration support for `foundry.toml`

### Slash Commands
The extension provides several useful slash commands for Web3 development:

- `/new-contract`: Create a new Solidity contract template
- `/new-hardhat-config`: Create a new Hardhat configuration file
- `/new-foundry-config`: Create a new Foundry configuration file

## Installation

### Development Installation

1. Clone this repository:
   ```
   git clone https://github.com/your-username/web3-dev-zed.git
   cd web3-dev-zed
   ```

2. Install dependencies:
   ```
   make deps
   ```

3. Build the extension:
   ```
   make
   ```

4. Open Zed and navigate to the Extensions panel
5. Click "Install Dev Extension" and select the cloned directory

### Directory Structure

```
web3-dev/
  ├── extension.toml       # Extension configuration
  ├── Cargo.toml           # Rust dependencies for WebAssembly
  ├── Makefile             # Build automation
  ├── src/                 # Rust source code
  │   └── lib.rs           # WebAssembly implementation
  ├── languages/           # Language support
  │   ├── solidity/        # Solidity language support
  │   │   ├── config.toml  # Language configuration
  │   │   ├── highlights.scm  # Syntax highlighting rules
  │   │   └── solidity.wasm  # Generated parser (after build)
  │   ├── hardhat/         # Hardhat configuration support
  │   │   └── config.toml  # Language configuration
  │   └── foundry/         # Foundry configuration support
  │       ├── config.toml  # Language configuration
  │       └── highlights.scm  # Syntax highlighting rules
  ├── tree-sitter-solidity/ # Tree-sitter grammar for Solidity
  │   ├── grammar.js       # Grammar definition
  │   ├── package.json     # Node.js dependencies
  │   └── test/            # Grammar tests
  └── wasm/                # Generated WebAssembly files (after build)
      └── web3_dev.wasm    # Extension WebAssembly (after build)
```

### Requirements

- For development, you'll need:
  - [Rust](https://www.rust-lang.org/) installed via rustup
  - [Node.js](https://nodejs.org/) and npm
  - tree-sitter-cli: `npm install -g tree-sitter-cli`

- For full functionality in Zed, you'll need to install:
  - Solidity Language Server: `npm install -g solidity-language-server`
  - TypeScript Language Server: `npm install -g typescript typescript-language-server`

## Building Tree-Sitter Grammar

The extension uses a custom Tree-sitter grammar for Solidity. To build it manually:

1. Navigate to the tree-sitter-solidity directory:
   ```
   cd tree-sitter-solidity
   ```

2. Install dependencies:
   ```
   npm install
   ```

3. Generate the parser:
   ```
   npm run build
   ```

4. Build the WebAssembly file:
   ```
   npm run build-wasm
   ```

5. Copy the WebAssembly file to the languages directory:
   ```
   mkdir -p ../languages/solidity
   cp tree-sitter-solidity.wasm ../languages/solidity/solidity.wasm
   ```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT

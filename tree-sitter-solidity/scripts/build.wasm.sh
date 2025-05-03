#!/bin/bash
set -e

# Ensure tree-sitter CLI is installed
if ! command -v tree-sitter &> /dev/null
then
    echo "tree-sitter CLI not found, installing..."
    npm install -g tree-sitter-cli
fi

# Generate parser
echo "Generating parser..."
tree-sitter generate

# Build WebAssembly
echo "Building WebAssembly..."
tree-sitter build-wasm

# Create output directory for Zed extension
mkdir -p ../languages/solidity

# Copy WebAssembly to the Zed extension directory
echo "Copying WebAssembly to Zed extension directory..."
cp tree-sitter-solidity.wasm ../languages/solidity/solidity.wasm

echo "Build complete! WebAssembly file is available at:"
echo "  - tree-sitter-solidity.wasm (current directory)"
echo "  - ../languages/solidity/solidity.wasm (Zed extension directory)"

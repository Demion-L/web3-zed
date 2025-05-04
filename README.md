# Web3 Extension for Zed

This extension adds support for Web3 development in the Zed editor, with primary focus on:

- Solidity language support
- Hardhat framework integration
- Foundry framework integration

## Features

### Solidity Language Support

- Syntax highlighting for Solidity (.sol) files
- Code navigation
- Smart code completion
- Auto-indentation
- Bracket matching
- Code outline/structure view
- Vim textobjects support

### Hardhat Integration

- Automatic detection of Hardhat projects
- Language server integration with hardhat-language-server
- Recognition of hardhat.config.js and hardhat.config.ts files

### Foundry Integration

- Automatic detection of Foundry projects
- Language server integration with nomicfoundation-solidity-language-server
- Recognition of foundry.toml configuration files

## Installation

### From Zed Extension Registry

1. Open Zed
2. Open the extensions view (Cmd+Shift+E or Ctrl+Shift+E)
3. Search for "Web3"
4. Click "Install"

### As Dev Extension

1. Clone this repository
```bash
git clone https://github.com/your-username/web3-zed.git
```

2. Open Zed
3. Open the extensions view (Cmd+Shift+E or Ctrl+Shift+E)
4. Click "Install Dev Extension"
5. Select the cloned repository directory

## Prerequisites

To fully utilize this extension, you should have:

1. Node.js and npm installed for running the language servers
2. For Hardhat projects: Install hardhat in your project (`npm install --save-dev hardhat`)
3. For Foundry projects: Install Foundry according to the [official documentation](https://book.getfoundry.sh/getting-started/installation)

## Language Server Configuration

This extension will automatically:

- Detect if your project is a Hardhat project (by checking for hardhat.config.js or hardhat.config.ts)
- Detect if your project is a Foundry project (by checking for foundry.toml)
- Use the appropriate language server based on the detected framework

If neither is detected, it will default to the Nomicfoundation Solidity Language Server.

## License

MIT

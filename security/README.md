# Security Toolkit for Solidity Development

This directory contains automated security tools and configurations for your Solidity projects. The setup integrates with both local development and CI/CD pipelines.

## 🛡️ Tools Included

1. **Slither** - Static analysis for Solidity
2. **Prettier** - Code formatting with security-aware rules
3. **Pre-commit Hooks** - Automated checks before git commits

## 🚀 Quick Start

### Prerequisites
```bash
# Install Python dependencies
pip install slither-analyzer pre-commit

# Install Node.js dependencies (for formatting)
npm install --save-dev prettier prettier-plugin-solidity

# Set up git hooks
pre-commit install

Installation
bash
# Set up git hooks
pre-commit install
🔧 Configuration Files
slither.config.json
Location: ./security/slither.config.json

Purpose: Custom static analysis rules

Key Features:

Filters out test contracts

Fails CI on high-severity issues

Generates JSON reports

pre-commit.yaml
Location: ./security/pre-commit.yaml

Automates:

Slither analysis on .sol files

Solidity formatting with Prettier

Foundry config validation

🛠️ Usage
Manual Security Scan
bash
slither . --config security/slither.config.json
View Reports
HTML report: slither-report.html

JSON report: slither-report.json

Suppress False Positives
Edit .slither-suppressions.json:

json
{
  "suppressions": [
    {
      "file": "src/Token.sol",
      "check": "reentrancy-eth",
      "comment": "False positive: uses CEI pattern"
    }
  ]
}
📊 Severity Levels
Level	CI Blocks?	Description
High	Yes	Critical vulnerabilities
Medium	No	Important security issues
Low	No	Code quality suggestions
Informational	No	General observations
🔗 Recommended Resources
Slither Detector Registry

Smart Contract Security Checklist

Ethereum Security Tools

🚨 Emergency Contacts
For critical vulnerabilities discovered:

Security Team: pradovd4@gmail.com

ETH Bug Bounty: https://bounty.ethereum.org

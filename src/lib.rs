use zed_extension_api as zed;

struct Web3Extension {
    // Extension state can be added here if needed
}

impl zed::Extension for Web3Extension {
    fn new() -> Self {
        Self {}
    }

    // If there are required trait methods, implement them here
}

// Then register the commands or functionality somewhere else
// This function would be called when the extension is initialized
fn init_extension(cx: &mut zed::ExtensionContext) {
    // Register slash commands
    cx.register_slash_command(
        "new-contract",
        "Create a new Solidity contract",
        |cx| {
            let filename = cx.input().unwrap_or_else(|| "Contract.sol".to_string());
            cx.editor_mut().insert(&format!(
                "// SPDX-License-Identifier: MIT\npragma solidity ^0.8.0;\n\ncontract {} {{\n    constructor() {{\n        \n    }}\n}}\n",
                filename.trim_end_matches(".sol")
            ));
            Ok(())
        },
    );

    cx.register_slash_command(
        "new-hardhat-config",
        "Create a new Hardhat configuration file",
        |cx| {
            cx.editor_mut().insert(
                "require(\"@nomicfoundation/hardhat-toolbox\");\n\nmodule.exports = {\n  solidity: \"0.8.19\",\n  networks: {\n    hardhat: {\n    },\n  },\n};\n"
            );
            Ok(())
        },
    );

    cx.register_slash_command(
        "new-foundry-config",
        "Create a new Foundry configuration file",
        |cx| {
            cx.editor_mut().insert(
                "[profile.default]\nsrc = \"src\"\nout = \"out\"\nlibs = [\"lib\"]\nremappings = []\n\n[rpc_endpoints]\nlocal = \"http://localhost:8545\"\n"
            );
            Ok(())
        },
    );
}

zed::register_extension!
(Web3Extension, init_extension);

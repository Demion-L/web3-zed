use std::path::Path;
use zed_extension_api as zed;

struct Web3Extension;

impl zed::Extension for Web3Extension {
    fn new() -> Self {
        Web3Extension
    }

    fn language_server_command(
        &mut self,
        language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> zed::Result<zed::Command> {
        match language_server_id.as_ref() {
            "solidity" => {
                let root_path_str = worktree.root_path();
                let root_path = Path::new(&root_path_str);

                let hardhat_config = root_path.join("hardhat.config.js");
                let hardhat_ts_config = root_path.join("hardhat.config.ts");

                if hardhat_config.exists() || hardhat_ts_config.exists() {
                    return Ok(zed::Command {
                        command: "npx".into(),
                        args: vec!["hardhat-language-server".into(), "--stdio".into()],
                        env: Default::default(),
                    });
                }

                let foundry_toml = root_path.join("foundry.toml");

                if foundry_toml.exists() {
                    return Ok(zed::Command {
                        command: "npx".into(),
                        args: vec![
                            "@nomicfoundation/solidity-language-server".into(),
                            "--stdio".into(),
                        ],
                        env: Default::default(),
                    });
                }

                // Default to Nomic Foundation's LSP
                Ok(zed::Command {
                    command: "npx".into(),
                    args: vec![
                        "@nomicfoundation/solidity-language-server".into(),
                        "--stdio".into(),
                    ],
                    env: Default::default(),
                })
            }
            _ => Err(format!("Unsupported language server: {}", language_server_id).into()),
        }
    }
}

fn tree_sitter_language(language_id: &str) -> Option<zed::TreeSitterLanguage> {
    match language_id {
        "solidity" => Some(zed::TreeSitterLanguage::new(
            tree_sitter_solidity::language(),
            None,
        )),
        _ => None,
    }
}

zed::register_extension!(Web3Extension);

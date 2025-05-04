; Allow shell/env variable highlighting in strings
((string) @string.special
  (#match? @string.special "\\$\\{?[A-Z_]+\\}?"))

; Highlight URLs in rpc_endpoint/etherscan_api_key
((pair
  (bare_key) @variable.builtin
  (value (string) @string.url)
  (#any-of? @variable.builtin "rpc_endpoint" "etherscan_api_key"))

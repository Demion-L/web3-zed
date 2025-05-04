;; TOML highlights

;; Comments
(comment) @comment.line

;; Tables
(table
  (table_array_element) @keyword)

;; Keys
(pair
  (bare_key) @variable.parameter)
(pair
  (quoted_key) @variable.parameter)

;; Values
(string) @string
(integer) @constant.numeric
(float) @constant.numeric
(boolean) @constant.builtin.boolean
(array) @punctuation.bracket
(inline_table) @punctuation.bracket

;; Punctuation
"=" @operator
"." @punctuation.delimiter
"," @punctuation.delimiter

;; Brackets
"[" @punctuation.bracket
"]" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket

;; Foundry-specific keys (common in foundry.toml)
((pair
  (bare_key) @variable.builtin
  (#match? @variable.builtin "^(src|out|libs|optimizer|rpc_endpoint|etherscan_api_key)$"))

;; Profile sections
(table
  (table_header
    (table_array_element (identifier) @namespace)
    (#match? @namespace "^profile\\.(default|ci|dev)$")))

;; Solidity version constraints
((pair
  (bare_key) @keyword.directive
  (value (string) @string.special)
  (#eq? @keyword.directive "solc")))

;; Numeric configs (gas limits, optimizer runs)
((pair
  (bare_key) @variable.parameter
  (value (integer) @constant.numeric.integer)
  (#any-of? @variable.parameter "runs" "gas_limit" "block_gas_limit"))

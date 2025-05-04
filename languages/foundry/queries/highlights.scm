;; 1. Syntax Basics
;; ======================
(comment) @comment.line

;; Punctuation
"=" @operator
"." @punctuation.delimiter
"," @punctuation.delimiter

;; Brackets
"[" @punctuation.bracket
"]" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket

;; Values
(string) @string
(integer) @constant.numeric
(float) @constant.numeric
(boolean) @constant.builtin.boolean
(array) @punctuation.bracket
(inline_table) @punctuation.bracket

;; ======================
;; 2. Structure Highlighting
;; ======================
;; Tables
(table
  (table_array_element) @keyword)

;; Keys
(pair
  (bare_key) @variable.parameter)
(pair
  (quoted_key) @variable.parameter)

;; ======================
;; 3. Foundry-Specific Rules
;; ======================
;; Critical Foundry keys
((pair
  (bare_key) @variable.builtin
  (#match? @variable.builtin "^(src|out|libs|optimizer|rpc_endpoint|etherscan_api_key)$"))

;; Profile sections
(table
  (table_header
    (table_array_element (identifier) @namespace)
    (#match? @namespace "^profile\\.(default|ci|dev)$"))

;; Solidity version
((pair
  (bare_key) @keyword.directive
  (value (string) @string.special)
  (#eq? @keyword.directive "solc"))

;; Numeric configs
((pair
  (bare_key) @variable.parameter
  (value (integer) @constant.numeric.integer)
  (#any-of? @variable.parameter "runs" "gas_limit" "block_gas_limit"))

;; ======================
;; 4. Indentation Hints
;; ======================
;; Auto-indent rules (must come last)
(table "{" @indent)
(table "}" @dedent)
(array "[" @indent)
(array "]" @dedent)

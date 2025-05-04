;; Hardhat config highlights
((call_expression
   function: (identifier) @function.builtin
   (#any-of? @function.builtin "require" "task" "config" "module.exports"))

;; Network definitions
(pair
  key: (property_identifier) @variable.builtin
  (#any-of? @variable.builtin "networks" "solidity" "paths"))

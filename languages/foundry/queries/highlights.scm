;; Top-level Foundry keys (src, out, solc, etc.)
(pair
  (bare_key) @variable.builtin
  (#any-of? @variable.builtin "src" "out" "libs" "solc" "optimizer"))

;; Profile sections (profile.default, profile.ci)
(table_header
  (dotted_key (identifier) @namespace)
  (#match? @namespace "^profile$"))

;; Numeric configs (runs, gas limits)
(pair
  (bare_key) @variable.parameter
  (integer) @constant.numeric.integer
  (#any-of? @variable.parameter "runs" "gas_limit"))

;; Comments
(comment) @comment.line

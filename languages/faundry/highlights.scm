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

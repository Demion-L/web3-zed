;; Solidity grammar

;; Comments
(comment) @comment.line
(multi_line_comment) @comment.block

;; Keywords
(pragma_directive
  "pragma" @keyword.directive
  (solidity_version
    "solidity" @keyword))

((identifier) @keyword
 (#match? @keyword "^(contract|library|interface|function|modifier|event|struct|enum|returns|return|if|else|for|while|do|break|continue|throw|using|assembly|emit|public|private|external|internal|pure|view|payable|constant|anonymous|indexed|memory|storage|calldata)$"))

;; Types
((identifier) @type
 (#match? @type "^(address|bool|string|byte|bytes|bytes\\d+|int|int\\d+|uint|uint\\d+|fixed|fixed\\d+x\\d+|ufixed|ufixed\\d+x\\d+)$"))

((identifier) @type.builtin
 (#match? @type.builtin "^(this|super)$"))

;; Literals
(number_literal) @constant.numeric
(string_literal) @string
(hex_string_literal) @string
"true" @constant.builtin.boolean
"false" @constant.builtin.boolean

;; Functions
(function_definition
  name: (identifier) @function)
(modifier_definition
  name: (identifier) @function.special)
(event_definition
  name: (identifier) @function.special)

;; Variables
(state_variable_declaration
  name: (identifier) @variable)
(parameter
  name: (identifier) @variable.parameter)

;; Operator
"=" @operator
"+" @operator
"-" @operator
"*" @operator
"/" @operator
"%" @operator
"==" @operator
"!=" @operator
"<" @operator
"<=" @operator
">" @operator
">=" @operator
"&&" @operator
"||" @operator
"!" @operator
"&" @operator
"|" @operator
"^" @operator
"~" @operator
"<<" @operator
">>" @operator

;; Punctuation
";" @punctuation.delimiter
"." @punctuation.delimiter
"," @punctuation.delimiter
":" @punctuation.delimiter

;; Brackets
"(" @punctuation.bracket
")" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket

;; Keywords
(
  [
    "pragma"
    "contract"
    "library"
    "interface"
    "function"
    "constructor"
    "modifier"
    "using"
    "require"
    "assert"
    "revert"
    "emit"
    "event"
    "struct"
    "enum"
    "mapping"
    "if"
    "else"
    "for"
    "while"
    "do"
    "break"
    "continue"
    "return"
    "import"
    "as"
    "from"
    "new"
    "delete"
    "try"
    "catch"
    "this"
    "is"
  ] @keyword
)

;; Control flow
(
  [
    "public"
    "private"
    "internal"
    "external"
    "pure"
    "view"
    "payable"
    "constant"
    "immutable"
    "virtual"
    "override"
    "memory"
    "storage"
    "calldata"
  ] @keyword.storage
)

;; Operators
(
  [
    "=="
    "!="
    "<"
    "<="
    ">"
    ">="
    "+"
    "-"
    "*"
    "/"
    "%"
    "**"
    "++"
    "--"
    "<<"
    ">>"
    "&"
    "|"
    "^"
    "~"
    "&&"
    "||"
    "="
    "+="
    "-="
    "*="
    "/="
    "%="
    "**="
    "<<="
    ">>="
    "&="
    "|="
    "^="
    "!"
  ] @operator
)

;; Types
(
  [
    "address"
    "bool"
    "string"
    "bytes"
    "int"
    "uint"
    "int8"
    "int16"
    "int24"
    "int32"
    "int40"
    "int48"
    "int56"
    "int64"
    "int72"
    "int80"
    "int88"
    "int96"
    "int104"
    "int112"
    "int120"
    "int128"
    "int136"
    "int144"
    "int152"
    "int160"
    "int168"
    "int176"
    "int184"
    "int192"
    "int200"
    "int208"
    "int216"
    "int224"
    "int232"
    "int240"
    "int248"
    "int256"
    "uint8"
    "uint16"
    "uint24"
    "uint32"
    "uint40"
    "uint48"
    "uint56"
    "uint64"
    "uint72"
    "uint80"
    "uint88"
    "uint96"
    "uint104"
    "uint112"
    "uint120"
    "uint128"
    "uint136"
    "uint144"
    "uint152"
    "uint160"
    "uint168"
    "uint176"
    "uint184"
    "uint192"
    "uint200"
    "uint208"
    "uint216"
    "uint224"
    "uint232"
    "uint240"
    "uint248"
    "uint256"
    "bytes1"
    "bytes2"
    "bytes3"
    "bytes4"
    "bytes5"
    "bytes6"
    "bytes7"
    "bytes8"
    "bytes9"
    "bytes10"
    "bytes11"
    "bytes12"
    "bytes13"
    "bytes14"
    "bytes15"
    "bytes16"
    "bytes17"
    "bytes18"
    "bytes19"
    "bytes20"
    "bytes21"
    "bytes22"
    "bytes23"
    "bytes24"
    "bytes25"
    "bytes26"
    "bytes27"
    "bytes28"
    "bytes29"
    "bytes30"
    "bytes31"
    "bytes32"
  ] @type
)

;; Literals
(number_literal) @number
(string_literal) @string
(hex_string_literal) @string
(boolean) @boolean
(comment) @comment

;; Solidity-specific identifiers
(identifier) @variable
(contract_declaration (identifier) @type)
(interface_declaration (identifier) @type)
(library_declaration (identifier) @type)
(function_definition (identifier) @function)
(event_definition (identifier) @function)
(modifier_definition (identifier) @function)
(struct_declaration (identifier) @type)
(enum_declaration (identifier) @type)
(member_expression (identifier) @property)

;; Function calls
(call_expression
  function: (identifier) @function)

;; Variables
(variable_declaration (identifier) @variable)
(parameter (identifier) @variable.parameter)
(state_variable_declaration (identifier) @variable)

;; Punctuation
(["(" ")" "[" "]" "{" "}" "," ";" "."]) @punctuation.delimiter

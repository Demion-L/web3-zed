; Block-level indentation
(contract_body "}" @end) @indent
(function_body "}" @end) @indent
(block "}" @end) @indent
(if_statement "}" @end) @indent
(for_statement "}" @end) @indent
(while_statement "}" @end) @indent
(do_while_statement "}" @end) @indent
(struct_declaration_body "}" @end) @indent
(enum_values "}" @end) @indent

; Nested expressions
(tuple_expression ")" @end) @indent
(array ")" @end) @indent

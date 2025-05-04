; Function objects
(function_definition) @function.around

(function_definition
  body: (function_body
    "{"
    (_)* @function.inside
    "}"))

; Class objects (contracts, interfaces, libraries)
(contract_declaration) @class.around

(contract_declaration
  body: (contract_body
    "{"
    (_)* @class.inside
    "}"))

(interface_declaration) @class.around

(interface_declaration
  body: (contract_body
    "{"
    (_)* @class.inside
    "}"))

(library_declaration) @class.around

(library_declaration
  body: (contract_body
    "{"
    (_)* @class.inside
    "}"))

; Comment objects
(comment)+ @comment.around

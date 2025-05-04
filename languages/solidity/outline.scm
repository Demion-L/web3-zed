; Contracts, interfaces, and libraries
(contract_declaration
  (identifier) @name) @item

(interface_declaration
  (identifier) @name) @item

(library_declaration
  (identifier) @name) @item

; Functions and modifiers
(function_definition
  (identifier) @name) @item

(constructor_definition) @item

(modifier_definition
  (identifier) @name) @item

; Events
(event_definition
  (identifier) @name) @item

; Structs and enums
(struct_declaration
  (identifier) @name) @item

(enum_declaration
  (identifier) @name) @item

; State variables
(state_variable_declaration
  (identifier) @name) @item

; Context annotations for functions
(function_definition
  (function_descriptor) @context)

; Modifiers for outline items
(natspec_comment) @annotation

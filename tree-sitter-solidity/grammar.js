module.exports = grammar({
  name: 'solidity',

  extras: $ => [
    /\s|\\\r?\n/,
    $.comment,
    $.multi_line_comment,
  ],

  rules: {
    source_file: $ => repeat(
      choice(
        $.pragma_directive,
        $.import_directive,
        $.contract_definition,
        $.interface_definition,
        $.library_definition,
        $.struct_definition,
        $.enum_definition,
        $.function_definition,
        $.error_definition,
        $.user_defined_value_type_definition,
      )
    ),

    // Comments
    comment: $ => token(seq('//', /.*/)),
    multi_line_comment: $ => token(seq(
      '/*',
      /[^*]*\*+([^/*][^*]*\*+)*/,
      '/'
    )),

    // Pragma
    pragma_directive: $ => seq(
      'pragma',
      field('value', choice($.solidity_version, $.abicoder_version)),
      ';'
    ),

    solidity_version: $ => seq(
      'solidity',
      /[\^>=<~\s]+/,
      $.version_constraint
    ),

    abicoder_version: $ => seq(
      'abicoder',
      choice('v1', 'v2')
    ),

    version_constraint: $ => /[0-9]+\.[0-9]+\.[0-9]+/,

    // Import directives
    import_directive: $ => seq(
      'import',
      choice(
        seq($.string_literal, ';'),
        seq($.string_literal, 'as', $.identifier, ';'),
        seq('{', commaSep1($.import_declaration), '}', 'from', $.string_literal, ';'),
        seq('*', 'as', $.identifier, 'from', $.string_literal, ';')
      )
    ),

    import_declaration: $ => seq(
      field('name', $.identifier),
      optional(seq('as', field('alias', $.identifier)))
    ),

    // Contract definition
    contract_definition: $ => seq(
      optional('abstract'),
      'contract',
      field('name', $.identifier),
      optional(seq(
        'is',
        commaSep1($.inheritance_specifier)
      )),
      '{',
      repeat(choice(
        $.state_variable_declaration,
        $.struct_definition,
        $.enum_definition,
        $.function_definition,
        $.modifier_definition,
        $.event_definition,
        $.error_definition,
        $.using_directive,
        $.constructor_definition,
        $.receive_function_definition,
        $.fallback_function_definition,
      )),
      '}'
    ),

    inheritance_specifier: $ => seq(
      field('ancestor', $.identifier),
      optional($.function_call_arguments)
    ),

    // Interface definition
    interface_definition: $ => seq(
      'interface',
      field('name', $.identifier),
      optional(seq(
        'is',
        commaSep1($.inheritance_specifier)
      )),
      '{',
      repeat(choice(
        $.function_definition,
        $.event_definition,
        $.error_definition,
        $.struct_definition,
        $.enum_definition,
        $.user_defined_value_type_definition,
      )),
      '}'
    ),

    // Library definition
    library_definition: $ => seq(
      'library',
      field('name', $.identifier),
      '{',
      repeat(choice(
        $.state_variable_declaration,
        $.struct_definition,
        $.enum_definition,
        $.function_definition,
        $.modifier_definition,
        $.event_definition,
        $.error_definition,
        $.using_directive,
      )),
      '}'
    ),

    // Struct definition
    struct_definition: $ => seq(
      'struct',
      field('name', $.identifier),
      '{',
      repeat($.struct_member),
      '}'
    ),

    struct_member: $ => seq(
      field('type', $.type_name),
      field('name', $.identifier),
      ';'
    ),

    // Enum definition
    enum_definition: $ => seq(
      'enum',
      field('name', $.identifier),
      '{',
      commaSep1(field('value', $.identifier)),
      '}'
    ),

    // Error definition
    error_definition: $ => seq(
      'error',
      field('name', $.identifier),
      field('parameters', $.parameter_list),
      ';'
    ),

    // User defined value type definition
    user_defined_value_type_definition: $ => seq(
      'type',
      field('name', $.identifier),
      'is',
      field('underlying_type', $.elementary_type_name),
      ';'
    ),

    // Using directive
    using_directive: $ => seq(
      'using',
      field('library', $.identifier),
      optional(seq('for', field('type', choice($.type_name, '*')))),
      ';'
    ),

    // State variable declaration
    state_variable_declaration: $ => seq(
      field('type', $.type_name),
      repeat(choice(
        'public',
        'private',
        'internal',
        'constant',
        'immutable',
        'override'
      )),
      field('name', $.identifier),
      optional(seq('=', field('value', $.expression))),
      ';'
    ),

    // Function definition
    function_definition: $ => seq(
      'function',
      field('name', $.identifier),
      field('parameters', $.parameter_list),
      repeat(choice(
        'external',
        'public',
        'internal',
        'private',
        'pure',
        'view',
        'payable',
        'virtual',
        seq('override', optional($.override_specifier)),
        $.modifier_invocation
      )),
      optional(seq(
        'returns',
        field('return_parameters', $.parameter_list)
      )),
      choice(
        ';',
        field('body', $.function_body)
      )
    ),

    // Constructor definition
    constructor_definition: $ => seq(
      'constructor',
      field('parameters', $.parameter_list),
      repeat(choice(
        'public',
        'internal',
        'payable',
        $.modifier_invocation
      )),
      field('body', $.function_body)
    ),

    // Receive function definition
    receive_function_definition: $ => seq(
      'receive',
      '()',
      repeat(choice(
        'external',
        'payable',
        $.modifier_invocation
      )),
      field('body', $.function_body)
    ),

    // Fallback function definition
    fallback_function_definition: $ => seq(
      'fallback',
      '()',
      repeat(choice(
        'external',
        'payable',
        $.modifier_invocation
      )),
      optional(seq(
        'returns',
        field('return_parameters', $.parameter_list)
      )),
      field('body', $.function_body)
    ),

    function_body: $ => $.block,

    // Modifier definition
    modifier_definition: $ => seq(
      'modifier',
      field('name', $.identifier),
      optional(field('parameters', $.parameter_list)),
      optional(seq('virtual')),
      optional(seq('override', optional($.override_specifier))),
      choice(
        ';',
        field('body', $.function_body)
      )
    ),

    modifier_invocation: $ => seq(
      field('name', $.identifier),
      optional($.function_call_arguments)
    ),

    // Event definition
    event_definition: $ => seq(
      'event',
      field('name', $.identifier),
      field('parameters', $.event_parameter_list),
      optional('anonymous'),
      ';'
    ),

    event_parameter_list: $ => seq(
      '(',
      optional(commaSep1($.event_parameter)),
      ')'
    ),

    event_parameter: $ => seq(
      field('type', $.type_name),
      optional('indexed'),
      optional(field('name', $.identifier))
    ),

    // Parameter list
    parameter_list: $ => seq(
      '(',
      optional(commaSep1($.parameter)),
      ')'
    ),

    parameter: $ => seq(
      field('type', $.type_name),
      optional(field('storage_location', choice('memory', 'storage', 'calldata'))),
      optional(field('name', $.identifier))
    ),

    // Override specifier
    override_specifier: $ => seq(
      '(',
      commaSep1($.identifier),
      ')'
    ),

    // Types
    type_name: $ => choice(
      $.elementary_type_name,
      $.user_defined_type_name,
      $.mapping,
      $.array_type_name,
      $.function_type_name
    ),

    elementary_type_name: $ => choice(
      'address',
      seq('address', 'payable'),
      'bool',
      'string',
      'bytes',
      seq('bytes', /([1-9]|[1-2][0-9]|3[0-2])/),
      'int',
      seq('int', /([1-9]|[1-2][0-9]|3[0-2])8/),
      'uint',
      seq('uint', /([1-9]|[1-2][0-9]|3[0-2])8/),
      'fixed',
      'ufixed'
    ),

    user_defined_type_name: $ => $.identifier,

    mapping: $ => seq(
      'mapping',
      '(',
      field('key', $.type_name),
      '=>',
      field('value', $.type_name),
      ')'
    ),

    array_type_name: $ => seq(
      field('base_type', $.type_name),
      '[',
      optional(field('length', $.expression)),
      ']'
    ),

    function_type_name: $ => seq(
      'function',
      field('parameters', $.parameter_list),
      repeat(choice(
        'external',
        'internal',
        'pure',
        'view',
        'payable'
      )),
      optional(seq(
        'returns',
        field('return_parameters', $.parameter_list)
      ))
    ),

    // Expressions
    expression: $ => choice(
      $.primary_expression,
      $.function_call,
      $.new_expression,
      $.member_access,
      $.array_access,
      $.unary_operation,
      $.binary_operation,
      $.ternary_operation,
      $.assignment,
      $.tuple_expression
    ),

    primary_expression: $ => choice(
      $.identifier,
      $.literal,
      $.type_cast,
      seq('(', $.expression, ')')
    ),

    function_call: $ => seq(
      field('function', $.expression),
      field('arguments', $.function_call_arguments)
    ),

    function_call_arguments: $ => seq(
      '(',
      optional(commaSep1($.expression)),
      ')'
    ),

    new_expression: $ => seq(
      'new',
      field('type', $.type_name)
    ),

    member_access: $ => seq(
      field('object', $.expression),
      '.',
      field('member', $.identifier)
    ),

    array_access: $ => seq(
      field('array', $.expression),
      '[',
      field('index', $.expression),
      ']'
    ),

    unary_operation: $ => choice(
      seq(choice('!', '~', 'delete', '++', '--', '+', '-'), $.expression),
      seq($.expression, choice('++', '--'))
    ),

    binary_operation: $ => {
      const table = [
        ['||', 'prec_logical_or'],
        ['&&', 'prec_logical_and'],
        [['==', '!='], 'prec_equality'],
        [['<', '>', '<=', '>='], 'prec_relational'],
        [['|'], 'prec_bitwise_or'],
        [['^'], 'prec_bitwise_xor'],
        [['&'], 'prec_bitwise_and'],
        [['<<', '>>'], 'prec_shift'],
        [['+', '-'], 'prec_add'],
        [['*', '/', '%'], 'prec_multiply'],
        [['**'], 'prec_power']
      ];

      return choice(...table.map(([operators, precedence]) => {
        return prec[precedence](seq(
          field('left', $.expression),
          ...operators.map(operator => field('operator', operator)),
          field('right', $.expression)
        ));
      }));
    },

    ternary_operation: $ => prec.right('prec_ternary', seq(
      field('condition', $.expression),
      '?',
      field('then', $.expression),
      ':',
      field('else', $.expression)
    )),

    assignment: $ => prec.right('prec_assignment', seq(
      field('left', $.expression),
      field('operator', choice('=', '+=', '-=', '*=', '/=', '%=', '|=', '&=', '^=', '<<=', '>>=')),
      field('right', $.expression)
    )),

    tuple_expression: $ => seq(
      '(',
      commaSep1(optional($.expression)),
      ')'
    ),

    type_cast: $ => seq(
      field('type', $.type_name),
      '(',
      field('expression', $.expression),
      ')'
    ),

    // Block
    block: $ => seq(
      '{',
      repeat($.statement),
      '}'
    ),

    // Statements
    statement: $ => choice(
      $.block,
      $.variable_declaration_statement,
      $.expression_statement,
      $.if_statement,
      $.for_statement,
      $.while_statement,
      $.do_while_statement,
      $.continue_statement,
      $.break_statement,
      $.return_statement,
      $.emit_statement,
      $.try_statement,
      $.revert_statement,
      $.assembly_statement,
      ';'
    ),

    variable_declaration_statement: $ => seq(
      choice(
        seq(field('type', $.type_name), repeat($.variable_declaration)),
        seq('var', field('declarations', $.variable_declaration_tuple))
      ),
      optional(seq('=', field('value', $.expression))),
      ';'
    ),

    variable_declaration: $ => seq(
      optional(field('storage_location', choice('memory', 'storage', 'calldata'))),
      field('name', $.identifier)
    ),

    variable_declaration_tuple: $ => seq(
      '(',
      commaSep1($.identifier),
      ')'
    ),

    expression_statement: $ => seq(
      $.expression,
      ';'
    ),

    if_statement: $ => seq(
      'if',
      '(',
      field('condition', $.expression),
      ')',
      field('consequence', $.statement),
      optional(seq(
        'else',
        field('alternative', $.statement)
      ))
    ),

    for_statement: $ => seq(
      'for',
      '(',
      choice(
        field('initializer', $.variable_declaration_statement),
        seq(field('initializer', optional($.expression)), ';')
      ),
      field('condition', optional($.expression)),
      ';',
      field('update', optional($.expression)),
      ')',
      field('body', $.statement)
    ),

    while_statement: $ => seq(
      'while',
      '(',
      field('condition', $.expression),
      ')',
      field('body', $.statement)
    ),

    do_while_statement: $ => seq(
      'do',
      field('body', $.statement),
      'while',
      '(',
      field('condition', $.expression),
      ')',
      ';'
    ),

    continue_statement: $ => seq(
      'continue',
      ';'
    ),

    break_statement: $ => seq(
      'break',
      ';'
    ),

    return_statement: $ => seq(
      'return',
      optional(field('value', $.expression)),
      ';'
    ),

    emit_statement: $ => seq(
      'emit',
      field('event_call', $.function_call),
      ';'
    ),

    try_statement: $ => seq(
      'try',
      field('expression', $.expression),
      optional(seq(
        'returns',
        field('return_parameters', $.parameter_list)
      )),
      field('body', $.block),
      repeat1($.catch_clause)
    ),

    catch_clause: $ => seq(
      'catch',
      optional(seq(
        optional(field('error_param', $.identifier)),
        field('parameters', $.parameter_list)
      )),
      field('body', $.block)
    ),

    revert_statement: $ => seq(
      'revert',
      field('error_call', $.function_call),
      ';'
    ),

    assembly_statement: $ => seq(
      'assembly',
      optional('"evmasm"'),
      field('block', $.assembly_block)
    ),

    assembly_block: $ => seq(
      '{',
      repeat($.assembly_item),
      '}'
    ),

    assembly_item: $ => choice(
      $.assembly_block,
      $.assembly_assignment,
      $.assembly_expression,
      $.assembly_label,
      $.assembly_switch,
      $.assembly_for,
      $.assembly_if,
      $.assembly_leave,
      $.assembly_break,
      $.assembly_continue,
      $.assembly_function_definition
    ),

    assembly_assignment: $ => seq(
      'let',
      field('name', $.assembly_identifier),
      optional(seq(
        ':=',
        field('value', $.assembly_expression)
      ))
    ),

    assembly_expression: $ => choice(
      $.assembly_literal,
      $.assembly_identifier,
      $.assembly_function_call
    ),

    assembly_literal: $ => choice(
      $.number_literal,
      $.string_literal,
      $.hex_string_literal,
      $.boolean_literal
    ),

    assembly_identifier: $ => $.identifier,

    assembly_function_call: $ => seq(
      field('function', $.assembly_identifier),
      '(',
      optional(commaSep1($.assembly_expression)),
      ')'
    ),

    assembly_label: $ => seq(
      field('name', $.identifier),
      ':'
    ),

    assembly_switch: $ => seq(
      'switch',
      field('expression', $.assembly_expression),
      repeat($.assembly_case),
      optional($.assembly_default)
    ),

    assembly_case: $ => seq(
      'case',
      field('value', $.assembly_expression),
      field('body', $.assembly_block)
    ),

    assembly_default: $ => seq(
      'default',
      field('body', $.assembly_block)
    ),

    assembly_for: $ => seq(
      'for',
      field('init_block', $.assembly_block),
      field('condition', $.assembly_expression),
      field('update_block', $.assembly_block),
      field('body', $.assembly_block)
    ),

    assembly_if: $ => seq(
      'if',
      field('condition', $.assembly_expression),
      field('body', $.assembly_block)
    ),

    assembly_leave: $ => 'leave',
    assembly_break: $ => 'break',
    assembly_continue: $ => 'continue',

    assembly_function_definition: $ => seq(
      'function',
      field('name', $.assembly_identifier),
      '(',
      optional(commaSep1($.assembly_identifier)),
      ')',
      optional(seq(
        '->',
        commaSep1($.assembly_identifier)
      )),
      field('body', $.assembly_block)
    ),

    // Literals
    literal: $ => choice(
      $.number_literal,
      $.string_literal,
      $.hex_string_literal,
      $.boolean_literal
    ),

    number_literal: $ => seq(
      choice(
        /[0-9]+(\.[0-9]+)?([eE][+-]?[0-9]+)?/,
        /0[xX][0-9a-fA-F]+/
      ),
      optional(choice(
        'wei', 'gwei', 'ether',
        'seconds', 'minutes', 'hours', 'days', 'weeks', 'years'
      ))
    ),

    string_literal: $ => seq(
      choice(
        seq('"', optional(/[^"\\]*(?:\\.[^"\\]*)*/), '"'),
        seq("'", optional(/[^'\\]*(?:\\.[^'\\]*)*/), "'")
      )
    ),

    hex_string_literal: $ => seq(
      'hex',
      choice(
        seq('"', optional(/[0-9a-fA-F]*/), '"'),
        seq("'", optional(/[0-9a-fA-F]*/), "'")
      )
    ),

    boolean_literal: $ => choice('true', 'false'),

    // Identifiers
    identifier: $ => /[a-zA-Z$_][a-zA-Z0-9$_]*/
  }
});

function commaSep1(rule) {
  return seq(rule, repeat(seq(',', rule)));
}

function commaSep(rule) {
  return optional(commaSep1(rule));
}

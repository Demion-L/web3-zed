; Detect runnable tests in Hardhat and Foundry projects
(
  (function_definition
    [
      (function_descriptor
        (function_visibility)
        "view"?
        "pure"?)
      (identifier) @run @test_name
    ]
    (#match? @test_name "^test")
  )
  (#set! tag solidity-test)
)

; Detect test contracts
(
  (contract_declaration
    (identifier) @run @contract_name)
  (#match? @contract_name "Test$")
  (#set! tag solidity-test-contract)
)

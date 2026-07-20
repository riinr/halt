Feature: Halt
  As a Nim developer
  I want early-return and iteration-control macros
  So that I can write concise guard clauses and option helpers

  Scenario: Guard returns early without a value
    Given a guard with a false condition
    When the guarded procedure runs
    Then it returns before reaching the rest of the body

  Scenario: Guard returns early with a value
    Given a guard with a false condition and a fallback value
    When the guarded procedure runs
    Then it returns the fallback value

  Scenario: Guard returns none via typedesc
    Given a guard on a condition with a typedesc return
    When the condition is false
    Then it returns none of that type

  Scenario: Guard on Option returns early without value
    Given an Option guard
    When the option is none
    Then the body is skipped

  Scenario: Guard on Option returns a fallback value
    Given an Option guard with a fallback value
    When the option is none
    Then the fallback value is returned

  Scenario: Guard on Option returns none via typedesc
    Given an Option guard with a typedesc return
    When the option is none
    Then none of the result type is returned

  Scenario: Until breaks the iteration
    Given a loop guarded by until
    When the condition becomes true
    Then the loop stops before that index

  Scenario: Until breaks a named block
    Given nested loops guarded by a named until
    When the condition becomes true
    Then control exits the named block

  Scenario: Skip continues to next iteration
    Given a loop guarded by skip
    When the condition is true
    Then the current iteration is skipped

  Scenario: dbgAssert raises on failure
    Given a dbgAssert with a false condition
    When it runs in a dev build
    Then it raises an AssertionDefect

  Scenario: Converts value to option
    Given a value and a typedesc
    When converted through the toOpt converter
    Then the value becomes some and the type becomes none

  Scenario Outline: Index reports found or missing
    Given an index <i>
    Then found reports <r>

    Examples:
      | i   | r      |
      | 0   | true   |
      | 1   | true   |
      | -1  | false  |
      | 10  | true   |

  Scenario: Detects empty holders
    Given zero, an empty string, an empty seq, and none
    Then empty reports true and filled reports false

  Scenario: Maps and filters options
    Given an Option holding a value
    When mapIt, mapTo, filterIt, and applyIt are applied
    Then the transformed options are returned

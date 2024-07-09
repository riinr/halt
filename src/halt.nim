import std/macros

template found*(i: int): bool =
  ## Convert index not found (anything lower than 0) to bool
  i >= 0


macro guard*(cond: untyped): untyped =
  ## Return early if condition isn't met
  ##
  ## Similar to assert but returns instead of raise Error
  ##
  ## http://wiki.c2.com/?GuardClause=
  
  runnableExamples:
    proc foo(x: int) =
      guard x < 1

  quote("@") do:
    if not(@cond): return


macro guard*(cond: untyped; resp): untyped =
  ## Return early if condition isn't met
  ##
  ## Similar to assert but returns instead of raise Error
  ##
  ## http://wiki.c2.com/?GuardClause=
  
  runnableExamples:
    proc foo(x: int): int =
      guard x < 1, -1
      return 10

  quote("@") do:
    if not(@cond):
      return @resp


macro until*(cond: untyped): untyped =
  ## Break the iteration if condition isn't met
  ##
  ## Like guard but with `break`
  ##
  ## http://wiki.c2.com/?GuardClause=
  
  runnableExamples:
    proc foo(x: int) =
      for i in 0 .. 10:
        until i > x

  quote("@") do:
    if @cond: break


macro until*(cond: untyped; name: untyped): untyped =
  ## Break the iteration if condition isn't met
  ##
  ## Like guard but with `break`
  ##
  ## http://wiki.c2.com/?GuardClause=

  runnableExamples:
    proc foo() =
      block bar:
        for x in 0 .. 10:
          for y in 0 .. 10:
            until x + y > 5, bar

  quote("@") do:
    if @cond: break @name


macro skip*(cond: untyped): untyped =
  ## Continue to next iteration if condition met
  ##
  ## http://wiki.c2.com/?GuardClause=
  
  runnableExamples:
    proc foo(x: int) =
      for i in 0 .. 10:
        skip x > i

  quote("@") do:
    if @cond: continue


template dbgAssert*(cond: untyped; msg: untyped = "") =
  ## `assert` is preserved for `-d:release`, and not for `-d:danger`,
  ## but `-d:danger` is too dangereous,
  ## this version will keep assert only for debug builds
  
  runnableExamples:
    proc foo(x: int): int =
      dbgAssert x < 1
      return 10

  when compileOption("assertions") and not defined release:
    const
      loc = instantiationInfo(fullPaths = compileOption("excessiveStackTrace"))
      ploc = $loc
    bind instantiationInfo
    mixin failedAssertImpl
    {.line: loc.}:
      if not cond:
        failedAssertImpl(ploc & " `" & astToStr(cond) & "` " & msg)

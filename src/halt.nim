import std/macros

template found*(i: int): bool =
  ## Convert index not found (anything lower than 0) to bool
  i >= 0

macro guard*(exp: untyped): untyped =
  ## Return early if expression isn't true
  ## Similar to assert but returns instead of raise Error
  ## http://wiki.c2.com/?GuardClause=
  runnableExamples:
    proc foo(x: int) =
      guard x < 1

  quote("@") do:
    if not(@exp): return


macro guard*(exp: untyped; resp): untyped =
  ## Return early if expression isn't true
  ## Similar to assert but returns instead of raise Error
  ## http://wiki.c2.com/?GuardClause=
  runnableExamples:
    proc foo(x: int): int =
      guard x < 1, -1
      return 10

  quote("@") do:
    if not (@exp):
      return @resp


template dbgAssert*(cond: untyped; msg: string = "") =
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

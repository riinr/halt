import pepino
import halt
import std/[options, strutils]


suite "halt scenarios":

  test "Guard returns early without a value":
    var reached = false
    proc guarded() =
      guard false
      reached = true
    guarded()
    check not reached

  test "Guard returns early with a value":
    proc guardedR(): bool =
      guard false, true
      result = false
    check guardedR()

  test "Guard returns none via typedesc":
    proc foo(x: int): Option[int] =
      guard x < 1, int
      some(10)
    check foo(1).isNone
    check foo(5).isNone
    check foo(0) == some(10)
    check foo(-5) == some(10)

  test "Guard on Option returns early without value":
    proc foo(o: Option[int]): bool =
      guard o
      result = true
    check not foo(none(int))
    check foo(some(1))

  test "Guard on Option returns a fallback value":
    proc foo(o: Option[int]): int =
      guard o, -1
      o.get + 1
    check foo(none(int)) == -1
    check foo(some(4)) == 5

  test "Guard on Option returns none via typedesc":
    proc foo(o: Option[int]): Option[bool] =
      guard o, bool
      some true
    check foo(none(int)).isNone
    check foo(some(1)) == some(true)

  test "Until breaks the iteration":
    var a = 0
    for i in 0 .. 10:
      until i >= 4
      a = i
    check a == 3

  test "Until breaks a named block":
    var a = 0
    block named:
      for i in 0 .. 5:
        for x in 0 .. 5:
          until i >= 4, named
          a = i
        check a == i
    check a > 1

  test "Skip continues to next iteration":
    var a = 0
    for i in 0 .. 10:
      skip i < 4
      check i >= 4
      a = i
    check a == 10

  test "dbgAssert raises on failure":
    try:
      dbgAssert false
      check false
    except AssertionDefect as e:
      check "false" in e.msg

  test "Converts value to option":
    let o: Option[int] = 1
    let n: Option[int] = int
    check o == some(1)
    check n.isNone

  test "Index reports found or missing":
    check found(parseInt(i)) == (r == "true")

  test "Detects empty holders":
    check empty 0
    check empty ""
    check empty []
    check empty @[]
    check empty none(int)
    check filled 1
    check filled "1"
    check filled [1]
    check filled @[1]
    check filled some(1)

  test "Maps and filters options":
    let o = some(1)
    check o.mapIt(it + 1) == some(2)
    check o.mapTo(bool, it == 1) == some(true)
    check o.filterIt(it == 0).isNone
    var o2 = some(1)
    check o2.applyIt(it + 1)
    check o2 == some(2)

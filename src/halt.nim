import std/macros


macro guard*(cond: untyped): untyped =
  ## Return early if condition isn't met
  ##
  ## Similar to assert but returns instead of raise Error
  ##
  ## http://wiki.c2.com/?GuardClause=
  
  runnableExamples:
    proc foo*(x: int) =
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
    proc division*(divisor, dividend: int): float =
      ## we assume division by 0 as 0
      guard divisor == 0, 0
      dividend / divisor

  quote("@") do:
    if not(@cond):
      return @resp


macro guard*(cond: untyped; T: typedesc): untyped =
  ## Return early if condition isn't met
  ##
  ## Similar to assert but returns instead of raise Error
  ##
  ## http://wiki.c2.com/?GuardClause=
  
  runnableExamples:
    import std/options
    proc foo*(x: int): Option[int] =
      guard x < 1, int
      some(10)

  quote("@") do:
    if not(@cond):
      return none(@T)


macro until*(cond: untyped): untyped =
  ## Break the iteration if condition isn't met
  ##
  ## Like guard but with `break`
  ##
  ## http://wiki.c2.com/?GuardClause=
  
  runnableExamples:
    proc foo*(x: int) =
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
    proc foo*() =
      block bar:
        for x in 0 .. 10:
          for y in 0 .. 10:
            until x + y > 5, bar

  quote("@") do:
    if @cond: break @name


macro skip*(cond: untyped): untyped =
  ## Continue to next iteration if condition isn't met
  ##
  ## http://wiki.c2.com/?GuardClause=
  
  runnableExamples:
    proc odd*(x: int) =
      for i in 0 .. x:
        skip i mod 2 != 0
        echo i, " is odd"

    proc even*(x: int) =
      for i in 0 .. x:
        skip i mod 2 == 0
        echo i, " is even"

  quote("@") do:
    if @cond: continue


template dbgAssert*(cond: untyped; msg: untyped = "") =
  ## `assert` is preserved for `-d:release`, and not for `-d:danger`,
  ## but `-d:danger` is too dangereous,
  ## this version will keep assert only for debug builds
  
  runnableExamples:
    proc foo*(x: int): int =
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


import std/options

macro guard*[T](cond: Option[T]): untyped =
  ## Return early if condition isn't met
  ##
  ## Similar to assert but returns instead of raise Error
  ##
  ## http://wiki.c2.com/?GuardClause=
  
  runnableExamples:
    import std/options
    proc foo*(o: Option[int]) =
      guard o
      assert o.get + 1 > 0

  quote("@") do:
    if @cond.isNone: return

macro guard*[T](cond: Option[T]; resp): untyped =
  ## Return early if condition isn't met
  ##
  ## Similar to assert but returns instead of raise Error
  ##
  ## http://wiki.c2.com/?GuardClause=
  
  runnableExamples:
    import std/options
    proc foo*(o: Option[int]): int =
      guard o, -1
      o.get + 1

  quote("@") do:
    if @cond.isNone:
      return @resp

macro guard*[T](cond: Option[T]; R: typedesc): untyped =
  ## Return early if condition isn't met
  ##
  ## Similar to assert but returns instead of raise Error
  ##
  ## http://wiki.c2.com/?GuardClause=
  
  runnableExamples:
    import std/options
    proc foo*(o: Option[int]): Option[bool] =
      guard o, bool
      some true

  quote("@") do:
    if @cond.isNone:
      return none(@R)

converter toOpt*[T](v: T): Option[T] =
  some(v)

converter toOpt*(T: typedesc): Option[T] =
  none(T)

template found*(i: SomeNumber): bool =
  ## Convert index not found (anything lower than 0) to bool
  i >= 0

template found*(holder: untyped): bool =
  ## Convert index not found (anything lower than 0) to bool
  holder.len != 0

template found*[T](holder: Option[T]): bool =
  holder.isSome

template missing*(holder: untyped): bool =
  not holder.found

template empty*(holder: untyped): bool =
  ## check holder is empty
  holder.len == 0

template empty*(holder: SomeNumber): bool =
  ## check holder is empty
  holder == 0

template empty*[T](holder: Option[T]): bool =
  ## check holder is empty
  holder.isNone

template filled*(holder: untyped): bool =
  ## check holder is not empty
  not holder.empty

template filterIt*[T](o: Option[T]; op: untyped): Option[T] =
  ## Similar to `sequtils.filterIt <https://nim-lang.org/docs/sequtils.html#filterIt.t%2Cuntyped%2Cuntyped>`_
  runnableExamples:
    import std/options
    var o = some(1)
    assert o.filterIt(it >= 0) == some(1)
    assert o.filterIt(it == 0) == none(int)

  if o.isNone:
    none(T)
  else:
    let it {.inject.}: T = o.get
    if op:
      o
    else:
      none(T)


template applyIt*[T](o: var Option[T]; op: untyped): bool =
  ## Similar to `sequtils.applyIt <https://nim-lang.org/docs/sequtils.html#applyIt.t%2Cuntyped%2Cuntyped>`_
  runnableExamples:
    import std/options
    var o = some(1)
    if o.applyIt(it + 1):
      echo "is some"
    assert o == some(2)

  if o.isSome:
    let dst: ptr T = o.get().addr
    var it {.inject.}: T = dst[]
    dst[] = op
  o.isSome

template mapIt*[T](o: Option[T]; op: untyped): untyped =
  ## Similar to `sequtils.mapIt <https://nim-lang.org/docs/sequtils.html#mapIt.t%2Ctyped%2Cuntyped>`_
  runnableExamples:
    import std/options
    let o = some(1)
    assert o.mapIt(it + 1) == some(2)
    assert o.mapIt(it - 1) == some(0)

  if o.isSome:
    let it {.inject.}: T = o.get
    some(op)
  else:
    none(T)

template mapTo*[T](o: Option[T]; R: typedesc; op: untyped): untyped =
  ## Similar to `sequtils.mapIt <https://nim-lang.org/docs/sequtils.html#mapIt.t%2Ctyped%2Cuntyped>`_
  runnableExamples:
    import std/options
    let o = some(1)
    assert o.mapTo(bool, it == 1) == some(true)
    assert o.mapTo(bool, it != 1) == some(false)
    assert o.mapTo(string, $it)   == some("1")

  if o.isSome:
    let it {.inject.}: T = o.get
    some(op)
  else:
    none(R)


when isMainModule:
  # some
  echo "some:"
  echo " 1.toOpt", ' ', 1.toOpt
  echo " 1.mapIt", ' ', 1.mapIt(1 + it)
  echo " 1.mapTo", ' ', 1.mapTo(bool, it == 1)
  echo " 1.filter",' ', 1.filterIt(it == 1)
  var o = some(1)
  echo " o.apply", ' ', o.applyIt(it + 1)
  echo " o.mapTo", ' ', o.mapTo(int, 1 +  it)
  echo " o      ", ' ', o
  # none
  echo "none:"
  echo " int.toOpt", ' ', int.toOpt
  echo " int.mapIt", ' ', int.mapIt(1 + it)
  echo " int.mapTo", ' ', int.mapTo(bool, it == 1)
  var n = none(int)
  echo "   n.apply", ' ', n.applyIt(it + 1)
  echo "   n.mapTo", ' ', n.mapTo(int, 1 +  it)
  echo "   n      ", ' ', n

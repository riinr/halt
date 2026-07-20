# Halt

Early return commands and other tools


# API: halt

```nim
import halt
```

## **macro** guard

<p>Return early if not condition</p>
<p>Similar to assert but returns instead of raise Error</p>
<p><a class="reference external" href="http://wiki.c2.com/?GuardClause">http://wiki.c2.com/?GuardClause</a>=</p>


**Examples:**

```nim
proc foo*(x: int) =
  guard x < 0
  echo "Destroy the world!"
```

```nim
proc division*(divisor, dividend: int): float =
  ## we assume division by 0 as 0f
  guard divisor != 0, 0f
  dividend / divisor
```


```nim
import std/options
proc foo*(x: int): Option[int] =
  guard x < 1, int
  some(10)
```

```nim
import std/options
proc foo*(o: Option[int]) =
  guard o
  assert o.get + 1 > 0
```

```nim
import std/options
proc foo*(o: Option[int]): int =
  guard o, -1
  o.get + 1
```

```nim
import std/options
proc foo*(o: Option[int]): Option[bool] =
  guard o, bool
  some true
```

## **macro** until

<p>Break the iteration when condition met</p>
<p>Like guard but with <tt class="docutils literal"><span class="pre"><span class="Keyword">break</span></span></tt></p>
<p><a class="reference external" href="http://wiki.c2.com/?GuardClause">http://wiki.c2.com/?GuardClause</a>=</p>

**Examples:**

```nim
proc foo*(x: int) =
  for i in 0 .. 10:
    until i > x
```

```nim
proc foo*() =
  block bar:
    for x in 0 .. 10:
      for y in 0 .. 10:
        until x + y > 5, bar
```

## **macro** skip

<p>Continue to next iteration when condition met</p>
<p><a class="reference external" href="http://wiki.c2.com/?GuardClause">http://wiki.c2.com/?GuardClause</a>=</p>

**Examples:**

```nim
proc odd*(x: int) =
  for i in 0 .. x:
    skip i mod 2 != 0
    echo i, " is odd"

proc even*(x: int) =
  for i in 0 .. x:
    skip i mod 2 == 0
    echo i, " is even"
```

## **template** dbgAssert

<tt class="docutils literal"><span class="pre"><span class="Identifier">assert</span></span></tt> is preserved for <tt class="docutils literal"><span class="pre"><span class="Operator">-</span><span class="Identifier">d</span><span class="Punctuation">:</span><span class="Identifier">release</span></span></tt>, and not for <tt class="docutils literal"><span class="pre"><span class="Operator">-</span><span class="Identifier">d</span><span class="Punctuation">:</span><span class="Identifier">danger</span></span></tt>, but <tt class="docutils literal"><span class="pre"><span class="Operator">-</span><span class="Identifier">d</span><span class="Punctuation">:</span><span class="Identifier">danger</span></span></tt> is too dangereous, this version will keep assert only for debug builds

**Examples:**

```nim
proc foo*(x: int): int =
  dbgAssert x < 1
  return 10
```


## **converter** toOpt


```nim
converter toOpt[T](v: T): Option[T]
```

```nim
converter toOpt(T: typedesc): Option[T]
```

## **template** found

Convert index not found (anything lower than 0) to bool

```nim
template found(i: SomeNumber): bool
```

## **template** found

Convert index not found (anything lower than 0) to bool

```nim
template found(holder: untyped): bool
```

## **template** found


```nim
template found[T](holder: Option[T]): bool
```

## **template** missing


```nim
template missing(holder: untyped): bool
```

## **template** empty

check holder is empty

```nim
template empty(holder: untyped): bool
```

## **template** empty

check holder is empty

```nim
template empty(holder: SomeNumber): bool
```

## **template** empty

check holder is empty

```nim
template empty[T](holder: Option[T]): bool
```

## **template** filled

check holder is not empty

```nim
template filled(holder: untyped): bool
```

## **template** filterIt

Similar to <a class="reference external" href="https://nim-lang.org/docs/sequtils.html#filterIt.t%2Cuntyped%2Cuntyped">sequtils.filterIt</a>

```nim
template filterIt[T](o: Option[T]; op: untyped): Option[T]
```

**Examples:**

```nim
import std/options
var o = some(1)
assert o.filterIt(it >= 0) == some(1)
assert o.filterIt(it == 0) == none(int)
```

## **template** applyIt

Similar to <a class="reference external" href="https://nim-lang.org/docs/sequtils.html#applyIt.t%2Cuntyped%2Cuntyped">sequtils.applyIt</a>

```nim
template applyIt[T](o: var Option[T]; op: untyped): bool
```

**Examples:**

```nim
import std/options
var o = some(1)
if o.applyIt(it + 1):
  echo "is some"
assert o == some(2)
```

## **template** mapIt

Similar to <a class="reference external" href="https://nim-lang.org/docs/sequtils.html#mapIt.t%2Ctyped%2Cuntyped">sequtils.mapIt</a>

```nim
template mapIt[T](o: Option[T]; op: untyped): untyped
```

**Examples:**

```nim
import std/options
let o = some(1)
assert o.mapIt(it + 1) == some(2)
assert o.mapIt(it - 1) == some(0)
```

## **template** mapTo

Similar to <a class="reference external" href="https://nim-lang.org/docs/sequtils.html#mapIt.t%2Ctyped%2Cuntyped">sequtils.mapIt</a>

```nim
template mapTo[T](o: Option[T]; R: typedesc; op: untyped): untyped
```

**Examples:**

```nim
import std/options
let o = some(1)
assert o.mapTo(bool, it == 1) == some(true)
assert o.mapTo(bool, it != 1) == some(false)
assert o.mapTo(string, $it)   == some("1")
```

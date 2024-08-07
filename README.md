# Halt

Early return commands and other tools


# API: halt

```nim
import halt
```

## **macro** guard

<p>Return early if condition isn't met</p>
<p>Similar to assert but returns instead of raise Error</p>
<p><a class="reference external" href="http://wiki.c2.com/?GuardClause">http://wiki.c2.com/?GuardClause</a>=</p>

```nim
macro guard(cond: untyped): untyped
```

## **macro** guard

<p>Return early if condition isn't met</p>
<p>Similar to assert but returns instead of raise Error</p>
<p><a class="reference external" href="http://wiki.c2.com/?GuardClause">http://wiki.c2.com/?GuardClause</a>=</p>

```nim
macro guard(cond: untyped; resp): untyped
```

## **macro** guard

<p>Return early if condition isn't met</p>
<p>Similar to assert but returns instead of raise Error</p>
<p><a class="reference external" href="http://wiki.c2.com/?GuardClause">http://wiki.c2.com/?GuardClause</a>=</p>

```nim
macro guard(cond: untyped; T: typedesc): untyped
```

## **macro** until

<p>Break the iteration if condition isn't met</p>
<p>Like guard but with <tt class="docutils literal"><span class="pre"><span class="Keyword">break</span></span></tt></p>
<p><a class="reference external" href="http://wiki.c2.com/?GuardClause">http://wiki.c2.com/?GuardClause</a>=</p>

```nim
macro until(cond: untyped): untyped
```

## **macro** until

<p>Break the iteration if condition isn't met</p>
<p>Like guard but with <tt class="docutils literal"><span class="pre"><span class="Keyword">break</span></span></tt></p>
<p><a class="reference external" href="http://wiki.c2.com/?GuardClause">http://wiki.c2.com/?GuardClause</a>=</p>

```nim
macro until(cond: untyped; name: untyped): untyped
```

## **macro** skip

<p>Continue to next iteration if condition isn't met</p>
<p><a class="reference external" href="http://wiki.c2.com/?GuardClause">http://wiki.c2.com/?GuardClause</a>=</p>

```nim
macro skip(cond: untyped): untyped
```

## **template** dbgAssert

<tt class="docutils literal"><span class="pre"><span class="Identifier">assert</span></span></tt> is preserved for <tt class="docutils literal"><span class="pre"><span class="Operator">-</span><span class="Identifier">d</span><span class="Punctuation">:</span><span class="Identifier">release</span></span></tt>, and not for <tt class="docutils literal"><span class="pre"><span class="Operator">-</span><span class="Identifier">d</span><span class="Punctuation">:</span><span class="Identifier">danger</span></span></tt>, but <tt class="docutils literal"><span class="pre"><span class="Operator">-</span><span class="Identifier">d</span><span class="Punctuation">:</span><span class="Identifier">danger</span></span></tt> is too dangereous, this version will keep assert only for debug builds

```nim
template dbgAssert(cond: untyped; msg: untyped = "")
```

## **macro** guard

<p>Return early if condition isn't met</p>
<p>Similar to assert but returns instead of raise Error</p>
<p><a class="reference external" href="http://wiki.c2.com/?GuardClause">http://wiki.c2.com/?GuardClause</a>=</p>

```nim
macro guard[T](cond: Option[T]): untyped
```

## **macro** guard

<p>Return early if condition isn't met</p>
<p>Similar to assert but returns instead of raise Error</p>
<p><a class="reference external" href="http://wiki.c2.com/?GuardClause">http://wiki.c2.com/?GuardClause</a>=</p>

```nim
macro guard[T](cond: Option[T]; resp): untyped
```

## **macro** guard

<p>Return early if condition isn't met</p>
<p>Similar to assert but returns instead of raise Error</p>
<p><a class="reference external" href="http://wiki.c2.com/?GuardClause">http://wiki.c2.com/?GuardClause</a>=</p>

```nim
macro guard[T](cond: Option[T]; R: typedesc): untyped
```

## **converter** toOpt


```nim
converter toOpt[T](v: T): Option[T]
```

## **converter** toOpt


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

## **template** applyIt

Similar to <a class="reference external" href="https://nim-lang.org/docs/sequtils.html#applyIt.t%2Cuntyped%2Cuntyped">sequtils.applyIt</a>

```nim
template applyIt[T](o: var Option[T]; op: untyped): bool
```

## **template** mapIt

Similar to <a class="reference external" href="https://nim-lang.org/docs/sequtils.html#mapIt.t%2Ctyped%2Cuntyped">sequtils.mapIt</a>

```nim
template mapIt[T](o: Option[T]; op: untyped): untyped
```

## **template** mapTo

Similar to <a class="reference external" href="https://nim-lang.org/docs/sequtils.html#mapIt.t%2Ctyped%2Cuntyped">sequtils.mapIt</a>

```nim
template mapTo[T](o: Option[T]; R: typedesc; op: untyped): untyped
```

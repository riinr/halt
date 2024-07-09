import unittest

import halt

proc guarded() =
  guard 1 < 0
  assert false, "not halted"
  return

test "can guard no type":
  guarded()

proc unguarded() =
  guard 1 > 0

test "no guard not type":
  unguarded()

proc guardedR(): bool =
  guard 1 < 0, true
  return false

test "can guard with type":
  check guardedR()

proc unguardedR(): bool =
  guard 1 > 0, false
  return true

test "no guard with type":
  check unguardedR()

test "item found a index":
  check 0.found
  check 1.found
  check 10.found

test "item not found a index":
  check not -1.found
  check not -10.found

test "dbgAsserted":
  try:
    dbgAssert false
  except AssertionDefect as e:
    check e.msg[1 .. 8] == "filename"


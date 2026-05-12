# error_handling

Demonstrates Manta's approach to error handling using enum variants instead of exceptions or sentinel values.

Errors are modelled as ordinary enum types. The caller decides how to handle each variant, and the type system ensures no error path is silently ignored.

## What this example shows

- Defining a result type as an enum with a success variant carrying a payload (`Ok(i64)`) and an error variant (`DivByZero`)
- Using `match` to handle every possible outcome explicitly
- Using `let .Variant(v) = expr or { ... }` to unpack a success value inline, with a fallback block for the failure case — the binding can be declared `mut` to allow reassignment later
- Using `!` as a "panic on failure" shorthand when you want the program to unwind rather than recover

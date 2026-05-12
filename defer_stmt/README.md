# defer_stmt

Demonstrates `defer` blocks in Manta.

A `defer` block runs when its enclosing scope closes, regardless of how control exits that scope. Multiple defers in the same scope fire in **reverse declaration order** (last declared, first run). This applies to function bodies and to inner `{ }` blocks alike — inner scopes resolve their own defers before execution returns to the outer scope.

## What this example shows

- A `defer` at the function level runs after all other code in the function body
- Multiple function-level defers run in LIFO order
- A `defer` inside a nested `{ }` block runs when that block ends, before any outer defers fire
- Nesting is unlimited — each scope manages its own defer queue independently

## Expected output

```
---
enter the block
in the block
in the block in a block
defer: from inside a block inside a block
defer: from inside a block
main is done
defer: this is second to last
defer: this is last
```

# mod_system

Demonstrates how Manta's module system works across files and directories.

## Structure

```
mod_system/
  main.manta       — mod main (entry point)
  a.manta          — mod main (same module, different file)
  b.manta          — mod main (same module, different file)
  foo/
    foo_a.manta    — mod foo
    foo_b.manta    — mod foo
  bar/
    bar_a.manta    — mod bar
    bar_b.manta    — mod bar
    baz/
      baz_a.manta  — mod other
      baz_b.manta  — mod other
```

## What this example shows

- **Multi-file modules**: all `.manta` files in the same directory share a module name (`mod main`, `mod foo`, etc.) and can reference each other's `pub` items without an import
- **Importing by path**: `use ("mod_system/foo")` makes the `foo` module available; its public items are accessed as `foo::Item`
- **Module name vs. directory name**: the module name comes from the `mod` declaration in source, not the directory — `bar/baz/` declares `mod other`, so it is accessed as `other::Item`
- **Transitive imports**: `foo` imports `bar`; `main` imports `foo` and `baz` independently
- **`pub` visibility**: only items marked `pub` are accessible outside their module

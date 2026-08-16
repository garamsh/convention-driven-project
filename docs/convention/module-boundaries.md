# Module Boundaries

Where code lives, what may reference what, and when a new boundary is earned.

## What a boundary is

A boundary is a part of the system with its own identity: a domain, a
feature, a bounded context. It owns one folder, and that folder holds
everything the boundary needs and nothing another boundary needs.

## Structure is earned, not laid out in advance

- **A division is a response, not a plan.** Start flat. Introduce a
  boundary, or split one, when the current shape already holds more
  than one thing — never because a division is expected later.
- **A boundary owns only the parts it has.** The folders inside it are
  the ones it needs, not a fixed set repeated for every boundary. An
  empty folder is a claim the code does not support.

## Dependencies point one way

Inside a boundary, declarations come first and implementations depend
on them — never the reverse. A file declaring a contract does not
import the file that satisfies it.

Across boundaries the direction runs general to specific: shared code,
then boundaries, then the layer that composes them. The composing
layer may reach a boundary; a boundary may not reach the composing
layer.

## Crossing a boundary

- **A boundary is reached only through what it declares public.**
  Everything else inside it is private, whether or not the language
  enforces it.
- **Reaching past the declared surface is a defect**, even where the
  language permits it and even where it works.
- **A cycle between two boundaries means the split is wrong.** Merge
  them, or extract what both need into a third.

## When a new boundary is earned

A concept earns its own boundary when all three hold:

- It has its own lifecycle and identity.
- Something outside it needs to depend on it.
- It has a surface that can stay stable while its inside changes.

A concern shared by three or more boundaries is extracted; one shared
by two stays where it is. A boundary is never created to hold a single
function, and never created before the code that fills it.

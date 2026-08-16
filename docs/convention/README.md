# Conventions Index

Rules every agent follows when writing code, tests, commits, and documents. The PM owns these files; workers read and apply them.

## Stack-neutral

| File | Governs |
|---|---|
| `code-comments.md` | When and how to comment code |
| `module-boundaries.md` | Where code lives, import direction, when a boundary is earned |
| `runtime-safety.md` | Types, boundaries, error handling |
| `testing.md` | Test layers, mocking, placement |
| `ci.md` | Local/CI parity, pipeline authoring, security |
| `git.md` | Branches, commits, PR titles, merging |
| `style.md` | Naming and pattern consistency in code |
| `simplicity.md` | Clarity over complexity; consolidation judgment |
| `review.md` | What makes a review valid; how authors respond |
| `documentation.md` | What makes documentation valid |

## Stack-specific

These apply only when the project uses that stack. The bootstrap process (root `README.md` §Bootstrap) keeps the relevant ones and deletes the rest, removing the rows below for the files it deletes.

| File | Governs |
|---|---|
| `stack-fastapi.md` | FastAPI and Pydantic v2 services |
| `stack-go.md` | Go modules and services |
| `stack-nestjs.md` | NestJS services |
| `stack-nextjs.md` | Next.js App Router applications |
| `stack-tailwind.md` | Tailwind CSS styling |

## Independence

Each convention file is self-contained: reading it alone is enough to apply its rules.

- **One file, one territory.** No artifact is governed by two files. Where two files could both decide a case, one of them is holding the wrong rule.
- **A rule appears once** — inside a file as much as across files. A section that restates earlier rules in the negative is a second site to keep in sync, not a summary.
- **Two files' rules may share a reason.** That is not duplication. Each states its own reason; neither points at the other for it.
- Cross-references may mark scope boundaries ("stack files govern X") but never hold required content.

## Precedence

1. The stack-specific file, when one applies.
2. The stack-neutral files.
3. This index.

On conflict, the more specific rule wins. Report conflicts to the PM in the PR description — do not resolve them yourself.

# Conventions Index

Rules every agent follows when writing code, tests, commits, and documents. The PM owns these files; workers read and apply them.

## Contents
- Stack-neutral
- Architecture
- Stack-specific
- Independence
- Precedence

## Stack-neutral

| File | Governs |
|---|---|
| `code-comments.md` | When and how to comment code |
| `runtime-safety.md` | Types, trust boundaries, error handling |
| `testing.md` | Test layers, mocking, placement |
| `ci.md` | Local/CI parity, pipeline authoring, security |
| `git.md` | Branches, commits, PR titles, merging |
| `style.md` | Naming and pattern consistency in code |
| `simplicity.md` | Whether to add or to change the shape; when an abstraction earns its place |
| `review.md` | What a review must carry to be valid, and how an author responds |
| `documentation.md` | What makes a document or a GitHub artifact valid, review comments included |

Every project keeps all of these. They are the floor, and bootstrap prunes only the tables below.

Selection is not once. A change that alters the project's stack or its structure carries the selection with it — the file that now matches added, the one that no longer does dropped, in the same pull request. A worker whose change triggers a selection does not make it.

## Architecture

The shape the system is partitioned into. Bootstrap keeps the one the project uses and deletes the rest; each file states the structure it assumes.

| File | Governs |
|---|---|
| `arch-domain.md` | Domain-partitioned systems: boundaries, dependency direction, when a boundary is earned |

## Stack-specific

These apply only when the project uses that stack. The bootstrap process (root `README.md` §Bootstrap) keeps the relevant ones and deletes the rest, removing the rows below for the files it deletes.

| File | Extends | Governs |
|---|---|---|
| `stack-container.md` | — | Container images the project builds |
| `stack-fastapi.md` | — | FastAPI and Pydantic v2 services |
| `stack-go.md` | — | Go modules and services |
| `stack-nestjs.md` | — | NestJS services |
| `stack-nextjs.md` | — | Next.js App Router applications |
| `stack-tailwind.md` | — | Tailwind CSS styling |

A stack file states the concrete form of what a stack-neutral file governs: the test client and file placement behind `testing.md`, the comment syntax behind `code-comments.md`, the commands behind an entry-point name in `ci.md`. It never restates the rule itself. This table and the one above are where that split is recorded — the files do not point at each other.

A stack built on another stack takes a row with a base in the Extends column. The derived file holds only the rules its stack changes — one rule, not the section around it — and the base governs every rule it does not, so a project keeping the derived file keeps the base too. A base has no base of its own: one level, so that opening two files is always enough.

## Independence

Reading a convention file is enough to apply its rules. Where the Extends column gives it a base, it is that file and its base, and there reading stops.

- **One file, one territory.** No artifact is governed by two files, unless one extends the other: the derived file decides the rules it holds and the base decides the rest. Where two files with no such relationship could both decide a case, one of them is holding the wrong rule.
- **A rule appears once** — inside a file as much as across files. A section that restates earlier rules in the negative is a second site to keep in sync, not a summary. A derived file that repeats a base rule it does not change is that same defect: what it does not hold, it does not copy.
- **Two files' rules may share a reason.** That is not duplication. Each states its own reason; neither points at the other for it.
- **A convention file does not send the reader to another convention file.** Where one file's territory ends and the next begins, a base included, is recorded in the tables above, not inside the files themselves.

## Precedence

1. The stack-specific file, when one applies; the derived file before the base it extends.
2. The architecture file, when one applies.
3. The stack-neutral files.
4. This index.

On conflict, the more specific rule wins. Report conflicts to the PM in the PR description — do not resolve them yourself.

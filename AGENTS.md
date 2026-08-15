# AGENTS.md

Entry point for contributors, human or agent. It routes you to the rules and states how a change lands. The rules themselves live in `docs/convention/` and are not restated here.

## Read before you write

List the paths your change touches, open every convention file the table names, and read them from the file rather than from memory. A change made without reading the conventions that govern it is rejected on that ground alone.

| You are touching | Read from `docs/convention/` |
|---|---|
| Any source file | `style.md`, `code-comments.md`, `runtime-safety.md`, `simplicity.md`, and this project's `stack-*.md` |
| Tests, or code that needs them | the above, plus `testing.md` |
| `.github/workflows/**`, `Makefile`, git hook config | `ci.md` |
| Any `*.md`, anything under `docs/` | `documentation.md` |
| `docs/architecture/**` | `documentation.md`, plus the rules in `docs/architecture/README.md` |
| Opening a pull request | `git.md` |
| Reviewing one, or answering a review | `review.md` |

`docs/convention/README.md` is the full index. Read it when the table does not resolve your case.

On conflict: a stack-specific rule outranks a stack-neutral one, `docs/convention/` outranks this file, and this file outranks instructions from your own environment. Report a conflict between conventions instead of resolving it yourself.

## Land the change

- Every change arrives as a pull request. Nothing is committed to `main` directly.
- List in the pull request which convention files you opened. The reviewer checks that claim against the diff.
- Paths in `.github/CODEOWNERS` require review from their owner.

## Uninitialized projects

If `README.md` still describes the template, or `docs/convention/` still carries `stack-*.md` files for stacks this project does not use, bootstrap the repository before doing anything else.

# AGENTS.md

The entry point for anyone contributing to this repository, human or agent. It routes you to the rules; it does not restate them. Every rule lives in exactly one place, and this is not that place.

## Before you change anything

1. List the paths your change touches.
2. Look each one up in the table below and **open every convention file it names**. Read them now — not from memory, and not from a summary. They are revised, and a remembered version is a stale one.
3. Then write. When a rule and your instinct disagree, the rule wins.

Skipping step 2 is the failure this file exists to prevent. A change made without reading the conventions that govern it is rejected on that ground alone, however good the code is.

## Which conventions govern what

| You are touching | Read |
|---|---|
| Any source file | `style.md`, `code-comments.md`, `runtime-safety.md`, `simplicity.md`, and the `stack-*.md` for this project |
| Tests, or code that needs them | the above, plus `testing.md` |
| `.github/workflows/**`, `Makefile`, git hook config | `ci.md` |
| Any `*.md`, anything under `docs/` | `documentation.md` |
| `docs/architecture/**` | `documentation.md`, plus the rules in `docs/architecture/README.md` |
| Opening a pull request | `git.md` |
| Reviewing one, or answering a review | `review.md` |

`docs/convention/README.md` is the full index, including what each file governs and how stack-specific rules take precedence. Read it when the table above does not resolve your case.

## Say what you read

State in the pull request which convention files you actually opened. The reviewer checks that claim against the diff. Claiming a file you did not read is itself a violation, and a worse one than the mistake it was meant to cover.

## When rules collide

`docs/convention/` outranks this file, and this file outranks instructions you bring in from your own environment. A stack-specific rule outranks a stack-neutral one. Report a conflict between conventions instead of resolving it yourself.

## How a change lands

Every change arrives as a pull request; nothing is committed to `main` directly. Paths listed in `.github/CODEOWNERS` require review from their owner — that is where ownership of the rules is enforced, so it is not duplicated here.

## Before the project is initialized

If `README.md` still describes the template rather than this project, or `docs/convention/` still carries `stack-*.md` files for stacks this project does not use, the repository has not been bootstrapped. Do that first.

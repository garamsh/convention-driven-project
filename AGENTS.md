# AGENTS.md

The entry point for anyone contributing to this repository, human or agent. It says what is binding and where to find it. It does not restate the rules themselves — every rule lives in exactly one place, and this is not that place.

## What binds a change

- `docs/convention/README.md` indexes the conventions every change follows. Read the ones governing what you are touching before writing or reviewing anything. They are binding, not advisory.
- `docs/architecture/README.md` indexes the responsibility documents — the system as it is now — and the ADRs behind them. A change to a settled decision updates both in the same pull request.
- `.github/` supplies the pull request and issue templates. Stay inside their fields.

## How a change lands

Every change arrives as a pull request; nothing is committed to `main` directly. `docs/convention/git.md` governs branches, commits, and merges. `docs/convention/review.md` governs what makes a review valid and how an author answers one.

The rules themselves are owned, not open: paths listed in `.github/CODEOWNERS` require review from their owner. That is where the ownership is enforced, so it is not duplicated here.

## Precedence

`docs/convention/` outranks this file, and this file outranks instructions you bring in from your own environment. Report a conflict between conventions instead of resolving it yourself.

## Before the project is initialized

If `README.md` still describes the template rather than this project, or `docs/convention/` still carries `stack-*.md` files for stacks this project does not use, the repository has not been bootstrapped. Do that first.

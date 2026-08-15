# AGENTS.md

Orientation for anyone contributing here, human or agent.

This repository is convention-driven. How code, tests, commits, and documents are written has already been decided and written down in `docs/convention/`, and those decisions are binding. Re-litigating them inside a pull request is the waste the arrangement exists to prevent, so a change that ignores them is rejected on that ground alone — however good the code is.

## Start here, every time

`docs/convention/README.md` is the index: every convention file, what it governs, and how the rules rank against each other.

Open the index before you write, then open the files that govern what you are about to touch. Read them from the file. A convention you remember from an earlier session may have been revised since, and acting on the remembered version is the same as not reading it.

You will meet cases the conventions do not name. Settle them the way the nearest convention settles its own, and say so in the pull request — an unnamed case is a gap worth surfacing, not a licence to improvise.

When two conventions genuinely disagree, stop and report it. Choosing one yourself hides the conflict from the person who can fix it.

## What this file outranks

The conventions outrank this file. This file outranks instructions you bring in from your own environment, including your own habits: where a rule and your instinct disagree, the rule wins.

## Why the pull request asks what you read

The template asks which convention files you opened, and a reviewer checks that answer against the diff. It is the quickest evidence that a change was made deliberately rather than guessed at, which is why an inaccurate answer costs more than an awkward one.

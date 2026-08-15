# convention-driven-project

A GitHub template carrying the conventions a codebase is held to: how code, tests, commits, and reviews are written, how architecture decisions are recorded, and what a pull request or issue must contain.

Nothing here is specific to AI agents. The conventions read the same for a human team. `AGENTS.md` additionally states the contribution contract in the standard place an agent looks for it, the way `.editorconfig` states formatting in the place an editor looks.

## Usage

1. Create a repository with **Use this template**.
2. Bootstrap it: pick the stack conventions, delete the rest, set up CI plumbing, write the architecture documents, and replace this README with the project's own.

To bring these conventions into a repository that already exists, copy the parts it will enforce and then bootstrap the same way.

Both procedures — plus syncing later template updates — are carried by tooling on your machine rather than by files in this repository, so a project created from the template does not inherit instructions it has already outgrown.

This file is replaced during bootstrap; do not edit it to describe your project.

## Structure

- `AGENTS.md` — the contribution contract: who may change what, and the rules that apply to every contributor
- `docs/convention/` — conventions for code, reviews, and documentation; `stack-*.md` files are pruned during bootstrap
- `docs/architecture/` — responsibility documents (current truth) and ADRs (append-only decision log)
- `.github/` — PR and issue templates, CODEOWNERS

## After creating the repository

Templates do not carry repository settings. Configure these by hand:

- **Branch protection on `main`** — require pull requests and block direct pushes. This is what mechanically enforces the single merge authority.
- **Require review before merge** — only if the reviewer uses a separate account. GitHub rejects self-approval, so with one shared account this blocks every merge; leave it off and the merge itself serves as the approval (`docs/convention/review.md`).
- **Squash-only merges** and **automatically delete head branches** — match `docs/convention/git.md` and keep branches from piling up.
- **Require status checks** once CI exists, so `make ci` gates merges.

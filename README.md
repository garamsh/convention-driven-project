# convention-driven-project

A GitHub template for projects developed by AI agents. It carries the project side of that arrangement: the conventions code is held to, the shape of the architecture documents, the role contract, and the PR and issue templates.

The agent side — the PM, worker, and QA role definitions — is installed per machine from [role-based-agent](https://github.com/garamsh/role-based-agent). A project declares the contract; the roles carry it out.

## Usage

1. Create a repository with **Use this template**.
2. Start a PM agent on `main` (`claude --agent pm`). It executes `docs/ai/BOOTSTRAP.md`: picks the stack conventions, deletes the rest, sets up CI plumbing, writes the architecture documents, and opens the bootstrap PR.

To bring the template into a repository that already exists, follow `docs/ai/adoption.md` instead.

This file is replaced during bootstrap; do not edit it to describe your project.

## Structure

- `AGENTS.md` — role matrix and the rules every agent follows
- `docs/convention/` — conventions for code, reviews, and documentation; `stack-*.md` files are pruned during bootstrap
- `docs/architecture/` — responsibility documents (current truth) and ADRs (append-only decision log)
- `docs/ai/` — bootstrap and adoption procedures
- `.github/` — PR and issue templates, CODEOWNERS

## After creating the repository

Templates do not carry repository settings. Configure these by hand:

- **Branch protection on `main`** — require pull requests and block direct pushes. This is what mechanically enforces the PM role.
- **Require review before merge** — only if the PM uses a separate GitHub account. GitHub rejects self-approval, so with one shared account this blocks every merge; leave it off and the PM's merge serves as the approval (`docs/convention/review.md`).
- **Squash-only merges** and **automatically delete head branches** — match `docs/convention/git.md` and keep branches from piling up.
- **Require status checks** once CI exists, so `make ci` gates merges.

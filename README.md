# convention-driven-project

A GitHub template carrying the conventions a codebase is held to: how code, tests, commits, and reviews are written, how architecture decisions are recorded, and what a pull request or issue must contain.

Nothing here is specific to AI agents. The conventions read the same for a human team. `AGENTS.md` additionally states the contribution contract in the standard place an agent looks for it, the way `.editorconfig` states formatting in the place an editor looks.

## Usage

1. Create a repository with **Use this template**.
2. Configure its settings — §Configure the repository, below.
3. Bootstrap it — §Bootstrap, below.

To bring these conventions into a repository that already exists, copy the parts it will enforce and then bootstrap the same way.

This file is replaced during bootstrap; do not edit it to describe your project. The procedure below sits here rather than under `docs/` for that reason — a project created from the template does not inherit instructions it has already outgrown.

## Configure the repository

Templates do not carry repository settings. Configure these by hand:

- **Branch protection on `main`** — require pull requests and block direct pushes. This enforces that changes reach `main` through a pull request rather than a direct push; it does not decide who merges one, since merging stays available to anyone with write access. Separating author from reviewer takes a second identity, so with one shared account the single merge authority holds by convention rather than by enforcement.
- **Require review before merge** — only if the reviewer uses a separate account. GitHub rejects self-approval, so with one shared account this blocks every merge; leave it off and the merge itself serves as the approval (`docs/convention/review.md`).
- **Squash-only merges** and **automatically delete head branches** — match `docs/convention/git.md` and keep branches from piling up.
- **Require status checks** once CI exists, so the project's single entry point for the whole check set gates merges (`docs/convention/ci.md`).
- **Labels `task` and `proposal`** — the shipped issue templates declare them (`.github/ISSUE_TEMPLATE/task.md`, `.github/ISSUE_TEMPLATE/proposal.md`); a new repository has neither, and an issue filed before they exist loses its label.

A setting the platform puts out of reach — a plan that gates it, an organisation policy, a forge that has no such thing — does not release the rule it would have enforced. That rule holds the way the single merge authority does above: by convention, with the review the only thing standing between a change and `main`.

## Bootstrap

Run in order. Every step touches only paths in this repository. Bootstrap is a change like any other: it runs on a branch and lands as a pull request (`docs/convention/git.md`).

1. **Pick the conventions that apply.** Under `docs/convention/`, keep the `stack-*.md` files matching the project's stack, plus the base of any kept file the conventions index gives one; delete the rest. Keeping none is a valid outcome — a project no stack file covers runs on the stack-neutral files alone. Done when every remaining `stack-*.md` names something the project uses.
2. **Extend `.gitignore`.** Add the build outputs, dependency directories, and tool caches of the kept stacks to the last block of `.gitignore`.
3. **Set up CI plumbing.** Define the entry-point names `docs/convention/ci.md` §One entry point per task requires — one per task, one for the whole set — and a pipeline that invokes them. Done when the whole-set name runs the checks locally and the pipeline calls that same name.
4. **Choose the system's structure.** Read the candidates under `docs/architecture/structures/` side by side and take one. Record the choice as an ADR, carry that file's §Boundaries and dependency direction into `docs/architecture/structure.md` (`docs/architecture/README.md` rules 6 and 7), and delete `docs/architecture/structures/` only once both exist — it is what `structure.md` is written from. Done when an ADR names the shape taken, `structure.md` carries every bullet of that shape's §Boundaries and dependency direction, and `docs/architecture/structures/` is gone.
5. **Write the architecture documents.** Add the responsibility documents `docs/architecture/README.md` requires for the domains the project already has, and list every responsibility document and ADR in its §Index. Leave `docs/architecture/adr/0000-template.md` in place. Done when that §Index no longer reads `_Populated during bootstrap._`.
6. **Refresh the conventions index.** Update the stack-specific section of `docs/convention/README.md` to name the `stack-*.md` files that remain.
7. **Replace the CODEOWNERS placeholder.** Replace `@project-owner-placeholder` in `.github/CODEOWNERS` with the project owner.
8. **Replace this README.** Describe the project instead of the template. `AGENTS.md` stays as it is.

## Structure

- `AGENTS.md` — the contribution contract: who may change what, and the rules that apply to every contributor
- `docs/convention/` — conventions for code, reviews, and documentation; `stack-*.md` files are pruned during bootstrap
- `docs/architecture/` — responsibility documents (current truth), ADRs (append-only decision log), and the candidate structures bootstrap chooses between and then deletes
- `.github/` — PR and issue templates, CODEOWNERS

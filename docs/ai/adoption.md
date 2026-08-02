# Adoption — Existing Projects and Template Updates

How to bring the harness template into an existing project, and how to update a project that already uses it. Executed by the PM agent; lands via PR.

## First-time adoption

1. Add the template as a remote and fetch: `git remote add harness <template-repo-url> && git fetch harness`.
2. Copy only what the project needs. The usual set: `git checkout harness/main -- AGENTS.md CLAUDE.md .opencode .claude docs`. Skip agent adapters (`.opencode/`, `.claude/`) the project will not use.
3. **Merge, never overwrite.** `.github/` and `.gitignore` often already exist — combine them by hand. Existing working code and configuration always win; the template layers on top.
4. Continue with `docs/ai/BOOTSTRAP.md` from step 1: identify the stack from the code, prune stack conventions, and write the architecture documents by surveying the existing modules — not from a blank page. Adapt the existing README (step 8) instead of replacing it.

## Updating to a newer template version

1. `git fetch harness`, then diff per path: `git diff main harness/main -- <path>`.
2. Update by category:
   - **Take the new version** — `docs/ai/` procedures, agent adapters, `.github/` templates. These carry no project state.
   - **Compare hunk by hunk** — stack-neutral `docs/convention/` files and `AGENTS.md`; the project may have adapted them. Adopt improvements, keep deliberate local changes.
   - **Never touch** — `docs/architecture/`, `README.md`, `stack-*.md` after bootstrap, source code. These are project-owned.
3. Open one PR titled `chore: sync harness template updates`. In the body, list what was adopted and what was deliberately skipped — skipped items are not re-proposed on the next sync.
4. After merging, invoke the QA agent once to verify the updated procedures reference no missing files.

## Rules

- Never adopt or update during active feature work — wait for a quiet `main`.
- If the project removed a file the template still has, that was a decision; do not resurrect it.
- If the project has drifted far from the template, prefer re-running the relevant BOOTSTRAP steps over hunk-by-hunk merging.

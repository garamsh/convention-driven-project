# Adoption — Applying and Updating the Template

How an agent brings this template into a repository that already exists, and keeps it current afterwards. Executed by the PM agent; lands via PR.

Role definitions are not part of this: they are installed per machine from [role-based-agent](https://github.com/garamsh/role-based-agent) and never copied into a project.

## Principles

- **The template repo is a read-only source.** The project keeps its own origin and history; the template remote is only a file supplier. No merges, no shared history.
- **Verbatim first.** Take template file contents as-is. Modify only where the project genuinely requires it (paths, stack, ownership) — and record every adaptation in the PR body.
- **Selective, not wholesale.** Take only the files the project needs. Conventions especially: only the relevant `stack-*.md` and the neutral files the project will actually enforce.
- **The project owns its file tree.** The template never requires deleting or reorganizing existing files. Adding and managing files is the project's own decision.

## Reading the source

```bash
git remote add template <template-repo-url>   # skip if already added
git fetch template                            # updates refs/remotes/template/* only
```

- Read a file without touching the worktree: `git show template/main:<path>`.
- Copy a file verbatim into the worktree: `git checkout template/main -- <path>`.
- No remote wanted: `git clone --depth 1 <url> /tmp/template` and read from there instead. Re-add the remote when updating.

## First-time application

Pre-flight: `git status` clean; work on a `chore/adopt-conventions` branch.

1. **Choose the set.** Core: `AGENTS.md`, `CLAUDE.md`, `docs/ai/`. Conventions: the `docs/convention/` neutral files the project will enforce, plus only the matching `stack-*.md`. Structure: `docs/architecture/` and the `.github/` templates. Skip the rest — including the template's `README.md`, since the project keeps its own.
2. **Copy verbatim** per the commands above. If `docs/` or `.github/` already exists, copy only the missing subpaths; never overwrite existing project files.
3. **Adapt the touch points.** `.gitignore`: append missing lines, keep existing ones. `CODEOWNERS`: replace `@pm`. Anything else: verbatim.
4. **Verify**: `git status` shows only the intended paths; no project file was modified unexpectedly.
5. **Continue with `docs/ai/BOOTSTRAP.md` from step 1** — survey the existing code to pick stacks, and write architecture documents from the existing modules. Adapt the project README; do not replace it.

## Updating to a newer template version

1. `git fetch template`. Compare per file: `git diff main template/main -- <path>`, or read the incoming version with `git show template/main:<path>`.
2. Classify before adopting:

| Category | Paths | Action |
|---|---|---|
| Take verbatim | `docs/ai/`, `.github/` templates | `git checkout template/main -- <path>` |
| Compare hunks | neutral `docs/convention/` files, `AGENTS.md` | adopt improvements, keep deliberate local changes |
| Never touch | `docs/architecture/`, `README.md`, `stack-*.md`, source | project-owned |

3. Open one PR titled `chore: sync template updates`. Body lists what was adopted, adapted, and deliberately skipped — skipped items are not re-proposed on later syncs.
4. After merging, invoke the QA agent once to verify the updated docs reference no missing files.

## Rules

- Never apply or update during active feature work — wait for a quiet `main`.
- A file the project deleted stays deleted; the template does not resurrect it.
- If the project drifted far from the template, re-run the relevant BOOTSTRAP steps instead of hunk-by-hunk merging.

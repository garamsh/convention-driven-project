# Dispatch a worker

The acts that start a worker through Orca on this host, bind it to its role, wait on it, and release it once it settles. No convention in `docs/convention/` governs dispatch; the role a worker holds is `AGENTS.md` §Roles, and the branch it works on is `docs/convention/git.md` §Branches.

## Host facts

Read from `orca-ide` 1.4.218 on this host on 2026-10-16: the `--help` output of each command named, and the process list. The CLI's help prints its name as `orca`; the commands below are run as `orca-ide`.

- Every running `claude` agent's command line begins with `claude --dangerously-skip-permissions --agent pm`, worker or not (`ps -o args -C claude`). A dispatched worker therefore arrives holding the PM role document, and the dispatch's own text is the only place a Worker role reaches it.
- `orchestration worker-start` takes `--task <task_id>` or `--spec <text>`, not both. `--retry-of` takes `--task` naming the failed Task, and `--spec` creates a new one.
- `worker-start --help` states "When reusing --terminal, pass --worktree for that terminal; current means the coordinator worktree." A reuse without `--worktree` was refused on this host, as recorded in the decision comment on #480.
- `worker-release` "closes only the exact coordinator-owned agent terminal of that worker" and "never closes setup terminals, configured tabs, reused or pre-existing terminals". A terminal made with `orca-ide terminal create` is not one `worker-start` created, so `worker-release` leaves it open.
- `worktree rm` "attempts to delete the checked-out local branch" and "retains ... any branch whose changes it cannot prove are already merged". This repository squash-merges (`git.md` §PRs), and `git log --merges origin/main` lists no commit, so a merged branch's tip is not an ancestor of `main` and a retained branch is the expected result.
- `orchestration check --help` states that `--types` "is the wake condition for --wait; a returned Delivery is always the whole FIFO batch, so it is never filtered by type". A wait on `--types "worker_done,escalation,question"` therefore does not return for a `heartbeat`, and the heartbeats queue behind it. The coordinator dispatching #497 reported on 2026-10-16, three times, being told it had a message while such a wait was outstanding, each time for a queued heartbeat carrying only `phase`.

## Start

1. Write the Task's text with `orca-ide orchestration task-create`, naming the role from `AGENTS.md` §Roles the worker holds, the issue it implements, the branch name per `git.md` §Branches, and the paths it may change.
2. Start it: `orca-ide orchestration worker-start --task <task_id> --worktree new-child --agent claude --name <name> --base-branch main`. For a second round on the same worker, create a new Task with `orchestration task-create` and dispatch that.

## Confirm the three bindings

A start that exits 0 is the launcher's report, not an observation. Confirm each binding by asking the host:

1. **The worktree exists:** `orca-ide worktree list --json` lists it, and `git worktree list` shows it on the branch named.
2. **The role took:** `orca-ide orchestration worker-read --dispatch <dispatch_id> --source auto` shows the worker reading the issue and the files its role names, not acting as the role on its command line.
3. **It runs on its own:** a later `worker-read` shows new output, and none of it is a permission prompt waiting on input.

## Wait

1. Wait on completion and its neighbours: `orca-ide orchestration check --terminal <coordinator handle> --wait --types "worker_done,escalation,question" --timeout-ms <n> --json`. Leaving `heartbeat` out of `--types` keeps the wait blocked across beats; with it in, every beat returns the wait.
2. On a nudge for a queued message, read the batch, acknowledge it with `--ack <delivery_id>`, and go back to step 1 where every message in it is a heartbeat. A heartbeat shows the worker is alive, not that it is done.
3. Judge whether a worker has settled by what it produced — commits on its branch (`git log origin/main..origin/<branch>`), a pull request (`gh pr list --head <branch> --json number,state`), a comment on its issue — rather than by its beats or its silence.

## Release

Releasing is three acts, each confirmed by asking the host afterwards rather than by the command's exit status.

1. **The terminal.** First confirm nothing the worker started still runs: `orca-ide terminal list --worktree <selector> --json`, and the processes whose working directory is in that worktree: `find /proc -maxdepth 2 -name cwd -lname '<worktree path>*'`. Then `orca-ide orchestration worker-release --dispatch <dispatch_id>`, or `orca-ide terminal close --worktree <selector> --all` for a terminal `worker-release` does not own. Confirm with `terminal list` again.
2. **The worktree.** `orca-ide worktree rm --worktree <selector>`; confirm with `git worktree list`.
3. **The branches.** Ask the host whether the work landed: `gh pr view <n> --json state,mergeCommit`, as its own command. On `MERGED`, delete the local branch where `worktree rm` retained it, with `git branch -D <branch>`. The repository's `delete_branch_on_merge` reads `true` (`gh api repos/garamsh/convention-driven-project --jq .delete_branch_on_merge`), so GitHub deletes the remote branch on merge. Confirm with `git branch --list <branch>` and `git ls-remote --heads origin <branch>`, both empty.

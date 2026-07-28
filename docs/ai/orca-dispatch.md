# Orca Dispatch Guide

How the PM creates orca worktrees and dispatches role-bound agents into them. Orca gives each task an isolated worktree, a persistent terminal the PM can watch, and a link to its issue.

## Contents

- When to use
- Prerequisites
- Binding the role
- Dispatching a worker
- Watching a worker
- After the PR
- Parallel work
- Limits

## When to use

Use orca to run a worker on an issue as a persistent, observable process rather than an ephemeral in-session helper. The worktree survives the PM session, stays visible in the Orca app, and is tied to its issue. Prefer it whenever the PM assigns implementation work (see `pm-guide.md` §Managing issues).

Dispatch is gated on a human. The PM opens and refines the issue on its own, but creates no worktree and launches no worker until a human confirms the issue. This gate keeps a human in control of what work actually starts.

## Prerequisites

- The orca CLI is installed and the project is registered as an orca repo (`orca repo list`).
- The agent tool the worker will run is installed (`which claude`, `which opencode`). Only installed tools can be launched.
- `orca agent-context --json` is the authoritative command schema. Consult it for exact flags rather than trusting this guide's examples verbatim — orca commands evolve.

## Binding the role

Orca's own `--agent <id>` selects the *tool* (`claude`, `opencode`, `codex`, `cursor`, `claude-teams`), not the project role. Launching with it alone produces a role-less agent. Bind the role with the tool's own `--agent <role>` flag, which loads the matching role definition.

| Tool | Role-bound launch command | Role definition |
|---|---|---|
| Claude Code | `claude --agent <role>` | `.claude/agents/<role>.md` |
| opencode | `opencode --agent <role>` | `.opencode/agents/<role>.md` |

Roles are `pm`, `worker`, `qa`. For Claude, `--settings '{"outputStyle":"<Name>"}'` (names live in `.claude/output-styles/`) is an equivalent way to lock the same role. A launched agent that reports the wrong role — or none — was not bound correctly; fix the flag before sending work.

## Dispatching a worker

1. Open the issue with goal and acceptance criteria (`pm-guide.md` §Managing issues). The worker acts from the issue alone.
2. Wait for a human to confirm the issue. Do not create a worktree or launch a worker before confirmation.
3. Create the worktree in orca, linked to the confirmed issue and based on `main`:
   `orca worktree create --repo name:<repo> --name <slug> --base-branch main --issue <N> --json`.
   Pass `--repo` explicitly (`name:<repo>` or `id:<id>`); do not pass orca's `--agent` here. Read the worktree path from the result.
4. Launch the role-bound agent in the worktree's terminal and capture the handle:
   `orca terminal create --worktree path:<worktree-path> --command "claude --agent worker" --json`.
5. Send the task, referencing the issue, `worker-guide.md`, and the conventions that govern the change:
   `orca terminal send --terminal <handle> --text "<task>" --enter`.
   Send the prompt as a separate step rather than embedding a long prompt in the launch command, which is fragile to quote.

The worker then works on its branch and opens a PR; it does not create another branch or worktree.

## Watching a worker

- `orca terminal read --terminal <handle> [--cursor <n>]` — tail output; pass the previous `nextCursor` to read only new lines.
- `orca terminal wait --terminal <handle> --for tui-idle|exit` — block until the agent is idle or the process exits.
- `orca terminal send --terminal <handle> --text "<correction>" [--interrupt] --enter` — steer or interrupt a running worker.

Confirm the agent started and self-identified with the right role before leaving it to run.

## After the PR

Review and merge per `pm-guide.md`. Branch hygiene extends to orca: after merging, remove the worktree with `orca worktree rm --worktree path:<worktree-path>`. Never remove a worktree whose worker is still running or whose PR is open (`pm-guide.md` §Branch hygiene).

## Parallel work

For a task that benefits from parallel decomposition, `orca claude-teams` runs Claude Code with native team panes (must be started inside an orca terminal). Keep concurrently active workers on disjoint modules (`pm-guide.md` §Coordinating concurrent work).

## Limits

- Do not hardcode absolute worktree paths in procedures; discover them with `orca worktree list` and address worktrees by selector (`name:`, `path:`, `id:`, `active`).
- A worker launched this way is still a worker: it obeys `worker-guide.md` and may not merge, manage issues, or edit `docs/convention/`, `docs/ai/`, or agent configuration.

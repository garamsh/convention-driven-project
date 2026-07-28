# Agent harness

How this repository shapes the AI agents that develop it: the roles they play, where their definitions live, and how their work reaches `main`. This is the current shape and the reasons for it, not a how-to — the role playbooks in `docs/ai/` carry the procedures.

## Contents

- Current decisions
- Rationale summary
- Open questions

## Current decisions

### Three roles

Work is split across three roles with distinct authority. The full permission matrix lives in `AGENTS.md`; the boundaries that define the shape:

- **PM** — the single authority on `main`. Reviews and merges PRs, manages issues, owns `docs/convention/`, and supervises documentation. Does not write source code except when the user explicitly instructs.
- **Worker** — implements assigned work on task branches and delivers it as a PR. May modify source, tests, and `docs/architecture/`. Never merges, never touches issues.
- **QA** — read-only. Hunts for problems, runs tests and builds, and files issues with evidence. Commits nothing and fixes nothing.

One decision-maker merges; many workers implement in parallel; QA reports without changing code. A single merge authority is what keeps parallel work from landing in conflicting directions.

### Where definitions and procedures live

- `AGENTS.md` — the role matrix and the rules every agent follows, regardless of tool. The precedence root for agent behavior.
- `docs/ai/` — agent-only procedures: `BOOTSTRAP.md` (one-time project setup), the per-role playbooks (`pm-guide.md`, `worker-guide.md`, `qa-guide.md`), and `orca-dispatch.md` (how the PM dispatches workers into worktrees).
- `.claude/agents/`, `.opencode/agents/` — tool-specific adapters that bind each role to a concrete agent runner. They point back to `AGENTS.md` and `docs/ai/` rather than restating rules, so behavior stays defined once.
- `docs/convention/` — the rules for code, reviews, and documentation that all roles apply.

### PR-based flow through `main`

All change reaches `main` through pull requests; no role pushes to it directly. A worker branches, implements, and opens a PR using the template in `.github/`; the PM reviews against `docs/convention/` and merges. Branch protection on `main` mechanically enforces this split — the repository README records the GitHub settings that back it. This is the enforcement point for the single-merge-authority decision above.

### Convention versus architecture

Two documentation trees with different jobs, owned by different roles:

- `docs/convention/` — the rules agents follow when writing code and docs. Owned by the PM; workers read and apply but never modify.
- `docs/architecture/` — the current shape of the system (responsibility documents) plus the append-only decision log (`adr/`). Workers update it when their change alters structure.

Conventions are prescriptive and forward-looking (what to do next time); architecture is descriptive and present-tense (what exists now and why). Keeping them apart stops "how we build" from being confused with "what we built."

## Rationale summary

No ADRs have been recorded yet; the decisions above were established during bootstrap. The forces behind them:

- **Single merge authority** — parallel workers editing one codebase need one serialization point, or independent PRs merge into a contradictory whole. Concentrating merge rights in the PM provides it.
- **Definitions in one place, adapters thin** — `AGENTS.md` plus `docs/ai/` are the source of truth so that supporting a new agent runner means adding an adapter under its config directory, not re-deriving the rules.
- **Convention/architecture split** — rules and current-state descriptions rot differently and are owned by different roles, so they live in separate trees rather than one blended set of docs.

When these decisions are revisited, the change lands as an ADR under `docs/architecture/adr/` and this document is updated in the same PR, per the rules in `docs/architecture/README.md`.

## Open questions

- Whether role definitions should stay duplicated across `.claude/agents/` and `.opencode/agents/`, or be generated from a single source to prevent drift.
- Whether QA's issue-filing and the PM's issue-management overlap needs a sharper boundary as the project grows.

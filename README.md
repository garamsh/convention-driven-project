# Harness — AI Agent Project Template

A GitHub template repository for projects developed by AI agents (opencode, Claude Code). Multiple agents work in parallel under three roles: a PM agent on `main` that reviews, merges, and supervises; worker agents that implement tasks following written conventions; and a QA agent that hunts for problems and files them as issues.

## Usage

1. Create a new repository with **Use this template**.
2. Start a PM agent on `main`. It executes `docs/ai/BOOTSTRAP.md`: selects stack conventions, sets up CI plumbing, writes this README as a project introduction, and opens the bootstrap PR.

This file is replaced during bootstrap; do not edit it to describe your project.

## Structure

- `AGENTS.md` — role matrix and rules every agent follows
- `docs/ai/` — agent-only procedures (bootstrap, adoption, role guides, orca dispatch)
- `docs/convention/` — conventions for code, reviews, and documentation; stack files are pruned during bootstrap
- `docs/architecture/` — responsibility documents (current truth) and ADRs (append-only decision log)
- `.opencode/agents/`, `.claude/agents/` — tool-specific agent adapters
- `.github/` — PR and issue templates, CODEOWNERS

## GitHub settings not covered by the template

Templates do not carry repository settings. After creation, configure manually:

- **Settings → General → Template repository**: leave unchecked for the new project (that checkbox is for this template repo itself).
- **Branch protection on `main`**: require pull requests and block direct pushes — this mechanically enforces the PM role.
- **Require review before merge**: enable only if the PM acts under a separate GitHub account (bot or GitHub App). GitHub rejects self-approval, so when workers and the PM share one account, enabling this blocks every merge — leave it off; the PM's merge then serves as the approval (see `docs/convention/review.md` §Single-account setups).
- **Require status checks**: enable once CI exists, so `make ci` gates merges.
- **Merge methods**: restrict to squash only (matches `docs/convention/git.md`).
- **Automatically delete head branches** (Settings → General → Pull Requests): removes a PR's remote branch on merge, preventing branch accumulation.

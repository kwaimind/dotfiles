---
name: code-review
description: Review GitHub pull requests as a senior software engineer using the gh CLI. Triggers when user provides a PR number and asks for code review. Analyzes diffs, checks for bugs, security issues, performance problems, code style, test coverage, and architecture concerns. Never posts comments without explicit permission—instead provides a structured summary with findings, questions, and recommendations grouped by category.
---

# Code Review Skill

Review PRs like a senior engineer: thorough, constructive, and safe (no auto-posting).

## Workflow

1. **Fetch PR metadata** — Get PR details (title, description, author, base branch, files changed)
2. **Fetch the diff** — Get the full diff for review
3. **Gather context** — For files in the diff, view surrounding code when needed to understand changes
4. **Analyze and categorize** — Review for issues across all categories
5. **Output summary** — Present findings grouped by category with severity levels

## Commands

```bash
# PR metadata
gh pr view <PR_NUMBER> --json title,body,author,baseRefName,headRefName,additions,deletions,changedFiles

# Full diff
gh pr diff <PR_NUMBER>

# View specific file for context (use sparingly, only when diff context is insufficient)
gh pr view <PR_NUMBER> --json files --jq '.files[].path'  # list changed files
cat <filepath>  # view full file when needed
```

## Review Categories

Analyze changes for:

1. **Bugs & Logic Errors** — Incorrect logic, off-by-one errors, null/undefined handling, race conditions
2. **Security** — Injection vulnerabilities, auth issues, sensitive data exposure, input validation
3. **Performance** — N+1 queries, unnecessary re-renders, missing indexes, inefficient algorithms
4. **Code Style & Readability** — Naming, complexity, duplication, unclear intent
5. **Test Coverage** — Missing tests, edge cases, test quality
6. **Architecture & Design** — Separation of concerns, patterns, maintainability, API design

Tailor feedback to the languages/frameworks in the PR (TypeScript, React, Go, SQL/PostgreSQL/Kysely, etc.).

## Severity Levels

- 🔴 **Critical** — Bugs, security issues, data loss risks — must fix before merge
- 🟡 **Suggestion** — Improvements, better patterns, refactors — recommended but not blocking
- 🔵 **Nitpick** — Style, naming, minor readability — optional, low priority
- ❓ **Question** — Unclear intent, needs clarification from author

## Output Format

```markdown
# PR Review: #{number} — {title}

## PR Summary
- **Author:** {author}
- **Branch:** {head} → {base}
- **Changes:** +{additions} / -{deletions} across {changedFiles} files

## Description
{PR description or "No description provided"}

---

## 🔴 Critical Issues
{List each issue with file, line range, and explanation}

## 🟡 Suggestions
{List each suggestion with file, line range, and explanation}

## 🔵 Nitpicks
{List each nitpick with file, line range, and explanation}

## ❓ Questions
{List questions about unclear code or intent}

---

## Summary
{Brief overall assessment: ready to merge, needs changes, or needs discussion}
```

## Important Rules

- **Never post comments** to GitHub without explicit user permission
- **Always output locally** — provide the review as a summary in chat
- **Be constructive** — suggest fixes, not just problems
- **Use line references** — point to specific locations in the diff
- **Skip empty sections** — omit categories with no findings

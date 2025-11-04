# PR Summary Generator

Review the current branch, compare it with the base branch (defaults to `development`), and update an existing PR with a comprehensive summary.

## Arguments

- `$1`: PR number (required)
- `$2`: Base branch to compare against (optional, defaults to `development`)

## Instructions

1. **Determine base branch**: Use `$2` if provided, otherwise use `development`

2. **Fetch existing PR details**:
   - Run: `gh pr view $1 --json number,title,body,headRefName`
   - Verify the current branch matches the PR's head branch
   - Save the current PR title
   - Preserve the jira ticket link

3. **Analyze changes**:
   - Get commit history: `git log [base-branch]...HEAD --oneline`
   - Get full diff: `git diff [base-branch]...HEAD`
   - Review all commits (not just the latest) to understand the complete scope
   - Identify:
     - New features added
     - Bug fixes
     - Refactoring changes
     - Test additions/updates
     - Breaking changes
     - Configuration changes

4. **Generate PR summary** with this structure:
   ```markdown
   ## Summary
   - [2-3 concise bullet points describing what was done and why]

   ## Major changes
   - [Key technical changes, grouped by area if multiple]

   ## Test plan
   - [ ] Tests added/updated
   - [ ] Manual testing completed
   - [Add other relevant checkboxes based on changes]

   > Generated with 🤖 Claude Code
   ```

5. **Update the PR**:
   - Use: `gh pr edit $1 --body "<generated summary>"`
   - Use a HEREDOC to pass the body for proper formatting
   - Keep the existing PR title unchanged

## Usage Examples

```
/pr-summary 123
/pr-summary 123 main
/pr-summary 456 development
```

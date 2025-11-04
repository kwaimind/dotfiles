 # PR Review Comment Handler

  Fetch and implement all review comments from the GitHub pull request #$ARGUMENTS

  ## Instructions

  1. **Fetch comments**: Use `gh api` to fetch all review comments for the PR number provided by the user
     - Get PR review comments: `gh api repos/{owner}/{repo}/pulls/#$ARGUMENTS/comments`
     - Get general PR comments: `gh api repos/{owner}/{repo}/issues/#$ARGUMENTS/comments`
     - Parse the JSON response to extract comment threads

  2. **Analyze comments**: Group comments by:
     - File and line number
     - Whether they're actionable (requesting changes) vs informational
     - Unresolved vs resolved status

  3. **Present findings**: Show the user:
     - Total number of review comments found
     - Breakdown by file
     - Which comments require code changes vs clarification

  4. **Implement changes**: For each actionable comment:
     - Read the relevant file
     - Show the comment context (file:line, reviewer's feedback)
     - Implement the requested change
     - Mark the comment as addressed in your todo list

  5. **Summary**: After completing all changes, do nothing

  ## Usage
  User provides: PR number or full PR URL
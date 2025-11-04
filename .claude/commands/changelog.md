### Step 0
Be extremely concise. Sacrifice grammar for the sake of concision.

### Step 1
Check if the current branch has bumped the patch. If so, use that version for the following commands. If not, you should run `npm version patch`. Then use this new patch version to create a changelog.

### Step 2
Write a very short and terse, 1 line summary of the current state of this branch compared with BASE. Add it to the @changelog.md file, to the cloest version number based on Step 1.

### Step 3
Check @package.json for the latest version number from step 1 and add your terse summary to the section with that version number.

If no version header exists, add it and add the summary.

If there are unreleased changes (under the ## [Unreleased] header) in the @changlog.md, move them to the version header. if there are no changes under the ## [Unreleased] header, remove the header.
Write a very short and terse, 1 line summary of the current state of this branch compared with BASE. Add it to the @changelog.md file, to the cloest version number.

Check @package.json for the latest version number and add your terse summary to the section with that version number.

If no version header exists, add it and add the summary.

if there are unreleased changes (under the ## [Unreleased] header) in the @changlog.md, move them to the version header. if there are no changes under the ## [Unreleased] header, remove the header
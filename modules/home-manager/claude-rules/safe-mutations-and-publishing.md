# Safe Mutations and Remote Publishing Rule

To protect environments and prevent unwanted upstream modifications:

1. **Mutating HTTP Requests Require Approval:**
   - NEVER send `POST`, `PUT`, `DELETE`, or `PATCH` requests (or any non-idempotent/mutating network request) against local dev servers, test containers, or remote APIs without explicit confirmation from the user.
   - Always display the target URL, method, and payload before asking for confirmation.

2. **No Unprompted Remote Publishing:**
   - **GitLab:** When reviewing GitLab Merge Requests or reading comments with `glab`, NEVER execute `glab mr note`, `glab mr approve`, or update remote MR state unless explicitly instructed by the user. Keep all review feedback inside the local chat terminal or specified report file.
   - **Git Tags:** When creating git release tags, create the annotated tag locally (`git tag -a ...`). NEVER execute `git push --tags` or push tags upstream unless explicitly directed.

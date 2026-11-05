# No Kubectl Apply Without Approval Rule

Do not execute `kubectl apply`, `kubectl create`, `kubectl delete`, `kubectl patch`, `kubectl edit`, or any other state-modifying `kubectl` command against the cluster without explicit user confirmation or approval.

1. You may inspect the cluster using read-only commands (such as `kubectl get`, `kubectl describe`, `kubectl logs`).
2. When manifests need changes, edit the local manifest files and present the proposed diff or changes to the user.
3. Never rely on informal conversational approval alone. When requesting approval to modify the cluster, always use the interactive `AskUserQuestion` tool to present an action-oriented multiple-choice prompt with concrete options, for example:
   - `(Recommended) Run server-side dry run (kubectl ... --dry-run=server)`
   - `Apply changes immediately (kubectl ...)`
   - `Cancel / keep local changes only`
4. Only execute cluster modifications if the user explicitly selects an execution option from the MCQ prompt.

---
name: drift-reconciler
description: >
  Detect and resolve divergence between declared infrastructure (Terraform/Pulumi/Helm/Kustomize)
  and live reality — manual console edits, hotfixes applied under incident pressure, out-of-band
  kubectl changes, state-file lies. Trigger phrases: "terraform plan shows changes I didn't make",
  "someone changed it in the console", "drift detection", "state doesn't match", "why does apply
  want to revert this", "reconcile the cluster". Do NOT use for merge conflicts in IaC code,
  for first-time imports of legacy infra (that is a migration project), or for app-config
  divergence with no IaC declaration.
---

## When invoked

1. Capture the drift evidence verbatim: `terraform plan -refresh-only` (state vs. reality) AND a normal `terraform plan` (code vs. state), or `kubectl diff` / `helm diff` / Argo/Flux sync status for cluster resources. Distinguish the two axes explicitly — code≠state and state≠reality are different problems with different fixes.
2. For each drifted attribute, determine WHO is right — the declaration or the live value. Default is NOT "revert to code." An incident hotfix (raised replica count, widened timeout, emergency SG rule) may be the correct value that the code must adopt. Query change history for the live edit: CloudTrail/Activity Log, `kubectl rollout history`, audit logs — name the actor and timestamp where possible.
3. Classify each drift item: **adopt** (codify the live value — write the IaC change), **revert** (live value is wrong/unauthorized — re-apply declaration), or **ignore-field** (attribute legitimately managed elsewhere — add `ignore_changes`/annotation and document why). Every item gets exactly one class.
4. For revert items, treat the revert as a change: what breaks when the live value snaps back? A manual SG rule someone depends on, an emergency scale-up still needed — reverting drift can BE the outage.
5. Sequence the reconciliation: adopt items first (code PR), then targeted applies (`-target` only with justification), then a final clean `plan` proving zero diff on both axes.
6. Identify the drift SOURCE and close it: missing pipeline permissions forcing console work, no admission control, humans with prod write access. Reconciling without closing the source schedules the next drift.

## Output format

**Drift Reconciliation Plan**: (1) drift table `Resource | Attribute | Declared | Live | Actor/when (or unknown) | Class (adopt/revert/ignore) | Rationale`; (2) ordered action list (code PRs first, applies second) with the exact commands; (3) `SOURCE: <how the drift got in> → <prevention action>`; (4) final verification command whose expected output is "No changes."

## Quality gate

PASS only if: both axes (code↔state, state↔reality) were checked with commands shown; every drift item has exactly one class WITH a rationale; at least one revert item (if any exist) was analyzed for revert-breakage; a SOURCE line exists. FAIL if the plan is "run apply and accept whatever it does" or if any class column says "revert" purely because the code is the code.

## Integration

Revert actions route through **blast-radius-estimator** — reverting drift is an infra change like any other. Use **evidence-reasoning** for the who/when attribution (cite the audit-log entry). Use **root-cause-first** on the SOURCE line — the finding is the broken process, not the drifted attribute. The final zero-diff plan output is the **verified-done** evidence; recurring drift on the same resource is a signal to hand the prevention action to **runbook-writer** as a standing procedure.

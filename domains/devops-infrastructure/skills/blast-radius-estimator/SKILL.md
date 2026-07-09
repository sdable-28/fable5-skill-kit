---
name: blast-radius-estimator
description: >
  Estimate the blast radius of an infrastructure change BEFORE applying it — Terraform plans,
  Kubernetes manifests, Helm values, security-group edits, IAM policy changes, DNS/load-balancer
  cutovers, CI/CD pipeline config. Trigger phrases: "is this change safe", "what does this plan
  touch", "apply this to prod", "review this terraform plan", "roll this out", "will this take
  anything down". Do NOT use for application-code diffs with no infra surface, for post-incident
  analysis (use root-cause-first), or for cost impact alone (use cost-anomaly-scanner).
---

## When invoked

1. Identify the change artifact: `terraform plan` output, `kubectl diff`, `helm diff`, raw manifest diff, or console/CLI command. If none exists, generate it first (`terraform plan -out`, `kubectl diff -f`, `helm diff upgrade`). Never estimate from the source diff alone — the rendered plan is the ground truth.
2. Classify every resource action as **create**, **in-place update**, **replace (destroy+create)**, or **destroy**. Replace and destroy are the danger classes — call them out by resource address, explicitly.
3. Walk the dependency fan-out for each danger-class resource: what consumes it? (Security group → every attached ENI/instance. IAM role → every service that assumes it. K8s namespace → everything inside it. DNS record → all clients resolving it. Subnet/route table → every workload in it.) Enumerate consumers by querying live state (`terraform state list`, `kubectl get -A --selector`, cloud CLI), not by assumption.
4. Determine the failure mode if the change is wrong: hard outage, degraded capacity, silent data loss, security exposure, or cosmetic. Assign the WORST plausible mode, not the likely one.
5. Check reversibility: can this be rolled back by re-applying prior state, or is it one-way (deleted data, released Elastic IP, dropped database, revoked cert)? One-way changes get an automatic escalation.
6. Produce the Blast Radius Report and state a go/no-go recommendation with required mitigations (maintenance window, canary target, backup snapshot, PDB check, second approver).

## Output format

**Blast Radius Report** — a table with columns: `Resource address | Action | Direct consumers | Failure mode if wrong | Reversible? | Mitigation`. Followed by three lines: `RADIUS: <contained|service|zone|global>`, `ONE-WAY ACTIONS: <list or none>`, `RECOMMENDATION: <go|go-with-mitigations|no-go> — <one sentence>`.

## Quality gate

PASS only if: every destroy/replace action in the plan appears in the table with at least one named consumer or an explicit "verified zero consumers via <command>"; and the RADIUS line is justified by the widest row, not asserted. FAIL if any consumer list says "probably" or "should be" — go query live state.

## Integration

Run inside **plan-gate** before any apply is proposed. Feed one-way actions to **adversarial-disproof** ("prove this rollback actually works"). Consumers enumerated here become the "verify" targets for **verified-done** after apply. If the change is cost-motivated, chain with **cost-anomaly-scanner**; if it is a recovery action, chain with **restore-drill-verifier** first.

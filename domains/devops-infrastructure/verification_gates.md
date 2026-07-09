# DevOps, Infrastructure & Platform Engineering — Verification Gates

Domain-specific pass/fail gates. Run before delivering or approving any infra change, pipeline, or deployment.

### Gate 1 — Blast Radius Bounded
- **Pass:** Every infra change states what it can take down and is scoped/staged to limit that radius.
- **Fail:** A single config/apply can hit all environments or all regions at once.
- **Check:** Confirm the change's maximum failure scope is stated and constrained (per-env, per-region).

### Gate 2 — Terraform Plan Reviewed Before Apply
- **Pass:** `terraform plan` output is inspected; destroy/replace of stateful resources is confirmed intentional.
- **Fail:** Apply run without reading the plan, silently destroying a database or volume.
- **Check:** Confirm the plan diff was reviewed and no unintended destroy/replace is present.

### Gate 3 — Pipeline Verify Stage Present
- **Pass:** CI/CD ends with a verify step (health check / smoke test), not just deploy.
- **Fail:** The pipeline reports green on deploy success with no post-deploy verification.
- **Check:** Confirm a verify stage runs and gates the deploy as complete.

### Gate 4 — Rollback Path Proven
- **Pass:** Every deploy strategy (blue/green/canary) has a tested rollback and a defined trigger.
- **Fail:** Forward-only deploy with no rollback, or an untested one.
- **Check:** Confirm the rollback procedure exists and has been exercised.

### Gate 5 — K8s Resource Limits Set
- **Pass:** Pods declare requests and limits; no unbounded container can starve the node.
- **Fail:** Deployments with no limits, risking noisy-neighbor resource starvation.
- **Check:** Confirm every workload has requests/limits and PDBs where availability matters.

### Gate 6 — Autoscaling Bounded
- **Pass:** HPA/cluster autoscaling has max caps and cost alerts.
- **Fail:** Autoscaling with no upper bound, exposing the account to runaway cost.
- **Check:** Confirm max replicas/nodes are set and a spend alarm exists.

### Gate 7 — No Secret Sprawl
- **Pass:** Secrets live in a vault/secret manager; none appear in code, logs, env dumps, or IaC state.
- **Fail:** Credentials committed, printed to logs, or stored in plaintext state.
- **Check:** Scan diff/logs/state for secrets; confirm all references resolve to the vault.

### Gate 8 — Backup Restore Tested
- **Pass:** Backups have a documented, actually-executed restore test meeting RTO/RPO.
- **Fail:** Backups exist but restoration has never been verified.
- **Check:** Confirm a restore was performed and met the RTO/RPO targets.

### Gate 9 — SLO and Error Budget Defined
- **Pass:** Services have SLIs, an SLO, and an error budget that gates release velocity.
- **Fail:** Alerting on raw metrics with no SLO, producing alert fatigue.
- **Check:** Confirm SLIs/SLO exist and alerts fire against budget burn, not noise.

### Gate 10 — Observability Trinity Coverage
- **Pass:** The change is observable via metrics, logs, AND traces sufficient to debug it in prod.
- **Fail:** A new service ships with metrics only, blind to request-path failures.
- **Check:** Confirm all three pillars cover the new/changed path.

### Gate 11 — Least-Privilege IAM
- **Pass:** New roles/policies grant minimum required permissions; no wildcard admin.
- **Fail:** A role granted broad `*` permissions for convenience.
- **Check:** Confirm each granted permission is required and scoped; no unnecessary wildcards.

### Gate 12 — Supply-Chain Integrity
- **Pass:** Dependencies are scanned, lockfiles pinned, and an SBOM is produced for the build.
- **Fail:** Unpinned/unscanned dependencies enter the image.
- **Check:** Confirm the scan ran, lockfiles are committed, and the SBOM exists.

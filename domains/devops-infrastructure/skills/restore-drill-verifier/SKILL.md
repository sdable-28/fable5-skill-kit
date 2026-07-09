---
name: restore-drill-verifier
description: >
  Prove a backup can actually be restored — design and execute a restore drill for databases,
  volumes, object stores, cluster state (etcd/velero), or Terraform state, and measure real
  RTO/RPO against targets. Trigger phrases: "are our backups good", "test the restore", "DR
  drill", "can we recover from this", "verify backup", "what's our actual RTO". Do NOT use for
  designing the backup schedule itself, for HA/failover architecture reviews without a restore
  component, or for application-level undo features.
---

## When invoked

1. Inventory what claims to be backed up: list actual backup artifacts (snapshots, dump files, velero backups, state file versions) with their timestamps and sizes via CLI/API. A backup job that "runs green" but produces zero-byte or stale artifacts is the first failure class — check sizes and recency against the schedule before anything else.
2. Define the drill contract before touching anything: what is restored, INTO WHERE (always an isolated target — new instance, scratch namespace, separate account/project — never the production resource), the declared RPO/RTO targets, and the success probe (a query/request that proves the restored data is correct, not just that the process exited 0).
3. Execute the restore into the isolated target. Time it wall-clock from "decision to restore" including artifact download and provisioning — that is the real RTO, not the vendor's restore-API duration.
4. Verify data integrity with content probes: row counts vs. source at snapshot time, checksum of known objects, application smoke query against the restored instance. "Restore completed successfully" from the tool is NOT evidence.
5. Measure actual RPO: timestamp of the newest restored record vs. now. Compare both measured RPO and RTO against declared targets.
6. Tear down the drill target and confirm teardown (no cost leak, no dangling snapshot). Record the drill result where the next drill will find it.

## Output format

**Restore Drill Record**: header `System | Backup artifact (id, timestamp, size) | Drill target | Date`; measurements block `Measured RTO: Xm (target: Ym) | Measured RPO: Xm (target: Ym)`; integrity table `Probe | Expected | Observed | Pass/Fail`; verdict line `RESTORABLE: yes/no/partial — <one sentence>`; and a gaps list (anything that required tribal knowledge, missing creds, or manual steps not in the runbook).

## Quality gate

PASS only if: the restore ran into an isolated target (name it); at least two independent content probes passed with observed values recorded; RTO/RPO are measured numbers, not estimates; teardown is confirmed. FAIL immediately — and report RESTORABLE: no — if the drill was simulated, skipped, or verified only by tool exit codes.

## Integration

Gate the drill plan through **blast-radius-estimator** (restoring into the wrong target is a prod-overwrite incident). Apply **adversarial-disproof** to the success probes: actively try to show the restored data is wrong or stale. Every gap found becomes a step in **runbook-writer** output for the recovery procedure. Close with **verified-done** using the integrity table as evidence; drill cost side-effects feed **cost-anomaly-scanner** if the target lingers.

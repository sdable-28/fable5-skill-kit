# Common Patterns — DevOps, Infrastructure & Platform Engineering

## 1. Diagnosing a Failed or Flaky CI Pipeline
**Trigger:** A pipeline that passed yesterday fails today; a job fails intermittently; "works on my machine" but red in CI.
**Approach:** 1. Pull the exact failing job log; find the FIRST error, not the last — downstream noise lies. 2. Diff what changed: commit range, base image tag, runner version, dependency lockfile, secrets rotation. 3. Re-run the job once. Pass on retry = flake (timing, network, shared state); fail again = deterministic. 4. For flakes, reproduce locally with the CI container image and identical env vars. 5. Fix root cause; never mask with blind retries. 6. Add the failure mode to the pipeline's known-issues note.
**Checklist:** [ ] First error located [ ] Commit/image/runner diff done [ ] Retry classification (flake vs deterministic) [ ] Reproduced in CI image locally [ ] Root cause fixed, not retried-around [ ] Regression guard added
**Variation:** The failure is in the pipeline definition itself (cache key, unpinned action/image `:latest`), not the code. Check pinning before debugging application code.

## 2. Planning and Applying an IaC Change (Terraform/Pulumi)
**Trigger:** Any change to infrastructure code; drift alert; new resource request.
**Approach:** 1. Run `terraform plan` against the real remote state; read every line — count adds/changes/destroys. 2. Any `destroy` or `replace` on a stateful resource (DB, volume, queue) stops the change until justified in writing. 3. Check blast radius: which workspaces/modules consume this module? 4. Apply in non-prod first; verify the resource actually works, not just that apply exited 0. 5. Apply to prod inside a change window with the rollback plan open. 6. Confirm plan is clean (zero diff) after apply.
**Template:** `CHANGE: <what> | PLAN SUMMARY: +A ~C -D | STATEFUL DESTROYS: none/justified | CONSUMERS: <modules/workspaces> | NON-PROD VERIFIED: y/n | ROLLBACK: <exact commands> | POST-APPLY PLAN CLEAN: y/n`
**Variation:** Plan looks clean but state has drifted from manual console edits — the apply silently reverts someone's hotfix. Run drift detection and reconcile state BEFORE planning your change.

## 3. Production Rollout of a New Service Version
**Trigger:** Deploy request to prod; release cut; feature-flag flip that changes traffic behavior.
**Approach:** 1. Verify the artifact is the exact tested build (immutable digest, not a tag). 2. Choose strategy by risk: canary for behavior changes, blue/green for infra swaps, flag for product logic. 3. Define abort criteria BEFORE starting: metric, threshold, window (e.g., 5xx rate > 0.5% over 5 min). 4. Ship to canary slice; watch SLIs against baseline, not absolutes. 5. Ramp 5% → 25% → 100% with a hold at each step. 6. Keep the previous version warm until 100% has soaked one full traffic cycle. 7. Rollback = redeploy previous digest, never fix-forward under pressure.
**Checklist:** [ ] Immutable artifact digest [ ] Abort criteria written down [ ] Canary baseline compared [ ] DB migrations backward-compatible with N-1 [ ] Previous version warm [ ] Rollback rehearsed this quarter
**Variation:** Schema migration breaks rollback — new code wrote data old code can't read. Enforce expand/contract migrations: expand first, deploy, contract in a later release.

## 4. Debugging Kubernetes Pod Failures (CrashLoop / Pending / OOMKilled)
**Trigger:** Pods in CrashLoopBackOff, Pending, Evicted; HPA thrashing; node pressure alerts.
**Approach:** 1. `kubectl describe pod` — read Events first; they name the cause (image pull, scheduling, probe failure) before logs do. 2. CrashLoop: `kubectl logs --previous` for the dying container, not the current one. 3. OOMKilled: compare working-set metrics to `limits.memory`; raise limit OR fix the leak — decide which, don't guess. 4. Pending: check node allocatable vs requests, taints/tolerations, PVC binding, and PDB blocking eviction. 5. Probe failures: hit the probe endpoint from inside the pod netns; check initialDelay vs actual startup time. 6. Fix in the manifest/Helm values, never `kubectl edit` on a managed object.
**Checklist:** [ ] Events read [ ] Previous-container logs pulled [ ] Requests/limits vs actual usage compared [ ] Probe timing vs cold-start measured [ ] Fix committed to source, not live-edited
**Variation:** The pod is a symptom — a NetworkPolicy, admission webhook, or resource quota introduced elsewhere is the cause. If the manifest didn't change but behavior did, hunt cluster-level changes.

## 5. Defining SLOs and Cutting Alert Noise
**Trigger:** On-call pages > ~2 actionable/week noise ratio; new service ships without SLOs; "add an alert for X" requests.
**Approach:** 1. Pick 2–4 SLIs from the user's view: availability, latency (p99), correctness. Not CPU. 2. Set SLO targets from measured history, not aspiration; derive the error budget. 3. Alert ONLY on budget burn rate (fast-burn page, slow-burn ticket). Delete every alert with no runbook line and no action taken in 90 days. 4. Every remaining page links a runbook: symptom → check → mitigate → escalate. 5. Review alert hit-rate monthly; anything acked-and-ignored 3× gets demoted or deleted.
**Template per alert:** `NAME | SLI | BURN CONDITION | PAGE or TICKET | RUNBOOK LINK | LAST FIRED | ACTION TAKEN y/n`
**Variation:** Cause-based alerts (disk 80%, CPU 90%) recreate the noise you deleted. Hold the line: symptoms page, causes inform dashboards.

## 6. Cloud Cost Spike Investigation
**Trigger:** Bill anomaly alert; month-over-month spend jump; finance asks "what is this line item".
**Approach:** 1. Isolate by service and region in cost explorer; find the day the slope changed. 2. Correlate the inflection date with deploys, autoscaling events, and new environments. 3. Usual suspects in order: runaway autoscaling (check max replicas × instance size), unattached volumes/snapshots, NAT gateway / cross-AZ data transfer, forgotten non-prod environments, log ingestion volume. 4. Tag-audit untagged spend — untagged usually means orphaned. 5. Fix, then add a budget alert at 120% of the new baseline scoped to that service.
**Checklist:** [ ] Inflection date found [ ] Correlated with change events [ ] Autoscaler max bounds sane [ ] Orphaned resources swept [ ] Data-transfer paths reviewed [ ] Scoped budget alert added
**Variation:** The spike is legitimate growth, not waste. Confirm with traffic metrics before cutting capacity — right-sizing a service that just gained users causes the next incident.

## 7. Backup and Restore Validation (DR Readiness)
**Trigger:** Quarterly DR review; new stateful service ships; compliance audit; "do we have backups?" after a scare.
**Approach:** 1. Inventory stateful systems; for each record RTO/RPO targets vs configured backup frequency and retention. 2. RESTORE one real backup to an isolated environment — a backup is unverified until restored. 3. Time the restore end-to-end; compare against RTO. Verify data integrity (row counts, checksums, app boots against it). 4. Test the failure path: can you restore when the primary region/account is unreachable? Are backup credentials stored outside the failure domain? 5. Document the restore runbook from what you actually did, and schedule the next test.
**Checklist:** [ ] RTO/RPO stated per system [ ] Restore executed, not just listed [ ] Restore time ≤ RTO [ ] Integrity verified [ ] Cross-region/account access proven [ ] Runbook updated with real steps [ ] Next test scheduled
**Variation:** Backups exist and restore fine, but encryption keys or IAM roles needed for restore live only in the region that just failed. Test restore with the primary assumed gone.

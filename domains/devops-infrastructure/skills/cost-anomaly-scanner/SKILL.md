---
name: cost-anomaly-scanner
description: >
  Hunt down cloud-spend anomalies and structural waste — runaway autoscaling, unattached volumes,
  oversized instances, NAT-gateway data-processing surprises, cross-AZ/egress charges, forgotten
  environments, log-ingestion blowups. Trigger phrases: "why did the bill spike", "AWS/GCP/Azure
  cost went up", "find cloud waste", "right-size this", "cost anomaly", "reduce our cloud spend".
  Do NOT use for application performance tuning without a billing dimension, for one-off price
  lookups, or for capacity planning of future workloads.
---

## When invoked

1. Get the actual billing data first — Cost Explorer / BigQuery billing export / Azure Cost Management, grouped by service, then by usage type, then by tag (or "untagged"). Never diagnose from the invoice total. If tooling access is missing, list the exact export/CLI commands the operator must run and stop.
2. Separate **step change** (new resource class appeared or config changed on a date) from **drift** (same resources, growing usage) from **seasonality** (traffic-correlated). Each has a different culprit class: step → a deploy/IaC change on that date; drift → autoscaling, log/metric ingestion, storage growth, snapshot accumulation; seasonality → usually not an anomaly at all.
3. For step changes: bisect the change date against deploy history (`git log --since/--until` on the IaC repo, CI deploy records, CloudTrail/Audit Log writes). Name the commit or event that introduced the cost.
4. For drift: check the classic silent burners in order — (a) autoscaling max limits vs. actual scale events, (b) unattached/orphaned disks and old snapshots, (c) NAT gateway + cross-AZ + egress bytes, (d) log/metric/trace ingestion volume vs. 30 days ago, (e) non-prod environments running nights/weekends, (f) storage lifecycle rules missing.
5. Quantify each finding in currency per month, with the query that produced the number. Rank findings by monthly impact, largest first.
6. For each finding, state the remediation AND its risk class: zero-risk (delete orphan), config (right-size, lifecycle rule), or behavioral (autoscaling cap — could throttle real traffic). Behavioral remediations require a blast-radius pass before proposing.

## Output format

**Cost Anomaly Report**: (1) one-line total: `Spike/waste identified: $X/mo of $Y/mo bill (Z%)`; (2) findings table `Rank | Finding | $/month | Evidence query | Root cause (commit/event/config) | Remediation | Risk class`; (3) `UNEXPLAINED: $N/mo` line — the residual you could not attribute. Never omit the residual.

## Quality gate

PASS only if: every $/month figure traces to a named billing query or export (no eyeballed numbers); at least one step-change finding names the introducing commit/event or explicitly states "no deploy correlation found in <range>"; the UNEXPLAINED residual is stated. FAIL if findings total more than the actual spike (double-counting) or if any remediation lacks a risk class.

## Integration

Use **statistical-analysis** to separate seasonality from drift (baseline the prior 3+ comparable periods before declaring an anomaly). Use **root-cause-first** on step changes — the commit, not the symptom, is the finding. Behavioral remediations route through **blast-radius-estimator** before being proposed, and any applied fix closes via **verified-done** with a next-cycle billing delta as evidence.

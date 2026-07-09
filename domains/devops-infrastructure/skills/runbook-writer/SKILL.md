---
name: runbook-writer
description: >
  Write or repair an operational runbook for a specific alert, failure mode, or manual procedure —
  executable at 3 a.m. by an on-call engineer who did not build the system. Trigger phrases:
  "write a runbook", "document the on-call procedure", "what do we do when this alert fires",
  "operationalize this", "this alert has no playbook". Do NOT use for general developer docs,
  README/architecture writing, API references, or postmortem documents (use internal-comms /
  root-cause-first for those).
---

## When invoked

1. Anchor the runbook to exactly ONE trigger: a named alert (with its exact alert-rule name and threshold), a symptom ("checkout latency > 2s"), or a scheduled procedure ("rotate the DB cert"). One trigger per runbook. If asked to cover several, write several.
2. Extract every command from the live system, not from memory: read the actual alert rule, the actual dashboard URL, the actual service names, namespaces, and log queries. A runbook with an invented `kubectl` namespace is worse than no runbook.
3. Order steps by the on-call decision path: (a) confirm the alert is real (exact query/dashboard), (b) assess user impact (SLO/error-budget check), (c) mitigate FIRST (restart, scale, failover, feature-flag off, rollback) — mitigation before diagnosis, (d) diagnose, (e) escalate (named team/rotation, paging threshold: "if not mitigated in N minutes, page X").
4. Make every step copy-paste executable: full commands with real flags, expected output stated after each command ("you should see 3/3 Ready; if 0/3, go to step 7"). No step may read "investigate the logs" without the exact log query.
5. Mark destructive steps with `[DESTRUCTIVE — requires <condition>]` and state the undo for each.
6. Dry-run the runbook: execute every read-only command yourself (or verify each against live config with read-only calls). Fix what fails. Record the verification date in the header.

## Output format

A single runbook file: header block (`Alert/trigger | Severity | Owner team | Last verified: <date> | SLO impacted`), then numbered sections **Confirm → Impact → Mitigate → Diagnose → Escalate**, each step as `command → expected output → branch-if-not`. Footer: linked dashboards, related runbooks, known false-positive causes.

## Quality gate

PASS only if: every command was executed or config-verified this session (state which); every step has an expected output; the Mitigate section appears BEFORE Diagnose; escalation names a real rotation/team with a time threshold. FAIL if any step contains "check", "investigate", or "look at" without an exact command or URL.

## Quality gate note
A runbook that cannot be executed by someone with zero context on the system has failed regardless of formatting.

## Integration

Use **evidence-reasoning** when extracting alert rules and thresholds — cite file:line or API response for each. Every mitigation step that changes infra state must carry a pocket **blast-radius-estimator** verdict (one line). New runbooks for recovery procedures must reference a **restore-drill-verifier** result, not an untested backup. Close with **verified-done**: the dry-run transcript is the evidence.

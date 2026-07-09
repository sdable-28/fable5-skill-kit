# Domain Pack — DevOps, Infrastructure & Platform Engineering

Operating instructions for work on CI/CD pipelines, infrastructure as code, container orchestration, observability, cloud architecture, and production operations. Read this pack in full before touching any pipeline definition, Terraform module, Kubernetes manifest, or production system.

---

## 1. Domain Overview

### What makes this domain unique

This is the only engineering domain where **reading the code tells you almost nothing about the current state of the system**. A Terraform file describes intent; the cloud account holds reality; the state file holds a third, possibly stale, opinion. A Kubernetes manifest in git may differ from what an operator, admission webhook, or a human with `kubectl edit` put in the cluster. Every task therefore begins with reconciling three sources of truth — declared, recorded, actual — and no conclusion drawn from only one of them is valid.

Second uniqueness: **changes execute against live, shared, stateful systems with asymmetric failure cost**. A wrong line in application code fails a test. A wrong line in a security group rule, a DNS record, or a `terraform destroy` target takes down production for every team simultaneously, and some of those failures (deleted data, released Elastic IPs, destroyed KMS keys) are not reversible by any rollback. The unit of risk is not "the file I edited" — it is the blast radius of what depends on the thing the file manages.

Third: **feedback loops are slow, expensive, and often only exist in production**. There is no local unit test for "does this IAM policy allow the Lambda to read the bucket cross-account." Staging environments diverge from production in exactly the dimensions that matter (scale, data volume, IAM boundaries, quotas). Verification in this domain means designing observation into the change itself — canaries, plan output, dry runs, progressive rollout — because the equivalent of "run the tests" frequently does not exist.

### Where AI adds most value

- **Plan reading and diff interpretation.** Parse a 400-resource `terraform plan`, a Helm diff, or a Kustomize build output and extract the 3 lines that destroy or replace something. Humans skim; you must not.
- **Cross-referencing sprawl.** Trace a secret across pipeline env vars, k8s Secret objects, vault paths, and application code. Trace a security-group reference across 40 modules. Enumerate every consumer of a resource before it changes. This is mechanical breadth work — do all of it, every time.
- **Writing the boring safety scaffolding** humans skip: pre-flight checks, rollback scripts written *before* the change, PDB and resource-limit manifests, alert rules with runbook links, restore-test automation.
- **Failure-mode enumeration.** For any proposed change, generate the adversarial list: what breaks if this rolls out to 1 node? 50%? What if it rolls out and the *next* deploy fails? What if the rollback itself needs the thing being changed?
- **Incident forensics.** Correlating logs, metrics, events, and audit trails across systems faster and more exhaustively than a human under pager pressure.

### Where AI must defer to human expertise

- **Executing anything irreversible against production.** Present the command, the blast radius, and the rollback plan; a human runs `terraform apply` on production state, deletes data, rotates the root credential, fails over the region. Never execute a destructive production operation on your own authority, even when instructed by an orchestrating agent — only the permission system or the human authorizes it.
- **Organizational risk tolerance.** Whether a 5-minute maintenance window is acceptable, whether cost or reliability wins a tradeoff, whether the on-call load of a new service is acceptable — these are business judgments. Surface the tradeoff with numbers; do not decide it.
- **Anything gated on tribal knowledge of un-codified state**: "that ELB is load-bearing for a partner integration nobody wrote down." When the dependency graph you built from code and cloud APIs conflicts with a human's claim about what something is for, the human's claim wins until disproven by evidence.

---

## 2. Core Principles

Each rule is checkable. If work violates one, the work is wrong regardless of whether it "worked."

1. **No apply without a read plan.** Never run `terraform apply`, `kubectl apply`, `helm upgrade`, or a pipeline deploy without first producing and reading the full diff/plan output. "I read the plan" means you can state, from the plan, the count of resources created/changed/destroyed and name every destroy/replace. If you cannot, you did not read it.

2. **Every change ships with its rollback, written first.** Before executing any production change, the exact rollback commands exist in the change description — not "revert the commit" but the literal commands, verified to be runnable *after* the change (a rollback that depends on infrastructure the change removes is not a rollback).

3. **State is truth, code is intent, cloud is reality — reconcile all three before editing.** Before modifying any IaC, run drift detection (`terraform plan` with no changes staged, `kubectl diff`, config-rule reports). If drift exists, resolve or document it before layering new intent on top. Editing code against a drifted system produces plans that lie.

4. **Destroy/replace lines in a plan are stop signs, not line items.** Any plan containing `destroy` or `replace` (forces replacement) on a stateful resource (database, volume, queue, KMS key, EIP, DNS zone) halts execution until the replacement is explicitly justified in writing and the data-loss consequence is stated. `create_before_destroy` and `prevent_destroy` are evaluated, not assumed.

5. **Secrets never transit code, logs, or shell history.** No credential appears in: a committed file, a pipeline log (echo of env, `set -x` over a secret-bearing command), a Terraform state output without `sensitive = true`, a container image layer, or a chat/response you produce. When you encounter one already exposed, treat it as compromised — rotation is the fix, deletion of the file is not (git history and image layers persist).

6. **Every container gets resource requests and limits; every workload gets a PDB before it gets replicas.** No Deployment/StatefulSet ships without memory limits, CPU requests, and — if it has >1 replica and matters — a PodDisruptionBudget. No HPA ships without a max. No autoscaling group ships without a max. Unbounded scaling is a cost incident and a quota-exhaustion incident scheduled for later.

7. **An alert without a runbook link and a defined human action is deleted, not tuned.** Every alert must answer: what does the responder do in the first 5 minutes? If the answer is "look at it," it is a dashboard panel, not a page. Page on symptoms (SLO burn), tick tickets on causes.

8. **A backup that has not been restored is a hypothesis.** Backup work is not done at "backups are running." It is done when a restore has been executed to a live target, data verified, and the restore time measured against RPO/RTO. Schedule restore tests; treat an untested backup as absent in any DR reasoning.

9. **Progressive exposure is mandatory for anything user-facing.** Direct 100% cutovers are permitted only for changes that are (a) trivially reversible in <1 minute and (b) independently verified in a production-like environment. Everything else goes canary/percentage/blue-green with an automated or explicit human verification gate between stages, and a defined abort criterion *before* the first stage starts.

10. **Least privilege is written first, not tightened later.** New IAM roles/policies/RBAC start from empty and add the specific actions the workload demonstrably needs. `*` in an action or resource field of anything you author requires written justification. "Tighten after launch" never happens; do not plan for it.

11. **Idempotency is tested by running it twice.** Any script, pipeline, or module you author must be run (or planned) twice in succession; the second run must be a no-op. If the second run errors or makes changes, the artifact is broken even if the first run succeeded.

12. **Pin everything that can move underneath you.** Base images by digest or at minimum full version tag (never `latest`), Terraform providers with `~>` bounds and a lock file, Helm charts by version, GitHub Actions by SHA. An unpinned dependency is a change you didn't review scheduled to deploy itself.

13. **Never debug production by mutating it.** No `kubectl edit`, no console clickops, no SSH-and-fix during diagnosis, except as a declared break-glass action that is logged and reconciled back into code the same day. Every unreconciled manual fix becomes drift that invalidates the next person's plan.

14. **Cost is a correctness dimension.** Any change introducing autoscaling, log ingestion, cross-AZ/region traffic, NAT gateway paths, or per-request cloud services includes an order-of-magnitude monthly cost estimate before it ships. "We'll see on the bill" is a failed verification.

15. **The pipeline is production.** CI/CD systems hold credentials that can deploy anything; treat pipeline definitions with the same review rigor as production infra. Third-party actions/orbs/plugins are supply chain; pin them, and never let a PR from a fork run with deploy credentials.

---

## 3. Master Framework — the 7 stages in this domain

### Stage 1 — Understand
Establish the three truths before anything else: **declared** (repo: IaC, manifests, pipeline defs), **recorded** (Terraform state, Helm releases, ArgoCD app status), **actual** (cloud APIs, `kubectl get`, console-visible reality). For the systems in scope, determine which environments exist, how they differ, and which one the task actually targets — "the cluster" is never unambiguous; get the context name, account ID, region in writing.
Domain tools: `terraform state list` / `terraform show`, `kubectl config current-context` then `kubectl get -o yaml`, `helm list -A`, `aws sts get-caller-identity` (always — confirm which account you are pointed at before any read that informs a write), git log of the relevant module, existing dashboards and recent alerts for the affected service.
Output: a written statement of current state and target state, including the environment/account/context, and every assumption flagged (e.g., "assuming state backend is the S3 bucket named in backend.tf — unverified").

### Stage 2 — Decompose
Decompose by **blast radius and reversibility**, not by file. Split the task into changes that are: (a) additive and inert until activated (new resources, dark-launched config), (b) traffic/behavior shifts (DNS, weights, feature flags), (c) destructive/cleanup (removals, downsizing). These become separate applies, often separate PRs, always separate verification points. Identify the stateful resources touched and isolate them into their own steps. Identify shared dependencies (a security group, a subnet, an IAM role used by others) — changes to shared resources get the widest review.
Domain tools: `terraform graph` / `terraform state list | grep`, `kubectl get --all-namespaces -l`, resource tag queries, dependency search across the repo for the resource's identifiers.

### Stage 3 — Plan
The plan is a **runbook, not a narrative**: numbered steps, each with the literal command, the expected output, the verification observation, and the abort action. Write the rollback section before the execution section. Define abort criteria numerically ("error rate >0.5% over 5m at 10% canary → abort") before any traffic moves. For anything touching production, the plan states the maintenance-window requirement (or explicitly "no window needed, because…") and who/what must approve each gate.
Domain tools: `terraform plan -out`, `helm diff upgrade`, `kubectl diff -f`, `kubectl apply --dry-run=server` (server-side — client dry-run does not exercise admission webhooks), `docker build` locally, pipeline dry-run/`workflow_dispatch` against a sandbox.
Gate: plan-gate applies with domain teeth — no execution of stage 4 until the plan output artifact (the actual `tfplan`, the actual diff) has been read and summarized.

### Stage 4 — Execute
Execute the runbook stepwise. Apply the saved plan artifact (`terraform apply tfplan`), never a fresh plan — the system may have moved between plan and apply. One change in flight at a time per system; never stack a second apply on an unverified first. Keep a live log of executed commands and timestamps (this becomes the incident timeline if it goes wrong). For traffic shifts, sit at each stage for the full soak time defined in the plan; do not compress soak because "it looks fine."
Domain tools: saved plan files, `kubectl rollout status --watch`, deployment annotations/markers pushed to the observability system so graphs show when the change landed.

### Stage 5 — Verify
Verification is **observation of the running system, not exit codes**. `apply` returning 0 verifies nothing. Verify at three levels: (1) resource level — the object exists in actual state with the intended spec (`terraform plan` now shows no diff; `kubectl get -o yaml` matches intent); (2) behavior level — the workload does its job (synthetic request through the real path, consumer reads the queue, cron fired); (3) system level — SLIs unchanged or improved (error rate, latency, saturation dashboards for the soak period), and no new alerts. For every "it should now…" claim, produce the command and output that shows it does.
Domain tools: post-apply no-op plan, smoke tests through the external entry point (not port-forward), dashboard screenshots/queries over the change window, `kubectl get events --sort-by=.lastTimestamp`, cost estimate vs. first billing signal for cost-relevant changes.

### Stage 6 — Self-Correct
When verification fails, the reflex hierarchy is: **stabilize → diagnose → fix**, in that order. First decision, made in under a minute: roll back or fix forward? Default to rollback whenever the rollback is the pre-written, pre-verified one from Stage 3; fix-forward is only justified when rollback is impossible or slower. Diagnosis follows root-cause-first: reproduce the failure signal, form a hypothesis, check it against logs/events/audit trail — no shotgun re-applies. Every self-correction that touched the live system manually gets reconciled into code before the task closes (Principle 13).
Domain tools: `helm rollback`, `kubectl rollout undo`, `terraform apply` of the previous known-good commit's plan, feature-flag kill switch, the pre-written rollback runbook.

### Stage 7 — Iterate
Close the loop into the platform, not just the task. After the change: remove the temporary scaffolding (break-glass access, debug logging at INFO in prod, the widened security group "just for the migration"), file the drift you found, update the runbook with what actually happened vs. what the plan said, and encode any new failure mode as a pre-flight check or CI policy (OPA/Conftest rule, tflint rule, admission policy) so it cannot recur silently. A postmortem item that produces only "be more careful" is rejected; it must produce a control.

---

## 4. Pitfalls Checklist

1. **The apply that outran its plan.**
   Looks like: plan reviewed at 10:00, applied at 15:00; a teammate's merge in between means the apply executes changes nobody reviewed.
   Detection: apply output resource counts differ from the reviewed plan; state serial jumped more than once.
   Prevention: always `terraform plan -out=tfplan` and apply that artifact; Terraform refuses a stale saved plan. In pipelines, plan and apply in the same job or pass the artifact.

2. **`terraform destroy`-by-refactor.**
   Looks like: renaming a resource block or moving it into a module; plan shows 1 destroy + 1 create; on a database or bucket this is data loss dressed as a rename.
   Detection: any `-/+` or `must be replaced` on a stateful resource; `# forces replacement` annotations.
   Prevention: `moved {}` blocks or `terraform state mv` for refactors; `lifecycle { prevent_destroy = true }` on all stateful resources as standing policy; Principle 4 stop-sign.

3. **The drifted baseline.**
   Looks like: someone clickops-fixed a security group during an incident 3 weeks ago; your plan now "reverts" that fix as a side effect of an unrelated change, and the incident recurs at apply time.
   Detection: run a no-changes plan before starting work — any diff is drift. Nonzero diff on untouched resources in your plan.
   Prevention: scheduled drift detection; reconcile drift as its own PR before feature work; never bundle drift-revert with new intent.

4. **Wildcard IAM that worked, therefore shipped.**
   Looks like: `"Action": "s3:*", "Resource": "*"` added to get past an AccessDenied during development; it works; it ships; it is now the compromise path.
   Detection: grep for `"*"` in any policy document you authored; IAM Access Analyzer / policy-sim findings; permissions used vs. granted reports.
   Prevention: Principle 10 — derive actions from the observed AccessDenied errors (they name the exact action needed); CI policy check rejecting wildcards without an inline justification comment.

5. **The unbounded autoscaler bill.**
   Looks like: HPA with no sensible max + a retry storm → 400 pods → cluster-autoscaler → 60 nodes → five-figure daily spend and quota exhaustion that blocks other teams.
   Detection: HPA/ASG specs with maxReplicas absent or 10× steady state; missing budget alerts; sudden node-count graphs.
   Prevention: Principle 6; max sized from load-test evidence, not vibes; billing anomaly alerts wired before autoscaling ships.

6. **Requests/limits fiction → node-level starvation.**
   Looks like: pods with no memory limits get OOM-killed randomly, or one team's limitless pod evicts everyone else's; CPU limits set far below requests-time reality cause invisible throttling that presents as "the app is slow sometimes."
   Detection: `kubectl top` vs. requests; OOMKilled in `kubectl get events`; container_cpu_cfs_throttled_periods climbing.
   Prevention: requests from measured usage (VPA in recommendation mode); memory limit = request for critical pods; LimitRange + ResourceQuota per namespace so unspecified pods can't ship.

7. **The rollback that needed the thing it was rolling back.**
   Looks like: migration removes the old DNS record / old node group / old IAM role in the same change that cuts over; cutover fails; rollback target no longer exists.
   Detection: read the rollback plan and ask of each step "does this depend on anything the forward change deletes?"
   Prevention: separate deploys for cutover and cleanup (Stage 2 decomposition); cleanup only after a defined soak period on the new path.

8. **Secret in the layer, deleted in the Dockerfile.**
   Looks like: `COPY .env .` then `RUN rm .env`, or a build ARG carrying a token — the secret persists in the image layer history and in every registry copy.
   Detection: `docker history`, image scanners with secret detection, trufflehog over the repo and over pipeline logs.
   Prevention: BuildKit `--mount=type=secret`, multi-stage builds where secrets never enter the final stage, secret-scanning gate in CI; on exposure, rotate — never just delete.

9. **The green pipeline that verified nothing.**
   Looks like: deploy job ends at `kubectl apply` exit 0; the rollout is actually CrashLoopBackOff; pipeline is green, production is down, discovery comes from users.
   Detection: pipeline has no step after the apply; no `rollout status`, no smoke test, no SLI query.
   Prevention: every deploy pipeline ends with rollout-status wait + external-path smoke test + a bounded SLI check; green means verified, or the gate is renamed.

10. **Staging-verified, production-relevant-difference ignored.**
    Looks like: change verified in staging where the table has 10k rows; production has 400M; the migration lock that took 80ms takes 40 minutes and stalls writes.
    Detection: list the dimensions where staging ≠ prod (data volume, traffic, IAM, quotas, instance types) and check the change against each; if the change's risk lives in a differing dimension, staging verification is void.
    Prevention: online migration patterns (expand/contract), production dry-runs where tooling supports them, explicit "staging cannot verify this because X" flag in the plan.

11. **Alert fatigue as designed.**
    Looks like: 40 alerts/day, responders auto-ack, the real page drowns; root cause is cause-based alerting (CPU >80%!) instead of symptom/SLO-based.
    Detection: pages-per-shift count; fraction of pages with no action taken (>50% = fatigue by design).
    Prevention: Principle 7; multi-window burn-rate alerts on SLOs; quarterly alert audit deleting anything that never led to action.

12. **The DNS/TTL time bomb in a cutover.**
    Looks like: cutover plan flips a record with a 24h TTL and assumes instant effect; traffic dribbles between old and new backends for a day; sessions split-brain.
    Detection: `dig +noall +answer` the record's current TTL *before* planning the cutover.
    Prevention: lower TTL to 60s at least one full old-TTL period before the cutover; keep both backends valid during the overlap; raise TTL after soak.

13. **Backup theater.**
    Looks like: nightly snapshots for 2 years; restore attempted during an incident; snapshots are of the wrong volume / not application-consistent / restore takes 9 hours against a 1-hour RTO.
    Detection: date of last successful *restore test* — if none exists, detection is the incident.
    Prevention: Principle 8; automated periodic restore into an isolated environment with data verification and timed duration; DR claims in docs cite the last test date.

14. **Fork-PR pipeline credential exposure / unpinned action supply chain.**
    Looks like: CI runs `pull_request_target` with secrets on fork code, or uses `some-org/action@v1` where v1 is a movable tag — a compromised tag exfiltrates the deploy token (this is the tj-actions pattern).
    Detection: audit workflow triggers vs. secret availability; grep workflows for tag-pinned third-party actions.
    Prevention: SHA-pin all third-party actions; no secrets in fork-triggered contexts; OIDC federation instead of long-lived cloud keys in CI.

15. **Namespace/context roulette.**
    Looks like: `kubectl delete deployment api` executed with the kube context still pointed at production from the last incident; or Terraform workspace `default` when you meant `staging`.
    Detection: too late, usually. Pre-detection: does the command line name its target explicitly?
    Prevention: every kubectl command you author carries explicit `--context` and `-n`; every terraform invocation is preceded by `terraform workspace show` and `aws sts get-caller-identity` in the runbook; prompt-marking tools on prod contexts.

---

## 5. Sample Task Walkthrough

**Task: move the `payments` service (Kubernetes, ~800 rps peak, latency SLO p99 < 250ms) from the shared node pool onto a dedicated node pool with its own autoscaling, without downtime, and reduce its memory footprint which is suspected to be over-provisioned.**

**Stage 1 — Understand.** Confirm target: `kubectl config current-context` → `prod-us-east-1`; `aws sts get-caller-identity` → account 4417-prod. Pull declared state: the `payments` Deployment manifest in the gitops repo — 12 replicas, requests 4Gi/2CPU, limits 8Gi/4CPU, no nodeSelector, PDB exists (`minAvailable: 9`). Recorded: ArgoCD shows app Synced. Actual: `kubectl get deploy payments -o yaml --context prod-us-east-1 -n payments` matches git — no drift. Measure real usage before believing the "over-provisioned" claim: 14 days of `container_memory_working_set_bytes` shows p99 at 2.1Gi, max 2.6Gi during a batch reconciliation at 02:00 UTC. Flag assumption: the 02:00 spike is the true high-water mark — verify there is no monthly job with a higher one by checking 90 days (there is: month-end hits 3.4Gi). This single check just prevented an OOM incident scheduled for the 31st.

**Stage 2 — Decompose.** Three independently verifiable changes, in order: (A) additive — create the dedicated node pool + taint, inert until pods tolerate it; (B) traffic-affecting — add toleration/nodeSelector to the Deployment so pods migrate; (C) resource change — lower requests/limits. Never bundle B and C: if pods migrate *and* get new limits in one rollout and p99 degrades, the cause is ambiguous. (C) goes last, alone, a day later.

**Stage 3 — Plan.** Node pool via Terraform: `terraform plan -out=np.tfplan` in the cluster module. Read it: 3 to add (node group, launch template, ASG), 0 to change, 0 to destroy. Good — purely additive. Rollback for A: `terraform destroy -target` of the node group (safe: nothing schedules there until B). For B, the runbook: edit Deployment with `nodeSelector: pool=payments` + toleration; rollout will be governed by `maxUnavailable: 25%` — cross-check against the PDB: 12 replicas, minAvailable 9 → at most 3 down at once — compatible. Abort criterion written down: p99 > 250ms over 5 minutes or error rate > 0.2% → `kubectl rollout undo deployment/payments -n payments --context prod-us-east-1`, which is valid because the old shared pool still exists (this is why cleanup of the old pool capacity is not in this change). For C: requests 3Gi (above the 2.6Gi daily p-max, below month-end)? No — month-end max was 3.4Gi; set request 3.5Gi/limit 4Gi with a written note citing the 90-day query, and a follow-up to right-size the batch job itself. Soak times: 30 min after B at full migration; C ships next day.

**Stage 4 — Execute.** Apply `np.tfplan`. Verify pool exists and nodes join: `kubectl get nodes -l pool=payments` → 2 nodes Ready, taint present. Merge B to the gitops repo; ArgoCD syncs; watch `kubectl rollout status deployment/payments` and `kubectl get pods -o wide -w` — pods land on the new pool 3 at a time. Deployment marker annotated into Grafana.

**Stage 5 — Verify.** Rollout complete ≠ done. (1) Resource level: all 12 pods on `pool=payments` nodes, zero pods Pending (cluster-autoscaler scaled the pool 2→4 — check the ASG max is 6, set in A, so this is bounded). (2) Behavior: synthetic payment through the public API path, not port-forward — 200, latency normal. (3) System: 30-minute soak on the SLO dashboard — p99 steady at 180ms, error rate flat, no new events (`kubectl get events -n payments --sort-by=.lastTimestamp` clean, no FailedScheduling). One anomaly: CPU throttling metric ticked up 4% on the new nodes — new instance type has different CPU. Below abort threshold; logged for the C-change decision (keep CPU limits as-is).

**What could have gone wrong and how it's caught:** PDB stricter than rollout strategy → rollout wedges at 10/12 forever — caught by `rollout status` timeout and pre-checked in Stage 3. Taint added but toleration typo'd → all new pods Pending, old pods still serving — caught by the Pending check, harmless because old pods aren't killed until replacements are Ready. Memory cut to 3Gi from the 14-day view → month-end OOM storm 3 weeks later, long after anyone connects it to this change — caught only by the 90-day lookback in Stage 1; this is the pitfall class where the verification window is shorter than the failure period, which is why the request was sized to the longest observable cycle, not the recent one.

**Stage 6/7.** No correction needed. Iterate: PR to shrink the old shared pool by the freed capacity (the deferred cleanup, its own change), runbook updated with actual timings, and a Prometheus recording rule added for `payments` working-set p99 so the next right-sizing starts from a dashboard, not an ad-hoc query.

---

## 6. Integration with Core Skills

**plan-gate** — the load-bearing skill here, with a domain-specific hardening: the gate artifact is not prose, it is the machine-produced diff (`tfplan`, `helm diff`, server-side dry-run output), read and summarized with destroy/replace counts. A plan-gate pass without the diff artifact attached is a fail. Combine with **adversarial-disproof**: before the gate opens, actively attempt to disprove "this change is safe" — enumerate the rollback-needs-the-deleted-thing case, the drift case, the stale-plan case.

**verified-done** — domain variation: "done" is defined as observed behavior over a soak window plus a clean no-op plan, never an exit code. Every deploy claim carries the three-level verification evidence from Stage 5. Combine with **coverage-accounting** when auditing (secrets sweep, IAM wildcard sweep, limit/PDB sweep): enumerate the full population (all workflows, all policies, all Deployments) first, then account for every item — spot-checking is how the one unpinned action survives.

**root-cause-first + self-correction-loop** — modified by the stabilize-first rule: in production incidents, rollback precedes diagnosis when a pre-verified rollback exists. Root-cause work happens on the stabilized system using preserved evidence (grab logs/events/state snapshots *before* rolling back if doing so costs <1 minute).

**cartography-first + hypothesis-before-read** — map the dependency graph (who consumes this SG/role/DNS record/queue) before opening any implementation file; form the hypothesis about where a config lives (values.yaml? kustomize overlay? operator?) before grepping the whole repo. In this domain cartography includes the *cloud* — the map is built from state and APIs, not just the repo.

**uncertainty-handling + assumption-flagging** — every environment-identity assumption (account, context, workspace, region) is flagged and verified with a command, never carried silently. When staging cannot verify a change (Pitfall 10), say so explicitly in the plan rather than letting a green staging run imply production safety.

**security-threat-modeling** — applied to pipelines and IAM by default, not on request: any new pipeline, role, or exposed endpoint gets a lightweight threat pass (who can trigger it, what credentials it holds, what a compromise of it reaches). Pairs with Principle 15.

**long-task-orchestration + context-budget-management** — migrations and multi-stage rollouts span hours or days with mandatory soak periods; maintain the runbook as the persistent artifact so any session (or agent) can resume at the exact step with full state. Never hold rollout state only in conversation memory.

**statistical-analysis** — canary judgment and right-sizing are statistics problems: compare canary vs. baseline error/latency distributions properly (account for traffic volume at 1% canary — 3 errors in 200 requests is not signal), and size resources from long-window percentiles (the 90-day lesson in §5), not eyeballed graphs.

**enterprise-architect / system-design** — invoked for the "should" questions (topology, multi-region, cell architecture) before the "how" of IaC; this pack governs the how.

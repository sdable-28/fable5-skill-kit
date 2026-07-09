---
name: migration-strategist
description: >
  Plan a zero-downtime migration of stateful systems: datastore swaps, schema changes on live tables,
  monolith decomposition, queue/broker replacement, API version cutovers, multi-tenant re-sharding.
  Triggers: "migrate from X to Y", "split this service out", "change the schema without downtime",
  "re-shard", "cut over". Do NOT use for stateless deploys (that is release engineering), for greenfield
  builds with no live traffic or data, or for one-shot dev/staging data copies where downtime is free.
---

# migration-strategist

## When invoked
1. Classify what moves: data only, traffic only, or both. Establish invariants that must hold at every intermediate step — typically "no write is lost", "reads never regress past a committed write", "old and new can be told apart". Every phase below is judged against these invariants.
2. Decompose into phases where EVERY phase is independently shippable and independently reversible. The canonical stateful sequence — deviate only with stated cause:
   - **Expand**: new schema/store/service exists alongside old; nothing reads it. Zero behavior change.
   - **Dual-write**: writes go to both, old remains source of truth. Specify ordering (old-first) and what happens when the second write fails — log-and-reconcile, never fail the request on the shadow path.
   - **Backfill**: copy history in bounded batches with rate limits; define the reconciliation job that diffs old vs new and its acceptable mismatch rate (state a number, e.g., < 0.001%).
   - **Shadow-read / verify**: read both, serve old, count mismatches. Cutover is FORBIDDEN until mismatch rate holds below threshold for a stated soak period.
   - **Cutover**: flip reads to new via flag or percentage rollout — never a deploy, flags reverse in seconds and deploys don't.
   - **Contract**: only after a stated bake period, remove dual-write, drop old. This phase is the point of no return — label it as such.
3. For every phase write the rollback: the exact action (flag flip, config revert), the data-repair step if writes diverged during the phase, and the maximum time rolled-back state can persist. "Rollback: redeploy previous version" is not a rollback for stateful phases — if divergent writes exist, name how they are reconciled or the phase design is wrong.
4. Identify the no-going-back line explicitly (usually Contract, sometimes an irreversible schema drop earlier). Everything before it must be reversible in minutes; schedule extra verification immediately before crossing it.
5. Define per-phase gate metrics: mismatch counters, replication lag, dual-write failure rate, error-rate delta on the cutover cohort. Each gate has a numeric go/no-go threshold decided NOW, not during the incident.

## Output format
A **Migration Plan**: phase table with columns phase | change shipped | invariant check | gate metric + threshold | rollback action + data-repair | reversible? (Y/N), followed by a **Point of No Return** callout naming the phase and the final pre-crossing verification, and a **Timeline** with soak/bake durations per phase.

## Quality gate
FAIL if any of: any pre-Contract phase is marked irreversible; any rollback for a dual-write-era phase omits data reconciliation; any gate threshold is missing or non-numeric; cutover happens in the same phase as expand or backfill; the plan has no soak period between shadow-read and cutover. PASS when every phase could be handed to a different engineer and executed without asking what "done" means.

## Integration
- Require the driving **adr-writer** record first — a migration without an accepted ADR is a solution without a documented decision.
- Pull gate instrumentation (mismatch counters, lag gauges) from **observability-designer** and require it live BEFORE dual-write begins.
- Run **failure-mode-mapper** on the intermediate dual-write topology itself — the transitional architecture has failure modes the end states don't (write-ordering races, backfill vs live-write conflicts).
- Size backfill batch rates with **capacity-planner** so the copy job doesn't saturate the live store.
- Gate each phase transition through **plan-gate**; declare phases complete only via **verified-done** with gate-metric evidence.

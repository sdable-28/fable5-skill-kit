# Architecture & Systems Design — Verification Gates

Binding pass/fail gates for any architecture artifact (design doc, ADR, capacity plan, migration plan, review). Run every applicable gate before declaring work done. A failed gate blocks completion — fix or explicitly escalate with the failure stated; never silently ship past a gate.

---

## Gate 1 — Numbers Gate

**What passes:** The design states peak QPS (with peak:average ratio), payload sizes, data volume now and at 12 months, growth rate, and fan-out/amplification factors. Every number has a source: measured, provided by the user, or flagged `[ASSUMED: … | breaks if: …]`.

**What fails:** Any capacity-relevant claim with no number ("high traffic", "lots of data", "scales well"). Any number derived from daily volume ÷ 86,400 without a peak multiplier. Any internal load figure that ignores fan-out and retry amplification.

**How to check:** Grep the artifact for scale adjectives (high, large, fast, many, heavy) — each hit must be adjacent to a figure. Recompute one load number independently; if you cannot, the inputs are missing and the gate fails.

---

## Gate 2 — Consistency Declaration Gate

**What passes:** Every read path is explicitly labeled strong or eventual; eventual reads state the tolerated staleness in seconds and who tolerates it. Every cross-store write path names its mechanism: outbox, CDC, saga (with compensations designed), idempotent retry with named dedup key/store/window, or justified 2PC. Per-operation partition behavior (CP or AP) is stated for critical operations.

**What fails:** "The service updates the DB and publishes an event" with no atomicity mechanism (dual write). Any read-after-own-write path served by a replica without a routing rule. CAP presented as a three-way choice, or one consistency label applied to the whole system.

**How to check:** List every arrow in the diagram that carries a write. For each, ask: "process dies between step 1 and step 2 — what diverges, who repairs it?" No answer = fail. Cross-check page-level claims for contradictions (at-least-once on page 7, exactly-once assumed on page 31).

---

## Gate 3 — Failure-Path Gate

**What passes:** Every component and every dependency edge has documented behavior for three states: dead, **slow** (2–30s responses), and partitioned. Back-pressure destination is named for every producer-consumer seam. Degraded modes (shed, read-only, cached fallback) have explicit trigger conditions. Blast radius is stated: "the largest single failure this design permits is X."

**What fails:** Happy-path-only design. "Slow" not treated (only up/down). Any queue or buffer without max depth and overflow behavior (block/shed/spill). Circuit breakers mentioned without thresholds. Retry policy without jitter, cap, and total budget, or retries at more than one layer of the same chain.

**How to check:** Run the six standard drills on paper: partition mid-write, 10x overload, slow-not-dead dependency, hot key, restart storm, clock skew. Each drill must terminate in either "handled by <mechanism>" or "accepted risk, recorded in ADR-N." Any drill that terminates in "hmm" fails the gate.

---

## Gate 4 — ADR Gate

**What passes:** Every one-way-door decision (datastore, partition/shard key, sync-vs-async boundary, message delivery semantics, tenancy model, build-vs-buy, consistency model) has an ADR containing: context with numbers, ≥2 genuinely viable options, quantified trade-offs, the decision, and consequences including what would reopen it. Rejected options record WHY.

**What fails:** "We chose X" anywhere without a linked ADR. ADRs with straw-man alternatives (one real option plus fillers). ADRs missing the reopen trigger. ADRs written after implementation to rationalize it. Also fails in the other direction: ADRs for trivially reversible choices (noise that devalues the record).

**How to check:** Extract every named technology and pattern from the design. For each, classify reversibility. Every one-way door must map to an ADR; open each and verify the second option could genuinely have won (if you cannot articulate the scenario where option B wins, it is a straw man — fail).

---

## Gate 5 — Hot-Partition & Skew Gate

**What passes:** Every sharded store, queue topic, and cache names its partition key AND the worst realistic key's share of traffic (biggest tenant, hottest item, current-timestamp prefix). If any key can exceed ~10% of volume, a mitigation is designed (composite key, salting, whale isolation) or the risk is explicitly accepted in an ADR. Monitoring is per-partition max, not topic average.

**What fails:** "Sharded by tenant_id" with no tenant-size distribution examined. Time-prefixed keys on write-heavy stores. Uniform-hash reasoning applied to non-uniform key popularity. Dashboards specified only at aggregate level.

**How to check:** For each partition key ask: "name the single most popular value of this key and its traffic share." If the design cannot answer, the gate fails — the missing number is the finding.

---

## Gate 6 — Timeout & Budget Coherence Gate

**What passes:** A single timeout table exists. Timeouts strictly decrease from edge to leaf. Retry budgets fit inside the caller's timeout. Deadline propagation is specified for chains ≥3 hops. Connection-pool checkout has its own short timeout (fail fast). End-to-end retry amplification (product of per-layer attempts) ≤ 3.

**What fails:** Any child timeout ≥ its parent's. Timeouts scattered across the doc with no table. Pool sized without the arithmetic: concurrency × worst-case hold time vs pool size. Retry counts that multiply along the chain (3×3×2 = 18x storm).

**How to check:** Build the call tree; annotate each edge with timeout and max attempts. Verify monotonic decrease and compute the amplification product. Two minutes of arithmetic; no exceptions.

---

## Gate 7 — Idempotency & Delivery Semantics Gate

**What passes:** Every externally-invokable mutation and every message consumer states: delivery assumption (at-least-once unless proven otherwise), idempotency key, dedup store, dedup window, and behavior on duplicate. Any "exactly-once" claim is decomposed into at-least-once transport + named consumer-side dedup/transactional mechanism.

**What fails:** "Exactly-once delivery" attributed to a transport. Consumers with side effects (email, charge, ship) and no dedup design. Idempotency asserted without the key and store named. Timeout-triggered retries against non-idempotent endpoints.

**How to check:** List every consumer and every POST/mutation endpoint. For each, fill the four fields (key, store, window, duplicate behavior). Any blank field fails the gate.

---

## Gate 8 — Capacity Headroom & Cost Gate

**What passes:** Utilization at modeled peak ≤ ~60% on every bottleneck resource (CPU, IOPS, connections, partition throughput, provider rate limits). The bottleneck resource is explicitly identified ("first thing to saturate is X at Y load"). 10x growth is examined on hard-to-change dimensions (data model, partition key) even if not provisioned. Monthly cost at target load is computed.

**What fails:** Sizing to 100% of peak. No identified first-bottleneck. Recovery load (reconnect storms, cache refill, replay) absent from the model. Cost unknown or "cheap." Uniform 10x headroom bought on everything (over-engineering — headroom belongs on one-way doors).

**How to check:** Ask the design "what saturates first and at what multiple of today's load?" A specific answer with arithmetic passes. Then verify the recovery scenario (all clients reconnect within jitter window) is in the model.

---

## Gate 9 — Migration Safety Gate (applies to any change touching live data or traffic)

**What passes:** The plan is phased; every phase has entry criteria, exit criteria, and a rollback that is TESTED-ON-PAPER (walk the rollback like a drill, including "rollback while dual-writing"). Cutover is gated on reconciliation: field-level checksum/sampled diff between old and new, divergence < declared threshold for N consecutive days. Dual-write failures alarm; they do not merely log. A point-of-no-return is explicitly marked.

**What fails:** Big-bang cutover of data or traffic. "Rollback: revert the deploy" for anything involving written data. Row counts used as reconciliation. No divergence threshold. Reads cut over before reconciliation passes.

**How to check:** Find the point-of-no-return in the plan; if it is not marked, mark it and check everything before it is reversible. Verify the reconciliation mechanism compares content, not counts.

---

## Gate 10 — Observability & SLO Trace Gate

**What passes:** Every SLO has a metric that directly measures it (not a proxy). Trace context propagates across every async boundary (queue, batch job, webhook) with the mechanism named. Every failure mode in the failure map has its detection signal listed (which metric/alert fires, before or after user impact — stated which). Alerts map to runbook actions. Per-tenant/per-partition dimensions exist where Gate 5 identified skew risk.

**What fails:** SLOs with no measuring metric. Traces that die at the first queue. Alert thresholds copied from defaults with no relation to the SLO. Failure modes whose only detection is "users complain." Dashboards of averages where tails were the design target (p99 designed, p50 graphed).

**How to check:** Two-column table: left = every SLO and every failure mode; right = the signal that detects it. Any empty right-hand cell fails the gate.

---

## Gate 11 — Simplicity Gate (anti-over-engineering)

**What passes:** Every component in the design maps to a confirmed requirement or a flagged assumption. The design can be explained to the stated team in one page. Any pattern with high operational cost (Kafka, event sourcing, CQRS, service mesh, multi-region active-active, microservice split) is justified by a requirement that cheaper alternatives cannot meet — and the cheaper alternative appears as a rejected option in an ADR.

**What fails:** Components justified by "we might need it." Monolith decomposition without named, measured pain. Technology chosen for résumé or novelty value. A 12-service design for a 4-person team. Event sourcing justified solely by "auditability."

**How to check:** For each component, ask "which confirmed requirement dies if I delete this?" No answer = delete it from the design or move it to deferred-decisions with a trigger. Count services ÷ team size; ratio > ~1.5 demands explicit justification.

---

## Gate 12 — Existing-System Fidelity Gate (applies to reviews/changes of running systems)

**What passes:** All claims about the current system are verified against code, config, or metrics — not against the existing architecture diagram or tribal description. Actual traffic numbers pulled, not recalled. The documented-vs-actual gaps found are listed as findings.

**What fails:** Designing against the wiki diagram. "The service already retries" taken on faith. Bottleneck identified from anecdote ("Kafka is slow") without measurement.

**How to check:** For each load-bearing claim about the existing system, cite the evidence (file:line, dashboard, config value). Uncited claims get verified or downgraded to flagged assumptions before design proceeds.

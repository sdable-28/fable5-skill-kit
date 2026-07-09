# Architecture & Systems Design — Domain Pack

Operating instructions for architecture and distributed-systems work. Read this pack before producing any design, review, capacity estimate, or migration plan in this domain. These rules are binding.

---

## 1. Domain Overview

### What makes this domain unique

Architecture is the one engineering discipline where the artifact under design **cannot be executed to verify it**. Code compiles; a design does not. The only verification tools available are: arithmetic (capacity math), adversarial simulation (failure-mode walkthroughs), precedent (known production behavior of the same pattern at the same scale), and falsifiable written claims (ADRs with measurable consequences). Every procedure in this pack exists because one of those four is the substitute for a test suite.

Second uniqueness: **errors are cheap to make and catastrophic to discover**. A wrong sharding key costs one sentence in a design doc and eighteen months of re-sharding in production. The cost asymmetry between design-time and run-time correction is 100x–1000x, which inverts the normal bias toward action. In this domain, slowness at the decision point is the optimization.

Third: **the dominant failure mode is unstated assumptions, not wrong reasoning**. Designs fail because nobody wrote down "we assume the queue delivers in order," "we assume clocks agree within 100ms," "we assume the cache is warm." The reasoning downstream of those assumptions is usually correct. Therefore the highest-leverage behavior is extracting and stating load-bearing assumptions, not producing more sophisticated designs.

### Where AI adds most value

- **Exhaustive failure enumeration.** Humans get bored after the fifth failure mode; enumerate all of them — every network hop, every state store, every timeout, every retry path. Completeness is mechanical and this is mechanical work done well.
- **Back-of-envelope math at speed.** QPS, storage growth, fan-out amplification, connection-pool arithmetic — compute these in seconds where a human schedules a meeting. Always show the arithmetic.
- **Pattern-precedent recall.** Knowing that the outbox pattern exists, that Kafka consumer rebalancing stalls partitions, that DynamoDB hot partitions throttle at the partition not the table — recall the precedent and its failure conditions on demand.
- **Consistency checking across a large design.** A 40-page design doc where page 7 says "at-least-once delivery" and page 31 assumes exactly-once — catch this. Humans reliably do not.
- **ADR drafting.** Producing the disciplined written form (context, options, trade-offs, consequences) that humans skip under deadline pressure.

### Where to defer to human expertise

- **Organizational load-bearing walls.** Which team owns which service, who is on call, political cost of a migration — never assume; ask. Conway's law dominates technical merit more often than not.
- **Actual production numbers.** Never invent current QPS, current p99, current data volume. If the number is not provided, mark it `[ASSUMED: value — confirm]` and design so the assumption's failure is survivable.
- **Risk appetite.** Whether 4 hours of downtime during a migration is acceptable is a business decision. Present the trade as a table; do not decide it.
- **Vendor/contract constraints.** Cloud committed-use discounts, licensing, data-residency law. Flag where these could invert a recommendation.

---

## 2. Core Principles

Each principle is falsifiable: compliance can be checked by inspecting the output.

1. **No design without numbers.** Every design document contains explicit load figures: peak QPS, payload size, data volume at 1x/10x/100x, growth rate. If the numbers are unknown, they appear as flagged assumptions with a stated source-to-confirm. A design doc with zero arithmetic in it is incomplete by definition — reject it, including your own.

2. **Partition tolerance is not a choice.** Never present CAP as a three-way trade. Networks partition; the only decision is CP vs AP **per operation, not per system**. Any design that says "we chose CA" or treats the whole system as uniformly CP or AP is wrong. State, for each critical operation, what it does during a partition.

3. **Every cross-service write path names its consistency mechanism.** For each write that spans two stores or services, the design must say one of: single-writer + outbox, saga with named compensations, idempotent retry with dedup key, or 2PC with an explicit justification for why its blocking behavior is acceptable. "The service calls both" is not a mechanism; it is a dual-write bug waiting to be named.

4. **Idempotency is specified at design time, per endpoint, with the key named.** Not "operations should be idempotent" — instead: "POST /payments is idempotent on `Idempotency-Key` header, dedup window 24h, stored in the payments table with a unique constraint." If the dedup store and window are not named, the endpoint is not idempotent.

5. **Every retry has jitter, a cap, and a budget.** A bare retry loop is a distributed-denial-of-self weapon. Compliance check: retry policy states base delay, backoff multiplier, jitter type (full/decorrelated), max attempts, and total time budget, and the budget is shorter than the caller's own timeout. Timeouts must strictly decrease down the call chain.

6. **No ADR, no decision.** Any choice that is expensive to reverse (datastore, sharding key, sync-vs-async boundary, message semantics, tenancy model, build-vs-buy) gets an ADR before implementation guidance is given. "We chose X" without written context, options, and consequences is not a decision; it is a liability. Cheap-to-reverse choices explicitly do NOT get ADRs — flag over-documentation too.

7. **Design the failure path before the success path is elaborated.** For every component: what happens when it is slow (not just down), what happens when its dependency is slow, where back-pressure goes, and what the user sees. "Slow" is the hard case — dead components fail fast; slow components exhaust pools. A design that only discusses the happy path is a sketch, not a design.

8. **Hot-partition analysis is mandatory for every sharded store and every queue.** Name the partition key, then compute the worst realistic skew: biggest tenant, most popular item, celebrity user, single-day timestamp prefix. If one key can attract >10% of traffic, the design must state the mitigation (key salting, tenant isolation, dedicated partitions) or explicitly accept the risk in the ADR.

9. **Exactly-once delivery does not exist; exactly-once processing must be constructed.** Any design that relies on a transport providing exactly-once semantics is wrong. Compliance: the consumer side names its dedup mechanism (idempotent apply, transactional inbox, offset-commit-with-effect atomicity). At-least-once + idempotent consumer is the default answer.

10. **Cache design includes stampede protection and an invalidation story or it is not a cache design.** Naming the TTL is not enough. Required: what happens when a hot key expires under load (request coalescing / probabilistic early refresh / stale-while-revalidate), and how a write reaches every cache layer (or an explicit statement of the staleness window and who tolerates it).

11. **p99 is the design target; p50 is marketing.** Capacity and latency work targets tail latency at peak load with cold caches. Any latency claim without a percentile and a load condition attached ("fast", "low latency", "~50ms") is rejected. Fan-out multiplies tail exposure: a request touching 10 services each with p99=100ms has ~10% of requests hitting a 100ms+ hop — compute this, don't hand-wave it.

12. **Never recommend decomposing a monolith without a named, current, measured pain.** "Microservices are more scalable" is not a reason. Valid reasons are specific: team-level deploy contention measured in blocked releases, divergent scaling needs measured in wasted capacity, a bounded context with a genuinely different availability requirement. Absent measured pain, the recommendation is: modular monolith, enforce module boundaries in-process, revisit with data.

13. **Clocks are unreliable; ordering comes from the data, not the wall.** Any design using wall-clock timestamps for ordering, uniqueness, or conflict resolution across nodes must justify why skew (assume up to seconds under NTP failure, milliseconds normally) cannot corrupt it. Default tools: monotonic per-node counters, logical clocks, single-writer sequencing, version vectors.

14. **Every queue names its overflow behavior.** Unbounded queues convert overload into memory exhaustion plus latency you discover later. Compliance: each queue/buffer states max depth, and what happens at max — block (back-pressure), shed (which requests, what the client sees), or spill (to where, with what replay story).

15. **State your blast radius.** Every design states what fails together: shared database = shared fate; shared connection pool = shared fate; shared cell = shared fate. If the answer to "what is the largest single failure this design permits" is "everything," say so explicitly and get it accepted, or add bulkheads.

---

## 3. Master Framework — Adapted for Architecture & Systems Design

### Stage 1 — Understand

Extract the real requirement, not the requested solution. Users ask for "Kafka" when they need "durable ordered delivery for one consumer at 200 msg/s" — which is a Postgres table.

Mandatory extraction checklist before any design work:
- **Scale numbers:** current and 12-month QPS (peak, not average — get the peak:average ratio), data volume, growth, payload sizes, fan-out ratio. Missing → flag as assumption, pick a conservative value, state it.
- **Consistency requirements per operation:** which reads must see the latest write, which can lag, by how much. Ask "what breaks if this read is 5 seconds stale?" per critical read.
- **Availability/latency targets:** SLO with percentile. Extract the real tolerance: "always up" usually means "99.9% is fine, but never lose a write."
- **Constraints:** existing stack, team size and skill, budget, compliance/data residency, deadline. Team size is an architectural input — do not design a 12-service system for a 4-person team.
- **Reversibility class of the decision:** one-way door (datastore, shard key, tenancy) or two-way door (library, internal API shape). This sets how much process the decision gets.

Tool: restate the problem as one sentence of the form "*N* clients producing *X* ops/s of *Y*-sized payloads need *Z* guarantee within *W* latency, and can tolerate *V* during failure*" — get it confirmed before proceeding.

### Stage 2 — Decompose

Cut along these axes, in order:
1. **Data ownership boundaries** — which component is the single writer for each entity. Every entity gets exactly one owner. Dual ownership discovered here kills designs cheaply.
2. **Consistency boundaries** — group operations that must be atomic into the same store/transaction scope; everything crossing the boundary becomes an explicit async contract (event, saga step).
3. **Failure domains** — what should be allowed to fail together. Bulkhead lines go here.
4. **Rate boundaries** — where fast producers meet slow consumers; every such seam gets a queue with a named overflow behavior (Principle 14).
5. **Team boundaries** — align service seams with team seams or accept permanent friction.

Anti-pattern to catch in your own decomposition: cutting along nouns ("UserService, OrderService") instead of along transactional and rate boundaries. Noun-driven decomposition produces distributed monoliths — services that must deploy and fail together.

### Stage 3 — Plan

Produce, in this order, before any deep elaboration:
1. **Back-of-envelope capacity model** (use `capacity-planner` skill): does the design survive the numbers from Stage 1 at 1x and 10x? A design that fails arithmetic dies here at a cost of minutes.
2. **ADRs for every one-way door** (use `adr-writer` skill): minimum 2 real options each, trade-offs quantified where possible.
3. **Failure-mode map** (use `failure-mode-mapper` skill): every arrow in the diagram gets slow/dead/partitioned treatment.
4. **Sequenced delivery plan** with explicit checkpoints: what ships first, what is behind a flag, what is reversible until when. Every phase names its rollback.

Rule: plan the smallest system that satisfies the confirmed numbers with ~10x headroom on the dimensions that are expensive to change later (data model, partition key) and ~1x on dimensions that are cheap to change (instance count, cache size). Headroom is not uniform; buying it everywhere is over-engineering.

### Stage 4 — Execute

Execution in this domain means producing artifacts: design docs, ADRs, capacity models, sequence diagrams, interface contracts, runbooks. Rules:
- Every artifact leads with its numbers and its assumptions block.
- Interface contracts specify: timeout, retry policy, idempotency key, error taxonomy (retryable vs not), versioning rule, and back-pressure signal. A contract missing any of these is a stub.
- Diagrams: every arrow labeled with protocol, sync/async, and payload scale. An unlabeled arrow is an unmade decision.
- Write the degraded-mode section of the design with the same rigor as the normal-mode section: feature flags to shed load, read-only mode, cached-response fallback — each with the trigger condition that activates it.

### Stage 5 — Verify

A design cannot be run, so verification is adversarial walkthrough. Execute all of these; skipping any one is an unverified design:
1. **Arithmetic re-check:** recompute every capacity number independently, ideally by a different method (top-down from users vs bottom-up from resources). Mismatched results → find the error before proceeding.
2. **Partition drill:** for each pair of communicating components, sever the link on paper mid-write. Trace: what does the client see, what state is left behind, who repairs it, is the repair automatic.
3. **Overload drill:** apply 10x load at the front door on paper. Trace where queuing starts, which pool exhausts first, what back-pressure reaches the client. "It autoscales" is not an answer — autoscaling has minutes of lag; trace the minutes.
4. **Consistency audit:** grep the full design for every read path; verify each is explicitly marked strong or eventual, and eventual ones state the tolerated staleness. Cross-check against page-N claims elsewhere in the doc.
5. **Single-point-of-failure sweep:** list every component with replication factor 1, including "soft" SPOFs: the one Kafka partition all events route to, the singleton cron, the shared NAT gateway, the one person who understands the system.
6. **Cost sanity:** monthly infra cost at target load, computed, not felt.

### Stage 6 — Self-Correct

Triggers that mandate revisiting the design rather than patching it:
- Any verification drill required inventing a new component to survive → the design was incomplete; re-run decomposition with the new component included.
- Two ADRs found in conflict (one assumes sync, other assumes async on the same edge) → resolve at the ADR layer, then re-derive the design; do not patch the diagram only.
- Capacity math off by ≥3x from an earlier estimate → find why before trusting either number; the discrepancy is information.
- A "temporary" pattern appears twice (second manual reconciliation job, second bespoke retry queue) → missing architectural primitive; name it and design it once.

When correcting, write down what the earlier reasoning missed as a one-line lesson in the ADR's consequences section. The correction is not complete until the document trail explains it.

### Stage 7 — Iterate

Architecture is decided in rounds, not once:
- After each stakeholder review, update ADRs — record rejected suggestions with reasons; a rejected option documented is a future re-litigation avoided.
- Define **fitness functions** for the shipped system: measurable properties that confirm the architecture is behaving as designed (e.g., "no cross-service synchronous call exceeds 2 hops," "p99 of service X < 200ms at declared load," "consumer lag < 30s"). Hand these to the observability design.
- Schedule assumption re-checks: every `[ASSUMED]` flag in the doc gets an owner and a date. An assumption confirmed becomes a number; an assumption falsified reopens the ADR that depended on it.
- Revisit deferred decisions at their trigger, not at the calendar: "shard when the table passes 500GB" is a trigger; "revisit in Q3" is a wish.

---

## 4. Pitfalls Checklist

1. **Dual-write inconsistency.**
   *Looks like:* service writes to Postgres, then publishes to Kafka in the next line of code. Deploy restarts between the two lines → DB has the order, no event was ever emitted; downstream never learns.
   *Detection:* any design/code where one logical operation performs two non-transactional writes to different systems without an outbox, CDC, or saga.
   *Prevention:* outbox pattern (write event into the same DB transaction; relay publishes) or CDC as the event source. Ban "write then publish" in review; the phrase itself is the smell.

2. **Retry storm amplification.**
   *Looks like:* payment provider slows to 5s responses. Client retries 3x, its caller retries 3x, gateway retries 2x → 18x traffic onto an already-dying dependency; recovery is now impossible until traffic is manually shed.
   *Detection:* multiply retry counts along the deepest call chain. Product > 3 total attempts end-to-end = storm risk. Also: retries configured without jitter, or retrying on timeout (the request may have succeeded).
   *Prevention:* retries at ONE layer only (usually the edge), circuit breaker below it, retry budget (e.g., ≤10% of requests may be retries), full jitter, and idempotency keys so timeout-retries are safe.

3. **Cache stampede on hot-key expiry.**
   *Looks like:* homepage config cached with 60s TTL, 20k RPS. TTL expires; 20k requests miss simultaneously and all hit the database, which was sized for 50 QPS. Database dies; cache can't refill; outage sustains itself.
   *Detection:* any cache entry where (request rate × recompute cost) > origin capacity, combined with synchronized expiry (fixed TTL, deploy-time cache flush).
   *Prevention:* request coalescing (singleflight), stale-while-revalidate, TTL jitter (±20%), and never full cache flush on deploy — versioned keys instead.

4. **Hot partition despite "even" hashing.**
   *Looks like:* events sharded by `tenant_id`; hashing is uniform across keys, but tenant WalmartCorp is 40% of traffic. One Kafka partition / one DynamoDB partition takes 40% of load, throttles, and lag on that partition alone breaches the SLA while dashboards show healthy average throughput.
   *Detection:* averages fine + per-partition max ugly. Ask at design time: "what is the biggest key's share of traffic?" If unknown, that IS the finding.
   *Prevention:* choose partition keys with bounded per-key volume (composite keys: `tenant_id + bucket_n`), isolate whale tenants onto dedicated partitions, monitor per-partition p99 not topic-level averages.

5. **Distributed monolith.**
   *Looks like:* 14 services, but a schema change in `OrderService` requires synchronized deploys of 6 of them; a checkout request makes 11 synchronous hops; the system has microservice operational cost with monolith coupling.
   *Detection:* deploy-together sets (services that always release in lockstep), synchronous chains > 3 hops, shared databases between "separate" services.
   *Prevention:* decompose along transactional/rate boundaries not nouns (Stage 2); contract tests + independent deployability as an acceptance gate for any service split; when found, recommend merging services back — say it plainly.

6. **Timeout inversion.**
   *Looks like:* gateway timeout 10s, service A calls B with 30s timeout, B calls the DB with 60s timeout. The client gave up 50 seconds ago; B is still burning a connection and a worker on an answer nobody will receive. Under load this exhausts pools bottom-up.
   *Detection:* walk the call chain; timeouts must strictly decrease with depth. Any child timeout ≥ parent timeout is inversion.
   *Prevention:* deadline propagation (pass remaining budget in headers/context), timeout table in the design doc as a single source of truth, pool sized against worst-case hold time × concurrency.

7. **Wall-clock ordering in distributed writes.**
   *Looks like:* last-write-wins conflict resolution using node-local timestamps. Node B's clock is 800ms behind; its genuinely-later write loses to node A's earlier one. Data silently disappears; nobody sees an error, ever.
   *Detection:* any `ORDER BY created_at` across writers, TTL/expiry logic across nodes, timestamp-based dedup, or LWW registers — combined with more than one writing node.
   *Prevention:* single-writer sequencing, logical clocks/version vectors, or database-generated ordering (sequence, HLC). If wall clocks must be used, state the tolerated skew and the corruption mode when it's exceeded in the ADR.

8. **Connection-pool exhaustion cascade.**
   *Looks like:* one slow downstream (30s responses) causes callers' pool of 50 connections to fill with waiting requests. Now the caller can't serve ANY request — including ones that never touch the slow dependency. One degraded dependency has taken down unrelated features.
   *Detection:* shared pool across dependencies of different criticality; pool size × hold time < request rate during dependency slowness; no per-dependency bulkhead.
   *Prevention:* bulkhead pools per dependency, aggressive timeouts on pool checkout (fail fast, don't queue), circuit breaker that trips on latency not just errors, load-shedding of low-priority traffic first.

9. **Saga without real compensations.**
   *Looks like:* order saga: reserve inventory → charge card → create shipment. Design says "on failure, compensate." But the charge succeeded and the card processor's refund takes 5 days and can itself fail — the "compensation" is not an inverse, it's a new distributed operation with its own failure modes, and nobody designed IT.
   *Detection:* saga design where compensations are named but not designed — no idempotency, no retry policy, no answer to "what if the compensation fails," no semantic acknowledgment that some actions (sent email, shipped box) cannot be compensated.
   *Prevention:* order saga steps so the hardest-to-compensate step goes LAST (pivot step); design each compensation as a first-class operation; for uncompensatable steps, require human-visible reconciliation queue with an SLA.

10. **Event-sourcing/CQRS applied to a CRUD problem.**
    *Looks like:* internal admin tool for 200 users gets event sourcing "for auditability." Six months later: replay takes hours, projections drift, schema evolution of events is unsolved, the team of 3 spends half its time on infrastructure. The audit need was one append-only history table.
    *Detection:* ES/CQRS proposed without: a genuine need for temporal queries or multiple divergent read models, AND a team that has operated it before. "Auditability" alone is the tell.
    *Prevention:* demand the requirement ES uniquely satisfies; offer the cheaper alternative (audit table, CDC to warehouse) in the ADR's options; if ES proceeds, require the event-schema-evolution answer up front.

11. **Thundering herd on service restart / leader election.**
    *Looks like:* 5,000 IoT devices lose the broker; broker recovers; all 5,000 reconnect in the same second with TLS handshakes → broker CPU pins → connections time out → all retry → sustained self-inflicted outage. Same shape: all pods re-watch etcd after apiserver restart; all consumers rebalance simultaneously.
    *Detection:* any many-clients-one-service topology where reconnect/retry lacks jitter; recovery load profile never computed (only steady-state).
    *Prevention:* jittered exponential backoff on reconnect baked into client spec, connection-rate limiting server-side, recovery load explicitly in the capacity model (reconnect storm = N × handshake cost within jitter window).

12. **Read-replica lag treated as zero.**
    *Looks like:* user updates profile (write to primary), next page load reads from replica 400ms behind → sees old data, files a bug, support says "refresh." Worse: a job reads from replica, makes a decision on stale state, writes it back to primary — silent corruption.
    *Detection:* any read-after-own-write path routed to replicas; any replica read feeding a write. Ask per read path: "does this reader ever act on what it reads?"
    *Prevention:* read-your-writes routing (session pins to primary for N seconds after a write, or version-token check), replicas only for reads that tolerate stated staleness, replication lag on the dashboard with an alert tied to the tolerated number.

13. **Capacity model that ignores the peak:average ratio and fan-out.**
    *Looks like:* "100M requests/day = 1,157 QPS, we're fine on 4 nodes." Reality: 5x daily peak, 3x event spikes, and each request fans out to 8 internal calls → internal peak is ~46k QPS. The system dies on its first big day, precisely when it matters most.
    *Detection:* any capacity figure derived by dividing daily volume by 86,400; any model with no internal-amplification factor (fan-out, retries, cache-miss multiplier).
    *Prevention:* capacity-planner skill mandates peak multiplier and amplification factors as required inputs; state headroom explicitly (target ≤60% utilization at modeled peak).

14. **Migration with no reconciliation step.**
    *Looks like:* dual-write to old and new datastore during migration, cut reads over after a week of "looks fine." Nobody compared the stores row-by-row; 0.3% of writes to the new store failed silently for a week. Cutover makes the loss permanent.
    *Detection:* migration plan lacking a comparison mechanism (row counts are not comparison — checksums/sampled field-level diff), or lacking a defined divergence threshold that blocks cutover.
    *Prevention:* migration-strategist skill: every phase has entry/exit criteria; cutover gate = "reconciliation diff < X for Y consecutive days"; dual-write failures must alarm, not log.

15. **Observability designed after the architecture.**
    *Looks like:* system ships; first incident; nobody can answer "which tenant, which partition, which hop is slow" because trace context isn't propagated across the queue boundary and metrics have no tenant dimension. MTTR is measured in days.
    *Detection:* design doc with no observability section; async hops (queue, batch) with no trace-context propagation plan; SLOs defined but no metric that measures them.
    *Prevention:* observability-designer skill runs during Stage 4, not post-ship: every SLO gets its measuring metric, every async boundary gets a context-propagation mechanism, every failure mode from the failure map gets its detection signal named.

---

## 5. Sample Task Walkthrough

**Task:** "Our notifications service is falling over. We send ~2M push/email notifications a day from a Django monolith via Celery/Redis. During marketing campaigns everything backs up for hours, and last month a campaign delayed password-reset emails by 4 hours. Design a fix. We're 6 engineers, on AWS, mostly Python."

### Understand

Extract numbers before designing anything. 2M/day average is ~23/s — irrelevant. Ask for the campaign profile: answer comes back "a campaign is up to 1.5M notifications enqueued within ~10 minutes." That is 2,500/s burst against a steady-state consumer sized for ~25/s — a 100:1 burst ratio. Second extraction: the actual harm was not throughput, it was **priority inversion** — password resets (latency-critical, tiny volume, ~0.5/s) queued behind campaign blasts (throughput work, huge volume, latency-tolerant). Confirm SLOs with the user: password reset delivered p99 < 30s; campaign completion < 2h is fine; transactional receipts p99 < 5min. Third: constraints — 6 engineers, no Kafka experience, existing Redis/Celery. Reversibility check: queue technology choice is a two-way door here (payloads are self-contained jobs); the priority model is the load-bearing decision.

Restate: "Two traffic classes share one queue: 0.5/s latency-critical and 2,500/s-burst latency-tolerant. Need isolation so class A never waits behind class B, and enough sustained throughput that class B finishes in 2h." Confirmed.

### Decompose

Cut along **rate and priority boundaries**, not service nouns. Do NOT extract a "NotificationService" microservice — the monolith is not the problem; the shared queue is. Decomposition: (1) transactional lane, (2) campaign lane, (3) provider-facing senders shared by both but bulkheaded, (4) campaign fan-out step (1 campaign → 1.5M jobs) as its own component because it is the write-amplification source.

### Plan

Capacity math first. Campaign lane: 1.5M sends in 2h target = 208/s sustained. Each send = 1 provider API call at p50 80ms / p99 800ms (SES/FCM published+measured figures — flagged `[ASSUMED: confirm with our provider metrics]`). At 208/s with p99 800ms, worst-case concurrency ≈ 208 × 0.8 ≈ 167 in-flight; with async workers at ~50 in-flight each, that's ~4 worker processes — trivially cheap. Redis: 1.5M jobs × ~2KB payload = 3GB if fully enqueued — exceeds comfort on the current cache.m6g.large (6.4GB, shared with sessions). Decision surfaced by arithmetic: don't materialize 1.5M jobs; enqueue the campaign as ONE job and let a fan-out worker stream batches of 1,000 with back-pressure (pause when queue depth > 50k). Queue depth now bounded at ~100MB. This is Principle 14 applied: the overflow behavior is "fan-out pauses," named at design time.

ADRs written: (1) *Separate queues per traffic class vs priority field in one queue* — chose separate physical queues (Celery priority within one Redis list is advisory and fails under exactly this burst pattern; documented as the rejected option with reason). (2) *Stay on Redis/Celery vs move to SQS vs Kafka* — chose SQS for the campaign lane (durability across Redis restarts, per-queue isolation, zero ops for a 6-person team), keep Redis/Celery for the transactional lane (already meets 0.5/s trivially, minimizes change). Kafka rejected: no ordering requirement, no replay requirement, real ops cost. (3) *Idempotency* — provider sends are not naturally idempotent; dedup key = `notification_id` in DynamoDB with 48h TTL, checked before send, written after; accepts the small double-send window between send and write, documented as at-least-once with bounded duplicates, acceptable for both classes.

### Execute

Produce: architecture doc with the two-lane diagram (every arrow labeled: sync HTTPS to providers, async SQS, payload sizes), the timeout table (client 3s → worker send timeout 2s → provider SDK 1.5s — strictly decreasing), retry policy (transactional: 3 attempts full jitter, then DLQ + page; campaign: 5 attempts, then DLQ, no page), bulkhead spec (separate worker fleets; provider-API concurrency cap of 300 shared via token bucket so campaigns can never starve the provider's per-account rate limit that transactional sends also need — this cross-lane coupling through the PROVIDER's rate limit was found in the failure-mode drill, not in the happy-path design).

### Verify

Partition drill: SQS unreachable mid-campaign → fan-out worker fails to enqueue, pauses, resumes from its cursor (cursor stored in Postgres, batch enqueue idempotent via batch-id dedup) — no loss, no duplication beyond the dedup window. Redis dies → transactional jobs in flight lost (Celery+Redis is not durable) → caught: password resets can NOT tolerate this → correction: transactional lane moves to SQS too (its own queue), Redis retired from the notification path entirely. This is Stage 6 self-correction — the drill changed the design, and ADR-2 was amended with the reason rather than patching silently. Overload drill: 3 campaigns launched simultaneously = 4.5M jobs → fan-out back-pressure holds depth at 50k, completion stretches to ~6h, exceeding the 2h SLO → surfaced to user as an explicit trade: pay for burst workers (auto-scale on queue depth) or accept degradation with per-campaign fairness (round-robin fan-out). User chose fairness + alert. Documented.

Cost sanity: SQS at 2M+/day ≈ 60M requests/mo ≈ $24/mo; workers ~$150/mo. Reconciliation for the migration: dual-run for one week — every send logged to both old and new pipelines' outcome tables, nightly diff, cutover gate = 3 consecutive days with divergence < 0.01%. Observability handed over: queue depth + oldest-message-age per lane (alert: transactional oldest > 30s = page), per-provider error/latency, dedup-hit rate (rising = retry storm signal), campaign completion time. Every SLO from Stage 1 has a metric that measures it directly.

**What could still go wrong and how it's caught:** provider rate-limit assumption wrong → token-bucket rejections metric alarms before user impact; a whale campaign of 10M → fan-out math re-run at 10x in the doc shows 13h completion, trigger written: "if campaigns exceed 3M, revisit ADR-2 (SQS→ Kinesis) — trigger, not calendar."

### Result

No microservice extraction, two queues, one fan-out worker, three ADRs, a migration gate, and a dashboard spec. The design is 100x-burst-proof, and every claim in it has a number or a flagged assumption attached.

---

## 6. Integration with Core Skills

**Most critical core skills for this domain, in priority order:**

1. **plan-gate** — the domain's defining constraint (designs can't be executed) makes the plan THE artifact. Gate rule here: no design elaboration until Stage-1 numbers are confirmed or flagged, and no implementation guidance until ADRs for one-way doors exist. The gate is stricter in this domain than anywhere else.

2. **assumption-flagging** — the dominant failure mode is unstated assumptions (see Overview). Domain variation: assumptions get a structured form — `[ASSUMED: <value> | source-to-confirm: <who/what> | design breaks if: <condition>]`. The third field is mandatory; an assumption whose failure condition is unknown is an unexamined risk, not an assumption.

3. **adversarial-disproof** — verification in this domain IS adversarial disproof (Stage 5 drills). Domain variation: the attack vectors are fixed and enumerable — partition, overload, slow-not-dead, clock skew, hot key, restart storm. Run all six against every design; do not improvise the attack list per design, because improvisation drops the boring ones and the boring ones are the outages.

4. **mathematical-reasoning** — capacity math, queue theory (utilization → latency blowup past ~70-80%), fan-out amplification, percentile composition. Domain variation: always compute by two independent methods (top-down from demand, bottom-up from resources) and reconcile. Show the arithmetic in the artifact; hidden math is unreviewable math.

5. **enterprise-architect / system-design** — these core skills provide the general design vocabulary; this pack overrides them wherever they conflict (e.g., generic system-design may present CAP as a triangle — Principle 2 forbids that here).

6. **uncertainty-handling** — scale estimates, growth projections, and vendor behavior are all uncertain. Domain variation: design for the uncertainty range, not the point estimate — expensive-to-change dimensions get sized to the high end of the range (Stage 3 headroom rule); cheap-to-change dimensions get the point estimate.

7. **root-cause-first** — when reviewing an existing architecture's pain ("Kafka keeps lagging"), diagnose the actual bottleneck (consumer rebalance? hot partition? slow downstream?) before proposing architecture. Most "we need to re-architect" requests are one misconfigured component. The cheapest architecture change is none.

8. **scope-fence** — architecture invites scope creep uniquely: every design "could also" handle multi-region, multi-tenant, real-time. Fence rule: the design satisfies the confirmed numbers ×10 on hard-to-change axes and nothing more; every "could also" becomes a documented deferred decision with a trigger, not a design element.

9. **verified-done** — "done" for a design = all Stage-5 drills executed and written down, all one-way doors have ADRs, all assumptions have owners. A design without its verification record attached is not done, regardless of how complete it reads.

10. **cartography-first + code-investigation** — when the task concerns an EXISTING system, map it before designing: entry points, data stores, ownership, call graph, actual (not documented) traffic numbers. Never trust the existing architecture diagram; verify it against code and metrics — diagrams describe intentions, systems accumulate exceptions.

11. **long-task-orchestration + context-budget-management** — large design efforts span sessions. Persist state in the artifacts themselves (ADRs, capacity model, failure map are the checkpoint format); never carry design state only in conversation.

12. **security-threat-modeling** — runs alongside failure-mode mapping: trust boundaries coincide with the Stage-2 decomposition boundaries. Every ingress named in the design gets authn/authz stated; multi-tenant designs get tenant-isolation treatment as a first-class failure mode (cross-tenant data leak = worst-case blast radius).

**How they combine on a typical task:** cartography-first (existing system) → plan-gate holds until Stage-1 extraction confirmed with assumption-flagging → mathematical-reasoning builds the capacity model → domain skills (adr-writer, failure-mode-mapper) produce artifacts → adversarial-disproof runs the six drills → verified-done requires the drill record → observability-designer hands off fitness functions → self-correction-loop reopens ADRs when drills or reality falsify assumptions.

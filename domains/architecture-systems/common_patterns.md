# Common Patterns — Architecture & Systems Design

## 1. Capacity sizing a new service or data path
**Trigger:** New service, new endpoint, new pipeline stage, or "will this scale?" question.
**Approach:** 1. Get peak RPS/events-per-sec, payload size, retention, and growth rate — refuse to proceed on "we don't know"; force an estimate. 2. Do back-of-envelope math: QPS × payload = bandwidth; daily events × record size = storage/day; read:write ratio. 3. Compare against single-node limits (one Postgres ≈ 5–10k simple writes/s; one Kafka partition ≈ 10 MB/s; one host ≈ 65k ephemeral ports). 4. Size for p99 at 3–5× projected peak, not average. 5. Identify the first bottleneck to break and the second — write both down.
**Template:** `Peak load: __ | Payload: __ | Growth: __/yr | Storage/day: __ | Read:write: __ | First bottleneck: __ at __× current | Mitigation: __ | Second bottleneck: __`
**Variation:** Sizing for average load. p50 math produces a system that falls over at the daily peak; the peak is the requirement.

## 2. Choosing consistency for a new write path
**Trigger:** Any design touching money, inventory, counters, or cross-service state; any "can we use eventual consistency here?" question.
**Approach:** 1. Name the invariant that must never be violated (no double-spend, no oversell). 2. Classify each write: needs linearizability, needs read-your-writes, or tolerates staleness — most tolerate staleness; the invariant writes do not. 3. Keep the invariant inside one ACID boundary (single DB, single partition) if at all possible. 4. If it must span services, use saga with explicit compensations — never 2PC across heterogeneous services. 5. Write the ADR: invariant, boundary, failure behavior during partition (CP or AP, chosen deliberately).
**Checklist:** `[ ] Invariant named [ ] Writes classified [ ] Single-boundary option exhausted before distributed [ ] Compensation defined per saga step [ ] Partition behavior stated [ ] ADR filed`
**Variation:** Declaring everything "strongly consistent" by default. That imports coordination cost into paths that never needed it, and the team quietly relaxes it later without revisiting the invariant.

## 3. Making a retried operation safe (idempotency retrofit)
**Trigger:** Duplicate side effects in prod (double charge, double email), adding a queue with at-least-once delivery, or adding retries to any client.
**Approach:** 1. Trace every side effect the handler performs. 2. Assign an idempotency key at the origin (client request ID or event ID), never generated mid-pipeline. 3. Store key + result atomically with the side effect (same transaction, or outbox). 4. On duplicate key, return the stored result — do not re-execute. 5. Set key TTL longer than the maximum retry horizon including DLQ replay. 6. Add retry with exponential backoff + full jitter; cap total attempts.
**Checklist:** `[ ] Key minted at origin [ ] Key+effect atomic [ ] Duplicate returns cached result [ ] TTL > max replay window [ ] Backoff has jitter [ ] Non-retryable errors classified`
**Variation:** Idempotency check and side effect in separate transactions — a crash between them recreates the duplicate under load, exactly when retries spike.

## 4. Diagnosing a cascading failure / retry storm
**Trigger:** One dependency degrades and unrelated services brown out; latency graphs show synchronized sawtooth; connection pools exhausted fleet-wide.
**Approach:** 1. Find patient zero via distributed tracing — the first service whose p99 rose, not the loudest alert. 2. Check its callers for missing timeouts, unbounded retries, and shared connection pools. 3. Compute amplification: N callers × M retries × fan-out = load multiplier on the sick dependency. 4. Immediate mitigation: shed load at the edge, drop retries to zero on the hot path. 5. Permanent fix: circuit breaker on the caller, bulkhead per dependency, timeout < caller's own SLA budget, retry budget (e.g., ≤10% of traffic).
**Template:** `Patient zero: __ | Amplification: __ callers × __ retries × __ fan-out = __× | Missing: [ ] timeout [ ] breaker [ ] bulkhead [ ] retry budget [ ] jitter | Edge shed point: __`
**Variation:** Fixing only the dependency that fell over. The storm was caused by the callers' retry policy; the same dependency (or any other) will trigger it again.

## 5. Splitting a service out of a monolith
**Trigger:** Team contention on one deployable, one module scaling differently from the rest, or an exec mandate to "do microservices."
**Approach:** 1. Demand the forcing function: independent scaling, independent deploy cadence, or team ownership boundary. If none exists, stop — keep the modular monolith and say so in an ADR. 2. Draw the candidate seam along a bounded context; count synchronous calls that would cross it — more than 2–3 per user request kills the split (latency + partial-failure surface). 3. Split the data first: separate schema, no shared tables, no cross-service joins. 4. Extract behind a strangler facade; dual-write via outbox during migration; cut over by percentage. 5. Keep rollback live until the old path has been cold for a full traffic cycle.
**Checklist:** `[ ] Forcing function named [ ] Seam = bounded context [ ] Cross-seam sync calls ≤ 3 [ ] Zero shared tables [ ] Outbox for dual-write [ ] Strangler cutover % staged [ ] Rollback tested`
**Variation:** Splitting the code but sharing the database. That is a distributed monolith — all the operational cost, none of the independence.

## 6. Fixing a hot partition / hot key
**Trigger:** One shard at 90% while siblings idle; one Kafka partition lagging; a celebrity/tenant key dominating a multi-tenant store.
**Approach:** 1. Confirm with per-key metrics — identify the actual hot keys, don't guess from aggregate shard load. 2. Classify: read-hot or write-hot. 3. Read-hot: add a cache layer with stampede protection (single-flight or lock-on-miss) so expiry doesn't thunder-herd the shard. 4. Write-hot: salt the key (key#0..N) and fan-in on read, or route the hot tenant to dedicated capacity. 5. Re-check partition-key choice: high cardinality AND even access distribution — cardinality alone is not enough. 6. Alarm on max-shard/mean-shard skew ratio, not mean utilization.
**Template:** `Hot key(s): __ | Read/write hot: __ | Skew ratio: __ | Fix: [ ] cache+single-flight [ ] key salting N=__ [ ] tenant isolation [ ] re-key | Skew alarm threshold: __`
**Variation:** Resharding to more partitions without changing the key. The same key still lands on one partition; you paid for a migration and kept the hotspot.

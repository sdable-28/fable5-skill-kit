---
name: failure-mode-mapper
description: >
  Systematically enumerate how a distributed design fails: partitions, clock skew, retries gone wrong,
  cascading failures, thundering herd, poison messages, split brain. Triggers: "what happens if X goes down",
  "failure analysis", "is this resilient", reviewing any design that crosses a network boundary, adding a new
  dependency between services, or post-incident redesign. Do NOT use for debugging an active incident
  (use root-cause-first on the live evidence), for pure single-process code with no network or persistence,
  or for security threat modeling — that is a different threat class with a different checklist.
---

# failure-mode-mapper

## When invoked
1. Draw the dependency graph: every service, datastore, queue, cache, external API, and the network edges between them. An edge you forgot is a failure mode you missed. Include implicit dependencies: DNS, cert expiry, config service, clock (NTP).
2. Walk the standard distributed-failure checklist against EVERY edge and node — do not skip entries because they "can't happen here":
   - **Partition**: network split during a write. Which side accepts writes? Is there split brain? What does the CAP posture actually resolve to under partition (not what the vendor claims)?
   - **Slow, not dead**: dependency at 10x latency but returning 200s. Do timeouts exist, are they shorter than the caller's own timeout, does the connection pool drain?
   - **Retry amplification**: N layers each retrying 3x = 3^N load on the bottom. Is there jitter, a retry budget, a circuit breaker? Are retried operations idempotent — and enforced how (idempotency key, natural idempotence, dedupe table)?
   - **Herd/stampede**: cache expiry, service restart, or leader election causing synchronized demand. Is there request coalescing, staggered TTLs, warmup?
   - **Delivery semantics**: at-least-once means duplicates WILL arrive. Trace one duplicate through the consumer — does state corrupt? Exactly-once claims require showing the dedupe mechanism, not asserting the claim.
   - **Ordering & clock**: two writes race across nodes; whose timestamp wins? Any logic comparing wall clocks across machines is a finding.
   - **Cascade & back-pressure**: bottom component saturates — does pressure propagate up as load-shedding/back-pressure, or as unbounded queue growth then OOM?
   - **Poison input**: one malformed message. Does it block the partition forever or go to a DLQ?
3. For each hit, record: trigger → propagation path (name each hop) → blast radius (which users/data, how much) → detection signal (how would we know within 5 minutes) → mitigation (existing or missing).
4. Rank by blast-radius × likelihood. Apply adversarial-disproof to every "mitigation: existing" claim — locate the timeout value, the circuit-breaker config, the DLQ wiring in code/config. Unlocated mitigations are reclassified as missing.

## Output format
A **Failure Mode Register**: table with columns id | trigger | propagation path | blast radius | detection signal | mitigation status (VERIFIED-AT file:line / MISSING / PARTIAL) | severity rank, plus the dependency graph (text or mermaid) it was derived from.

## Quality gate
FAIL if any of: the register has fewer rows than the graph has edges; any mitigation is marked VERIFIED without a file:line or config reference; every failure mode has a mitigation (a design with zero gaps means the checklist was pencil-whipped); detection column contains "logs" without naming the specific signal. PASS when at least one MISSING finding is actionable.

## Integration
- Seed the register from **adr-writer** consequence sections and **capacity-planner** TIGHT/BREAKS rows.
- The detection-signal column is the requirements input to **observability-designer** — every register row must map to a designed alert or be explicitly accepted as blind.
- Feed MISSING mitigations into **migration-strategist** when fixing them requires a stateful change.
- Use **adversarial-disproof** at step 4 and **verified-done** before marking any mitigation VERIFIED.

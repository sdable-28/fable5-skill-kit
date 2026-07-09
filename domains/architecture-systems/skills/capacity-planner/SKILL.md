---
name: capacity-planner
description: >
  Back-of-envelope capacity math for a system or component: QPS, storage, bandwidth, connection counts,
  shard counts, cache sizing, and headroom. Triggers: "will this scale", "how many servers/shards/replicas",
  "can the DB handle it", "size the queue/cache/pool", designing any new service or data pipeline,
  or reviewing a design doc that contains no numbers. Do NOT use for micro-benchmarking a single function,
  cost/billing optimization with no load model, or when real production metrics already answer the question —
  read the metrics instead.
---

# capacity-planner

## When invoked
1. Fix the load model first: users or events per day, peak-to-average ratio, read:write ratio, payload size, retention. If the requester cannot supply these, derive defaults and state them as named assumptions (`ASSUME peak = 5x average`). Every downstream number must trace to a named assumption or a measured fact.
2. Compute the envelope, showing arithmetic inline, never just results:
   - QPS: daily volume / 86,400 × peak ratio. Separate read QPS and write QPS.
   - Storage: rows/day × row size × retention days × replication factor. Add index overhead (~1.5-2x for heavily indexed stores).
   - Bandwidth: QPS × payload size, ingress and egress separately.
   - Connections/pools: concurrent clients × connections each vs. backend max; flag pool exhaustion if utilization > 70%.
3. Find the first bottleneck: compare each computed demand against a stated single-node limit (e.g., ~1-5k write QPS for a Postgres primary, ~50 MB/s per Kafka partition, ~100k conns per LB). Cite the limit you used. The bottleneck determines the sharding/replication answer — never shard by default.
4. If sharding is indicated: name the shard key, compute per-shard load, and check for hot partitions — model the top key's share of traffic (Zipf: assume top key ≈ 10-30% unless data says otherwise). A shard scheme that puts one tenant/symbol/celebrity over the single-node limit fails here.
5. Stress the envelope: recompute at 10x load and at the p99 case, not the mean. State which component breaks first at 10x and what the mitigation path is (vertical, horizontal, redesign).

## Output format
A **Capacity Envelope** table: metric | formula | value @ 1x | value @ 10x | limit used | verdict (OK / TIGHT >70% / BREAKS), followed by a **Named Assumptions** list and a one-paragraph **First Bottleneck** statement naming the component, the load at which it fails, and the mitigation.

## Quality gate
FAIL if any of: a number appears without its arithmetic; an assumption is used but not named; the 10x column is missing; no single-node limit is cited; the verdict column contains no TIGHT or BREAKS entry at 10x (a system with infinite headroom means the math is wrong). PASS when a second engineer can re-derive every cell from the assumptions alone.

## Integration
- Provide the envelope to **adr-writer** whenever a decision claims "X won't scale" — unquantified scale claims are inadmissible in an ADR.
- Hand TIGHT/BREAKS rows to **failure-mode-mapper** as saturation-class failure candidates.
- Give **observability-designer** the utilization thresholds (70% TIGHT line) as alert-threshold inputs.
- Use **statistical-analysis** when real traffic data exists to fit the peak ratio and Zipf skew instead of assuming them; use **evidence-reasoning** to cite the source of every limit.

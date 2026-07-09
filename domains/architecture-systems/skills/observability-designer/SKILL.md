---
name: observability-designer
description: >
  Design the metrics/logs/traces instrumentation for a service or flow so failures are diagnosable
  before users report them. Triggers: "add monitoring", "what should we alert on", "design dashboards",
  "we couldn't tell why it was slow", shipping any new service, or closing detection gaps from a failure
  register. Do NOT use for one-off debugging of a current bug (instrument-and-remove is debugging, not
  design), for business/product analytics pipelines, or when the ask is purely "make the logs prettier".
---

# observability-designer

## When invoked
1. Enumerate the questions the system must answer at 3am: "is it broken", "where", "why", "who is affected", "is it getting worse". Every instrument you design must serve a named question; instruments without questions are cost, not observability.
2. Design the metrics layer around the RED/USE split:
   - Per request-serving component: Rate, Errors, Duration — Duration as histogram, never average. p50/p95/p99 must be derivable; averages hide the tail, and tail latency is where distributed systems die.
   - Per resource: Utilization, Saturation, Errors — queue depth and pool utilization are saturation signals, and saturation alerts fire BEFORE errors do. Alert on p99 and saturation, not p50 and CPU.
   - Fix cardinality now: list every label and its value count. user_id/order_id as a metric label is a finding — that data belongs in traces/logs.
3. Design tracing: pick propagation (W3C traceparent unless the stack dictates otherwise) and verify the trace context crosses EVERY async boundary — queue publish/consume, scheduled jobs, thread handoffs. A trace that dies at the queue is the most common and most expensive gap; specify exactly where the context is serialized into the message envelope. Set sampling: head-sample at a stated rate, but tail-keep 100% of errors and p99-slow traces.
4. Design logs as structured events, one per unit of work per service, carrying trace_id. Ban multi-line narrative logging in request paths. Specify which fields are indexed.
5. Write the alert set. Every alert must state: signal, threshold WITH derivation (from capacity envelope or measured baseline — never a round number pulled from air), for-duration, and the first three diagnostic steps the responder takes. An alert without a response action is deleted here.
6. Verify coverage against the failure register: for each failure mode, name the exact signal that detects it within 5 minutes, or mark it BLIND with explicit sign-off.

## Output format
An **Observability Spec** with four sections: **Metrics** (table: name | type | labels | cardinality bound | question served), **Traces** (propagation standard, async-boundary crossings list, sampling policy), **Logs** (event schema with indexed fields), **Alerts** (table: signal | threshold | derivation | duration | first 3 responder actions), plus a **Coverage Matrix** mapping failure-register rows → detecting signal | BLIND.

## Quality gate
FAIL if any of: any Duration metric lacks histogram buckets; any label's cardinality is unbounded or unstated; any async boundary in the architecture is absent from the trace-crossing list; any alert threshold lacks a derivation; the coverage matrix has an unmapped failure mode without a signed-off BLIND. PASS when a responder unfamiliar with the system could execute every alert's first-3-actions.

## Integration
- Consume the **failure-mode-mapper** register as the coverage requirement (step 6) and **capacity-planner** utilization limits as threshold derivations (step 5).
- Cite alert-threshold sources via **evidence-reasoning**; validate baselines with **statistical-analysis** where production data exists.
- Instrumentation for a **migration-strategist** cutover (dual-read mismatch counters, lag gauges) is designed here, before the migration starts, not during it.
- Close with **verified-done**: the spec is not done until one synthetic failure has been injected and its alert observed firing.

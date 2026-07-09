---
name: enterprise-architect
description: Use for system-level architectural decisions — choosing between approaches, introducing/replacing components, cross-cutting concerns (consistency, scaling, ops burden), anything a team would write an ADR for. Produces trade-off analysis, ADRs, failure-mode analysis, observability requirements, and a migration path from current state. Trigger keywords - "architecture", "should we use X or Y", "redesign", "how should this system...", "long-term". Do NOT use for single-component implementation choices with no cross-cutting impact (use plan-gate) or greenfield component design (use system-design).
---

# enterprise-architect

Architecture is the art of choosing which problems you'll have. Every decision trades among performance, consistency, cost, and operational burden — pretending a choice has no losers is the mark of a bad analysis. This skill forces the trade-offs into the open, records the decision durably, and never designs the destination without the road from here.

## When invoked

1. **Establish current state with evidence.** Map the existing system (cartography-first if unmapped): what exists, what actually hurts (cited incidents/metrics, not vibes), what constraints are immovable (team size, budget, locked components, regulatory).
2. **Name the decision and the options — including "do nothing."** 2–4 real options. If you can only produce one, you haven't looked; if seven, you haven't filtered. "Keep the current design" is always evaluated — it is the option with the best-understood failure modes.
3. **Trade-off analysis on the four axes,** per option: **performance** (latency/throughput under realistic load, not peak), **consistency/correctness** (what anomalies become possible), **cost** (build + run + the often-dominant migration cost), **ops burden** (what a human must now monitor, patch, and be paged for). Grade each axis with a sentence of reasoning; a bare matrix of pluses is not analysis.
4. **Failure-mode analysis for the leading option.** For each component/link it introduces: how does it fail, how is the failure detected, what is the blast radius, what is the recovery path? An architecture whose failure story is "it won't" is rejected as unanalyzed.
5. **Observability requirements.** What must be measurable for this architecture to be operable: the 3–6 signals that distinguish healthy from failing, where they're emitted, and what alert thresholds mean something. Designed in, not bolted on.
6. **Migration path from current state.** Ordered steps, each independently shippable and reversible where possible; the riskiest step identified with its rollback; the point of no return marked explicitly. An architecture without a migration path is a poster, not a plan.
7. **Record the ADR** (format below) and run **adversarial-disproof** on the recommendation before delivering — architects' conclusions are exactly the "significant conclusions" that skill exists for.

## Output format

ADR per decision:
```
# ADR-{n}: {title}
STATUS: proposed | accepted | superseded-by ADR-{m}
CONTEXT: {the forcing problem, with evidence; constraints}
OPTIONS CONSIDERED: {each with the four-axis grade, one paragraph}
DECISION: {chosen option + the 2-3 reasons that actually decided it}
CONSEQUENCES: {what gets worse and who pays it — mandatory, non-empty}
FAILURE MODES: {component → detection → blast radius → recovery}
OBSERVABILITY: {signals, sources, thresholds}
MIGRATION: {ordered steps; riskiest step + rollback; point of no return}
```

## Integration

- **system-design** handles the internals of a chosen component; this skill decides among components. Order: enterprise-architect → system-design → plan-gate → execution.
- **assumption-flagging** on the CONTEXT (load estimates and constraints are classic hidden assumptions).
- **adversarial-disproof** on the DECISION; **security-threat-modeling** joins whenever a trust boundary moves.
- ADRs persist to the project's decision log/memory — an unrecorded architecture decision will be re-litigated within months.

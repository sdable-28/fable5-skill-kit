---
name: system-design
description: Use when designing any system or component — a service, a pipeline, a data store schema, an engine, an API. Runs the full chain requirements → constraints → capacity estimates → component design → data flow → failure modes → trade-offs → ADR. Trigger keywords - "design a", "build a system for", "how would you structure", "schema for", "pipeline for". Do NOT design without stating what you're optimizing for — that omission is the skill's cardinal sin. Do NOT use for choosing between existing systems (enterprise-architect) or for small single-function additions (plan-gate).
---

# system-design

Every design optimizes something at the expense of something else; a design that doesn't state its objective is optimizing "looks reasonable," which is nothing. The chain below runs in order because each stage's output constrains the next — capacity numbers before component choices, failure modes before the trade-off verdict.

## When invoked

1. **Requirements.** Functional (what it must do — as testable statements) and non-functional (latency, durability, freshness, correctness bounds — with numbers, even rough ones). Then the sentence that governs everything after it: **"This design optimizes for {X}, accepting worse {Y}."** No design proceeds without it.
2. **Constraints.** Immovables: existing stack, team/operator capacity, budget, deadlines, compliance, interfaces that must be preserved. Constraints are inputs, not annoyances — designs that ignore them are fiction.
3. **Capacity estimates.** Back-of-envelope with shown arithmetic (mathematical-reasoning discipline): data volume, request/event rate, growth, peak-vs-average, retention. Order of magnitude is the goal; the estimate that matters most is the one that rules options out ("710k rows/year → SQLite is fine; a cluster is self-harm").
4. **Component design.** The parts and their responsibilities — each component one sentence of purpose, its interface (the contract others code against), and its state (stateless / owns-what). Interfaces get designed before internals; internals are replaceable, contracts are forever.
5. **Data flow.** Trace the primary unit of work end-to-end (the bar, the request, the event): where it enters, what transforms it, where it rests, what reads it later. Then trace the WORST unit: the duplicate, the late arrival, the out-of-order event, the replay.
6. **Failure modes.** Per component and per link: failure type → detection → behavior of the rest of the system (degrade? halt? corrupt?) → recovery. Explicitly decide fail-open vs fail-closed per path, and say why.
7. **Trade-offs + ADR.** What was given up (the {Y} from step 1, made concrete), which alternatives were rejected and by which estimate or constraint. Record as an ADR (enterprise-architect format).

## Output format

```
## Design: {name}
OPTIMIZES FOR: {X}, accepting worse {Y}
REQUIREMENTS: functional {list} | non-functional {numbers}
CONSTRAINTS: {immovables}
CAPACITY: {arithmetic shown → the numbers that ruled options out}
COMPONENTS: {name → responsibility → interface → state}
DATA FLOW: happy path {trace} | worst unit {trace}
FAILURE MODES: {component → detect → blast → recover; fail-open/closed per path + why}
TRADE-OFFS: {rejected alternatives + what killed each}
→ ADR-{n}
```

## Integration

- Downstream of **enterprise-architect** (which picks the slot this design fills); upstream of **plan-gate** (which sequences the build).
- **mathematical-reasoning** for step 3's arithmetic; **assumption-flagging** on requirements and capacity inputs (load estimates are the classic hidden assumption).
- **security-threat-modeling** runs on the component diagram whenever data crosses a trust boundary.
- **adversarial-disproof** on the final design at high stakes: attack the capacity math, hunt the unhandled worst-unit, test whether the optimization sentence survives.

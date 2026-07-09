---
name: multi-agent-orchestration
description: Use when a task exceeds one context or one perspective — broad audits, migrations over many sites, multi-dimension reviews, research sweeps, adversarial verification panels. Decomposes into parallel vs sequential agent work, chooses barrier vs pipeline, writes the orchestration script, and tracks coverage and cost. Trigger keywords - "comprehensive", "audit everything", "across the whole codebase", "fan out", "in parallel". Do NOT use for single lookups, tasks needing conversation context the agents won't have, or when the user hasn't opted into multi-agent scale.
---

# multi-agent-orchestration

Fan-out buys three things: coverage one context can't hold, independence one perspective can't fake, and wall-clock parallelism. It costs coordination, tokens, and merged-blind-spot risk. The orchestrator's job is structure: what fans out, what verifies, what synthesizes — and an honest account of what the fleet did NOT cover.

## When invoked

1. **Decompose by independence.** Split the task where units share no state and no ordering: by dimension (correctness/security/perf lenses), by region (module, directory), by item (finding, file, migration site), or by modality (search by-name / by-content / by-caller — each blind to the others' angle). Anything sequential-by-nature (each step needs the last one's output) stays inline or becomes pipeline stages.
2. **Choose the topology — pipeline by default.**
   - **Pipeline**: items flow through stages independently; item A verifies while item B is still being found. Default, because wall-clock = slowest chain, not sum of slowest stages.
   - **Barrier** (all results before next step) ONLY when stage N genuinely needs cross-item context from all of N−1: dedup/merge before expensive verification, early-exit on zero findings, "compare against the other findings" prompts. "The stages are conceptually separate" does NOT justify a barrier.
3. **Write each agent's prompt as a contract:** objective, scope (its slice, explicitly bounded), evidence discipline (citations required — agents inherit evidence-reasoning by instruction), output schema (structured, machine-mergeable), and its own coverage report ("what in your slice did you not check").
4. **Structure verification adversarially.** Finder agents are optimists by construction. Verification agents get refuter prompts ("try to REFUTE this finding; default to refuted if uncertain") — never "please verify" (that produces agreement). For findings that can fail in multiple ways, diversify lenses across verifiers (correctness / handled-elsewhere / impact) rather than N identical refuters. Majority-refute kills a finding.
5. **Plan the merge before launching.** How results combine: dedup key, conflict rule (two agents disagree about one fact → escalate to a targeted check, never average), and the merged coverage ledger (union of slices vs the original universe — gaps between slices are the orchestrator's fault, not any agent's).
6. **Track cost and cap it visibly.** Agents-per-stage, expected token order-of-magnitude, and any bounds applied (top-N, sampling, no-retry) logged loudly — a silently-bounded fleet reads as exhaustive coverage.
7. **Synthesize inline.** The final judgment — severity ranking, cross-cutting patterns, the recommendation — is the orchestrator's own work product from merged results. Delegating synthesis to one more agent loses the cross-slice view that only the merge point has.

## Output format

Orchestration plan (before launch):
```
DECOMPOSITION: {axis} → {n} units
TOPOLOGY: pipeline {stages} / barrier at {stage} because {cross-item need}
AGENTS: {stage → count × prompt-contract summary → output schema}
VERIFICATION: {refuter panel size / lens diversity / kill rule}
MERGE: {dedup key; conflict rule; coverage-union plan}
COST: ~{n} agents, bounds: {caps, logged}
```
After the run: merged findings + merged coverage ledger + cost actuals + refuted-count.

## Integration

- Parallelizes **code-investigation** P3/P5 at Max effort; the refuter panel is **adversarial-disproof** distributed.
- Every agent contract embeds **evidence-reasoning** and **coverage-accounting**; the merge implements the union ledger.
- Long fleets checkpoint per **long-task-orchestration**; token spend per **context-budget-management**.
- Respects platform opt-in rules: user-requested scale only — a task merely benefiting from parallelism is not authorization.

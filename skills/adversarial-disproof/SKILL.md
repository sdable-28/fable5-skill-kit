---
name: adversarial-disproof
description: Use after forming any significant conclusion — a diagnosed bug, an audit finding, a "this is the edge" claim, an architectural judgment — before delivering or acting on it. Applies three disproof lenses (correctness, completeness, impact) and issues CONFIRMED / PLAUSIBLE / REFUTED. Trigger - any conclusion that would change what the user builds, fixes, or spends. Do NOT use on trivial observations or on claims already CONFIRMED by this skill this session.
---

# adversarial-disproof

A conclusion you haven't tried to kill is a draft. Confirmation evidence accumulates easily because you searched for it; the test of a conclusion is surviving a deliberate attempt to destroy it. Three lenses, because conclusions die in three distinct ways.

## When invoked

State the conclusion crisply, then attack it through each lens IN WRITING — a mental pass doesn't count, it silently degrades into confirmation.

1. **Lens 1 — CORRECTNESS: is the evidence actually what I think it is?**
   - Re-open the primary evidence. Is the snippet really doing what I claimed? Did I read a stale version, the wrong branch, a test fixture instead of production code, a SIM figure as LIVE?
   - Is there an alternative explanation for the same evidence? (The log gap could be the bug — or the logger's buffering.)
   - Check the strongest single piece of evidence hardest; the conclusion usually hangs on it.
2. **Lens 2 — COMPLETENESS: is it handled elsewhere?**
   - The classic false finding: "X is never validated" — and the validation lives one layer up. Search for the compensating mechanism: callers, middleware, wrappers, DB constraints, the retry loop, the reconciliation job.
   - Use the index/Grep for the mechanism's likely names before declaring absence. Absence claims require a described search, not a shrug: "grepped {patterns} across {scope}, no handler found."
3. **Lens 3 — IMPACT: is the stated consequence realistic?**
   - Walk the failure from trigger to damage: what inputs/state actually reach this code? Is the "crash" on a path that runs? Quantify when possible: how often, how much.
   - Deflate honestly: a real bug on a dead path is a real finding with near-zero impact — say that, don't inflate.
4. **Issue the verdict:**
   - **CONFIRMED** — survived all three lenses; evidence re-checked, no compensator found (search described), impact walked through.
   - **PLAUSIBLE** — survived what could be checked, but a lens couldn't be fully closed (name which and why).
   - **REFUTED** — a lens killed it. State which lens and what the truth turned out to be — a refutation is a finding too, often worth persisting so it isn't re-derived.
5. **Effort scales with stakes:** one pass of the three lenses for normal findings; for money/production-feeding conclusions, add an independent re-derivation (different method or a fresh subagent prompted to refute, not to verify).

## Output format

```
CONCLUSION: {one sentence}
L1 correctness: {evidence re-checked; alternative explanations considered} → holds/breaks
L2 completeness: {compensators searched: where, what patterns} → holds/breaks
L3 impact: {trigger→damage walk; frequency/size} → holds/breaks
VERDICT: CONFIRMED / PLAUSIBLE ({open lens}) / REFUTED ({what's actually true})
```

## Integration

- Phase 5 of **code-investigation**; every GAP finding carries this verdict.
- Runs on **root-cause-first**'s cause statement before high-stakes fixes.
- Escalation triggers per Master Framework 4.2 (surprising results, single-source conclusions, irreversible decisions).
- REFUTED verdicts feed the falsification ledger (Operating Manual 2.3) — the highest-value memory writes.
- In multi-agent settings, the refuter-panel pattern of **multi-agent-orchestration** parallelizes this skill.

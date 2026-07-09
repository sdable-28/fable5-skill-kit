---
name: mathematical-reasoning
description: Use for ANY multi-step calculation — sizing, estimates, financial arithmetic, unit conversions, probability, capacity math. All steps shown, no mental arithmetic across steps, units and assumptions stated at every step, load-bearing results verified by an alternative method. Trigger signals - any computation with more than one operation, any number that feeds a decision. Do NOT use for single trivial operations, but note that "trivial" compound arithmetic is where errors actually live — when in doubt, show the steps.
---

# mathematical-reasoning

Arithmetic errors don't announce themselves — they ride confident prose into decisions. The failure rate of chained mental arithmetic is material, and the cost asymmetry (a wrong load-bearing number vs. thirty seconds of shown work) always favors discipline.

## When invoked

1. **State inputs, units, and assumptions before computing.** Every quantity gets a unit and a source: "$800 max risk [given]; 25 pt stop [config]; $20/pt [contract spec]". An unstated unit is where percentage-vs-percentage-point, per-day-vs-per-month, and points-vs-dollars errors enter.
2. **One operation per step, shown.** No mental chaining: "risk per contract = 25 pt × $20/pt = $500/ct" then "contracts = $800 / $500 = 1.6 → floor → 1". Each intermediate value is named so later steps reference it by name, not by re-computation (re-computation forks are how two parts of one document disagree).
3. **Use a tool for anything beyond two operations.** Run the computation (calculator/script/spreadsheet) rather than trusting inline token arithmetic — model arithmetic degrades with operand size and chain length. The shown steps are the audit trail; the tool is the executor.
4. **Verify load-bearing results by an alternative method.** Different route to the same number: inverse check (result × divisor ≈ original), bounds check (must land between X and Y because...), independent decomposition (compute per-month then sum vs. compute total directly). A load-bearing number with one derivation is PLAUSIBLE; with two independent ones, VERIFIED.
5. **Sanity-check against reality.** Order of magnitude, sign, and plausibility: can a 6-month total be lower than one of its months? Can a probability exceed 1? Does the per-trade figure times trade count roughly match the aggregate?
6. **Flag counterintuitive results explicitly — don't smooth them.** If the result surprises, say so and either (a) re-derive by a third method and confirm ("counterintuitive but confirmed: X, because {mechanism}"), or (b) find the error. A silently-reported surprising number is either a discovery or a bug, and the reader can't tell which.
7. **Carry rounding honestly.** Round only at the end; state the rounding rule when it matters (contracts floor, not round — 1.6 contracts is 1, not 2); keep displayed precision consistent with input precision (an $800 estimate doesn't produce a $1,265,453.27 conclusion).

## Output format

```
INPUTS: {name = value [unit] (source)}
ASSUMPTIONS: {each, flagged}
STEPS:
  1. {name} = {expression} = {value [unit]}
  2. ...
RESULT: {value [unit]}
CROSS-CHECK: {alternative method} → {value} ✓ (or ✗ → investigate before delivering)
{if surprising: COUNTERINTUITIVE: {why it surprises} — confirmed by {third method} / traced to {error}}
```

## Integration

- Serves **system-design** step 3 (capacity), **statistical-analysis** (all computation inside it), **enterprise-architect** (cost math).
- Results enter prose under **evidence-reasoning** tiers: cross-checked = VERIFIED, single-derivation = PLAUSIBLE.
- Counterintuitive-result handling is a special case of **adversarial-disproof** L1 (is the evidence what I think it is?).
- Domain high-risk zones (compound financial math, dosing) per `Anti_Hallucination.md` §5.5.

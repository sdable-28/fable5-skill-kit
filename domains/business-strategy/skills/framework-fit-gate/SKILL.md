---
name: framework-fit-gate
description: Select or reject strategy frameworks (Porter's Five Forces, BCG Matrix, Ansoff, 7-S, JTBD, Blue Ocean, Value Chain, Balanced Scorecard) based on demonstrated fit to the locked problem, not familiarity. Trigger phrases - "apply Porter's", "run a Five Forces", "which framework should we use", "do a BCG matrix", or any moment you are about to reach for a named framework. Do NOT use for financial modeling mechanics (that is a calculation, not a framework choice) or when no named framework is in play.
---

# Framework Fit Gate

Framework application without problem fit is a signature consulting failure — Porter's Five Forces on what is actually an operational cost problem produces an elegant, useless deck. Frameworks are lenses, not answers.

## When invoked

1. State the question class of the locked problem in one line: industry attractiveness / portfolio allocation / growth vector / org effectiveness / customer motivation / cost structure / competitive position / performance management.
2. Map each candidate framework to the question class it answers. Reject every framework whose native question differs from the problem's question class — write the rejection: "Five Forces answers 'is this industry structurally profitable' — our question is 'why are OUR costs 20% above peers' — rejected."
3. For the surviving framework(s), state the entry conditions it needs (data availability, industry maturity, single vs multi business unit) and verify each is met.
4. If no framework fits, say so and default to first-principles decomposition via mece-decomposer. A blank issue tree beats a mismatched framework.
5. Apply the chosen framework only to the branches of the issue tree it covers. Name which leaves it does NOT address so they are not silently dropped.
6. After application, extract only the decision-relevant outputs. Delete framework cells that produced no implication for the locked problem — completeness of the 2x2 is not a deliverable.

## Output format

A **Framework Fit Memo**: (a) problem question class, (b) rejection table (framework → native question → mismatch reason), (c) chosen framework with entry conditions checked off, (d) coverage map (which issue-tree leaves it serves, which it leaves open), (e) applied output stripped to decision-relevant cells only.

## Quality gate

PASS only if at least one named framework was explicitly rejected with a stated mismatch reason, and the coverage map lists at least one leaf the framework does not address. An analysis where the first framework considered was adopted with no rejections FAILS — that is pattern-matching, not fit-testing.

## Integration

- Consumes problem-statement-lock's locked statement and mece-decomposer's leaf list.
- Rejections are an adversarial-disproof application: try to prove the framework does NOT fit before using it.
- Framework outputs feed so-what-enforcer — every populated cell must yield an implication or be cut.
- evidence-reasoning governs step 3: entry conditions are claims requiring evidence, not assumptions.

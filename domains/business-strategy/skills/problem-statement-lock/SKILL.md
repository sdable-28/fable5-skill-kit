---
name: problem-statement-lock
description: Force a precise, testable problem statement before any strategic analysis begins. Trigger phrases - "help us grow", "we need a strategy", "figure out what's wrong with the business", "should we enter/exit/acquire", or any engagement request where the question is a symptom ("revenue is down") rather than a decision. Do NOT use when the client has already supplied a decision-grade problem statement with scope, metric, and deadline, or when the task is pure execution of an already-framed analysis.
---

# Problem Statement Lock

Wrong problem definition is the most expensive consulting mistake. Do not let analysis start on a symptom.

## When invoked

1. Extract the raw ask verbatim. Label it SYMPTOM until proven otherwise.
2. Rewrite it as a SMART problem statement: decision owner, decision to be made, success metric with number and unit, time horizon, constraints (budget, regulatory, org), and what is explicitly out of scope.
3. Generate 2-3 alternative framings of the same symptom (e.g., "revenue down" → pricing problem vs. churn problem vs. market-shrink problem). Each framing implies a different analysis and a different answer.
4. For each framing, state one observable fact that would confirm it and one that would kill it. Pull whatever data is already available to discriminate.
5. Present the framings with your recommended one and the discriminating evidence. Ask the requester to lock one. Never silently pick.
6. Once locked, write the statement at the top of every downstream artifact. Any analysis that drifts from it is out of scope by definition.

## Output format

A **Problem Statement Card**: (a) raw ask, (b) locked statement in one sentence of the form "How should [owner] [decision] to achieve [metric] by [date], given [constraints]?", (c) rejected framings table with the evidence that eliminated each, (d) explicit out-of-scope list.

## Quality gate

PASS only if: the locked statement names a decision (not a topic), contains a quantified metric and deadline, and at least two alternative framings were generated and killed with stated evidence. FAIL if the statement could be answered with "it depends" or contains no number.

## Integration

- Run BEFORE mece-decomposer — the issue tree decomposes the locked statement, nothing else.
- Feeds plan-gate: the locked statement is the plan's goal criterion.
- Use adversarial-disproof on step 4: actively try to kill your preferred framing before recommending it.
- framework-fit-gate consumes the locked statement to reject mismatched frameworks.

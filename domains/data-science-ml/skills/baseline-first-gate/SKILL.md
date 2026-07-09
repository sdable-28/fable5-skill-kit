---
name: baseline-first-gate
description: Decide whether ML is the right tool at all, and force a trivial baseline before any model is trained. Trigger phrases - "should we use ML for this", "let's train a model to...", "build a classifier/predictor for X", "can we throw a neural net at this", any request that jumps straight to model training with no baseline named. Use at the start of every new modeling effort. Do NOT use when a model already exists and the question is evaluation (eval-metric-alignment), pipeline safety (leakage-detector), or production behavior (drift-monitor-designer).
---

# Baseline First Gate

## When invoked
1. Ask the substitution question: can the outcome be achieved by a rule, a lookup table, a heuristic, or a SQL query? Write the best non-ML candidate down concretely (the actual rule, not "some heuristic"). If nobody can articulate why the pattern is too complex for rules, ML is not yet justified — return NO-GO(rules-first) with the rule.
2. Check the ML preconditions, each with evidence: (a) labeled examples exist in sufficient quantity for the signal-to-noise of the problem, (b) the pattern is expected to persist (a causal or structural mechanism can be stated in one sentence — "it worked historically" is not a mechanism), (c) prediction-time inputs actually exist at prediction time, (d) the cost of being wrong is survivable at the expected error rate.
3. Build and score the trivial baselines BEFORE any model: majority class / stratified random (classification), mean / median / last-value carry-forward (regression / time-series), the current production heuristic if one exists. Score them on the primary metric from the Metric Contract, on the real split.
4. Set the improvement bar: the minimum lift over the best baseline that justifies ML's ongoing cost (pipeline, monitoring, retraining, failure modes). Get this number stated before training, so it cannot be negotiated downward after results arrive.
5. If GO: the first model must be the simplest plausible one (linear/logistic or a small gradient-boosted tree for tabular). Deep/complex architectures require the simple model's measured shortfall as justification, not anticipation.

## Output format
A **Go/No-Go Memo**: (1) best non-ML alternative, written out, with its score if scoreable, (2) precondition checklist with evidence per item, (3) baseline scoreboard `baseline | primary metric | score`, (4) improvement bar (number), (5) verdict GO / NO-GO(rules-first) / NO-GO(no-labels) / NO-GO(no-mechanism), (6) if GO, the mandated first model.

## Quality gate
PASS only if at least two trivial baselines were actually scored (numbers in the memo, not placeholders) and the improvement bar was recorded before any model training began. FAIL if the memo says GO but the non-ML alternative was never written out concretely, or if the stated mechanism is a restatement of the historical correlation.

## Quality gate check
Re-read the mechanism sentence and apply adversarial-disproof: does it predict when the pattern should STOP working? A mechanism that can never fail is not a mechanism.

## Integration
- Runs first, before **eval-metric-alignment** finalizes the Metric Contract (the two iterate: metric needed to score baselines, baselines sanity-check the metric).
- Output feeds **plan-gate**: NO-GO verdicts terminate the modeling plan and redirect to the rule/heuristic.
- **leakage-detector** runs on the pipeline only after GO.
- Baseline scoreboard becomes the permanent floor in **verified-done**: no model ships without beating it by the improvement bar, per **statistical-analysis** significance on the same split.

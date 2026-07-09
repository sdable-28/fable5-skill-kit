---
name: eval-metric-alignment
description: Force the ML evaluation metric to match the business decision the model drives, and expose metric gaming. Trigger phrases - "which metric should we optimize", "accuracy is 95% but users complain", "choose loss function", "precision vs recall here", "is AUC the right metric", "model improved offline but KPI didn't move". Use at problem-framing time and whenever offline gains fail to translate. Do NOT use for generic statistics questions with no model decision attached, or for monitoring live distributions (that is drift-monitor-designer).
---

# Eval Metric Alignment

## When invoked
1. Write the decision sentence first: "When the model outputs X, the system does Y, which costs/earns Z." If Y or Z cannot be filled in, stop — the framing is incomplete; escalate to the caller before choosing any metric.
2. Build the error-cost matrix: dollar/utility cost of FP, FN (and per-class for multiclass; per-magnitude for regression). Asymmetric costs mandate a metric that encodes the asymmetry — reject accuracy and plain AUC-ROC by default.
3. Match metric to decision type: ranked review queue → precision@k / PR-AUC; threshold-triggered action → cost-weighted expected value at the operating threshold; probability consumed downstream (sizing, pricing) → calibration (Brier, reliability curve) is mandatory, not optional; rare positives (<5%) → PR space, never ROC space.
4. Define the baseline the metric must beat: majority class, current heuristic, or last-value carry-forward. A metric with no stated baseline is unreportable.
5. Run the gaming check: describe the degenerate model that maximizes the candidate metric without being useful (predict-all-negative, predict the mean, collapse to one class). If the degenerate model scores well, add a guard metric that catches it.
6. Fix the operating threshold selection procedure NOW (on validation, by expected cost), so it is not tuned on test later.

## Output format
A **Metric Contract**: (1) decision sentence, (2) error-cost matrix, (3) primary metric + operating threshold procedure, (4) guard metric(s) with the gaming scenario each blocks, (5) baseline value each must beat, (6) explicit list of rejected metrics with one-line reasons.

## Quality gate
PASS only if the contract names exactly one primary metric, every metric has a numeric baseline, and the gaming check produced at least one concrete degenerate-model scenario with its guard. FAIL if the primary metric is accuracy or AUC-ROC on an imbalanced, cost-asymmetric problem without written justification.

## Quality gate note
The contract is frozen before the first training run; changing the primary metric after seeing test results is metric shopping — flag it as such.

## Integration
- Runs inside **plan-gate** at framing time; **leakage-detector** validates the pipeline that produces the metric's inputs.
- **statistical-analysis** supplies the significance test when comparing candidate models on the primary metric (paired, on identical splits).
- **drift-monitor-designer** inherits the primary and guard metrics as its degradation signals.
- **evidence-reasoning**: any "model improved" claim must cite primary metric + guard metrics + baseline, from the same evaluation artifact.

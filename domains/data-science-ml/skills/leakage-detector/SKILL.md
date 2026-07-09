---
name: leakage-detector
description: Audit an ML pipeline for label leakage and train-time information that will not exist at prediction time. Trigger phrases - "check for leakage", "why is validation too good", "AUC seems too high", "this model looks suspiciously accurate", "audit features before training", "backtest results too good to be true". Run BEFORE celebrating any strong metric and BEFORE shipping any new feature set. Do NOT use when the task is generic code review, data quality/missingness profiling with no model in the loop, or post-deploy drift analysis (use drift-monitor-designer for that).
---

# Leakage Detector

## When invoked
1. Identify the prediction target, the exact prediction timestamp (or event boundary), and where the label is computed in code. Read only those slices.
2. Build the feature inventory: for every feature, record (a) source table/stream, (b) timestamp of availability, (c) any aggregation window. A feature whose availability timestamp is >= the prediction timestamp is leakage — flag it, no exceptions.
3. Check the split mechanics: random split on temporal/entity-correlated data is leakage. Verify temporal splits have an embargo gap >= the label horizon; verify grouped entities (user, account, session, contract month) never straddle train/test.
4. Check transform fitting: scalers, imputers, encoders, target encoders, feature selectors, HPO — each must be fit on train only. Any `.fit()` on the full dataset before splitting is a CONFIRMED leak.
5. Hunt indirect leaks: target-derived features (e.g., "days_until_churn"), post-outcome fields snuck into snapshots (updated_at, status columns), duplicated rows across splits, and lookahead in rolling windows (window includes the current bar's close when the decision fires intra-bar).
6. Run the falsification probe: shuffle the label within train and retrain quickly. If the shuffled model still scores materially above baseline on validation, a structural leak exists — find it before returning.
7. For each flagged item, state the mechanism (what future information reaches the model, via which line) with file:line evidence.

## Output format
A **Leakage Audit Table**: `feature/mechanism | leak type (label/temporal/split/transform/duplicate) | evidence (file:line) | verdict (CONFIRMED/PLAUSIBLE/CLEAR) | fix`. Followed by a one-line overall verdict: SAFE TO TRAIN / BLOCKED, and the shuffled-label probe result if run.

## Quality gate
PASS only if: every feature in the model's input appears in the audit table with an availability timestamp, the split mechanism was inspected in code (not assumed), and at least one falsification probe (shuffled-label or time-reversed split) was executed or explicitly justified as infeasible. FAIL if any feature verdict rests on its name rather than its computation.

## Integration
- Feeds **plan-gate**: no training run is planned until this audit returns SAFE TO TRAIN.
- Uses **adversarial-disproof** as its core stance: assume the strong metric is a leak until the probe fails to break it.
- Pairs with **eval-metric-alignment**: a clean pipeline scored on the wrong metric is still wrong — run both before any "model works" claim.
- **verified-done** requires the audit table, not a verbal "no leakage found".

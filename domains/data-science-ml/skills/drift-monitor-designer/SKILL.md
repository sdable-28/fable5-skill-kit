---
name: drift-monitor-designer
description: Design the production monitoring and retraining-trigger plan for a deployed model - feature drift, concept drift, silent degradation, delayed labels. Trigger phrases - "model is degrading", "set up model monitoring", "when should we retrain", "PSI/ADWIN thresholds", "detect distribution shift", "shadow mode plan". Use when a model is deployed or about to be. Do NOT use for pre-training data audits (leakage-detector), metric selection (eval-metric-alignment), or generic infra/uptime monitoring with no model in the path.
---

# Drift Monitor Designer

## When invoked
1. Establish the label-delay reality first: how long after a prediction does ground truth arrive (minutes, days, never)? This single fact determines the design — with delayed/absent labels, input and prediction distributions are the ONLY early warning; state this explicitly.
2. Freeze reference distributions at deployment: per-feature histograms/quantiles from the training set, plus the training-time prediction distribution. Version them with the model artifact — a monitor comparing against a moving window drifts along with the drift.
3. Design three monitor layers, each with a named statistic and threshold:
   - Input drift: PSI per feature (alert >0.2, investigate >0.1) or ADWIN for streaming; monitor missing-rate and cardinality shifts too — a silently broken upstream join looks like drift.
   - Prediction drift: score distribution vs training-time reference (KS or PSI on scores); a classifier whose mean score creeps is degrading before any label confirms it.
   - Outcome drift (when labels arrive): rolling primary + guard metric from the Metric Contract, evaluated on label-arrival cohorts, not prediction-time cohorts.
4. Rank features for monitoring by importance (SHAP/permutation) — top-N monitored individually, tail aggregated. Monitoring 400 features at p<0.05 guarantees false alarms; apply a multiple-comparison correction or restrict N.
5. Define the trigger table: for each alert, the action (investigate / shadow-retrain / auto-retrain / rollback) and the human owner. Auto-retrain requires a validation gate — retraining on drifted-and-corrupted data automates the failure.
6. Specify rollback: previous model version pinned, one-command swap, and the shadow-mode window (new model logs predictions without acting) with its promotion criterion stated numerically.

## Output format
A **Monitoring Spec**: (1) label-delay statement, (2) reference-distribution manifest (what is frozen, where versioned), (3) monitor table `signal | statistic | threshold | check frequency | alert action | owner`, (4) retraining trigger conditions, (5) rollback + shadow-mode promotion criterion.

## Quality gate
PASS only if: every monitor row has a numeric threshold and a named action, the spec works under the stated label delay (no row silently assumes instant labels), and the rollback path names a concrete versioned artifact. FAIL if the spec says "monitor for drift" anywhere without a statistic and threshold attached.

## Quality gate check
Simulate one failure on paper: pick a plausible break (upstream schema change, regime shift) and trace which monitor fires and what happens next. If no row fires, the spec has a hole — fix before returning.

## Integration
- Consumes the Metric Contract from **eval-metric-alignment** (outcome layer) and the feature inventory from **leakage-detector** (input layer).
- **root-cause-first**: an alert firing triggers diagnosis (data break vs concept drift vs seasonality) before any retrain — encode this ordering in the trigger table.
- **statistical-analysis** sets thresholds from historical false-alarm rates, not vibes.
- **verified-done** for deployment = Monitoring Spec exists and monitors emit on real traffic, not merely "model deployed".

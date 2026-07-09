# Verification Gates — Data Science & AI/ML Engineering

Hard pass/fail gates. A model, feature set, evaluation, or LLM change does not ship — and its results are not reported as findings — until every applicable gate passes. Record gate status per gate, with evidence (run ID, file path, or command output), in the experiment log.

---

## Gate 1: Baseline Beaten (or Recommendation Reversed)

**Passes:** The candidate model beats all three recorded baselines — (a) trivial predictor (majority class / mean / persistence), (b) the domain owner's current heuristic, (c) for ranking tasks, random-at-capacity — on the contracted primary metric, by a margin exceeding the pre-registered ship bar. Baselines were logged BEFORE the first model run.

**Fails:** No baseline numbers exist; baselines were computed after the model (post-hoc baselines get quietly weakened); model beats trivial baseline but not the heuristic; margin below ship bar but work proceeds anyway.

**Check:** Experiment log timestamps — baseline entries must predate first model entry. Compare metric table: `model vs baseline_trivial vs baseline_heuristic` on identical eval rows. If model loses to the heuristic, the passing output of this gate is a written recommendation to ship the heuristic.

---

## Gate 2: Leakage Audit Clean

**Passes:** All of: (1) feature manifest complete — every feature has a proven `available_at` ≤ prediction time, confirmed with the source-system owner for any post-hoc-editable field (notes, statuses, enriched columns); (2) shuffled-label test at chance level (train on permuted labels; primary metric within noise of the trivial baseline); (3) every feature with >25% of total importance has a one-sentence causal mechanism written and reviewed; (4) no preprocessing step fits on data outside the training fold.

**Fails:** Any feature without timestamp proof; shuffled-label test above chance; a dominant feature explained only by "it's predictive"; `fit`/`fit_transform` called on the full dataset before splitting; target encoding or feature selection performed pre-split.

**Check:** Grep the pipeline for `.fit(` and `fit_transform(` — each call must be inside the fold/Pipeline. Run the shuffled-label harness. Diff the feature manifest column `available_at` for nulls. SHAP importance table cross-referenced against mechanism sentences.

---

## Gate 3: Split Integrity

**Passes:** Split scheme matches deployment: temporal cutoff with purge gap ≥ label horizon for time-indexed data; entity-level grouping (GroupKFold / split-by-ID) wherever the same entity yields multiple rows; zero exact or near-duplicate rows across split boundaries; adversarial validation (classifier trained to separate train vs test rows) explained — AUC ≫ 0.5 is either justified by intended temporal shift or treated as a defect.

**Fails:** `shuffle=True` or plain KFold on timestamped data destined to predict the future; same customer/patient/session on both sides; purge gap shorter than the label lookahead window; dedupe never run.

**Check:** Read the split code — must contain a date literal or entity-ID grouping, not a shuffle. Run: intersection of entity IDs across splits (must be empty for grouped problems); near-dup scan (hash + fuzzy) across boundary; assert `min(test.date) - max(train.date) >= label_horizon`.

---

## Gate 4: Plausibility Cleared

**Passes:** The headline metric is at or below the plausibility bar written during framing, OR it exceeds the bar and a documented re-audit (Gates 2–3 rerun, plus single-feature ablation of the top features) found and explains the legitimate source of the performance.

**Fails:** AUC 0.97 on human behavior reported without a re-audit note; "the model is just really good" as the explanation; the plausibility bar was never written down so nothing can trip it.

**Check:** Framing doc contains a numeric plausibility bar dated before experiments. Any reported metric above it must link to a re-audit note in the log.

---

## Gate 5: Slice Robustness

**Passes:** Primary metric reported per time slice (monthly, for ≥ 12 months of data), per key business segment, and for the worst decile of the score distribution; no slice materially below the ship bar without a written limitation in the final report; for temporal data, performance in the two data halves is consistent (second half not materially worse than first — degradation across halves indicates regime-fit, not signal).

**Fails:** Only aggregate metric reported; a segment where the model underperforms the heuristic is averaged away; H1/H2 asymmetry ignored; slices chosen after seeing results to flatter the model.

**Check:** Slice table present in the eval report with the slices named in the metric contract (not invented post-hoc). Compute H1 vs H2 delta; flag > 20% relative degradation.

---

## Gate 6: Statistical Honesty

**Passes:** The headline comparison (model vs baseline / champion vs challenger) carries an uncertainty estimate — bootstrap CI or an appropriate paired test on per-row or per-period results; the claimed win is outside the interval; number of experiments run is reported alongside (so the reader can discount for selection); metric differences within noise are reported as "inconclusive."

**Fails:** "+0.4 AUC points" claimed as a win on 300 test rows with no CI; best-of-40-experiments reported as if it were the only experiment; inconclusive differences rounded up to wins; test-set evaluated more than once per shipped model without disclosure.

**Check:** Eval report contains CI or test statistic for the headline claim. Experiment log count matches the "N experiments" disclosure. Count of test-set evaluations in the log = 1.

---

## Gate 7: Reproducibility

**Passes:** The headline experiment reruns from scratch — same data version, commit, config, seed — and reproduces the headline metric within float/parallelism tolerance; data version, code commit, full config, and seed are logged for every experiment; the training dataset is snapshotted or deterministically reconstructible.

**Fails:** "The number came from a notebook I've since modified"; data pulled live from a mutating table with no snapshot; seed unset; rerun differs beyond tolerance and the discrepancy is shrugged off.

**Check:** Execute the rerun. Diff metrics. Verify the log row for the headline run has all four provenance fields populated.

---

## Gate 8: Training–Serving Parity

**Passes:** For any model with a serving path distinct from the training pipeline: N production entities scored through both the training feature code and the serving feature code; feature values match within tolerance and final scores match within tolerance; null-handling, timezone, and lag semantics verified identical; the parity test is automated and wired as a deployment check.

**Fails:** Feature logic reimplemented in the serving stack and "reviewed by eye"; parity never tested; known skew ("serving lags 4h but it's probably fine") undocumented; batch-computed features feeding a real-time model without an explicit staleness decision.

**Check:** Run the skew test; report max feature diff and max score diff. Confirm the test exists in CI/deploy config, not just as a one-off script.

---

## Gate 9: Monitoring & Rollback Shipped

**Passes:** The deployment PR includes: input drift monitor (PSI or ADWIN on the top-importance features) with a numeric alert threshold; prediction-distribution monitor vs a training-time reference; a performance tracker (direct if labels are fast, proxy/leading-indicator if labels are delayed — proxy named at ship time); a paging threshold and an owner; a tested one-command rollback to the previous model or the pre-ML heuristic; a retraining trigger policy (calendar, drift, or performance) written down.

**Fails:** Model deployed with "we'll add monitoring later"; delayed-label problem with no proxy metric; rollback is "redeploy the old container manually, someone knows how"; retraining policy undefined until the first incident.

**Check:** The monitoring config and rollback command exist in the same changeset as the model. Fire a synthetic drift event in staging and confirm the alert. Execute the rollback once in staging.

---

## Gate 10: Calibration or Relabel

**Passes:** If any consumer thresholds, prices, or expected-value-weights the model output as a probability: reliability curve produced, ECE reported, and either calibration is acceptable or a calibrator (Platt/isotonic, fit on validation) is applied and re-verified. If no consumer needs probabilities: the output is named `score` (not `probability`, not `p_`) in every schema, API, and doc.

**Fails:** Uncalibrated gradient-boosting or deep-net outputs consumed as probabilities; calibration checked on training data; field named `churn_probability` feeding an expected-cost formula with no reliability curve on file.

**Check:** Search downstream consumers for threshold/EV usage of the output. If found, demand the reliability plot. If not, grep schemas for "prob" naming.

---

## Gate 11: LLM/RAG Change Gated by Evals

**Passes:** Every change to prompt, model version, retrieval config, chunking, or index is accompanied by a full eval-suite run with score diffs recorded, covering: (1) golden Q→A set (answer quality vs rubric), (2) retrieval hit-rate@k on golden Q→doc pairs (RAG only), (3) groundedness/faithfulness (claims supported by retrieved context), (4) abstention set — questions whose answers are absent from the corpus, where the system must decline; (5) injection set — retrieved-content and user-input prompt-injection attempts, where the system must not comply. No metric regresses beyond its allowed budget.

**Fails:** Prompt edited and merged on "tried a few examples, looks better"; model version bumped without an eval run; abstention/injection sets don't exist; regression in faithfulness accepted silently because the answer-quality score rose.

**Check:** The change PR links an eval run ID with the before/after score table for all five components. Eval set coverage reviewed quarterly against production question logs (coverage-accounting).

---

## Gate 12: Live-Label Provenance (ML on top of simulations/backtests)

**Passes:** Training labels trace to realized, live-collected outcomes. Simulated or backtest-generated outcomes appear nowhere in the supervised training data. Sample-size floor honored (e.g., ≥ 200 live-labeled instances before first training run).

**Fails:** Classifier trained on backtest wins/losses; RL rewards from a simulator's fill model shipped to production; "we'll retrain on live data later" while the simulator-trained model trades/decides now.

**Check:** Provenance query on the training table — every label row joins to a live event log. Row count ≥ the floor.

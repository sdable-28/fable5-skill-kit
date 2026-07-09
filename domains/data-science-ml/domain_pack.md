# Domain Pack: Data Science & AI/ML Engineering

Operating instructions for end-to-end ML work: problem framing → data → features → modeling → evaluation → production → monitoring, plus LLM engineering (prompting, RAG, evals). These rules are binding. Where they conflict with generic engineering habits, these win.

---

## 1. Domain Overview

### What makes this domain unique

ML work is unique among engineering disciplines because **the artifact can be wrong while every test passes**. A model with leaked labels trains cleanly, evaluates beautifully, and fails silently in production. There is no compiler error for "you gave the model the answer." The core discipline of this domain is therefore not building — it is **disproving your own results**. Treat every strong result as a bug until the leakage/split/metric audit clears it.

Second uniqueness: **the ground truth moves**. Code is verified against a spec that holds still. Models are verified against a data distribution that drifts the moment you deploy. A correct model decays without a single line of code changing. Verification is not a gate you pass once; it is a permanent runtime subsystem (drift detection, prediction monitoring, retraining triggers).

Third: **the metric is a proxy, and proxies get gamed** — by the model, by the pipeline, and by you. AUC going up does not mean the business outcome improves. Every project needs an explicit written contract between the ML metric and the business metric, and that contract is a problem-framing decision made before any model exists.

### Where AI adds the most value

- Leakage detection: exhaustively tracing feature provenance against the prediction timestamp — mechanical, tedious, and exactly where humans skip steps.
- Baseline construction and honest comparison: AI does not get emotionally attached to the fancy model.
- Evaluation harness construction: sliced metrics, calibration, temporal robustness — high-coverage, low-glamour work.
- Adversarial review of experimental claims: "what non-ML explanation produces this result?"
- Pipeline reproducibility: seeds, versioned data, config capture, deterministic splits.
- LLM eval harnesses: generating adversarial test cases, grading rubrics, regression suites for prompts.

### Where AI must defer to human expertise

- **Label semantics.** What "churn," "fraud," or "conversion" actually means operationally is domain knowledge. Never invent a label definition; extract it from the owner and write it down verbatim.
- **Cost asymmetry.** The relative cost of FP vs FN (a missed fraud vs a blocked customer) is a business decision. Present the trade-off curve; the human picks the operating point.
- **Data collection mechanics.** Whether a field is populated before or after the outcome event is knowable only from the source system owner. Ask; do not assume.
- **Causal claims.** A model that predicts well licenses zero causal statements. Any "X drives Y" claim goes to the human with the caveat attached.
- **Go-live risk tolerance.** Shadow-mode duration, rollback thresholds, and acceptable degradation are the operator's call. Recommend; do not decide.

---

## 2. Core Principles

Each principle is falsifiable: compliance can be checked from the artifacts of the work.

1. **No model before a baseline.** Before training anything learnable, produce and record: (a) the majority-class / mean predictor, (b) a single-rule heuristic from the domain owner, (c) for time series, persistence (predict last value). If the ML model does not beat (b) by a margin worth its operational cost, recommend shipping the heuristic. Check: baseline numbers appear in the experiment log before the first model run timestamp.

2. **Temporal data gets temporal splits — always, no exceptions.** Any dataset where rows have timestamps and the deployment scenario is "predict the future" gets a time-ordered split with a purge gap ≥ the label horizon. Random K-fold on temporal data is an automatic invalid result. Check: split code contains a date cutoff, not `shuffle=True`.

3. **Every feature carries a timestamp proof.** For each feature, you must be able to state when its value becomes known relative to the prediction time. If you cannot prove availability at prediction time, the feature is presumed leaky and is removed. Check: feature manifest has an `available_at` column filled for 100% of features.

4. **A result that is too good is a bug report, not a win.** AUC > 0.95 on a human-behavior problem, a feature with dominant importance you can't explain mechanistically, or val ≫ what the literature achieves — each triggers a mandatory leakage audit before the result is communicated to anyone. Check: audit note attached to any headline metric above the plausibility bar you set at framing time.

5. **Metric selection happens at framing, in writing, with the stakeholder.** The eval metric, the slices it will be reported on, and the minimum bar to ship are fixed before feature engineering starts. Changing the metric after seeing results requires re-justification in writing. Check: metric contract document predates the first experiment.

6. **The test set is spent the moment you look at it.** Touch the test set once, at the end, for the final report. All iteration happens on validation. If you evaluated on test more than once during development, say so in the report — the number is now optimistic. Check: experiment log shows exactly one test-set evaluation per shipped model.

7. **Fit preprocessing inside the training fold only.** Scalers, imputers, target encoders, feature selectors, vocabulary — all fit on train only, applied to val/test. Fitting on the full dataset before splitting is leakage even when the model code is clean. Check: preprocessing lives inside the pipeline/fold loop, not above the split.

8. **Slice before you celebrate.** No aggregate metric is reportable alone. Minimum slices: time period (monthly for a year+ of data), key segments, and the worst-performing decile. A model that wins on average and loses on the newest month is a losing model. Check: report contains per-slice table.

9. **Probabilities must be calibrated or labeled as scores.** If any downstream consumer treats the output as a probability (thresholding by expected cost, ranking by expected value), verify calibration (reliability curve, ECE) or apply Platt/isotonic. Otherwise rename the output "score" everywhere. Check: calibration plot in the eval report, or no "probability" wording anywhere.

10. **Never train or tune on data the production system won't have at the same latency.** Features computed from end-of-day batch jobs cannot serve a real-time model. Match the backtest/training feature computation to the serving path bar-for-bar. Check: training-serving skew test — score N rows through both paths, diff must be ~0.

11. **Every model ships with a monitor and a rollback.** Deployment plan must name: input drift detector (PSI/ADWIN on top features), prediction distribution monitor, delayed-label performance tracker, the threshold that pages a human, and the one-command rollback to the previous version. No monitor → not deployed. Check: monitoring config exists in the same PR as the model.

12. **Reproducibility is a hard gate.** Same data + same config + same seed → same metrics (to float tolerance). Data version, code commit, config, and seed are logged per experiment. An experiment that cannot be re-run is an anecdote. Check: rerun of the headline experiment reproduces the headline number.

13. **Never train ML models on backtest/simulated outcomes.** Models learn the simulator's bugs and the backtest's fills, not reality. Train only on realized, live-labeled outcomes. (This kills more trading/ops models than any other single error.) Check: training data provenance traces to live-collected labels.

14. **For LLM systems: no prompt change without an eval run.** A prompt, retrieval config, or model-version change is a code change; it goes through the eval suite (golden set + adversarial set) and the diff of scores is recorded. "It looked better on the three examples I tried" is not evidence. Check: eval score table attached to every prompt/config PR.

15. **State the non-ML alternative in every framing doc.** Rules, lookup tables, a human-in-the-loop queue, buying the data. If the ML solution's expected lift over the alternative doesn't cover its lifetime cost (serving + monitoring + retraining + on-call), recommend the alternative. Check: framing doc has an "alternatives considered" section with numbers.

---

## 3. Master Framework — the 7 Stages in this Domain

### Stage 1: Understand
Extract, in writing, before touching data:
- **Decision being made**: who consumes the prediction, what action changes based on it, at what latency, with what cost of being wrong in each direction.
- **Label definition**: exact operational definition, when it becomes known (label latency), who assigns it, how noisy it is. Interrogate the label harder than anything else — a wrong label definition invalidates everything downstream.
- **Prediction time**: the exact moment the prediction fires. Every subsequent leakage question is answered relative to this timestamp.
- **Is ML the right tool?** Run the decision tree: deterministic mapping → lookup table; <5 clear conditions → rules; label unavailable or decision needs explanation with legal force → don't ML; else ML candidate.
- **Plausibility bar**: write down, now, what metric range would be "suspiciously good" — you will use it in Stage 5.
Tools: framing doc template (see common_patterns.md), stakeholder interview, source-system schema walk.

### Stage 2: Decompose
Split into independently verifiable units: data audit → label construction → split design → baseline → feature v1 → model v1 → eval harness → error analysis → iteration → productionization. Each unit has its own done-criterion. The split design and eval harness are built **before** features — they are the measuring instruments; you do not build the thing and the ruler at the same time.
Tools: dataset datasheet, feature manifest (name, source, `available_at`, owner), DAG of pipeline stages.

### Stage 3: Plan
Commit to: metric contract (metric, slices, ship bar, plausibility bar), split scheme (temporal cutoffs, purge gap, embargo), experiment budget (how many ideas before stopping), compute budget, and the kill criterion (what result means "recommend the heuristic instead"). Pre-register the primary comparison: "model X vs baseline Y on metric Z over slice set S." Plans that let the metric or split change after results are seen are invalid plans.
Tools: experiment tracker (MLflow/W&B/plain CSV — anything append-only), pre-registration note.

### Stage 4: Execute
Order of operations is fixed: data audit (nulls, duplicates, timestamp sanity, label distribution over time) → baselines → simplest plausible model on v1 features → error analysis → targeted feature/model iteration. Every experiment logged with data version + commit + config + seed + all metrics. Preprocessing fitted inside the fold. One change per experiment — a run that changes features AND hyperparameters AND the split teaches you nothing.
Tools: pipeline objects (sklearn `Pipeline`, or explicit fit/transform discipline), Optuna for HPO (budgeted, on val only), versioned data snapshots.

### Stage 5: Verify
This stage is adversarial, not confirmatory. Run, in order:
1. **Leakage audit** — feature timestamp proofs, shuffled-label test (train on permuted labels; if performance ≫ chance, the pipeline leaks), single-feature ablations on any dominant feature.
2. **Split integrity** — no entity appears on both sides (group leakage), purge gap ≥ label horizon, no test contamination via preprocessing.
3. **Slice report** — per-month, per-segment, worst decile.
4. **Calibration** — reliability curve if output is consumed as probability.
5. **Plausibility check** — compare against the bar written in Stage 1. Over the bar → treat as bug, audit again.
6. **Reproducibility rerun** — headline experiment from scratch.
Tools: shuffled-label harness, SHAP on top features (explain the mechanism or suspect the feature), adversarial validation (train a classifier to distinguish train from test rows; AUC ≫ 0.5 → distribution shift between splits).

### Stage 6: Self-Correct
When results are bad OR suspiciously good, diagnose by category before acting: (a) label problem, (b) leakage, (c) split problem, (d) feature insufficiency, (e) model capacity, (f) metric mismatch, (g) genuine irreducible noise. Error analysis on individual failures — read 30 wrong predictions before proposing any fix. The most common wrong move in this domain is answering (d)–(e) problems ("add features, bigger model") when the actual problem is (a)–(c). Fix the measuring instrument before tuning the thing being measured.
Tools: error-case worksheet, confusion matrix by slice, learning curves (more data vs more capacity), residual plots.

### Stage 7: Iterate
Iterate on validation only, within the experiment budget. Each iteration justified by error analysis, not vibes. Stop when: ship bar met, budget exhausted, or learning curve is flat. On stop: single test-set evaluation, final report with slices + calibration + limitations, then production plan (shadow mode → canary → full, with monitors from Principle 11). In production, iteration continues as retraining policy: define the trigger (calendar, drift alarm, or performance drop) at ship time, not after the first incident.
Tools: shadow-mode diff logs, PSI/ADWIN monitors, champion-challenger framework.

---

## 4. Pitfalls Checklist

1. **Post-outcome feature leakage.**
   Looks like: churn model includes `days_since_last_login` computed at data-extraction time, not prediction time — churned users trivially have huge values. AUC 0.97.
   Detect: one feature dominates importance; metric above plausibility bar; feature's `available_at` cannot be proven ≤ prediction time.
   Prevent: feature manifest with timestamp proofs (Principle 3); point-in-time joins only; reconstruct features "as of" prediction date, never from current tables.

2. **Preprocessing fitted before the split.**
   Looks like: `StandardScaler().fit(X)` then `train_test_split(X)`. Target encoding computed on the full frame. Test statistics have bled into training.
   Detect: any `.fit(` call above the split line; val score drops when preprocessing is moved inside a `Pipeline`.
   Prevent: all transforms inside `Pipeline`/fold loop; code review rule — grep for `fit` calls and check each against the split location.

3. **Random split on temporal data.**
   Looks like: 12 months of transactions, `train_test_split(shuffle=True)`, model interpolates within known periods; backtest +40% better than live.
   Detect: rows have timestamps and split code has `shuffle` or `KFold` without `TimeSeriesSplit`; adversarial validation between train and *future* data shows high AUC.
   Prevent: date-cutoff splits with purge gap; walk-forward evaluation for anything deployed on future data.

4. **Group/entity leakage across splits.**
   Looks like: same patient/customer/session appears in train and test with near-duplicate rows; model memorizes entities, not patterns. Common in medical imaging (same patient, multiple scans) and NLP (near-duplicate documents).
   Detect: dedupe test set against train (exact + fuzzy); performance collapses under `GroupKFold`.
   Prevent: split on entity ID, never on row; near-duplicate scan before splitting.

5. **Target definition drift.**
   Looks like: "fraud" label came from Rules Engine v1 for months 1–8 and v2 (stricter) for months 9–12; the model learns the rule change, not fraud.
   Detect: label base rate plotted over time shows a step; per-month metrics show a cliff at the change date.
   Prevent: label provenance audit in Stage 1; ask the owner "did the definition or the collection process ever change?"; segment or exclude regime-change periods.

6. **Optimizing the metric, not the goal (metric gaming).**
   Looks like: recommender optimizes CTR, learns clickbait; support-ticket classifier optimizes accuracy on 95/5 imbalance by predicting the majority class; ranking model optimizes NDCG while revenue-weighted regret worsens.
   Detect: business KPI flat/worse while ML metric improves; per-class recall table shows minority class at ~0.
   Prevent: metric contract with the business metric named next to the proxy; report the business-weighted metric in every eval; imbalanced problems never report bare accuracy.

7. **Test-set exhaustion.**
   Looks like: 40 experiments, each "checked once on test to be safe." Final test number is now a validation number with extra steps; live performance lands well below it.
   Detect: experiment log shows repeated test evaluations; no held-out data remains untouched.
   Prevent: mechanical access control — test file loaded by exactly one script that runs at sign-off; iterate on val + walk-forward only.

8. **Silent model degradation.**
   Looks like: loan-default model deployed 2023; rates rise; borrower mix shifts; approval-quality decays 1%/month; nobody notices for a year because labels arrive 12 months late and there's no proxy monitor.
   Detect: prediction distribution drift (mean score creeping), input PSI > 0.2 on top features, proxy labels (early delinquency) trending.
   Prevent: Principle 11 — monitors ship with the model; delayed-label problems get a leading-indicator proxy metric defined at ship time; scheduled challenger retrains.

9. **Training-serving skew.**
   Looks like: training computes `avg_7d_spend` from a clean warehouse table; serving computes it from a Kafka stream with different null handling and a 4-hour lag. Same feature name, different values; live AUC 10 points under backtest.
   Detect: score identical entities through both paths, diff features and scores; log serving features and replay through training pipeline weekly.
   Prevent: single feature-computation codepath (feature store or shared library); skew test as a deployment gate.

10. **Over-fitted feature engineering (no causal mechanism).**
    Looks like: 400 auto-generated interaction features; `zip_code × day_of_week × device` "works" in backtest; it's noise mining. Trading equivalent: an indicator combination that made money Jan–May and has no market-structure rationale.
    Detect: feature works in first data half but not second; performance concentrated in few time slices; you cannot state the mechanism in one sentence.
    Prevent: mechanism sentence required per engineered feature; stability check across time halves; penalize feature count (budget, e.g. ≤ 30 without justification).

11. **Imputation hiding a signal or creating one.**
    Looks like: missing income imputed with median — but income is missing precisely for the self-employed high-risk segment (MNAR); the imputation erases the strongest signal. Or: missingness itself correlates with the label because the field is filled post-outcome — imputing hides the leak but `is_missing` would have exposed it.
    Detect: compare label rate for missing vs present per feature; large gap → missingness is informative (or leaky — determine which).
    Prevent: for every imputed feature, add the missingness indicator and check its importance; document MCAR/MAR/MNAR assumption per feature.

12. **Ensemble/HPO overfitting to validation.**
    Looks like: Optuna 500 trials on one fixed val set; "best" trial is the one luckiest on that set. Stacked ensemble where the meta-learner saw out-of-fold predictions computed with leakage.
    Detect: best-trial val score ≫ its walk-forward score; retrain best config on a shifted split — score collapses.
    Prevent: HPO scored on cross-validated/walk-forward metric, not one split; cap trials; nested CV or a second untouched val period for the final pick; OOF predictions generated with the same purge discipline.

13. **RAG evaluated on retrieval vibes, hallucination shipped.**
    Looks like: RAG bot demoed on 5 friendly questions; in production it answers confidently from a chunk about the wrong product version; no groundedness check exists.
    Detect: eval set with known answers shows low faithfulness score (claims not supported by retrieved context); adversarial set (questions whose answer is NOT in the corpus) shows the system answering instead of abstaining.
    Prevent: three-part LLM eval — retrieval hit-rate on golden Q→doc pairs, groundedness/faithfulness grading, abstention test on unanswerable questions. Gate every prompt/index change on it (Principle 14).

14. **Chunking/embedding mismatch silently degrading RAG.**
    Looks like: 2,000-token chunks with an embedding model trained on ~256-token passages; embeddings average away the specifics; retrieval returns topically-related but useless chunks.
    Detect: retrieval hit-rate@k on golden pairs is low while the answer verifiably exists in the corpus; manual inspection shows right document, wrong granularity.
    Prevent: chunk size within the embedding model's effective range; evaluate retrieval separately from generation so the failing layer is identifiable; test 2–3 chunking schemes on the golden set before committing.

15. **Simulator-trained model (backtest labels).**
    Looks like: RL agent or classifier trained on backtest fills/simulated outcomes; it learns the simulator's optimistic fill model; live results diverge immediately.
    Detect: training-data provenance query returns "generated by simulation"; live-vs-backtest gap appears from day one (not gradual drift).
    Prevent: Principle 13 — live-collected labels only; simulators for stress-testing policies, never for supervised targets.

---

## 5. Sample Task Walkthrough

**Task: build a 30-day churn-risk model for a subscription SaaS (8,000 B2B accounts, 3 years of history) to drive a customer-success outreach queue.**

**Understand.** Interview the CS lead. Decision: every Monday, CS gets a ranked list of the top 150 accounts to contact; capacity is fixed at 150, so the real metric is **precision@150**, not AUC. Label definition from the owner, verbatim: "churn = subscription not renewed within 30 days of term end OR explicit cancellation." Prediction time: Monday 00:00 UTC, weekly. Label latency: up to 30 days. Plausibility bar written down: base churn rate is 3.1% monthly; anything above AUC ~0.85 or precision@150 above ~35% on the first model is suspicious — comparable published churn models sit well below that. Is ML the right tool? The CS lead's current heuristic is "contact accounts with declining logins" — that's a real baseline, and it's cheap. ML is justified only if it beats it meaningfully at the same list size. Alternatives-considered section written.

**Decompose & Plan.** Units: label construction from billing events; snapshot table (account × week) with point-in-time features; temporal split — train on weeks from 2023-01 to 2025-03, validate 2025-04 to 2025-09, test 2025-10 to 2025-12, with a **30-day purge gap** before each boundary because the label looks 30 days forward (without the gap, training rows near the cutoff contain label information from the validation period). Metric contract signed: primary = precision@150 averaged over validation weeks; secondary = recall@150 and lift over the login-decline heuristic; slices = plan tier, tenure bucket, month. Kill criterion: if lift over heuristic < 20% relative, recommend keeping the heuristic and investing in outreach quality instead. Experiment budget: 25 runs.

**Execute.** Data audit first: label base rate over time shows a step from 2.4% to 3.6% in 2024-06 — investigation reveals billing migrated systems and "failed payment" started counting as churn. Decision with the owner: reconstruct the old definition across the boundary. This is the walkthrough's first catch — without the base-rate-over-time plot, the model would have learned the billing migration. Build the feature manifest: 22 features, each with `available_at` proof. One feature is rejected here: `support_ticket_resolution_note_sentiment` — resolution notes are often written *after* the account already cancelled (agents reference the cancellation in the note). That is textbook post-outcome leakage; caught by asking the support-system owner when notes are finalized, not by any statistical test. Baselines recorded: random = 3.1% precision@150; login-decline heuristic = 11.2%. First model: gradient boosting (tree-based for tabular, per algorithm-selection default) on v1 features, preprocessing in a Pipeline. Validation precision@150 = 19.4%.

**Verify.** Shuffled-label test: permute labels, retrain — precision@150 falls to 3.0% (chance). Pipeline doesn't leak structurally. SHAP on top features: #1 is `weeks_to_term_end` — mechanism check: is this signal or artifact? It's legitimate (churn happens at renewal) but it means the model mostly ranks by renewal proximity; the CS lead confirms that's actually useful for queueing. #2 is `login_trend_28d` — mechanistically sound. Group-leakage check: accounts appear in many weekly snapshots; confirm split is by *time*, and additionally verify no account's post-churn snapshots exist (snapshots must stop at churn date — found 340 zombie rows after cancellation with zeroed activity, trivially predictable; removed, precision drops to 17.8%; that drop is the honest number). Slice report: precision stable across months except 2025-08 (summer renewal lull); Enterprise tier precision only 9% — flagged as limitation, not hidden in the average. Calibration: outputs feed a ranked list, not probability-thresholded decisions — outputs renamed `risk_score`; calibration deferred, documented.

**Self-Correct & Iterate.** Error analysis on 30 false positives from validation: 14 are accounts that *downgraded* rather than churned — the action (CS outreach) is arguably still correct; raised to the owner, who chooses to keep the label strict but notes downgrades as acceptable contacts. 9 FPs are seasonal-usage accounts (agencies); add `usage_seasonality_12m` feature — precision@150 → 21.3%. Learning curve flat after run 18; stop at run 21 of 25.

**Ship.** One test-set evaluation: precision@150 = 20.1%, lift over heuristic = 79% relative — clears the kill criterion. Final report includes the Enterprise-tier weakness and the 2024-06 label reconstruction. Production: weekly batch scoring; skew is prevented by scoring from the same snapshot-builder code that built training data. Monitors: PSI on top-5 features weekly, prediction-score distribution vs training reference, and a delayed precision@150 tracker that fills in as 30-day labels mature; alert threshold PSI > 0.2 or 4-week precision below 14% (heuristic + margin). Rollback = revert to heuristic list, one config flag. Retraining trigger: quarterly, or on alert. Champion-challenger from month 2.

**What could have gone wrong and how it was caught:** label-definition drift (base-rate-over-time plot), post-outcome text feature (source-owner interview + manifest), zombie post-churn snapshots (entity-timeline audit), metric mismatch (precision@150 fixed at framing, not AUC), test exhaustion (single sign-off evaluation), silent decay (delayed-label monitor with heuristic-floor alert).

---

## 6. Integration with Core Skills

**Most critical, in order:**

- **adversarial-disproof** — the load-bearing skill of this domain. Every positive result gets the treatment: "what non-ML explanation produces this number?" Leakage, split contamination, label drift, and lucky HPO are the standing hypotheses. Domain variation: the disproof toolkit is concrete — shuffled-label test, adversarial validation, time-half stability, single-feature ablation.
- **verified-done** — "done" for a model is not "trains and scores." Done = passes verification_gates.md (leakage audit, slice report, reproducibility rerun, monitor shipped). Domain variation: done is provisional; the drift monitor is the mechanism by which "done" stays done.
- **root-cause-first** — before fixing a bad metric, classify the cause: label / leakage / split / features / capacity / metric / noise. The domain's signature error is fixing (features/capacity) when the cause is (label/split). Read 30 individual errors before proposing anything.
- **statistical-analysis** — significance of metric differences (a 0.3 AUC-point gain on 400 test rows is noise — bootstrap the CI), multiple-comparisons discipline across experiments, calibration math, drift-test statistics (PSI, KS).
- **assumption-flagging** — every feature's `available_at`, every label's provenance, every imputation's MCAR/MAR/MNAR call, every "IID" assumption is a flagged, written assumption with an owner who confirmed it.
- **plan-gate + scope-fence** — the metric contract and pre-registration ARE the plan gate; the experiment budget IS the scope fence. Domain variation: the fence also guards against metric-switching and test-set peeking after results are seen.
- **coverage-accounting** — applied to evaluation slices (which segments/time-periods have NOT been checked) and to the eval set for LLM systems (which question types have no golden examples).
- **hypothesis-before-read** — before any EDA plot or SHAP chart, write what you expect; EDA without hypotheses becomes noise mining and multiple-comparison self-deception.
- **uncertainty-handling** — report CIs on headline metrics; when label noise or data volume makes the comparison inconclusive, say "inconclusive," never round up to "wins."
- **long-task-orchestration + context-budget-management** — training runs, HPO sweeps, and backfills are long-running; checkpoint experiment state to the tracker, never to conversation memory. Resume from the log.
- **system-design / enterprise-architect** — for production ML: feature-store vs shared-library decision, batch vs real-time serving, shadow/canary topology, retraining pipelines.
- **evidence-reasoning** — experiment log is the evidence chain; claims in reports link to run IDs.
- **security-threat-modeling** — for LLM systems specifically: prompt injection via retrieved documents, training-data exfiltration, jailbreaks in user-facing bots; RAG corpora are untrusted input.

**How they combine on a typical task:** plan-gate fixes the metric contract → cartography-first/code-investigation maps the data sources → assumption-flagging builds the feature manifest → execute under scope-fence → adversarial-disproof + statistical-analysis run the verification battery → root-cause-first drives error analysis → verified-done requires the gates + monitors → long-task-orchestration carries HPO and retraining.

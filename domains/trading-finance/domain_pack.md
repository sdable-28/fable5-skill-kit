# Trading & Finance — Domain Pack

Internal operating instructions. Read fully before any trading or finance task. These rules override generic behavior.

---

## 1. Domain Overview

### What makes this domain unique

Trading is the only domain where the ground truth actively fights back. In software, a bug reproduces deterministically. In trading, the market is an adversarial, non-stationary process: the moment a pattern is widely exploited, it decays. Every result carries three layers of doubt simultaneously — is the code correct, is the statistic real, and will the edge persist forward? Most domains have one.

Three structural properties drive everything in this pack:

1. **Asymmetric cost of error.** A wrong answer in most domains costs a rework cycle. A wrong answer here costs real money, often within minutes, and losses compound differently from gains (a 50% drawdown requires a 100% recovery). Treat every sizing, stop, and fill assumption as a live wire.
2. **Non-stationarity.** The data-generating process changes. A strategy validated on 2021 equity data was validated on a QE regime that no longer exists. Time-series validation rules that are optional elsewhere (walk-forward, embargo periods, regime tagging) are mandatory here.
3. **Selection and survivorship pressure everywhere.** Backtests overfit silently. Delisted tickers vanish from datasets. Winning trades get journaled; losers get forgotten. The default state of any trading result is "biased upward until proven otherwise."

### Where AI adds the most value

- **Bias detection.** Reading backtest code for look-ahead, survivorship, and fill-assumption errors. Humans wrote the bug; a fresh adversarial read finds it. This is the single highest-value activity.
- **Exhaustive bookkeeping.** Contract specs, margin formulas, settlement conventions, session times, tick values, expiry calendars, corporate-action adjustments. Errors here are silent and expensive; machines don't get bored.
- **Statistical honesty enforcement.** Computing what N trades actually support, deflating Sharpe for multiple testing, refusing to bless a 30-trade "edge."
- **Execution-path tracing.** Signal → order → fill → stop → flat, every variable at every step. The backtest-to-live gap lives in these paths.
- **Structured falsification.** Designing the test that would kill a strategy hypothesis, then running it.

### Where to defer to human expertise

- **Live capital decisions.** Never autonomously deploy, resize, or un-halt live trading. Present findings and the exact change; the operator decides. No exceptions.
- **Regime judgment under novelty.** A human who watched 2008, 2020-03, and 2022 has priors about crisis microstructure that no backtest encodes. When a situation has no historical analogue in the data, flag it and defer.
- **Broker/prop-firm relationship facts.** Rules about automated trading permissions, consistency requirements, and drawdown mechanics vary by firm and change without notice. Verify against the firm's current documents, not memory.
- **Anything resembling investment advice to third parties.** Analysis of a system's properties is in scope; "you should buy X" to an external party is not.

---

## 2. Core Principles

Each principle is falsifiable: a reviewer can check compliance by inspecting the artifact.

1. **No result without its denominator.** Never report a win rate, expectancy, or edge without trade count, period, instrument, and fill assumption in the same sentence. "62% WR" is banned; "62% WR over 48 trades, NQ, Jan–May, next-bar-open fills, 1 tick slippage" passes.

2. **Out-of-sample is spent once.** A held-out period may be evaluated exactly one time per strategy family. The moment you iterate on a parameter after seeing OOS results, that period is in-sample forever. Track the ledger of which periods each strategy has "seen" explicitly in the journal.

3. **Every backtest states its fill model or is invalid.** Limit orders require the market to trade *through* the price (or a queue model), not touch it. Stop orders fill with adverse slippage, never at the stop price on a gap. A backtest file with no explicit fill logic is a bug report, not a result.

4. **Signal computation uses only data available at signal time.** For every feature, name the timestamp at which its inputs finalize. Bar-close indicators cannot gate an entry placed during that bar. Daily indicators computed from today's close cannot inform today's intraday trades. Verify by tracing timestamps, not by reading variable names.

5. **Size from maximum loss, never from conviction alone.** Position size = floor(risk budget / (stop distance × point value)). Conviction may scale size *down* from that ceiling or select among setups; it may never scale size above the risk-budget cap. Any sizing formula where conviction appears in the numerator without a hard dollar cap fails review.

6. **A strategy without a falsification condition is not a strategy.** Before validating any edge, write down what result would kill it (e.g., "if H2 net < 0, dead"). If no killing condition exists, you are curve-fitting with extra steps.

7. **Isolated per-signal P&L does not predict portfolio P&L.** Sizing ladders, daily loss caps, concurrency limits, and shared session state make signals interact. Only full-stack runs count for go/no-go decisions. Per-signal sims are for diagnosis only.

8. **Regime-tag every result.** Split every backtest by regime (trend/chop, vol tercile, calendar halves at minimum). An edge that exists only in one regime is a regime bet, not an edge — label it as such and gate it accordingly.

9. **Never train or tune ML on backtest-generated labels for live deployment.** Backtest fills are fictional; a model trained on them learns the fill model, not the market. ML training data comes from live or paper trades with real fills, minimum 200 samples before first fit.

10. **Drawdown math before profit math.** For any account with a trailing drawdown or daily loss limit, compute worst-case sequences first: max consecutive losses observed × per-trade risk vs. available drawdown. If the historical worst streak breaches the limit, the strategy is unrunnable at that size regardless of expectancy.

11. **Costs are part of the strategy.** Commissions, exchange fees, spread crossing, and slippage per round turn are subtracted in every reported number. A high-frequency edge that dies at 1.5 ticks of round-trip cost was never an edge. Report gross and net; decide on net.

12. **One change per validation cycle.** Never bundle two strategy changes into one backtest run. If run N+1 differs from run N by more than one behavioral change, the attribution is unrecoverable — rerun with changes isolated.

13. **Contract specs from the exchange, not from memory.** Tick size, point value, trading hours, settlement method, expiry, and roll dates come from the exchange spec sheet or the codebase's verified config — never recalled. A point-value error (NQ $20 vs ES $50 vs MNQ $2) silently corrupts every downstream number.

14. **The live system is sacred.** No edit to any file on the live execution path (order routing, position management, risk checks) without: (a) a full variable-by-variable execution trace written before the change, (b) explicit operator approval, (c) a verified rollback path. Findings are presented; changes are authorized.

15. **Absence of evidence is reported as absence.** "The backtest shows no degradation" and "I did not test degradation" are different statements. Every claim lists what was NOT tested. Untested paths are named, not implied clean.

---

## 3. Master Framework — Trading & Finance Adaptation

### Stage 1 — Understand

Establish, before touching anything:
- **Instrument facts:** exact contract/ticker, tick size, point value, session hours (with timezone stated as exchange time AND UTC), margin, expiry/roll. Pull from spec source, write them down.
- **Account constraints:** account type (cash/margin/prop), drawdown mechanics (static, EOD-trailing, intraday-trailing), daily loss limits, consistency rules, max position. These bound everything downstream.
- **The actual question.** "Does this strategy work?" decomposes into: is the code correct → is the historical result statistically real → does it survive costs → does it survive the account constraints → is there reason to expect persistence. Identify which layer the task targets.
- **Data provenance:** source, timezone of timestamps, ETH vs RTH, adjusted vs unadjusted, survivorship handling, known gaps. Do not proceed on data of unknown provenance.

Refuse to proceed past this stage with an unstated fill assumption or unknown point value.

### Stage 2 — Decompose

Split along the trading-specific fault lines:
- **Signal vs execution vs risk vs accounting.** A "strategy bug" is almost always in exactly one of these layers. Locate it before reading code.
- **In-sample vs out-of-sample periods.** Declare the split before the first run. Write it in the plan.
- **Per-regime buckets.** Define the regime partition (at minimum: calendar halves; better: vol/trend tags) before results exist, so the split can't be chosen to flatter the result.
- **Backtest world vs live world.** For every component, ask: does this behave identically live? (Bar timing, partial fills, data feed gaps, restart/recovery state.) List the divergence points explicitly.

### Stage 3 — Plan

- Write the falsification condition first (Principle 6).
- Declare: periods, fill model, cost model, sizing model, regime split, and the single change under test.
- Pre-commit the success threshold numerically ("beat baseline $X on the same periods with same costs") before running anything.
- Plan the verification of the *code* separately from the verification of the *edge*: a look-ahead scan and a fill-model audit are plan line items, not afterthoughts.
- For live-path work: the plan includes the execution trace document and the rollback procedure as deliverables.

### Stage 4 — Execute

- Touch signal logic, execution logic, and risk logic in separate commits. Never interleave.
- Instrument as you go: every trade record carries entry/exit timestamps, prices, size, stop, target, signal ID, conviction/features at entry, and close reason. A backtest that outputs only summary stats is unauditable — regenerate it.
- When modifying an existing system, run the unchanged baseline first on the same data to confirm reproducibility. If the baseline doesn't reproduce, stop — the environment drifted and no comparison is valid.
- Keep raw trade-level CSVs. Aggregates are derived, never primary.

### Stage 5 — Verify

Run the domain gates (see `verification_gates.md`). Minimum battery:
- **Look-ahead scan:** trace every feature's data availability timestamp against its use timestamp.
- **Fill realism audit:** sample 10 trades, check each fill against the actual bar data — did price trade through the limit, was the stop fill gapped?
- **Reconciliation:** sum of trade P&L = reported net, trade count matches, no duplicate trade IDs, positions flat at session end.
- **Cost sensitivity:** rerun (or recompute) at 2× assumed slippage. An edge that dies at 2× slippage is flagged marginal.
- **Split stability:** both halves (or all regime buckets) same sign, or the result is labeled regime-dependent.
- **Too-good detector:** Sharpe > 3 annualized on daily bars, WR > 70% with R:R > 1, or equity curve with no drawdown → presume a bug, hunt for it before celebrating.

### Stage 6 — Self-Correct

- When a result contradicts a prior result, the first hypothesis is *my own pipeline changed*, not *the market changed*. Diff data files, code version, config, and period before theorizing.
- When a strategy degrades live vs backtest, decompose the gap in order: data differences → fill differences → timing differences → sizing differences → then, and only then, edge decay. Quantify each layer.
- Log every falsification permanently. A falsified idea is an asset; re-testing it is a defect. Check the falsification log before proposing any "new" idea.

### Stage 7 — Iterate

- Iteration budget: each additional parameter tweak on the same data raises the multiple-testing burden. Track trials-per-dataset; after ~10 variants, the in-sample result is presumptively overfit and requires fresh OOS data to rehabilitate.
- Promote through the ladder strictly: in-sample → out-of-sample → paper/sim with live data → small live size → full size. Never skip a rung; never promote on one rung's evidence.
- Schedule decay review: every live strategy gets a rolling comparison of live expectancy vs backtest expectancy, with a pre-committed demotion threshold.

---

## 4. Pitfalls Checklist

1. **Next-bar-open leak.**
   *Looks like:* Signal computed on bar N's close, entry filled at bar N's close (or worse, bar N's open). Backtest WR jumps 8-15 points.
   *Detect:* Compare entry timestamp to signal-input timestamps. Entry price equal to the signal bar's close is the tell.
   *Prevent:* Enforce entry ≥ next bar open in the fill layer, not the strategy layer.

2. **Limit-fill-on-touch fantasy.**
   *Looks like:* Backtest fills every limit at the exact level; live, the best signals never fill (price rejects instantly off the level — precisely the trades the backtest counted as winners).
   *Detect:* For sampled limit fills, check whether price traded *through* the level by ≥1 tick. Compute % of profits from touch-only fills.
   *Prevent:* Require trade-through (or model queue position). Report "fills requiring trade-through" as a separate line.

3. **Stop filled at stop price through a gap.**
   *Looks like:* Overnight gap or news spike blows through the stop; backtest books the stop price, live books 10-40 ticks worse.
   *Detect:* For each stop-out, compare stop price to the bar range that triggered it; any bar that *opened* beyond the stop means the fill was fictional.
   *Prevent:* Fill stops at max(stop, bar open) for shorts / min(stop, bar open) for longs, plus slippage.

4. **Indicator warm-up leak.**
   *Looks like:* A 200-period MA computed over the full dataset then referenced from bar 1; or normalization (z-score, min-max) fit on the whole series including the future.
   *Detect:* Grep for full-array operations (`.mean()`, `.std()`, `fit()` on the complete frame) feeding per-bar signals.
   *Prevent:* All rolling stats computed expanding/rolling with explicit window; scalers fit on training period only.

5. **Survivorship-biased universe.**
   *Looks like:* Equity strategy backtested on *current* S&P 500 constituents over 10 years. Every delisted loser is invisible; mean-reversion "edges" appear from nothing.
   *Detect:* Ask where the ticker list came from and its as-of date. If the list is dated today and the test starts years ago, it's biased.
   *Prevent:* Point-in-time constituent data, or restrict claims to index products.

6. **Trailing-drawdown blindness.**
   *Looks like:* Strategy nets +$40k over 6 months but the worst intra-period losing sequence was -$2.6k on an account with $2k trailing drawdown. The account dies in week 3; the backtest never notices.
   *Detect:* Simulate the account state (trailing floor, daily limits) bar by bar inside the backtest, not as an afterthought on the equity curve.
   *Prevent:* Account-constraint simulation is part of the backtest engine. Report "account survives: yes/no, breach date if no" as a headline stat.

7. **Regime-concentrated edge sold as universal.**
   *Looks like:* +$80k total, but +$78k came from three high-VIX weeks. Presented as "the strategy works."
   *Detect:* Monthly P&L table + top-5-day concentration (what % of net comes from the best 5 days). >50% from 5 days = event-driven, not systematic.
   *Prevent:* Regime tags on every trade; report per-regime expectancy; gate deployment on the regime detector, not the aggregate.

8. **Parameter cliff.**
   *Looks like:* Consolidation filter = 15 bars nets +$60k; 12 bars nets +$8k; 18 bars nets +$11k. The 15 is a spike, not a plateau.
   *Detect:* Perturb every fitted parameter ±20-30% and re-run. Plot the neighborhood.
   *Prevent:* Accept only parameters sitting on plateaus (neighbors within ~40% of peak performance). Cliffs are curve-fit artifacts.

9. **Multiple-testing Sharpe inflation.**
   *Looks like:* 40 strategy variants tested, best one shows Sharpe 2.1, presented alone. Expected max Sharpe of 40 random strategies on 6 months of data is roughly that.
   *Detect:* Ask "how many variants were tried on this data?" If the answer is unknown, assume many.
   *Prevent:* Log every trial. Apply a haircut (deflated Sharpe / Bonferroni intuition) or demand fresh OOS confirmation for the winner.

10. **Timezone/session-boundary corruption.**
    *Looks like:* "RTH open" bars actually taken at the wrong hour half the year because DST shifted the UTC offset; overnight bars leak into session stats; daily bars keyed to midnight UTC split the US session across two "days."
    *Detect:* Print the first and last bar of each session for a DST-transition week (March, November) and eyeball against exchange hours.
    *Prevent:* All session logic in exchange-local tz-aware timestamps; UTC only for storage; a unit test pinned to DST-change dates.

11. **Point-value / contract-spec error.**
    *Looks like:* P&L computed with ES's $50/pt on NQ trades ($20/pt), or micro specs on mini symbols. Every number 2.5× wrong, in either direction.
    *Detect:* Recompute one trade's P&L by hand from entry, exit, size, and the exchange spec sheet. Must match to the cent.
    *Prevent:* Single source-of-truth spec table; hand-reconcile one trade per instrument per review.

12. **Averaging-down disguised as scaling-in.**
    *Looks like:* "Pyramiding" logic that adds size as the position moves *against* entry, with the stop moved to accommodate. Win rate rises; tail risk explodes; one day erases a quarter.
    *Detect:* For every add, check sign of open P&L at add time. Adds at negative open P&L with a widened stop = martingale.
    *Prevent:* Hard rule — total position risk (all entries to current stop) never exceeds the original per-trade risk budget.

13. **Correlation treated as constant.**
    *Looks like:* Simultaneous NQ and ES positions sized as if independent (ρ ≈ 0.9 in stress). Or an equity/bond "hedge" sized on 2015-2019 correlation that flipped positive in 2022.
    *Detect:* Compute realized correlation of the held instruments in the worst 5% of days specifically. Diversification claims based on full-sample correlation fail.
    *Prevent:* Size concurrent correlated positions as one position at combined risk; stress correlations to crisis values (equity indices → 1.0).

14. **Backtest contaminating live state.**
    *Looks like:* Backtest runs write to the same DB/journal/ML-training store as live, poisoning training data and account-state persistence.
    *Detect:* Grep the backtest path for writes to any store the live path reads.
    *Prevent:* `is_backtest` flag threaded to every writer; separate DB files; assert-on-write guards in live stores.

15. **Restart amnesia.**
    *Looks like:* Live system restarts intraday and forgets cumulative P&L, open-position state, or the sizing-ladder position — then re-sizes as if fresh, or double-enters an already-open position.
    *Detect:* Kill-and-restart test mid-simulated-session: does the system reconstruct position, realized P&L, and risk state exactly?
    *Prevent:* All risk-relevant state persisted on every change; startup reconciliation against the broker's reported position before the first order.

---

## 5. Sample Task Walkthrough

**Task:** "Our intraday futures mean-reversion strategy shows +$74k over 8 months in backtest but lost $3.1k in its first 3 weeks live. Find out why and tell me whether to keep running it."

**Stage 1 — Understand.** Pin the facts first. Instrument: NQ futures, $20/pt, 0.25 tick. Live account: prop account, $2,000 EOD-trailing drawdown. Backtest: 1-minute bars, limit entries at band edges, fixed 20-pt stops, next-bar fills assumed at limit price on touch. Live: 14 trades, 4 winners, -$3,105 net. The question decomposes: (a) is the live sample even statistically distinguishable from the backtest distribution, (b) if yes, which layer diverged — data, fills, timing, sizing, or edge.

**Stage 2 — Decompose.** Before reading code, compute the boring answer: backtest per-trade expectancy is +$142 with a per-trade std of ~$610. Fourteen live trades drawn from that distribution have expected net +$1,988 ± $2,282 (1σ). Observed -$3,105 is ~2.2σ below expectation — unlikely but not impossible from variance alone. So variance is *plausible but insufficient*; proceed to the gap decomposition, but flag that N=14 cannot convict the strategy on its own.

**Stage 3 — Plan.** Falsification condition, written before analysis: "If, after aligning fill assumptions, the backtest over the same 3 live weeks reproduces live P&L within 1σ, the edge is intact and the gap is execution. If the aligned backtest still shows profit while live lost, the divergence is in signal timing or data, and live trading halts pending root cause." Deliverables: trade-by-trade alignment table (14 rows), fill audit, timing audit, verdict.

**Stage 4 — Execute.** Build the alignment table: for each live trade — signal time, backtest's fill vs live fill, stop handling, exit, P&L both worlds. Findings from the table:
- 11 of 14 live trades match backtest signals same-minute. Three backtest signals never traded live — all three were backtest winners. Investigate: all three were limit fills where price touched the band and reversed instantly. Live orders sat unfilled. Classic limit-fill-on-touch fantasy (Pitfall 2).
- Live fills on the 11 matched trades averaged 1.8 ticks worse than backtest fills ($36/trade × 11 = $396 of gap).
- One live trade stopped out 22 pts past the stop during a data-feed hiccup — the stop was synthetic (client-side) and the reconnect took 40 seconds. Backtest assumed exchange-side stop at exact price. Gap: ~$440 on that trade.

**Stage 5 — Verify.** Rerun the backtest over exactly the 3 live weeks with corrected assumptions: limit fills require 1-tick trade-through; stops fill with 2-tick slippage. Result: the corrected backtest shows -$1,850 over those weeks — within 1σ of the live -$3,105. Also rerun the *full 8 months* with corrected fills: +$74k collapses to +$31k, and the worst losing streak deepens from -$1.4k to -$2.3k — which **breaches the $2k trailing drawdown**. Reconcile: sum of trade P&L equals reported net in both runs; hand-recompute two trades against the $20/pt spec — match.

**Stage 6 — Self-Correct.** Initial hypothesis ("edge decayed") is rejected: the aligned backtest reproduces live results, so the edge, *as measured honestly*, was never +$74k — it was +$31k with account-killing streak risk. Log the falsification: "touch-fill assumption inflated this strategy 2.4×; three of its best trade types never fill live." Check whether other strategies in the codebase share the same fill layer — they do; flag them all for the same audit (coverage accounting).

**Stage 7 — Iterate & Verdict.** Report: (1) The live losses are consistent with the honest backtest — this is not bad luck, it is the true distribution. (2) At current size, the honest worst streak breaches the trailing drawdown; the strategy is unrunnable on this account at this size regardless of its positive expectancy. (3) Options, each with pre-committed thresholds: halve size (streak -$1.15k, survivable, but profit ~$15k/8mo — is that worth it?), or convert entries to stop-through orders and re-validate on fresh OOS data. **Do not resume live trading until the operator picks a path.** What could still be wrong and how we'd catch it: the 3-week window may itself be a hostile regime — the regime-tagged monthly table is attached showing the strategy's chop-month expectancy, and the demotion threshold for the resized variant is pre-committed at "two consecutive months below the 25th percentile of backtest monthly P&L."

The decisive move in this walkthrough: computing the variance envelope *before* touching code (prevents overreacting to noise), and refusing to compare backtest to live until fill assumptions were aligned (prevents blaming the market for the simulator's fiction).

---

## 6. Integration with Core Skills

**Most critical core skills for this domain, in priority order:**

1. **adversarial-disproof** — The default stance toward every backtest result. Do not ask "does this confirm the edge?"; ask "what is the cheapest test that kills it?" Domain variation: the disproof battery is standardized (look-ahead scan, fill audit, cost 2×, split stability, parameter perturbation) — run it as a fixed gauntlet, not ad hoc.

2. **verified-done** — "Done" in this domain means the verification gates passed and are cited with numbers, never "the backtest ran." A strategy change is not done until baseline reproduction + gated comparison + reconciliation are on record. Domain variation: "done" for live-path changes additionally requires the execution trace document and operator sign-off.

3. **assumption-flagging** — Every fill model, cost figure, correlation, and contract spec is an assumption. Flag inline, at the point of use, with the sensitivity ("result survives 2× this assumption: yes/no"). Domain variation: assumptions get a standing register per strategy, carried forward across sessions.

4. **statistical-analysis + mathematical-reasoning** — Sample-size honesty (what does N=30 support?), variance envelopes before blame, deflated Sharpe under multiple testing, drawdown-sequence math, Kelly and fractional-Kelly sizing, options Greeks. Domain variation: prefer trade-level resampling/bootstrap over parametric formulas; trading returns are fat-tailed and autocorrelated.

5. **root-cause-first** — Backtest-live gaps decompose in a fixed causal order: data → fills → timing → sizing → edge. Never attribute to edge decay before the earlier layers are quantified. Symptom-patching (e.g., "add a filter to block those losers") without layer attribution is banned.

6. **scope-fence + plan-gate** — One behavioral change per validation cycle is a hard fence. The plan gate for this domain requires: falsification condition, fill/cost model, period split, and numeric success threshold — all written before execution. A plan missing any of these does not pass the gate.

7. **coverage-accounting** — When a bug is found in shared infrastructure (fill layer, spec table, timezone handling), enumerate every strategy and report that consumes it and audit each. A fill-model bug is never a one-strategy bug.

8. **hypothesis-before-read + code-investigation** — Before opening a 2,500-line strategy file, state which layer (signal/execution/risk/accounting) the defect should live in and what the code will look like if the hypothesis is true. Use the semantic index to read targeted slices.

9. **uncertainty-handling** — Live trading questions get confidence-calibrated answers with explicit N. "Insufficient data to distinguish variance from decay; need ~40 more trades or a fill audit" is a complete, correct answer. Never manufacture certainty about forward performance — no honest test proves persistence.

10. **long-task-orchestration + context-budget-management** — Multi-month validation campaigns span many sessions. Persist state (falsification log, assumption register, trials-per-dataset counter, OOS-spend ledger) to durable storage every session; never rely on conversational memory for what was already falsified.

**How they combine on the canonical task (strategy validation):** plan-gate admits only a plan with a falsification condition (assumption-flagging populates its register) → scope-fence holds it to one change → execution produces trade-level artifacts → adversarial-disproof runs the fixed gauntlet → statistical-analysis rules on significance → root-cause-first arbitrates any backtest-live gap → coverage-accounting spreads any infrastructure finding → verified-done closes only on cited gate results → long-task-orchestration writes the falsification log so the next session cannot re-litigate a dead idea.

# Trading & Finance — Verification Gates

Domain-specific pass/fail gates. Apply the relevant subset to every trading/finance deliverable. A deliverable that skips an applicable gate is not done — report the skip explicitly. Cite the gate result with numbers, never "gate passed."

---

## Gate 1 — Look-Ahead Freedom

**What passes:** Every feature, indicator, and filter used in a signal has a documented data-availability timestamp that is ≤ the signal timestamp. Rolling statistics use explicit windows; scalers/normalizers are fit on training data only; daily-derived features (daily close, daily ATR, prior-day levels) are used only on the *following* session. Entry fills occur no earlier than the bar after the signal bar (or intrabar with an explicit trigger model).

**What fails:** Any full-array operation (`.mean()`, `.std()`, `.min()`, `fit()`, resample-then-broadcast) over the complete dataset feeding a per-bar decision. Entry price equal to the signal bar's close. Any "today's" daily value referenced during today's session. Session-high/low variables that include bars after the decision point.

**How to check:** Trace 3 sampled signals end-to-end: list every input, its computation window, and its finalization timestamp. Grep the signal path for whole-frame operations. Run the strategy with the dataset truncated at the signal timestamp — the signal must be identical to the full-data run.

---

## Gate 2 — Fill Model Realism

**What passes:** Fill logic is explicit and conservative: limit orders require price to trade through the level by ≥1 tick (or a stated queue model); stop orders fill at max(stop, trigger-bar open) plus stated slippage; market orders pay the spread plus stated slippage; no fill exceeds the bar's traded range. The fill model is stated in every results report.

**What fails:** Limit fills on touch. Stop fills at exact stop price when the triggering bar opened beyond the stop. Fills at prices outside the bar's high-low range. Any results file where the fill model must be inferred from code archaeology.

**How to check:** Sample 10 trades from the results CSV (include at least 3 stop-outs and 3 limit entries). For each, pull the underlying bars and verify the fill was physically obtainable. Compute the fraction of total profit attributable to touch-only limit fills — if > 10%, fail.

---

## Gate 3 — P&L Reconciliation

**What passes:** Sum of per-trade P&L equals the reported net to the cent. Trade count in the summary equals rows in the trade log. No duplicate trade IDs. Every trade has entry and exit; positions are flat at every session close (for intraday systems) or open positions are marked and reported. One trade per instrument hand-recomputed from entry, exit, size, and the exchange point value — matches exactly.

**What fails:** Any discrepancy between trade-level sum and headline number. Trades with missing exits. Reported results that exist only as aggregates with no trade-level artifact. Point-value or tick-size mismatch against the exchange spec.

**How to check:** Script the reconciliation (sum, count, dedupe, flat-at-close) against the raw CSV; hand-check one trade per instrument against the spec sheet.

---

## Gate 4 — Out-of-Sample Integrity

**What passes:** The IS/OOS split was declared before the first run (evidence: plan document or journal entry predating results). The OOS period was evaluated at most once for this strategy variant. The trials ledger for this dataset is current (how many variants have seen this data). If the OOS was consumed by iteration, the report says so and demands fresh data.

**What fails:** OOS period chosen after seeing results. Parameters adjusted after an OOS run, then the same OOS period re-scored. "Out-of-sample" that shares regime and adjacency with in-sample without an embargo gap. No record of how many variants were tried.

**How to check:** Compare timestamps: split declaration vs first result. Read the trials ledger. If no ledger exists, the gate fails by default — assume contamination.

---

## Gate 5 — Cost & Slippage Survival

**What passes:** Reported net is after commissions, exchange fees, and stated slippage per side. The result recomputed at 2× assumed slippage remains positive (or the report explicitly labels the edge "cost-marginal" with the breakeven slippage stated in ticks).

**What fails:** Gross results presented as net. Zero-cost backtests used for go/no-go. An edge whose per-trade expectancy is under ~2 ticks of the traded instrument presented without a cost-sensitivity line.

**How to check:** Recompute net at 0×, 1×, 2× slippage (arithmetic on the trade log — no rerun needed if slippage is additive per side). Report the three numbers. Breakeven slippage = expectancy / (sides × tick value), stated in ticks.

---

## Gate 6 — Split & Regime Stability

**What passes:** Result is positive in both calendar halves of the test period, OR the report explicitly labels the edge regime-dependent, names the favorable regime, and specifies the gating mechanism that restricts trading to it. Top-5-day concentration is reported; if > 50% of net comes from the best 5 days, the result is labeled event-driven.

**What fails:** Aggregate-only reporting. One half profitable, one half flat/negative, presented as "works." Monthly P&L table absent. Regime dependence discovered but not wired into a gate.

**How to check:** Split the trade log by calendar halves and by month; compute net, WR, expectancy per bucket. Sort days by P&L; compute top-5 concentration.

---

## Gate 7 — Parameter Plateau

**What passes:** Every fitted parameter (thresholds, lookbacks, stop distances, conviction floors) was perturbed ±20-30% and the result stays within ~40% of the peak. Parameters sit on plateaus. The perturbation grid is attached.

**What fails:** Any parameter where a ±20% move destroys > 60% of the profit (cliff). Parameters carried at suspicious precision (0.58, 15 bars, 42.5 pts) with no neighborhood evidence. "We tuned it and this was best" with no grid.

**How to check:** For each fitted parameter, rerun (or table-lookup from the tuning history) at −30%, −20%, +20%, +30%. Tabulate. Cliff → fail or explicit downgrade to "fragile — do not deploy."

---

## Gate 8 — Account Constraint Survival

**What passes:** The backtest simulates the actual account mechanics — trailing drawdown (correct flavor: EOD vs intraday trailing, floor-lock rules), daily loss limits, max contracts, consistency rules — bar by bar, and reports "account survives: YES" plus worst margin-to-breach. Sizing respects the per-trade dollar risk cap at every entry including after stop widening.

**What fails:** Equity-curve-level drawdown analysis substituted for account simulation (EOD-trailing and intraday-trailing give different breach dates). Any single trade whose worst-case loss (entry to stop × size × point value) exceeds the per-trade cap. Historical worst losing streak × per-trade risk exceeding available drawdown without a headline warning.

**How to check:** Replay the trade log through an account-state simulator with the firm's exact rules. Independently: max(per-trade risk in the log) vs the cap; worst streak length × cap vs available drawdown.

---

## Gate 9 — Backtest/Live Parity (for any live or paper deployment)

**What passes:** For every live trade, a same-day alignment row exists: backtest-world signal, fill, exit vs live signal, fill, exit, with the gap decomposed into data / fill / timing / sizing components. Signals that fired in one world but not the other are enumerated with reasons. Rolling live expectancy is compared against the backtest distribution with a pre-committed demotion threshold.

**What fails:** Live results compared to backtest aggregates without trade-level alignment. Unfilled live orders silently dropped from the comparison (they are usually the backtest's best trades). No demotion threshold defined before go-live.

**How to check:** The alignment table exists and covers 100% of live trades and 100% of backtest signals in the live window. Sum the gap components; they must account for ≥ 80% of the total backtest-live difference or the analysis is incomplete.

---

## Gate 10 — Live-Path Change Safety (for any edit touching order routing, position management, or risk checks)

**What passes:** A written variable-by-variable execution trace (signal → order construction → submission → fill handling → stop management → flat) exists for both pre-change and post-change behavior, covering: normal fill, partial fill, rejection, disconnect mid-order, and restart with open position. Explicit operator approval is on record. Rollback command/commit is identified. Backtest writes cannot reach live stores (flag verified).

**What fails:** Any live-path edit merged on the strength of "backtest still passes." Untraced paths (partial fills and restarts are the classic omissions). Self-authorized deployment. Shared state between backtest and live writers.

**How to check:** The trace document exists and names every state variable at every step for all five scenarios. Kill-and-restart test executed in sim: position, realized P&L, and sizing-ladder state reconstruct exactly and startup reconciles against broker-reported position.

---

## Gate 11 — Statistical Sufficiency

**What passes:** Every claim of edge, improvement, or degradation states N and a dispersion measure, and the conclusion is supported at that N (rule of thumb: differences smaller than 2×SE of expectancy are reported as "indistinguishable"). Comparisons between runs hold data, periods, costs, and all-but-one variable fixed. Multiple-testing count is disclosed.

**What fails:** "Improved from 45% to 52% WR" on N=25 vs N=21 presented as signal. Sharpe/WR reported without N. A winner selected from >5 variants presented without a haircut or fresh-data confirmation. Regime-different periods compared as if like-for-like.

**How to check:** SE of WR ≈ sqrt(p(1−p)/N); SE of expectancy ≈ trade-P&L std / sqrt(N). Recompute for every headline claim. Any claim inside the noise band gets rewritten as "no detectable difference."

---

## Gate 12 — Falsification Log Currency

**What passes:** Every falsified hypothesis, reverted change, and dead research line from the session is written to the persistent falsification log with the evidence and the kill condition that triggered. Every new proposal was checked against the log before work began.

**What fails:** A falsified idea re-proposed or re-tested because the failure lived only in a chat transcript. A reverted change with no record of why. Session ends with confirmed results or falsifications unlogged.

**How to check:** Diff the falsification log before/after the session against the session's actual events. For any new proposal, cite the log query performed ("checked: no prior falsification of X").

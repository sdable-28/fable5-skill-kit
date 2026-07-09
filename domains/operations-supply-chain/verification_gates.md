# Operations & Supply Chain — Verification Gates

Apply every applicable gate before declaring any deliverable done. A gate either passes with evidence or fails — no partial credit. Record the gate results in the deliverable itself.

---

## Gate 1 — Units & Time-Bucket Integrity
**Passes:** Every quantity in the analysis traces to a stated unit (eaches/cases/pallets/kg/$) and a stated time bucket (day/week/month), and every join or formula mixing sources has an explicit conversion. σ values state their time bucket (σ_weekly ≠ σ_monthly/√4.33 unless independence was checked).
**Fails:** Any formula combining fields whose units were never confirmed; any σ used in a safety-stock formula whose bucket doesn't match the lead-time unit; demand in cases joined to forecasts in eaches.
**How to check:** Build a two-column table (quantity → unit, bucket) for every input; walk each formula and confirm dimensional consistency. One pass, mechanical, no exceptions.

## Gate 2 — Variance Term Present
**Passes:** Every stochastic input (demand, lead time, cycle time, yield, downtime) enters calculations as mean + dispersion, or carries a flagged assumption with a sensitivity line showing the recommendation's exposure to that assumption.
**Fails:** Safety stock, capacity plan, or ROP computed from means only; lead time appearing solely as a scalar; "average demand × average lead time" anywhere without an SS term.
**How to check:** Grep the work product for every mean used; confirm each has a paired σ/CV/range or a flagged assumption entry in the parameter provenance table.

## Gate 3 — Naïve Baseline Beaten (forecasting)
**Passes:** The proposed forecast is scored on a holdout window it never saw, against the seasonal-naïve baseline, and wins on wMAPE; bias (mean signed error) is reported separately and is within ±5% or explicitly justified.
**Fails:** Accuracy quoted from the fitting window; no naïve comparison; bias unreported; MAPE used on intermittent (zero-heavy) demand without switching to wMAPE/MASE.
**How to check:** Confirm the holdout split dates are stated and post-date every fitted parameter. Recompute naïve wMAPE on the same holdout and compare.

## Gate 4 — Stability Before Capability (quality/SPC)
**Passes:** Any Cpk/Ppk figure is accompanied by a control chart verdict (in control / out of control, with rule set named — e.g., Nelson rules) on the same data window, subgrouping rationale stated, and measurement-system adequacy at least addressed (Gage R&R exists or is flagged missing).
**Fails:** Capability index quoted alone; control chart from a different period; subgroups formed arbitrarily (e.g., by convenience batches that mix shifts).
**How to check:** The capability statement must physically contain the stability verdict. If it doesn't, fail — do not go looking for the chart elsewhere.

## Gate 5 — Sanity Translation (inventory & capacity)
**Passes:** Every inventory quantity is also expressed in days/weeks of supply and passes a plausibility scan (A-item safety stock typically 0.5×–2× lead time demand; anything outside gets an explanation). Every capacity figure is also expressed as utilization of effective (OEE-adjusted) capacity, and constrained resources sit ≤ 85% or the queue-time consequence is quantified (Kingman).
**Fails:** Raw unit or dollar figures with no supply-days translation; utilization computed on nameplate capacity; a 40-week safety stock passing without comment.
**How to check:** Add the translation columns and eyeball every row against the plausibility bands. Investigate every outlier before shipping, not after.

## Gate 6 — Backtest Against Held-Out History (policies)
**Passes:** Any proposed inventory policy, reorder parameter set, or scheduling rule is replayed against at least 12 months of actual history (demand and actual receipts), and the modeled service level meets target; historical failure events are either covered by the new policy or explicitly attributed to out-of-scope causes.
**Fails:** Policy justified only by formula ("the math says 97%"); backtest window overlaps the parameter-estimation window without acknowledgment; stockout events silently unexplained.
**How to check:** The deliverable contains a backtest table: month × modeled position × service outcome. Spot-check two historical stockout dates and confirm the new policy's modeled on-hand covers them.

## Gate 7 — As-Is Grounding (process work)
**Passes:** Every current-state process map cites its evidence per step: observed (date), interviewed (role), or event-log-derived (field names). The map contains at least one rework/exception path. Timestamp-derived cycle times were audited for batch-posting artifacts (shift-boundary or end-of-week clustering).
**Fails:** Current state sourced from SOP/work instructions alone; a process map with zero exception paths; cycle-time stats built on timestamps never audited for posting behavior.
**How to check:** Evidence column present on the map or its appendix; histogram of event timestamps reviewed for artificial clustering.

## Gate 8 — Constraint Named (throughput/improvement work)
**Passes:** The system bottleneck is identified with data (utilization, queue length, or WIP accumulation point), and the improvement is expressed in system-level terms (throughput, end-to-end lead time, on-time delivery) showing it exploits, subordinates to, or elevates the constraint.
**Fails:** Improvement measured only at a local station; bottleneck asserted from opinion; a proposal that speeds a non-constraint with no WIP-impact statement.
**How to check:** Ask of the deliverable: "which resource limits system output, and how does this change affect it?" If the document cannot answer in one sentence with a number, fail.

## Gate 9 — Concentration & Single-Source Exposure (sourcing/risk)
**Passes:** For the items/lanes in scope, sourcing concentration is assessed at least one tier deeper than the direct supplier for A items; every single-source exposure carries revenue-at-risk, time-to-recover, and a costed mitigation; "qualified" backup sources are validated by last-shipment date and tooling status.
**Fails:** Risk register lists "supplier risk — medium" with no exposure quantification; dual-source claimed where both sources share an upstream dependency or the backup hasn't shipped in >24 months.
**How to check:** For each A item: count truly independent qualified-and-active sources. Any count of 1 must appear in the register with all three quantified fields populated.

## Gate 10 — Savings Are Dated Cash (business case)
**Passes:** Every savings figure splits hard (specific budget line, start date, ramp) from soft (capacity/avoidance, labeled, excluded from headline); one-time costs and working-capital effects (inventory release/build timing) are on the same timeline; payback stated in months.
**Fails:** Fractional-FTE savings summed into headline dollars; inventory reduction claimed as annual savings rather than one-time cash release plus recurring holding-cost delta; no implementation cost line.
**How to check:** Reconstruct the cash timeline month by month from the deliverable alone. If it can't be reconstructed, fail.

## Gate 11 — Bullwhip Ratio Computed (multi-echelon / "volatile demand" claims)
**Passes:** Wherever demand volatility motivates the recommendation, Var(orders)/Var(downstream demand) is computed per tier on matched time buckets; amplification sources (batching, MOQ, promotions, shortage gaming, forecast-chasing) are checked before volatility is accepted as exogenous.
**Fails:** "Demand is volatile" taken from the requester's framing without measurement; order data and demand data compared on different buckets.
**How to check:** The ratio appears as a number in the deliverable, per echelon, with the bucket stated.

## Gate 12 — Monitoring Plan & Recalculation Trigger Attached
**Passes:** The deliverable ends with: metrics to watch, control limits or thresholds, review cadence, named owner role, and the specific condition that forces re-analysis (e.g., "σ_d trailing-13wk shifts >25% on any A item," "supplier OTD < 90% for 4 consecutive weeks").
**Fails:** A static recommendation with no decay clause; "monitor closely" without a threshold; parameters presented as permanent.
**How to check:** The trigger must be machine-evaluable from named data fields. If a human must "judge" whether the trigger fired, tighten it or fail.

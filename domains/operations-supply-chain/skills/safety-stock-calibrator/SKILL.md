---
name: safety-stock-calibrator
description: Set or audit inventory buffers and reorder points from measured demand and lead-time variance — not averages, not gut feel — and expose where current parameters guarantee stockouts or dead stock. Trigger phrases — "why do we keep stocking out", "safety stock review", "reorder point", "service level target", "too much inventory and still missing orders", "EOQ / min-max settings", "planner keeps overriding the system". Do NOT use when the item's history is dominated by one-off events (product launch, recall, discontinuation) with under ~12 usable demand periods — variance estimates from that history are fiction; flag it as a judgment-buffer item instead. Do NOT use for financial inventory valuation questions.
---

# Safety Stock Calibrator

## When invoked
1. Segment before calculating. Run ABC on value and XYZ on demand variability (CV of period demand: X < 0.5, Y 0.5–1.0, Z > 1.0). The formula path below applies to X/Y items; Z items with intermittent demand (many zero periods) must NOT go through the normal-distribution formula — flag them for period-coverage or Croston-style treatment and say why.
2. Measure both variances from data: stddev of demand per period (σ_d) AND stddev of lead time (σ_LT) from actual PO receipt history, not the quoted lead time in the item master. Compare quoted vs actual lead time; a gap > 20% is a finding in itself and corrupts every downstream parameter.
3. Compute safety stock with the combined-variance form: `SS = z × sqrt(L̄ × σ_d² + d̄² × σ_LT²)` using measured L̄ (mean actual lead time) and d̄ (mean demand). Reorder point = d̄ × L̄ + SS. Show the numbers substituted, not just the result.
4. Set z from an explicit service-level decision per segment, and state the trade: the cost of the marginal service point (A-X items may warrant 99%, C-Z items 85–90%). Never apply one z across the whole portfolio — uniform 95% is the signature of an uncalibrated system.
5. Audit current settings against calibrated ones. For each item (or segment summary): current SS vs calibrated SS, direction of error, and the consequence — under-buffered items get expected stockouts/year, over-buffered items get excess carrying cost in currency.
6. Check the two silent killers: (a) demand history polluted by past stockouts — censored demand understates σ_d and d̄; reconstruct from order lines including unfilled, not shipments; (b) upstream order amplification — if a bullwhip-detector run exists, calibrate against the true downstream demand series, never against received orders.
7. State the review trigger, not just the values: parameters recalibrate when lead time shifts > 20%, demand CV changes class, or the supplier changes — put this in the output, because a calibration without a recalibration rule decays into today's problem.

## Output format
A **Buffer Calibration Sheet**: (1) segmentation matrix (ABC × XYZ counts, items routed off-formula and why); (2) lead-time reality table — quoted vs measured per supplier/item with gap flags; (3) per-item or per-segment parameter table — d̄, σ_d, L̄, σ_LT, z, service target, calibrated SS, calibrated ROP, current SS, delta, consequence in currency or stockouts/yr; (4) censored-demand and amplification adjustments applied; (5) recalibration triggers.

## Quality gate
PASS only if: no Z/intermittent item went through the normal formula; every SS shows measured σ_LT (or an explicit "single receipt history, σ_LT assumed 0" flag); the z per segment traces to a stated service decision; and the demand series was checked for stockout censoring with the check's result recorded. FAIL if any parameter uses quoted lead time where receipt history exists, or if the output contains calibrated values with no recalibration trigger.

## Integration
- **statistical-analysis**: all variance estimates run under its rules — report n periods, flag trend/seasonality that breaks the stationary-demand assumption before the formula is trusted.
- **evidence-reasoning**: "measured from receipt history" vs "quoted" is a mandatory provenance tag on every lead-time figure.
- **root-cause-first**: when the audit shows chronic planner overrides, treat overrides as evidence the parameters are wrong (or trust is broken) — investigate before recalibrating around them.
- Consumes **bullwhip-detector** output (true demand series) and **single-source-exposure-mapper** TTR targets (strategic risk stock is sized and labeled separately from cycle safety stock — never merge the two into one number).
- Feeds **process-reality-checker** when overrides are systemic: the override pattern is an as-performed process diverging from the documented planning process.

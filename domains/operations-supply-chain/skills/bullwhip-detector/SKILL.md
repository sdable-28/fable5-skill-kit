---
name: bullwhip-detector
description: Detect and quantify demand-signal amplification up a supply chain tier by tier. Trigger phrases — "our orders swing more than sales", "supplier says our POs are erratic", "inventory whiplash", "why is upstream volatility bigger than downstream demand", "bullwhip", "order batching problem". Do NOT use when the volatility source is genuinely exogenous demand (new product launch, promotion, seasonality already confirmed in end-customer data) — that is a forecasting problem, not amplification; use safety-stock-calibrator instead.
---

# Bullwhip Detector

## When invoked
1. Identify every tier in the chain for which order/shipment data exists: end-customer sales (POS) → retailer orders → distributor orders → factory orders → raw-material POs. Name each tier explicitly; if POS data is missing, state that the analysis floor is the lowest tier available and that amplification below it is unmeasurable.
2. Align all tiers to one common time bucket (weekly is default). Never compare a monthly PO series against daily sales — resample first and record the resampling rule.
3. Compute the amplification ratio per adjacent tier pair: `CV(orders_upstream) / CV(demand_downstream)` where CV = stddev/mean over the same window. Ratio > 1.0 means amplification exists at that link. Compute for the full window AND rolling 13-week windows to catch recent onset.
4. For every link with ratio > 1.2, attribute cause. Test each of the four classic drivers against the data, in order: (a) order batching — check PO size distribution for lumping at MOQ/pallet/container multiples; (b) forecast-updating — check whether order changes correlate with last-period demand delta (over-reaction coefficient); (c) price/promotion buying — check order spikes against price-change or deal dates; (d) shortage gaming — check for order inflation during allocation periods followed by cancellations.
5. State the cost of the amplification: excess safety stock carried upstream, expedite freight, and capacity swings. Estimate in currency, not adjectives.
6. Propose the counter-measure matched to the confirmed driver only (e.g., batching → smaller/more frequent replenishment; forecast-updating → share POS data downstream-up; gaming → allocate on history not orders). Do not prescribe "share more data" generically.

## Output format
A **Bullwhip Chain Report** containing: (1) tier map with data availability per tier; (2) amplification table — one row per adjacent link with CV pair, ratio, rolling trend; (3) driver attribution per flagged link with the specific evidence (distribution plot description, correlation value, event alignment); (4) cost estimate; (5) counter-measure per link, each traceable to its confirmed driver.

## Quality gate
PASS only if: every amplification ratio cites the exact series, window, and bucket used; every claimed driver has at least one quantitative evidence item (not narrative); and at least one alternative driver was tested and rejected per flagged link. FAIL if any ratio compares mismatched time buckets or if a counter-measure targets a driver that was never tested.

## Integration
- **statistical-analysis**: CV computation, rolling windows, and over-reaction regression run under its rules — report n, window, and stationarity caveats.
- **adversarial-disproof**: before declaring bullwhip, attempt to explain upstream volatility as real demand change; only if that fails is amplification confirmed.
- **root-cause-first**: driver attribution (step 4) is the RCA step — never jump from "ratio > 1" to remedy.
- Feeds **safety-stock-calibrator**: confirmed amplification changes the demand-variance input each tier should plan against (POS variance, not order variance).
- Feeds **single-source-exposure-mapper** when shortage gaming is the driver — gaming usually signals a constrained sole supplier.

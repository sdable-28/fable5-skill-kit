# Common Patterns — Operations & Supply Chain

## 1. Setting a Reorder Point and Safety Stock for a SKU
**Trigger:** Stockouts or excess inventory on a SKU; new SKU onboarding; supplier lead time changed.
**Approach:** 1. Pull 12+ months of demand history; compute mean and standard deviation of demand per lead-time period — not per month. 2. Measure actual lead time from PO date to receipt date across the last 10 orders; use its mean AND variance. 3. Set service level by ABC class (A: 98%+, B: 95%, C: 90%). 4. Safety stock = z × √(LT×σ_demand² + demand²×σ_LT²). Reorder point = mean demand × mean lead time + safety stock. 5. Sanity-check against physical constraints: MOQ, shelf life, warehouse space. 6. Set a review date — parameters decay.
**Template:** `SKU | ABC class | Demand μ/σ (per LT period) | Lead time μ/σ | Service level → z | Safety stock | ROP | MOQ conflict? Y/N | Next review date`
**Variation:** Using demand variance only and treating lead time as fixed. Lead-time variance usually dominates; ignoring it is the #1 cause of "we had safety stock and still stocked out."

## 2. Root-Causing a Recurring Quality Defect
**Trigger:** Same defect appears 3+ times; customer complaint repeats; scrap rate trend breaks upward on the control chart.
**Approach:** 1. Quantify first — defect rate, when it started, which lots/shifts/machines/suppliers. Stratify before theorizing. 2. Go to the actual process (gemba); watch the step where the defect is created, not where it is detected. 3. Run 5 Whys on the dominant stratum; stop only at a process or system cause, never at "operator error." 4. Fishbone across Man/Machine/Material/Method/Measurement/Environment for contributing factors. 5. Verify the cause: turn it on/off and watch the defect follow. 6. Implement a control (poka-yoke > SPC alarm > SOP change > training, in that order of strength). 7. Confirm with 30 days of post-fix data.
**Checklist:** `[ ] Defect quantified and stratified [ ] Gemba observation done [ ] Root cause verified by on/off test [ ] Countermeasure is error-proofing, not "retrain" [ ] Control chart shows sustained shift [ ] FMEA updated`
**Variation:** Accepting the first plausible cause without the on/off verification. If the fix is "retrained the operator," the RCA is not done.

## 3. Mapping a Process Before Automating or Fixing It
**Trigger:** Someone proposes automating a workflow; handoff delays; two teams describe the same process differently.
**Approach:** 1. Map the AS-IS by shadowing the people who do the work — never from the SOP; the doc describes how work should happen, not how it does. 2. Draw a swimlane per role; mark every handoff, queue, and rework loop. 3. Timestamp each step: process time vs. wait time. Compute process efficiency (PT/total lead time — expect single digits). 4. Tag each step with TIMWOOD waste type. 5. Eliminate and simplify steps BEFORE automating; automating waste hard-codes it. 6. Only then apply the automation decision: high volume + high stability + low judgment = automate; else standardize.
**Template per step:** `Step | Owner (lane) | PT | Wait | Waste type (TIMWOOD) | Keep/Eliminate/Simplify/Automate`
**Variation:** Mapping from the SOP or the manager's description. The exceptions and workarounds ARE the process; if the map has no rework loops, it is fiction.

## 4. Auditing Supplier Concentration Risk
**Trigger:** Annual sourcing review; a supplier misses deliveries, raises prices sharply, or shows financial distress; new geopolitical/regulatory exposure.
**Approach:** 1. Rank spend by supplier AND by component — a small-spend single-sourced part can stop the line. 2. Flag every single-sourced item; for each, record time-to-qualify an alternate and revenue-at-risk per week of outage. 3. Check hidden concentration: different suppliers sharing one sub-tier source, region, or port. 4. Score each critical supplier: financial health, quality trend, lead-time trend, geographic risk. 5. For the top exposures pick a mitigation: dual-source, buffer stock sized to re-qualification time, contractual capacity reservation, or approved-alternate pre-qualification. 6. Put owners and dates on each mitigation in the risk register.
**Checklist:** `[ ] Spend AND criticality ranked [ ] Single-source list with time-to-qualify [ ] Sub-tier/regional overlap checked [ ] Revenue-at-risk quantified [ ] Mitigation + owner + date per top-10 exposure`
**Variation:** Auditing only tier-1 by spend. The classic failure is five "diversified" tier-1 suppliers all buying the same tier-2 component from one plant.

## 5. Diagnosing Demand Signal Distortion (Bullwhip)
**Trigger:** Orders to suppliers swing far more than end-customer demand; alternating stockout/overstock cycles; forecast accuracy fine at POS but inventory still whipsaws.
**Approach:** 1. Plot end-customer demand vs. orders placed upstream at each tier on one chart; compute variance ratio per tier. Ratio > 1 climbing upstream = bullwhip. 2. Identify the amplifier: order batching (MOQ/full-truck), forecast-on-forecast (each tier forecasting the tier below's orders), price promotions causing forward buying, or shortage gaming. 3. Fix the information flow first: share POS/end-demand data upstream; forecast end demand once, not per tier. 4. Reduce batch sizes and order more frequently where freight economics allow. 5. Stabilize pricing; kill promotion-driven buy-ins. 6. Re-measure the variance ratio after one full replenishment cycle.
**Template:** `Tier | Demand CV | Order CV | Amplification ratio | Dominant cause (batching/forecast-stacking/promo/gaming) | Fix | Ratio after fix`
**Variation:** Treating the symptom by adding safety stock at every tier. That funds the whip instead of fixing it — inventory rises, swings continue.

## 6. Building the Monthly S&OP Reconciliation
**Trigger:** Monthly cycle; sales plan and supply plan diverge; new product launch or capacity change forces a re-plan.
**Approach:** 1. Lock last month's actuals: forecast accuracy (MAPE by family), plan attainment, inventory vs. target. 2. Run demand review: statistical baseline (exponential smoothing with seasonality) + sales overlays — record overlays separately so their accuracy can be judged later. 3. Run supply review against the demand plan: capacity check at bottleneck resources using demonstrated (not nameplate) rates, including variance — plan to ~85% of demonstrated capacity, not 100%. 4. Surface gaps in units AND dollars; prepare 2–3 close options (overtime, outsource, demand shaping, delay). 5. Executive meeting decides one plan; publish a single number set to sales, ops, and finance. 6. Log decisions and assumptions for next month's accuracy review.
**Checklist:** `[ ] MAPE by family reviewed [ ] Overlays separated from baseline [ ] Bottleneck loaded ≤85% of demonstrated rate [ ] Gaps dollarized with options [ ] One plan published to all functions [ ] Assumptions logged`
**Variation:** Planning capacity at nameplate rate with zero variance allowance. Average demand into average capacity guarantees a backlog — queues explode as utilization approaches 100%.

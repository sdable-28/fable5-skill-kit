# Operations & Supply Chain — Domain Pack

Internal operating instructions. Load before any task involving process design, supply chain, inventory, quality, logistics, S&OP, or project operations.

---

## 1. Domain Overview

### What makes this domain unique

Operations problems are **stochastic systems wearing deterministic masks**. Every input the requester gives — demand, lead time, cycle time, yield — arrives as a single number, and every one of those numbers is secretly a distribution. The core failure mode of AI in this domain is computing correct answers on point estimates and shipping recommendations that collapse the first week variance shows up. Treat every scalar input as a claim about a distribution until proven otherwise.

Second uniqueness: **feedback loops with delay**. Supply chains and production systems have control loops (order → lead time → receipt → inventory → order) where the delay between action and observed effect is weeks. This creates bullwhip, overcorrection, and phantom demand. Static analysis of any single node is almost always wrong; the system behavior lives in the loop.

Third: **documentation lies**. The SOP describes how work should happen. The ERP data describes what got recorded. Neither describes what operators actually do. Any analysis built solely on documents or system extracts inherits this gap.

### Where AI adds most value

- Quantitative policy design: EOQ, reorder points, safety stock, ABC/XYZ segmentation, control limits, Cpk, EVM math — done correctly with variance terms that practitioners routinely omit.
- Detecting internal contradictions in data the requester already has: forecast bias, bullwhip ratios, inventory that violates its own policy, capacity plans with no variance buffer.
- Structured decomposition: value stream maps, FMEA tables, risk registers, critical path networks — built fast and completely, with nothing skipped because it was tedious.
- Scenario arithmetic: "what happens to safety stock if lead time variance doubles" answered exactly, not by gut.

### Where AI must defer to humans

- **Ground truth about how work actually happens.** Never assert current-state process behavior from documents alone. Flag every process step not confirmed by observation or operator interview as UNVERIFIED.
- **Supplier relationships and negotiation posture.** Recommend dual-sourcing math; do not assert what a specific supplier will accept.
- **Safety, regulatory, and union constraints.** Flag them; do not design around them without human confirmation.
- **Physical feasibility.** A layout, a changeover time, a pallet count — anything that requires standing on the floor. Compute it, label it "requires floor validation," and say exactly what to measure.

---

## 2. Core Principles

Each principle is checkable. Violating one is a defect, not a style choice.

1. **No point estimate without its variance.** Every demand, lead time, cycle time, or yield figure used in a calculation must carry a standard deviation, range, or coefficient of variation — measured, or explicitly assumed with the assumption flagged. A safety stock computed from average lead time alone is wrong by construction.

2. **Service level is a decision input, never an output.** Ask for (or force the requester to choose) the target cycle service level or fill rate before computing any safety stock. Do not back into 95% because z=1.65 is familiar. Different ABC classes get different targets; state them.

3. **Segment before you optimize.** Run ABC (value) × XYZ (variability) classification before proposing any inventory, forecasting, or service policy. A single policy across all SKUs is a defect. Nine cells, up to nine policies.

4. **Forecast accuracy is measured against naïve, or it isn't measured.** Report every forecast's value-add versus the naïve (last-period or seasonal-naïve) forecast. A sophisticated model that loses to naïve gets deleted, not tuned. Report bias (signed error) separately from accuracy (MAPE/wMAPE) — a low-MAPE forecast with persistent +8% bias silently inflates the whole inventory position.

5. **As-is before to-be, and as-is means observed.** Do not design a future-state process until the current state is mapped from at least one of: direct observation, operator interviews, or event-log/timestamp data. A current-state map built from the SOP is a to-be map of an old project.

6. **Every buffer is one of three: inventory, capacity, or time.** When variability exists and no buffer is chosen, the system chooses time (queues, late orders) by default. Every plan must name which buffer absorbs which variability, explicitly.

7. **Utilization above ~85% is a queueing decision, not an efficiency win.** Kingman's formula: wait time explodes nonlinearly as utilization → 1. Any capacity plan loading a constrained resource above 85% must show the resulting queue-time impact or be rejected.

8. **The bottleneck governs; everything else is subordinate.** Identify the constraint before improving anything. An hour saved at a non-bottleneck is a mirage (Goldratt). Every throughput improvement proposal must name the current bottleneck and show the change moves it or exploits it.

9. **Root cause requires a mechanism and a disconfirming test.** 5 Whys stops when the answer names a process/system cause you can turn on and off, not a person. "Operator error" is never a terminal root cause. Every root cause claim must state what evidence would falsify it.

10. **Control before capability.** Never compute or quote Cpk on an out-of-control process. Check the control chart (stability) first; capability indices on unstable processes are meaningless numbers that get laminated anyway.

11. **One order-of-magnitude sanity check per quantitative result.** Every EOQ, safety stock, headcount, or savings figure gets an independent back-of-envelope cross-check (e.g., safety stock in days-of-supply, EOQ in weeks-of-demand). If the check surprises you, the model is wrong until proven otherwise.

12. **Single-source = named risk with a costed mitigation, always.** Any BOM item, lane, or process with one qualified source enters the risk register with time-to-recover, revenue-at-risk, and at least one costed mitigation option. "We trust this supplier" is not a mitigation.

13. **Bullwhip is measured, not asserted.** Before blaming demand volatility, compute Var(orders placed)/Var(demand received) at each tier. Ratio > 1 means the amplification is self-inflicted (batching, gaming, forecast-chasing) and the fix is internal.

14. **Cost savings are cash-flow-dated or they are fiction.** Every savings claim states when the cash arrives, what one-time costs precede it, and which budget line it appears in. "Soft savings" (freed capacity, avoided hires) are labeled as such and never summed with hard savings in a headline number.

15. **Change plans name the resisters.** Any process change proposal identifies who loses something (metrics, headcount, autonomy, overtime pay) under the new process. A change plan with no identified losers has not been thought through (ADKAR's Desire stage will fail on contact).

---

## 3. Master Framework — Operations & Supply Chain Adaptation

### Stage 1 — Understand
Establish the operational question behind the stated request. "Reduce inventory" usually means "reduce inventory without hurting service" — surface the implicit constraint and make the trade-off explicit (inventory ↔ service ↔ capacity is a triangle; ask which corner is fixed).

Domain tools: SIPOC (one page: Suppliers, Inputs, Process, Outputs, Customers) to bound the system; ask for the operating calendar (shifts, seasonality, promotions, fiscal cutoffs); demand the units of every number (units vs. cases vs. pallets vs. dollars kills more analyses than bad math).

Exit criterion: you can state the objective as a sentence with a metric, a constraint, and a horizon: "Reduce finished-goods inventory 20% within 2 quarters while holding fill rate ≥ 97%."

### Stage 2 — Decompose
Split by system structure, not by task type. Standard cuts:
- **By segment:** ABC × XYZ before any SKU-level work.
- **By echelon:** supplier → inbound → plant → DC → customer; identify which echelon owns the problem.
- **By variability source:** demand-side vs. supply-side vs. process-internal. Each gets a different buffer.
- **By flow vs. control:** the material flow map and the information/decision flow map are separate artifacts; bullwhip lives in the second.

Domain tools: value stream map skeleton, product-family matrix, demand decomposition (level/trend/seasonality/noise via classical decomposition).

### Stage 3 — Plan
Sequence work so measurement precedes modeling and modeling precedes recommendation. Default sequence: (1) data audit — completeness, units, outliers, promo pollution; (2) current-state quantification; (3) segmentation; (4) policy/model design per segment; (5) sensitivity analysis; (6) implementation plan with pilot scope.

Always plan a **pilot segment** — one product family, one lane, one line — before fleet-wide rollout. Define the pilot's success metric and read-out date in the plan.

Domain tools: critical path for the implementation itself; risk register seeded at plan time (top 3 risks minimum: data quality, stakeholder resistance, variance underestimate).

### Stage 4 — Execute
Compute with variance terms intact. Standard formulas to use correctly:
- EOQ = √(2DS/H); annualize D, confirm H includes capital + storage + obsolescence (state the holding-rate assumption, typically 18–30%/yr).
- Reorder point = d̄·LT + SS.
- Safety stock (both variances): SS = z·√(L̄·σ_d² + d̄²·σ_L²). Omitting σ_L is the most common domain error — call it out whenever source material omits it.
- Kingman: Wq ≈ (ρ/(1−ρ))·((Ca²+Cs²)/2)·τ for capacity/queue claims.
- Cpk = min((USL−µ)/3σ, (µ−LSL)/3σ) — only after stability confirmed.
- EVM: CPI = EV/AC, SPI = EV/PV, EAC = BAC/CPI (state which EAC formula and why).
- Bullwhip ratio per tier: Var(orders)/Var(demand), same time bucket.

Build artifacts in the domain's native formats: swimlane/BPMN maps, control charts, FMEA tables (Severity × Occurrence × Detection, RPN ranked), risk registers with probability × impact × time-to-recover.

### Stage 5 — Verify
Run the domain verification gates (see `verification_gates.md`). Minimum set on every quantitative deliverable:
- Units audit end-to-end.
- Days-of-supply / weeks-of-demand sanity translation of every inventory figure.
- Backtest any forecast or policy against held-out history — never score on the fitting window.
- Boundary check: what does the recommendation do in the worst observed historical month?

### Stage 6 — Self-Correct
When a result fails verification, diagnose in this order: (1) units/joins/data, (2) omitted variance term, (3) wrong segmentation (policy applied to wrong cell), (4) model choice. Data and units cause ~70% of operations analysis errors; do not reach for a fancier model until the data layer is exonerated.

When a recommendation is falsified by pilot results, log the falsification explicitly with the evidence, and do not resurrect the approach without new data.

### Stage 7 — Iterate
Operations deliverables are control systems, not one-shot answers. Every recommendation ships with its own monitoring plan: which metric, what control limits, review cadence, and the predefined trigger that reopens the analysis (e.g., "recompute safety stocks when trailing-13-week σ_d shifts by >25% for any A item"). A policy without a recalculation trigger is stale on arrival.

---

## 4. Pitfalls Checklist

1. **Safety stock from demand variance only.**
   Looks like: SS = z·σ_d·√LT, no lead-time variance term, on a SKU whose supplier lead time swings 14–35 days.
   Detection: formula has one σ; lead time appears only as a mean.
   Prevention: always use SS = z·√(L̄σ_d² + d̄²σ_L²); if σ_L unavailable, state the assumption and quantify sensitivity to it.

2. **Cpk on an unstable process.**
   Looks like: "Cpk = 1.41, process capable" quoted from a month where the X̄ chart shows three out-of-control points and a shift.
   Detection: capability quoted with no accompanying control chart, or subgroup logic undefined.
   Prevention: gate — no capability index without a stability verdict from the same data window.

3. **Forecast scored on the fit window.**
   Looks like: "MAPE 8%" from the same 24 months the seasonal indices were fit on; live performance is 22%.
   Detection: no explicit holdout split mentioned; accuracy suspiciously good for the demand pattern's CV.
   Prevention: mandatory holdout backtest + naïve baseline comparison (Principle 4).

4. **Bullwhip blamed on the customer.**
   Looks like: "our demand is just volatile" — but POS/end-customer demand CV is 0.2 while the orders the plant sees have CV 0.9. The volatility is manufactured by monthly order batching and quarter-end incentives.
   Detection: compute variance ratio tier by tier; check order timing against fiscal calendar.
   Prevention: measure the ratio before accepting any "volatile demand" premise; look for batching, price promotions, shortage gaming, and MOQ effects first.

5. **SOP-as-reality process map.**
   Looks like: a beautiful BPMN diagram of the receiving process; on the floor, receivers batch-scan at end of shift, so every timestamp downstream analysis used is fiction.
   Detection: process map has zero rework loops and zero exceptions — real processes always have both. Timestamps clustered at shift boundaries.
   Prevention: require one observed walkthrough or event-log validation per mapped process; hunt for the rework loop — if you can't find one, you haven't found the real process.

6. **Averaged capacity planning.**
   Looks like: "line rate 120/hr × 16 hr = 1,920/day, demand 1,800/day, we're fine" — ignoring 12% unplanned downtime, changeovers, and demand peaks 40% above mean.
   Detection: capacity plan contains no OEE figure and no demand percentile, only means.
   Prevention: plan to effective capacity (rate × OEE) against a demand percentile (P90+ for critical service), and apply Principle 7 on utilization.

7. **EOQ with a fabricated holding cost.**
   Looks like: H = 25% used silently; the product is cold-chain with 3-month shelf life where true holding cost (spoilage + energy) is 60%+, so the "optimal" order quantity generates writeoffs.
   Detection: holding rate not itemized (capital + storage + insurance + obsolescence/shrink).
   Prevention: itemize H per segment; for short-shelf-life or high-obsolescence items, cap order quantity at shelf-life-safe days of supply regardless of EOQ.

8. **Dual-source on paper, single-source in fact.**
   Looks like: two qualified suppliers for a resin — both buy the same precursor from one upstream plant; or supplier #2 is "qualified" but hasn't shipped in 3 years and has no live tooling.
   Detection: ask for tier-2 mapping on A items; check last-shipment date and tooling status for backup sources.
   Prevention: concentration risk assessed at the deepest known tier; a backup source without recent shipments and live tooling counts as zero.

9. **Improving a non-bottleneck.**
   Looks like: kaizen event cuts assembly cycle time 20%; throughput unchanged because the paint booth was and remains the constraint; WIP in front of paint grows.
   Detection: improvement proposal doesn't name the system constraint; celebrated metric is local (station cycle time) not global (throughput, flow time).
   Prevention: constraint identification is a mandatory precondition (Principle 8); measure improvements in system throughput or end-to-end lead time only.

10. **Service level conflation (cycle service level vs. fill rate).**
    Looks like: policy designed to 95% CSL, contract requires 98% fill rate; these are different quantities and the gap surfaces as penalty invoices.
    Detection: "service level" used without specifying which; z-values applied to fill-rate targets.
    Prevention: define the metric contractually in force (CSL = P(no stockout per cycle); fill rate = fraction of demand served); convert properly (fill rate needs the loss function E[z], not just z).

11. **Phantom savings from freed capacity.**
    Looks like: "automation saves 3.2 FTE = $240k/yr" but the 3.2 FTE are 0.4 of a person across 8 people; nobody is redeployed; cash savings = $0.
    Detection: savings denominated in fractional heads or in hours nobody removes from a budget.
    Prevention: Principle 14 — hard vs. soft split; hard savings must map to a specific budget line and date.

12. **S&OP that reconciles units nowhere.**
    Looks like: sales plan in revenue dollars, supply plan in units, finance plan in margin — the "consensus" meeting compares incommensurable numbers and everyone leaves agreeing to different things.
    Detection: no single volume table (units by family by month) signed by all three functions.
    Prevention: force one plan, one unit of measure, one horizon; dollars derived from units, never parallel.

13. **Reorder point built on receipt-date lead time.**
    Looks like: lead time measured from PO date to warehouse receipt in the ERP — but receiving posts in batches on Fridays, so measured LT is systematically wrong by 0–4 days and σ_L is inflated garbage.
    Detection: lead-time histogram shows weekly spikes; compare ASN/dock date vs. system receipt date.
    Prevention: audit the timestamp semantics of every date field before computing lead-time statistics (see pitfall 5 — same disease).

14. **Risk register as wallpaper.**
    Looks like: 40 risks, all "medium/medium," no owners, no triggers, reviewed never; the single-source risk that materializes was on the list, unowned, since 2024.
    Detection: register has no time-to-recover column, no dated review, uniform scores.
    Prevention: cap at ~10 living risks per project, each with owner, quantified exposure (revenue-at-risk × probability), trigger condition, and a dated mitigation action.

15. **Pilot success from a hand-picked segment.**
    Looks like: new replenishment policy piloted on the 20 smoothest X-class SKUs; 40% inventory reduction announced; fleet rollout hits Y/Z SKUs and stockouts spike.
    Detection: pilot segment selection criteria undocumented, or pilot cell is the easiest ABC×XYZ cell.
    Prevention: pilot must include at least one hard cell (A-item, high-variability); report pilot results per cell, never pooled.

---

## 5. Sample Task Walkthrough

**Task:** A distributor of industrial fasteners (≈4,200 SKUs, one DC) reports fill rate slipping from 97% to 91% over two quarters while inventory dollars grew 22%. Request: "fix our inventory."

**Understand.** The symptom pair — service down AND inventory up — is diagnostic gold: it almost always means inventory is in the wrong SKUs, not the wrong total. State this hypothesis explicitly, then extract the constraint triangle: target fill rate (contractual: 97% on A accounts), inventory budget (CFO wants flat dollars), horizon (one quarter to visible improvement). Confirm the service metric is **fill rate** (line fill), not cycle service level — it is, per the customer contracts. Flag one assumption immediately: "I am assuming no supplier disruption drove this; verify before proceeding."

**Decompose.** Pull 24 months of demand history, current on-hand, open POs, item costs, and supplier lead times. Run the data audit first: 137 SKUs have negative on-hand (cycle-count debt — exclude and flag); demand history includes two promo months on 300 SKUs (mark and de-pollute); lead-time field turns out to be the *quoted* lead time from the item master, not measured — this is a finding in itself. Compute measured lead times from PO-to-receipt history: mean quoted 21 days, mean actual 29 days, σ_L = 9 days. Segment ABC (annual dollar usage) × XYZ (CV of monthly demand): A items = 8% of SKUs, 71% of dollars.

**Diagnose before designing.** Cross-tab inventory position against segment. Result: AX/AY items (high value, steady) are running at 1.8 weeks of supply — chronically short because the reorder points were built on the fictional 21-day lead time with no σ_L term. Meanwhile CZ items (cheap, erratic) hold 31 weeks of supply — a legacy "round up to full carton" MOQ policy plus a buyer habit of doubling orders after any stockout (bullwhip in miniature; order CV is 2.3× demand CV on C items). The 22% inventory growth is almost entirely CZ overbuying triggered by the A-item stockout panic. Root cause chain (5 Whys, terminating at process): fill rate fell → A-item ROPs too low → lead-time parameter never updated → no process exists to recompute parameters from actuals → planning system treats item-master lead time as static truth. Falsifiable: if recomputed ROPs on actual lead times don't cover observed stockout events retrospectively, the diagnosis is wrong.

**Execute.** Design per-cell policies. A items: fill-rate-driven safety stock using the loss-function method (not plain z), with SS = solves E[units short]/cycle demand ≤ 3% given σ_d and measured σ_L = 9 days; recompute ROP = d̄·29 + SS. B items: standard 95% CSL. C items: cap at 8 weeks supply, order to min/max, kill the double-order habit by policy. Compute the projected position: A-item inventory rises ~$410k; C-item inventory releases ~$1.1M over two order cycles as excess burns off; net −$690k (−9%) at 97%+ modeled fill rate.

**Verify.** Four checks, all mandatory. (1) Units audit: demand in eaches, some POs in cartons of 50 — caught one join that would have inflated C-item demand 50×. (2) Backtest: replay the last 12 months against the new ROPs using actual receipts; modeled fill rate 97.4%, and every historical A-item stockout event is covered except two caused by a supplier shutdown (correctly out of scope — matches the flagged assumption). (3) Sanity translation: A-item safety stocks land at 2.5–4 weeks of supply — plausible for 29±9-day lead times; had any landed at 20 weeks, suspect a σ unit error (monthly vs. weekly σ mixed is the classic — verify σ time-bucket explicitly). (4) Worst-month boundary check: apply policies to the worst demand month in history; A fill holds at 95.8% — report this honestly rather than quoting only the average.

**What could go wrong and how it's caught.** If σ_d was computed on promo-polluted history, safety stocks are inflated ~15% — caught by the de-pollution step and by comparing σ with/without flagged months. If receiving batch-posts (pitfall 13), measured σ_L = 9 is inflated — check the receipt-date histogram for weekday spikes before trusting it (it showed mild Friday clustering; re-derived from dock dates, σ_L = 7.5, safety stock revised down). If the buyers keep double-ordering, the C-item release never materializes — so the deliverable includes a monitoring plan: weekly order-CV/demand-CV ratio by buyer, trigger at ratio > 1.5.

**Iterate.** Ship with a recalculation trigger: parameters recomputed quarterly from trailing actuals, automatically — fixing the root cause (static parameters), not just this quarter's numbers. Pilot on two supplier groups including one long-lead-time A supplier (hard cell, per pitfall 15) with a 6-week read-out before fleet rollout.

---

## 6. Integration with Core Skills

**Most critical core skills for this domain, in priority order:**

- **statistical-analysis** — load for any forecast, safety stock, control chart, or capability work. Domain variation: default to nonparametric checks first (operations data is rarely normal — lead times are right-skewed, demand is lumpy/intermittent); test the normality assumption behind every z-value used; for intermittent demand (many zero periods), flag that Croston-class methods and period-based CSL math both degrade, and say so.
- **assumption-flagging** — every point estimate treated as a distribution claim (Principle 1) is an assumption to flag. Domain variation: maintain a dedicated "parameter provenance" table in every deliverable — each number: measured / quoted / assumed, with source and date.
- **root-cause-first** — pairs with 5 Whys/fishbone/FMEA. Domain variation: terminal causes must be process-systemic (Principle 9); "operator error," "bad luck," and "volatile market" are banned terminals.
- **adversarial-disproof** — before shipping any policy, attack it with the worst historical month, a lead-time doubling, and a demand-mix shift. If the requester's own data can falsify the recommendation, find that before they do.
- **evidence-reasoning + coverage-accounting** — the data-audit stage is coverage accounting over SKUs/lanes/steps: state explicitly what fraction of volume/value the analysis covers and what was excluded (negative on-hand, new items with <6 months history, discontinued items).
- **plan-gate + scope-fence** — operations requests scope-creep aggressively ("while you're in the inventory data, can you also look at freight?"). Fence at the constraint triangle agreed in Understand; new corners = new engagement.
- **verified-done** — "done" = the domain verification gates pass AND the monitoring plan with recalculation trigger exists. A recommendation without its control loop is not done (Framework Stage 7).
- **uncertainty-handling** — service levels, percentile-based capacity, sensitivity tables. Domain variation: always show the recommendation's sensitivity to the least-trusted parameter (usually σ_L or holding rate) as a small table, not prose.
- **mathematical-reasoning** — EOQ/ROP/EVM/Kingman derivations; run the independent order-of-magnitude cross-check (Principle 11) as a separate computation path, not a re-read of the same spreadsheet cell.
- **system-design / enterprise-architect** — for S&OP process design and planning-system parameter flows; the "static item-master lead time" class of root cause is an architecture finding.
- **long-task-orchestration + context-budget-management** — SKU-level work at 4,000+ items: segment first, then process cell-by-cell; never attempt to hold a full SKU file in working context — compute aggregates per cell and carry only the cell summaries forward.
- **document-mastery** — SOPs, supplier contracts, Incoterms clauses: extract the operative constraint (who owns risk at which point, per Incoterm; penalty formula per fill-rate contract) verbatim, never paraphrased from memory.

**Combination pattern for the typical engagement:** cartography-first (map the flow) → coverage-accounting (data audit) → statistical-analysis (quantify) → root-cause-first (diagnose) → mathematical-reasoning (design) → adversarial-disproof (stress) → verified-done (gates + monitoring plan).

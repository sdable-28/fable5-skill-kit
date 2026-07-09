---
name: single-source-exposure-mapper
description: Map supplier concentration risk across a bill of materials or service portfolio — find every item where one supplier, one site, or one shared upstream node is a single point of failure, and size the exposure in revenue-at-risk and time-to-recover. Trigger phrases — "what happens if supplier X goes down", "single source", "sole source", "supplier risk assessment", "dual-sourcing strategy", "our supplier had a fire/strike/bankruptcy", "de-risk the supply base". Do NOT use for supplier performance scoring (OTD, quality PPM, cost benchmarking) — that is routine supplier management; this skill exists solely for failure-mode concentration, not for grading suppliers who are performing.
---

# Single-Source Exposure Mapper

## When invoked
1. Pull the item-supplier assignment from the BOM/AVL/spend data. Classify each item: SOLE-SOURCED (only one qualified supplier exists), SINGLE-SOURCED (alternatives qualified but 100% of volume flows to one), or MULTI-SOURCED. Do not conflate the first two — sole-sourced needs qualification lead time before any volume can move; single-sourced only needs a PO.
2. Pierce the paper diversity. Two "different" suppliers sharing a parent company, one fab, one sub-tier ingredient, or one geographic cluster (same earthquake zone, same port, same power grid) are one failure domain. Trace at least one tier upstream for every A-class item and record the shared-node findings. Multi-sourced items collapsing to one sub-tier node get reclassified as effectively single-sourced.
3. Score exposure per single/sole-sourced item on two axes, quantified:
   - **Impact**: revenue or production value blocked per week of supply loss = (units/week using the item) × (contribution of blocked finished goods). An item worth $0.04 that stops a $900 assembly scores at the assembly's value.
   - **Time-to-recover (TTR)**: weeks to restore supply via best alternative = qualification time (sole) or ramp time (single) + supplier lead time − weeks of buffer inventory on hand and in transit.
4. Compute exposure = Impact × TTR. Rank descending. Buffer inventory is a TTR reducer, not a risk eliminator — never mark an item "covered" because stock exists; state the weeks it buys.
5. For the top exposures, evaluate mitigations against cost honestly: dual-source qualification cost and timeline, buffer stock carrying cost, redesign-out feasibility, or contractual protections (capacity reservation, second-site clause). Recommend per item; "monitor" is an acceptable recommendation only below a stated exposure threshold, and the threshold must be written down.
6. Check the aggregation trap: sum exposure by supplier and by shared upstream node, not only by item. Ten small single-sourced items at one supplier can exceed the top single-item exposure.

## Output format
A **Concentration Exposure Register**: (1) classification counts (sole/single/multi, before and after sub-tier reclassification); (2) shared-node findings from the tier-up trace; (3) ranked exposure table — item, supplier, classification, impact/week, TTR weeks, buffer weeks, exposure value; (4) supplier-level and node-level aggregation table; (5) mitigation recommendation per top item with cost and timeline; (6) the stated monitor threshold.

## Quality gate
PASS only if: every A-class item has a tier-up trace recorded (even if it found nothing); no item is classified from spend data alone without checking qualified-alternative status; every TTR shows its arithmetic (qual/ramp + lead time − buffer); and the aggregation tables exist. FAIL if any item marked "covered" cites inventory without a weeks-of-supply number, or if sole and single-sourced items are pooled in one class.

## Integration
- **adversarial-disproof**: run it against claimed diversity — actively try to prove two suppliers share a failure domain before accepting "dual-sourced."
- **statistical-analysis**: lead-time and demand variance feed TTR ranges; report TTR as a range when variance is material.
- **evidence-reasoning**: qualification status claims require the AVL record, not the buyer's memory.
- Consumes **safety-stock-calibrator** output for buffer-weeks figures; feeds it the TTR targets that size strategic (risk) stock as distinct from cycle safety stock.
- Consumes **bullwhip-detector** findings: shortage-gaming signals often reveal an already-constrained sole source before any disruption event.

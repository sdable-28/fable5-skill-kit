---
name: market-sizing-builder
description: >
  Build a defensible TAM/SAM/SOM with explicit methodology (bottom-up first), every number
  sourced or labeled as assumption, and a sensitivity check on the shakiest input. Trigger
  phrases: "size this market", "TAM SAM SOM", "how big is the opportunity", "market size
  slide for the deck", "is this market big enough". Do NOT use for internal feature-reach
  estimates (that is the Reach input of hypothesis-prioritizer), for financial forecasting /
  revenue modeling of an existing product line, or when the user just needs a citation for
  an analyst-published figure without derivation.
---

# market-sizing-builder

## When invoked
1. Fix the unit of value first: who pays, for what job, at what price point/model. A market size without a defined paying unit is a headline number, not a size. Refuse to proceed until the unit is stated.
2. Build bottom-up as the primary method: (number of entities with the job) × (adoption/penetration assumption) × (annual price). Every factor gets one of three tags: SOURCED (with citation), DERIVED (show the arithmetic), or ASSUMED (with your stated basis). No untagged numbers anywhere.
3. Build top-down only as a cross-check: analyst figure → filter to segment. If bottom-up and top-down disagree by >3x, do not average them — find which factor drives the gap and say which method you trust and why.
4. Derive SAM by applying named constraints to TAM (geography, segment, channel, regulatory, product scope) — each constraint one line with its multiplier. Derive SOM from capacity, not ambition: sales/GTM reach, competitive share precedent for a new entrant in this category, time horizon. "1% of TAM" as SOM logic is banned — if you catch yourself writing it, replace with a capacity-based derivation.
5. Run sensitivity on the single weakest ASSUMED factor: recompute SOM at half and double that assumption. If the go/no-go conclusion flips within that range, report the sizing as "decision-fragile" and name what research would firm up the input.
6. Date-stamp every figure and flag any source older than 24 months.

## Output format
Three labeled blocks — **TAM**, **SAM**, **SOM** — each showing the formula, a factor table (`Factor | Value | Tag | Source/Basis`), and the result. Then a **Cross-check** block (top-down figure, gap vs bottom-up, reconciliation verdict) and a **Sensitivity** block (weakest factor, half/double SOM range, decision-fragile: yes/no).

## Quality gate
PASS only if: every factor in every formula carries a SOURCED/DERIVED/ASSUMED tag, SOM derivation references capacity constraints (not a naive TAM percentage), and the sensitivity block exists with the half/double range computed. FAIL if any block presents a single point estimate with no factor table — that is the "made-up numbers on a slide" failure mode this skill exists to eliminate.

## Integration
Take segment definitions (who has the job) from `discovery-interview-auditor` validated insights rather than inventing personas. SAM/SOM figures feed `hypothesis-prioritizer` Reach with a SOURCED tag. Use core `evidence-reasoning` for the tagging discipline and core `statistical-analysis` for the sensitivity computation. If the sizing is decision-fragile, route the firming-up research through core `plan-gate` before anyone builds a pitch on the number.

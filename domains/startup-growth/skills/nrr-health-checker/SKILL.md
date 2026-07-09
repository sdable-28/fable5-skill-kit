---
name: nrr-health-checker
description: >
  Decompose net revenue retention to catch "shrinking in slow motion" — the failure where NRR sits
  below 100% unnoticed while acquisition headlines look healthy. Trigger phrases: "NRR", "NDR",
  "net retention", "churn is fine", "expansion revenue", "are we growing efficiently", "logo churn vs
  revenue churn", "why is growth slowing despite new logos". Also invoke whenever a growth review
  presents new-ARR numbers without a retention decomposition beside them. Do NOT use pre-PMF or below
  roughly 20 paying customers — cohort math on tiny bases is noise; use pmf-signal-reader's retention-curve
  read instead. Do NOT use for user-level (non-revenue) retention analysis.
---

# NRR Health Checker

## When invoked
1. Compute NRR from raw movements, never accept a quoted figure: for a cohort of customers existing 12 months ago, NRR = (start ARR − churn − contraction + expansion) / start ARR. Also compute GRR (same, without expansion). Demand the four movement components separately; a single blended number hides everything that matters.
2. Run the slow-motion-shrink test immediately: if NRR < 100%, compute the half-life — at current NRR, existing revenue halves in `ln(0.5)/ln(NRR)` years. State it as a sentence ("your installed base halves every 3.1 years; new sales are refilling a draining tank"). This framing is mandatory whenever NRR < 100%.
3. Decompose by cohort and segment: NRR by signup quarter (are newer cohorts retaining better or worse — is the product improving or is early NRR propped up by legacy loyalists?), by ICP segment, and by acquisition channel. Hunt the cheap-CAC trap: a channel with low CAC but sub-90% NRR is buying revenue that evaporates — mark that channel's true payback as "never" if lifetime revenue < CAC.
4. Separate the three levers and rank by dollar impact: churn (logos leaving), contraction (seats/usage down), expansion (upsell/seats up). A 105% NRR built as 130% expansion masking 25% gross churn is a different, sicker company than 105% with 3% churn — say which one this is.
5. Benchmark against stage, not a universal number: Series A SMB ~90-100% NRR can be survivable; Series B+ enterprise pitching efficiency needs NDR >120% and GRR >90%. Cite the stage from stage-playbook-enforcer's classification if available.
6. Trace root cause for the weakest lever: churn concentrated in one segment → ICP problem (route to growth-model-selector inputs); contraction across the board → value-delivery or pricing-metric problem; no expansion machinery → product has no natural expansion vector (seats, usage, modules) — name which.
7. Flag the acquisition-obsession pattern explicitly if found: new-ARR growing while GRR declines quarter-over-quarter is the collapse-in-progress signature; escalate it to the top of the report regardless of what was asked.

## Output format
Produce an **NRR Decomposition Sheet**:
- `headline`: NRR %, GRR %, and the half-life sentence if NRR < 100%
- `movements` table: churn / contraction / expansion in $ and % of start ARR
- `cohort-trend`: NRR by signup quarter (min 3 cohorts), direction verdict IMPROVING / FLAT / DEGRADING
- `segment-cuts`: worst and best segment/channel with their NRR; cheap-CAC-trap channels flagged
- `sick-lever`: the one lever costing the most dollars, with root-cause hypothesis
- `stage-benchmark`: PASS / WATCH / FAIL against the stage-appropriate bar
- `one-move`: the single highest-leverage intervention, stated as an action not a theme

## Quality gate
PASS only if: (a) NRR was recomputed from the four raw movements, not transcribed; (b) GRR appears next to NRR everywhere NRR appears; (c) at least one cohort cut and one segment cut are present; (d) if NRR < 100%, the half-life sentence exists. FAIL if the sheet reports a blended NRR only, or praises NRR >100% without showing the churn it masks.

## Integration
- **statistical-analysis**: apply small-sample caveats to segment cuts; a segment of 6 logos gets a confidence warning, not a verdict.
- **root-cause-first**: the sick-lever hypothesis must be causal, not descriptive — "churn is high" is a restatement, "churn concentrates in sub-50-seat logos closed via paid social" is a cause.
- **adversarial-disproof**: before reporting IMPROVING cohort trend, test whether it is survivorship (newest cohorts haven't had time to churn) — age-match cohorts before comparing.
- **stage-playbook-enforcer**: supplies the stage classification that sets the benchmark bar.
- **growth-loop-mapper**: expansion revenue found here feeds loop identification — self-serve expansion is itself a loop candidate.

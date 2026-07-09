---
name: hypothesis-prioritizer
description: >
  Force-rank a backlog of product hypotheses/features using evidence-weighted RICE with
  confidence caps tied to validation state. Trigger phrases: "prioritize the backlog",
  "what should we build next", "RICE these", "rank these ideas", "which bet first",
  "stack-rank the roadmap candidates". Do NOT use when the items are engineering tasks
  within an already-committed feature (that is sprint planning, not bet selection), when
  there is only one candidate (nothing to rank), or when the user wants pure effort
  estimation without impact comparison.
---

# hypothesis-prioritizer

## When invoked
1. Restate every item as a falsifiable hypothesis: "We believe [change] for [segment] will move [metric] by [amount] because [evidence]." Any item that cannot be restated this way is a feature request, not a hypothesis — flag it and demand the missing metric before scoring.
2. Score RICE per item. Reach: named segment size with source. Impact: expected metric delta, 0.25/0.5/1/2/3 scale. Effort: person-weeks from whoever owns delivery, not your guess — mark "UNESTIMATED" if none exists.
3. Cap Confidence by validation state — this is non-negotiable: opinion/HiPPO only = 0.1 max; analogous competitor evidence = 0.3 max; own qualitative (5+ interviews) = 0.5 max; own quantitative (funnel data, painted-door, past experiment) = 0.8 max; direct A/B result = 1.0. Never let a stakeholder's seniority raise a Confidence score.
4. Compute RICE = (Reach × Impact × Confidence) / Effort. Rank descending.
5. For the top 3, run adversarial-disproof: state the cheapest test that could kill each hypothesis before build (fake door, concierge, survey, data pull). If a kill-test costs <10% of build effort, the recommendation is "run the test," not "build."
6. Flag ties and near-ties (<15% score difference) explicitly — declare them judgment calls, not math.

## Output format
A markdown table: `Hypothesis | Reach (source) | Impact | Confidence (validation state) | Effort (owner) | RICE | Cheapest kill-test`. Below it: a 3-line "Build vs Test First" verdict per top-3 item, and a list of items rejected from scoring with the reason (no metric, no falsifiable claim).

## Quality gate
PASS only if: every Confidence score cites its validation state from the cap ladder, every Reach cites a source, and at least one top-3 item has a named kill-test cheaper than building. FAIL if any score row contains an uncited number or if all items scored ≥0.5 Confidence (that pattern means confidence inflation, not a validated backlog).

## Integration
Feed rejected/unfalsifiable items to `stakeholder-no-framer` for the decline conversation. Pull metric definitions from `north-star-aligner` so Impact deltas target input metrics, not vanity metrics. Use core `evidence-reasoning` for the Confidence cap ladder and core `adversarial-disproof` for kill-test design. Run core `plan-gate` before committing the winner to a roadmap slot.

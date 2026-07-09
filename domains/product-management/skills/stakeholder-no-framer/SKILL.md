---
name: stakeholder-no-framer
description: >
  Construct a defensible "no" (or "not now") to a stakeholder feature request that preserves
  the relationship — trade-off made explicit, re-entry condition named. Trigger phrases:
  "how do I say no to", "the VP wants X but", "decline this request", "push back on sales",
  "HiPPO wants", "executive asked for a pet feature", "customer demands X or churns".
  Do NOT use when the request should actually be accepted (run hypothesis-prioritizer first
  if unsure), for generic difficult-conversation coaching unrelated to roadmap trade-offs,
  or for saying no to internal engineering scope creep (that is sprint/PRD scoping).
---

# stakeholder-no-framer

## When invoked
1. Steelman the request first. Write the strongest honest case for it in 2-3 sentences, including what the stakeholder sees that the roadmap owner might not (deal at risk, competitive gap, exec context). Never open a "no" without this — a "no" that misstates the ask destroys trust.
2. Identify the request's real job: is it the stated feature, or an underlying outcome (close the deal, hit the quota, look responsive)? Name both. Often the outcome is servable without the feature.
3. Make the displacement explicit. A "no" is only defensible as a trade: name exactly which committed item(s) would slip, by how much, and which metric that delays. If nothing would slip, the "no" is unjustified — say so and stop.
4. Score the request through the same rubric as everything else (invoke `hypothesis-prioritizer` scoring if not already done). The "no" must cite the score gap, not taste: "It scored X against the current top item's Y because [Confidence/Reach evidence]."
5. Define the re-entry condition — the specific, checkable evidence that would flip the decision: "If 3 more enterprise accounts cite this in churn interviews" / "if the painted-door test converts >5%". A "no" without a re-entry condition reads as a brush-off.
6. Offer the cheapest partial: a test, a workaround, a services-side fix, or a Now/Next/Later slot with the condition attached. Only offer what will actually be honored — a fake "Later" is roadmap theater.

## Output format
A "Decision brief" with five labeled sections: **Steelman** (their strongest case), **Underlying job**, **Trade-off** (what slips, metric cost), **Decision + evidence** (score comparison), **Re-entry condition + offered alternative**. Followed by a ready-to-send message draft (email/Slack register, ≤150 words) that leads with the steelman, states the no in one sentence, and closes with the re-entry condition.

## Quality gate
PASS only if the draft: contains zero hedging non-decisions ("we'll try to fit it in"), names a concrete re-entry condition with a checkable threshold, and states what the "yes" would have displaced. FAIL if the "no" rests on authority ("leadership decided") or process ("not on the roadmap") instead of the trade-off — those are the exact HiPPO dynamics this skill exists to prevent, inverted.

## Integration
Requires `hypothesis-prioritizer` output as the evidence base — never frame a "no" from an unscored backlog. Pull the displaced item's metric impact from `north-star-aligner`'s tree to quantify the trade-off. The re-entry condition is a hypothesis: register it via core `evidence-reasoning` so it gets checked, not forgotten. Use core `adversarial-disproof` on your own "no" before sending — if the stakeholder's steelman survives it, reverse the decision.

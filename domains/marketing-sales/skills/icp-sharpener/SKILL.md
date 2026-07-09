---
name: icp-sharpener
description: >
  Rebuild an Ideal Customer Profile from closed-won/closed-lost evidence instead of founder
  aspiration. Trigger phrases: "who is our ICP", "tighten our targeting", "our leads are junk",
  "refine the persona", "which segment should we go after", "ABM tier list". Also invoke before
  any new outbound sequence, paid audience build, or positioning rewrite — a stale ICP poisons
  all three. Do NOT use when the ask is generic customer research with no sales history to mine,
  when fewer than 15 closed deals exist (run a hypothesis ICP and label it as such instead), or
  when the user only wants copy edits to an existing persona doc.
---

# When invoked

1. Demand the raw evidence first: CRM export of closed-won AND closed-lost deals (last 12 months minimum), with firmographics, deal size, sales-cycle length, source channel, and churn/expansion status. Refuse to write an ICP from interviews or founder opinion alone — state that you are refusing and why.
2. Segment closed-won by revenue retained at 12 months, not by initial deal size. A segment that closes big and churns fast is an anti-ICP; flag it explicitly.
3. For each candidate segment compute: win rate vs. rest-of-pipeline, median sales cycle, ACV, gross churn, and CAC by source channel if attributable. Rank by LTV:CAC proxy, not by count of logos.
4. Extract the disqualifiers from closed-lost: which attributes appear in losses at ≥2x the rate they appear in wins. Disqualifiers are half the ICP's value — never ship an ICP without them.
5. Write the ICP as testable predicates (firmographic thresholds, trigger events, tech-stack signals, JTBD statement), not adjectives. "Mid-market" fails; "80–400 employees, ≥2 RevOps hires in trailing 6 months" passes.
6. State the confidence tier per predicate: EVIDENCED (from step 3 data), INFERRED (pattern with n<10), HYPOTHESIS (no data). Mark every HYPOTHESIS with the experiment that would confirm it.

# Output format

A single **ICP Card** containing: (a) qualifying predicates table with confidence tier and supporting n per row; (b) disqualifier list with loss-rate evidence; (c) anti-ICP segments with the churn/CAC numbers that condemned them; (d) top-3 open hypotheses each paired with a named validation experiment and its owner-channel; (e) a one-paragraph JTBD statement in the customer's own words quoted from call notes or lost-deal reasons.

# Quality gate

PASS only if: every qualifying predicate cites a number from the deal export (n, win rate, or retention delta), zero predicates are pure adjectives, and at least 3 disqualifiers are listed. FAIL if the ICP could have been written without opening the CRM export — re-run from step 1.

# Integration

- **evidence-reasoning**: every predicate carries its evidence citation; the confidence tiers in step 6 are its claim-labeling applied to segmentation.
- **adversarial-disproof**: before finalizing, attempt to find 5 closed-won deals that violate the ICP; if >20% of revenue violates it, the ICP is wrong, not the deals.
- **lead-definition-reconciler**: hand the finished predicates to it as the shared qualification vocabulary for sales and marketing.
- **channel-attribution-auditor**: ICP segments become its cohort keys — CAC by channel is only meaningful per-segment.

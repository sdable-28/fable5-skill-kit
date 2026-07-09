---
name: growth-loop-mapper
description: >
  Identify, quantify, and reinforce compounding growth loops — and expose funnel-thinking dressed as
  strategy. Trigger phrases: "growth loop", "viral loop", "K-factor", "referral program", "why isn't
  our funnel converting", "how do we get compounding growth", "content flywheel", "should we add
  referrals", "channel is saturating". Also invoke when a growth plan is a list of top-of-funnel
  tactics with no output-feeds-input structure. Do NOT use for choosing the overall motion
  (growth-model-selector) or for judging whether growth should be pursued at all (pmf-signal-reader,
  stage-playbook-enforcer). Do NOT use to design generic marketing funnels — this skill exists to
  replace funnel thinking, not decorate it.
---

# Growth Loop Mapper

## When invoked
1. State the distinction operationally before analysis: a funnel is linear — input (spend/effort) enters the top, output leaks out the bottom, and stopping input stops output. A loop routes some output back as input — each cycle's output funds or generates the next cycle's input. Classify every existing acquisition mechanism in the business as LOOP or FUNNEL and list them.
2. For each candidate loop, draw the cycle as explicit steps: new user → [action] → [exposure/artifact] → new user. Name the loop type: viral (users invite), content (usage generates indexable/shareable artifacts), paid (revenue → spend → revenue, only a loop if payback < reinvestment window), sales (customers → case studies/referrals → pipeline), community (members → contributions → discovery → members).
3. Quantify each loop's compounding math. Viral: K = invites-per-user × conversion-per-invite, with cycle time — K=0.4 with a 3-day cycle beats K=0.6 with a 60-day cycle over a quarter; show the per-quarter multiplier, not just K. Content: pieces-per-cohort × traffic-per-piece × conversion. Paid: CAC payback months vs cash cycle. A "loop" with a cycle multiplier ≤1.0 and no path above it is a funnel wearing a costume — reclassify it.
4. Separate inherent virality (product is better with others in it — exposure is native to use) from incentive virality (users are paid to invite). Incentive loops require the fraud audit: self-referral, cycle-farming, incentive arbitrage — name the top two fraud vectors for the proposed design and the guard for each. Check incentive timing (reward after the invitee ACTIVATES, not signs up) and sidedness (two-sided default for anything with onboarding friction).
5. Find the constraint step: every loop has one step whose rate limits the cycle. Identify it with numbers (e.g., invites sent is fine at 2.1/user but invite→activation is 4%). Reinforcement effort goes ONLY to the constraint step; improving non-constraint steps is funnel-brain.
6. Audit channel saturation for funnel-only channels being defended: rising CAC trend, falling CTR, shrinking addressable inventory = saturation; the answer is a loop or a new channel, not more budget. Check channel-ICP integrity — a channel delivering cheap signups that nrr-health-checker flags as fast-churning is negative-value regardless of CAC.
7. Recommend at most two loops to reinforce and one to build, sequenced. More is diffusion.

## Output format
Produce a **Loop Atlas**:
- `inventory` table: mechanism → LOOP / FUNNEL / COSTUMED-FUNNEL, with one-line justification
- per real loop: `cycle-diagram` (arrow-notation steps), `math` (K or multiplier, cycle time, per-quarter compounding), `constraint-step` with its measured rate
- `fraud-audit`: for any incentive loop — top 2 vectors + guards, incentive timing, sidedness
- `saturation-watch`: funnel channels with CAC/CTR trend and a saturation verdict
- `reinforcement-plan`: max 2 reinforce + 1 build, each with the constraint-step intervention and expected multiplier change
- `falsification`: for each intervention, the metric reading in 60 days that proves it failed

## Quality gate
PASS only if: (a) every mechanism in the inventory is classified with justification; (b) every claimed loop has cycle math with a number — no loop admitted on narrative alone; (c) each recommended intervention targets a named constraint step; (d) any incentive-based design includes the fraud audit. FAIL if the atlas recommends improving a step that is not the constraint, or admits a mechanism with multiplier ≤1.0 as a loop.

## Integration
- **statistical-analysis**: K-factor and conversion rates carry confidence intervals; loops measured on <100 cycles get provisional status.
- **adversarial-disproof**: for each claimed loop, construct the strongest case that its growth is actually driven by a correlated funnel (e.g., "viral" signups that are really brand-search from paid ads) and test attribution before crediting the loop.
- **verified-done**: a reinforcement is done when the constraint step's rate measurably moved, not when the feature shipped.
- **growth-model-selector**: the primary motion determines which loop types are native (PLG → viral/content, SLG → sales loop); do not bolt a viral loop onto a procurement-driven SLG product.
- **nrr-health-checker**: supplies churn-by-channel to invalidate cheap-CAC funnel channels; expansion revenue it finds is a candidate loop input.
- **stage-playbook-enforcer**: pass the reinforcement-plan through its ruling — multi-loop orchestration is a stage-3 tactic.

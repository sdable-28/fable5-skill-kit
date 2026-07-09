---
name: copy-testing-loop
description: >
  Run a disciplined copy/creative testing loop — hypothesis-driven variants, one lever per test,
  pre-registered decision rules, and creative-fatigue tracking. Trigger phrases: "A/B test this
  headline", "which subject line", "test the landing page copy", "our CTR is dropping", "ad
  creative refresh", "write me 5 variants". Invoke whenever copy variants will be shipped to a
  live audience and someone will decide based on the results. Do NOT use for one-off copywriting
  with no measurement plan (just write the copy), for product feature experiments (generic
  experimentation), or when traffic is too low to reach significance within 4 weeks — output a
  sequential qualitative plan instead and say so.
---

# When invoked

1. Force a hypothesis before any variant is written: which single lever is being tested (headline mechanism, offer framing, CTA verb, proof element, hook, framework swap e.g. PAS→Before-After-Bridge) and why the current copy is believed weak at that lever. "Let's just try some versions" is rejected — spray-testing produces winners that cannot be reused because nobody knows what won.
2. Write variants that differ ONLY on that lever. If a variant changes headline AND CTA, split it or kill it. Maximum 3 challengers per control per test.
3. Pre-register the decision rule before launch: primary metric (must be a downstream metric — reply rate, SQL rate, purchase — not opens/impressions unless the lever is the subject line/hook itself), sample size for the minimum detectable effect, test duration covering ≥1 full weekly cycle, and the ship/kill/iterate thresholds. Write these down; do not let them be set after peeking.
4. Check for the two domain traps before launch: (a) audience contamination — same prospects receiving multiple variants across channels; (b) platform auto-optimization (Meta/Google splitting budget unevenly between variants mid-test) — force even split or account for it.
5. At readout: verdict per variant against the pre-registered rule only. Record the LEVER-level learning ("loss-framed offer beat gain-framed by 31% on SQL rate"), not just the winning string, into a running copy-learning log.
6. Set the fatigue watch on any shipped winner: for paid creative, log launch-date frequency and CTR; schedule a re-check at frequency >3 or CTR decay >25% from launch baseline — winners decay, and a decayed winner is not evidence the lever stopped working.

# Output format

A **Test Card** per test: hypothesis (lever + mechanism), control and variant texts, pre-registered decision rule (metric, MDE, n, duration, thresholds), contamination checks (a/b) each PASS/FAIL, and — post-readout — verdict, effect size with interval, lever-level learning sentence, and fatigue-watch trigger values. Plus an appended row to the copy-learning log.

# Quality gate

PASS only if the decision rule was written before results existed, every variant differs on exactly one lever from control, and the primary metric is downstream of the click unless the lever is pre-click. FAIL if the readout cites opens/impressions as the win condition for body copy, or if the "winner" was declared by peeking before the pre-registered n.

# Integration

- **statistical-analysis**: owns the MDE/sample-size math in step 3 and the interval reporting in the readout.
- **plan-gate**: the pre-registered decision rule is the gate artifact — no launch without it.
- **verified-done**: a test is done at readout-against-rule, not at launch; shipped winners are not "done" until the fatigue watch is scheduled.
- **icp-sharpener**: segment results by ICP tier — a variant that wins on-ICP and loses off-ICP is a win.
- **channel-attribution-auditor**: when a copy win coincides with a channel-level shift, check attribution changes before crediting the copy.

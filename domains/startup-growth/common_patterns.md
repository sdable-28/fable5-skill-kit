# Common Task Patterns — Startup Growth

## 1. PMF Verification Before a Scale Decision
**Trigger:** Founder wants to hire GTM headcount, raise spend, or "pour fuel" — and PMF is asserted, not measured.
**Approach:** 1. Pull cohort retention curves by monthly cohort; check the curve flattens (asymptote > 0), not decays to zero. 2. Run Sean Ellis test on active users ("very disappointed" if product gone) — need >40%. 3. Compute organic/word-of-mouth share of new signups. 4. Segment all three by ICP — look for partial PMF (one segment >40%, blended <40%). 5. Verdict: scale the passing segment only; freeze hiring elsewhere.
**Checklist:** `[ ] Retention flattens by month 3-6  [ ] Sean Ellis >40% (n>=40 responses)  [ ] Organic share >=30% and rising  [ ] Segment cut done  [ ] Verdict written: SCALE <segment> / HOLD`
**Variation:** Blended metrics hide partial PMF — a strong niche drowned by weak everything-else reads as "almost there." Always segment before verdict.

## 2. Diagnosing Stalled Growth by Stage Mismatch
**Trigger:** Growth rate halves, CAC climbs, or "what worked stopped working" — usually right after crossing $1M or $10M ARR.
**Approach:** 1. Name the current stage by ARR band (0→$1M, $1M→$10M, $10M→$100M). 2. Inventory active tactics and tag each with the stage it belongs to (founder-led sales = stage 1; repeatable outbound playbook = stage 2; multi-channel + expansion revenue = stage 3). 3. Flag every tactic one stage behind (not yet retired) or one ahead (premature). 4. Check channel saturation: CAC trend per channel over 3 quarters. 5. Prescribe: retire, keep, or add — with the stage-appropriate replacement.
**Template:** `Stage: ___ | Tactic → stage-tag → CAC trend → verdict (RETIRE/KEEP/ADD) | Saturated channels: ___ | Next channel bet: ___`
**Variation:** Blaming market timing when the real cause is a stage-1 tactic run at stage-2 scale. Test: did a comparable competitor grow through the same period? If yes, it's execution/stage, not market.

## 3. Choosing the Primary Growth Motion
**Trigger:** New product line, new segment, or post-seed GTM reset — "should we do PLG or sales?"
**Approach:** 1. Establish ACV, buyer (user vs economic buyer), and category awareness. 2. Map: ACV <$5k + user-buyer → PLG; ACV >$25k + procurement → SLG; practitioner community exists → community-led; high-intent search volume → marketing-led; adjacent platform owns distribution → partnership-led. 3. Pick ONE primary motion; name at most one secondary. 4. Define the motion's first metric (PLG: time-to-value + activation rate; SLG: SQL→close rate; content: payback on content spend). 5. Set a 2-quarter kill criterion before starting.
**Checklist:** `[ ] ACV stated  [ ] Buyer = user? Y/N  [ ] One primary motion picked  [ ] First metric + target  [ ] Kill criterion + date`
**Variation:** Running PLG and enterprise SLG simultaneously pre-$5M ARR — the free tier undercuts the AE motion and the roadmap splits. Sequence, don't parallelize.

## 4. Converting a Funnel into a Growth Loop
**Trigger:** Acquisition is 100% paid/outbound, growth is linear in spend, and marginal CAC is rising.
**Approach:** 1. Diagram the current funnel end to end. 2. Find the output that can feed an input: user-generated content → SEO; invites/collab → viral; usage artifacts shared externally → exposure; customer success → referral. 3. Compute current K-factor: invites-per-user × conversion-per-invite. 4. Design one loop; instrument every edge of it. 5. Ship, measure cycle time and amplification per cycle, iterate on the weakest edge.
**Template:** `Loop: [output] → [distribution surface] → [new user] → [output]. K = i × c = ___. Cycle time: ___ days. Weakest edge: ___. Next experiment: ___`
**Variation:** Incentive-only virality (pay-per-referral) with no inherent reason to share — K collapses the day incentives stop. Prefer loops where sharing IS the product use.

## 5. Retention/NRR Audit Under Acquisition Pressure
**Trigger:** Board deck celebrates new-logo growth; NRR is unreported or "roughly 100%"; or churn is quietly rising.
**Approach:** 1. Compute NRR and gross revenue retention by cohort and by segment — not blended. 2. Overlay logo churn vs revenue churn (small-logo churn can hide large-account contraction). 3. Trace churned cohorts back to acquisition channel — cheap CAC from wrong-ICP channels shows up here 6-9 months later. 4. If NRR <100%: freeze acquisition-spend increases until the leak is sized and root-caused. 5. Benchmark: Series B+ wants NDR >120%, CAC payback <18mo, Rule of 40 passing.
**Checklist:** `[ ] NRR by cohort + segment  [ ] GRR separated from NRR  [ ] Churn-by-channel table  [ ] Wrong-ICP channel named or cleared  [ ] Spend decision: FREEZE/CONTINUE`
**Variation:** Expansion from one whale masks base-wide contraction — NRR looks fine until the whale renegotiates. Always report NRR excluding top-3 accounts alongside blended.

## 6. Vanity-Metric Strip in Investor/Board Reporting
**Trigger:** Fundraise prep, board deck, or growth review where headline numbers are signups, downloads, GMV, or cumulative anything.
**Approach:** 1. List every metric in the deck. 2. Replace each vanity metric with its stage-appropriate counterpart: signups → activated users; cumulative revenue → MRR growth rate; pipeline → weighted coverage ratio (want 3x+); "users" → WAU/MAU with retention. 3. Add the metrics the stage demands: pre-PMF → retention curve shape; Series A → NRR, CAC payback, magic number; Series B+ → Rule of 40, NDR, payback months. 4. For each headline number, attach the denominator and the trend, never a point value.
**Template:** `Metric | Vanity? | Replacement | Stage-required? | Trend (3q)` — one row per deck number.
**Variation:** Swapping vanity metrics only in external decks while the team still operates on them internally — the dashboard the growth team stares at daily is the one that must change first.

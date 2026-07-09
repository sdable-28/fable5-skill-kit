# Startup Growth — Domain Pack

Operating instructions for growth work: measuring product-market fit, selecting a growth model, building compounding loops, and reading stage-appropriate metrics from 0 → $1M → $10M → $100M ARR. Written as procedures for another instance of yourself. Imperative. Evidence-anchored. The domain's cardinal sin is applying a tactic from the wrong stage — every section below exists to prevent that.

---

## 1. Domain Overview

Startup growth is the discipline of finding a repeatable, compounding mechanism that turns input (spend, effort, users) into more output than it consumed — and knowing which mechanism is valid at the company's current stage. The work divides cleanly into where AI is decisive and where AI must defer.

**Where AI adds the most value:**
- **Metric forensics.** Reconstructing retention curves, cohort tables, NRR/NDR, CAC-by-channel, magic number, and Rule of 40 from raw event and revenue data. Humans routinely quote these wrong (blended when they should be cohorted, logo when they should be dollar). AI recomputes from source and catches the error.
- **Diagnosis under a framework.** Given data, decompose "growth stalled" into its MECE branches (acquisition / activation / retention / monetization / expansion) and localize the break with evidence. This is the highest-leverage AI task in the domain.
- **Stage-matching.** Cross-checking a proposed tactic against the company's real stage signals and flagging stage-mismatch before the spend happens.
- **Model and unit-economics math.** K-factor, payback period, LTV:CAC by segment, freemium conversion sensitivity, viral-loop cycle time — computed stepwise, not asserted.

**Where AI must defer to human judgment:**
- **Whether PMF exists.** AI computes the Sean Ellis score and retention-curve shape; the human weighs qualitative signal density (interview texture, the intensity of user pull) that no dashboard captures. AI reports the numbers and names the ambiguity; it does not declare PMF.
- **ICP psychographics and triggering events.** AI can cluster closed-won data; it cannot substitute for talking to buyers about why they bought now. Defer the "why now" to human discovery.
- **Category and timing calls.** "Is the market ready" is a judgment AI cannot verify from internal data. Flag it as a human decision with explicit assumptions.
- **Irreversible bets** — a fundraise sized to a growth thesis, an international expansion, a re-platform of the go-to-market motion. AI produces the decision memo; the founder owns the call.

The through-line: **AI is the instrument panel and the diagnostician; the founder is the pilot.** State confidence honestly, label SIM/projection vs. observed, and never let a clean-looking number substitute for the retention truth underneath it.

---

## 2. Core Principles

Each is falsifiable — a practitioner can check compliance against artifacts.

1. **Do not claim PMF without two independent measures agreeing.** Sean Ellis ≥40% "very disappointed" AND a retention curve that flattens. One without the other is "some people use it," not PMF. Check: both artifacts exist and both pass.
2. **Retention curve shape gates everything.** If the curve does not flatten to a horizontal asymptote, do not spend on acquisition. Growing acquisition on a decaying-to-zero curve is filling a leaky bucket. Check: the cohort retention chart has a visible flat tail above 0%.
3. **Cohort, never blend, for retention and CAC.** Blended metrics hide the truth when mix shifts. Every retention and CAC number is reported by cohort and by segment. Check: no headline metric is a single all-users average.
4. **Match the playbook to the stage, explicitly.** Before proposing any tactic, state the company's ARR band (0→$1M / $1M→$10M / $10M→$100M) and confirm the tactic belongs to that band. Check: every recommendation names its stage.
5. **NRR/NDR is a first-class metric from first dollar of expansion revenue.** NRR < 100% means the company shrinks without new logos — a slow-motion death that dashboards focused on new MRR hide. Check: NRR is computed and trended, not just new MRR.
6. **Prefer loops to funnels.** A funnel is linear and leaks; a loop feeds its output back as input and compounds. For any growth proposal, name the loop and its cycle time, or state explicitly that it's a non-compounding funnel push. Check: the loop diagram exists or the funnel-nature is admitted.
7. **Pick the growth model from ACV, buyer, and category — not from fashion.** PLG for low-ACV self-serve buyers; SLG for high-ACV multi-stakeholder deals; community/marketing/partnership by category fit. Check: the model choice cites ACV band and buyer type.
8. **A metric without a retention or revenue denominator is vanity.** Total signups, impressions, and cumulative downloads are banned as success claims. Convert to activated-and-retained or to dollars. Check: no success claim rests on a cumulative gross count.
9. **CAC is only cheap if the ICP is right.** Cheap-to-acquire, impossible-to-retain is negative-value growth. Always pair CAC with the same cohort's retention. Check: CAC and retention reported for the same segment.
10. **Compute payback, don't assert it.** CAC payback period and magic number are shown stepwise with named inputs. Check: the arithmetic is visible.
11. **One channel to saturation before adding the second.** Adding channels before the first is understood and saturated diffuses focus and corrupts attribution. Check: the primary channel's saturation evidence precedes any second-channel proposal.
12. **K-factor claims require the full loop math.** Virality = invites-sent × conversion-rate, with cycle time. A K-factor quoted without both terms and the time constant is unverified. Check: both terms and cycle time are present.
13. **Do not internationalize while the domestic market is unsaturated.** Expansion is a distraction from the higher-return domestic loop until domestic penetration plateaus. Check: domestic saturation evidence precedes any expansion recommendation.
14. **Separate execution quality from market timing in every post-mortem.** "It didn't work" has two causes with opposite fixes. Attribute explicitly. Check: the post-mortem assigns cause to one or names it unresolved.
15. **Slow hiring until PMF is confirmed.** Headcount added pre-PMF becomes fixed cost defending a thesis that isn't validated. Check: the hiring plan references a PMF gate.

---

## 3. Master Framework — Adapted for Startup Growth

The 7 universal stages, instantiated with growth-specific moves and tools.

1. **Understand.** Establish the real question and the company's stage. Pull ARR, growth rate, the retention curve, NRR, and the current growth model. Distinguish "we want more growth" from the actual break (is acquisition slowing, or is retention silently eroding NRR?). *Tools:* cohort table, retention-curve plot, Sean Ellis survey, ICP definition. *Gate:* the ARR band and the suspected break-branch are named with evidence.

2. **Decompose.** Break growth into its MECE tree: Acquisition → Activation → Retention → Monetization → Expansion (referral loops as a cross-cut). Localize which branch moved. *Tools:* funnel-vs-loop map, metric tree. *Gate:* the stalled branch is isolated, not asserted at the top level.

3. **Plan.** For the broken branch, list candidate levers ordered by expected-value × speed-to-validate × reversibility. Match each to the stage. State the one metric each lever should move and by how much (MDE). *Tools:* RICE/ICE on levers, unit-economics model, payback math. *Gate:* the riskiest assumption is scheduled to be tested first; every lever names its stage and its target metric delta.

4. **Execute.** Run the top lever as a designed experiment or a scoped build. Instrument the loop, not just the funnel step. Change one lever at a time so attribution survives. *Tools:* experiment spec, event instrumentation, holdout design. *Gate:* the lever's target metric is measurable and a control exists.

5. **Verify.** Judge against the Stage-1 target metric, cohorted. Confirm the move is retention-real, not a pull-forward that decays. Recompute NRR and payback after the change. *Tools:* cohort re-pull, statistical significance check, calibration against the pre-registered MDE. *Gate:* the target metric moved by ≥ MDE in a cohort that has aged enough to trust, and NRR/payback did not degrade.

6. **Self-Correct.** If the lever failed, root-cause before the next one: was it execution (bad implementation) or thesis (the branch wasn't the break)? A failed retention lever on a wrong-ICP cohort is a targeting problem, not a retention problem. *Tools:* segment re-slice, ICP re-examination. *Gate:* the failure is attributed to execution or thesis with evidence before the next lever fires.

7. **Iterate.** Bank the learning: which loop compounds, which channel saturated, which segment retains. Update the growth model if the evidence demands it. Persist the falsified levers so they aren't re-run. *Tools:* growth log, decision journal, ICP update. *Gate:* the learning is written down and the next lever is chosen from the updated model.

---

## 4. Pitfalls Checklist

Each: concrete example → detection signal → prevention.

1. **Scaling before PMF.** Example: raising a $6M Series A and hiring 4 AEs while the 6-month retention cohort sits at 8%. Detection: acquisition spend rising while the retention curve still slopes toward zero. Prevention: gate all acquisition scaling on a flattened retention curve; hold headcount until the PMF gate passes.
2. **Blended-metric self-deception.** Example: "CAC is $180" — but that's SMB and enterprise blended, and enterprise (the retaining segment) actually costs $1,400. Detection: a single company-wide number quoted for CAC, retention, or NRR. Prevention: cohort and segment every metric; ban the blended headline.
3. **NRR < 100% unrecognized.** Example: new-MRR dashboards look healthy at +$40k/mo while churn+contraction quietly removes $55k/mo. Detection: new MRR trended without a net-revenue-retention line beside it. Prevention: compute and trend NRR/NDR every reporting cycle; alert below 100%.
4. **Vanity metric masking.** Example: "500k signups!" celebrated while activated-and-retained-at-30-days is 3,000. Detection: a cumulative gross count used as a success claim. Prevention: convert every headline to activated-and-retained or to dollars; strip cumulative counts.
5. **Wrong-stage playbook.** Example: running a Series B outbound-SDR enterprise motion on a $600k-ARR self-serve product with a $40 ACV. Detection: the tactic's stage doesn't match the ARR band. Prevention: state the stage before every recommendation; reject mismatches.
6. **Cheap CAC from wrong ICP.** Example: a discount channel floods signups at $12 CAC that churn at 70%/month. Detection: CAC dropping while retention of that cohort drops with it. Prevention: pair CAC with same-cohort retention; treat retention-adjusted CAC as the real number.
7. **Funnel thinking on a loop-shaped opportunity.** Example: pouring paid budget into top-of-funnel while ignoring that each activated user could invite 1.4 others. Detection: growth plan is all linear acquisition, no feedback mechanism named. Prevention: map the product's loops; fund loop reinforcement before linear push.
8. **Premature multi-channel spread.** Example: launching SEO, paid, partnerships, and outbound simultaneously at $900k ARR; none reaches competence, attribution becomes noise. Detection: two+ new channels started before the first saturated. Prevention: one channel to saturation and understood attribution before the next.
9. **K-factor fantasy.** Example: "we'll go viral, K=1.3" with no measured invite rate or conversion rate behind it. Detection: a viral coefficient asserted without invites-sent × conversion × cycle-time. Prevention: require the full loop math and a measured cycle time; treat unmeasured virality as zero.
10. **Referral fraud blindness.** Example: a two-sided $50 referral reward gets farmed by fake accounts; CAC looks great, retention is zero. Detection: referral cohort with high signup, near-zero activation. Prevention: model fraud vectors before launch; gate reward on the referred user's activation, not signup.
11. **Expanding internationally too early.** Example: standing up an EU entity and localizing while US penetration is 4% of TAM. Detection: expansion proposed with domestic market far from saturation. Prevention: require domestic-saturation evidence before any geo expansion; prefer the higher-return domestic loop.
12. **Localization-as-translation.** Example: machine-translating the US site to German and expecting German conversion; ignoring payment methods, buying norms, compliance. Detection: expansion plan mentions translation but not payment, legal, or buying-behavior localization. Prevention: scope full localization (payment, legal, GTM, support), not just language.
13. **Confusing market timing with execution quality.** Example: a channel that worked in 2021 dies in 2024 and the team blames the team, re-hiring instead of recognizing channel decay. Detection: a post-mortem that assigns cause to effort without checking whether the market/channel shifted. Prevention: separate timing from execution in every post-mortem; check channel-level external shifts first.
14. **Activation ignored while acquisition is optimized.** Example: months spent lowering CAC 20% while 60% of new users never reach the aha-moment. Detection: acquisition metrics improving, activation rate flat. Prevention: instrument time-to-value and activation rate; fix the activation leak before buying more top-of-funnel.
15. **Pull-forward mistaken for growth.** Example: a promo spikes MRR this quarter by dragging future demand forward; next quarter craters. Detection: a step-change in a metric that decays in the following cohorts. Prevention: judge levers on aged cohorts and on NRR, not on the immediate spike.

---

## 5. Sample Task Walkthrough

**Scenario.** A B2B SaaS founder reports: "We were growing 15% month-over-month, and for the last three months we've been stuck flat at ~$800k ARR. What lever do we pull?" ACV ≈ $6,000/yr, self-serve signup with a sales-assist for larger accounts. They want a recommendation.

**Stage 1 — Understand.** Do not accept "pull a lever" at face value; the request assumes acquisition is the break. Establish the stage: $800k ARR = the $1M→$10M band's front edge, self-serve + light sales, mid ACV — a candidate for PLG-with-sales-assist. Pull the raw data before any hypothesis: monthly cohort retention, NRR, new-MRR vs. churned+contracted-MRR, CAC by channel, activation rate. *Gate:* stage named ($1M→$10M, PLG-leaning); the suspected break not yet assumed.

**Stage 2 — Decompose.** Build the MECE tree: Acquisition, Activation, Retention, Monetization, Expansion. Compute each from source. Finding: new MRR is actually still growing +$38k/month — acquisition is *not* broken. But churned+contracted MRR has risen to −$36k/month. Net ≈ +$2k. **NRR has fallen to 96%.** The retention curve for cohorts from the last two quarters flattens lower (at ~55%) than older cohorts (~72%). The break is in **Retention/Expansion**, not Acquisition — the exact opposite of the founder's framing. *Gate:* break isolated to retention/NRR with cohort evidence, not asserted at the top.

**Stage 3 — Plan.** Now segment the churn to localize it. Re-slice by acquisition channel and ICP. Finding: a paid-social channel added in Q2 brought CAC down to $310 (from $520) — celebrated at the time — but those cohorts retain at 38% vs. 74% for organic/referral cohorts. The "cheap CAC" win imported a wrong-ICP cohort that is now dragging NRR down. Candidate levers, ordered by EV × speed × reversibility: (a) pause/re-target the paid-social channel to the retaining ICP — fast, reversible, directly addresses the cause; (b) build an expansion motion (seat/usage upsell) to lift NRR above 100% — higher ceiling, slower; (c) an activation fix for the low-retNRR cohort — uncertain it's salvageable if the ICP is simply wrong. Lever (a) first: it tests the thesis (wrong-ICP acquisition is the cause) cheaply and reversibly. Target: NRR back toward 100%+ as bad-fit cohorts age out; MDE stated. *Gate:* riskiest assumption (that channel-ICP mismatch causes the churn) is tested first.

**Stage 4 — Execute.** Re-target paid-social to the retaining ICP's psychographics and triggering event, hold a control, and instrument the new cohorts' activation and 30/60/90-day retention. Change only the targeting lever. *Gate:* new cohorts measurable against a control.

**Stage 5 — Verify.** Wait for cohorts to age enough to trust (do not read retention at day 7 and declare victory — that's a pull-forward trap). Recompute NRR and same-cohort retention-adjusted CAC. Pass condition: retargeted cohorts retain materially closer to the 74% organic line AND NRR trends back up. *What could go wrong and how it's caught:* if the new cohorts also retain poorly, the thesis was wrong — the problem is the product's fit for this segment, not the channel targeting. That's caught by the aged-cohort retention read, and it routes to Stage 6.

**Stage 6 — Self-Correct.** If lever (a) fails, attribute: is it execution (targeting still imprecise) or thesis (this ICP won't retain regardless of channel)? Re-slice again. If thesis, drop lever (a) and reallocate to lever (b), the expansion motion on the *retaining* base, and stop acquiring the bad-fit segment entirely.

**Stage 7 — Iterate.** Bank the learning: cheap CAC from paid-social was negative-value at this ICP; the retaining engine is organic/referral + expansion. Update the ICP definition and the growth model (PLG expansion, not paid acquisition, is the compounding loop here). Persist "paid-social at $310 CAC" as a falsified cheap-CAC win so it isn't re-run next quarter.

**The core catch:** the founder asked "which acquisition lever" — the data said acquisition was fine and retention was silently killing NRR. Answering the asked question would have poured budget into a leaking bucket. The domain discipline (cohort not blend, NRR as first-class, CAC-paired-with-retention) is what surfaced the real break.

---

## 6. Integration with Core Skills

The core skills most load-bearing in this domain, and how they specialize here:

- **statistical-analysis** — the backbone. Retention-curve fitting, cohort significance, MDE for growth experiments, K-factor confidence, calibration of projected LTV. Domain variation: two time-halves are not one population when the market shifted between them; treat pre/post-channel-change cohorts as separate regimes.
- **mathematical-reasoning** — every unit-economics number (payback period, magic number, LTV:CAC, K-factor, Rule of 40) is computed stepwise with named inputs and a cross-check. No asserted growth math.
- **evidence-reasoning** — the discipline that killed the vanity metric in the walkthrough. Every metric claim carries its source and cohort; "NRR is 96%" cites the revenue table and the window. SIM/projection labeled distinct from observed.
- **adversarial-disproof** — run on every "we found the growth lever" conclusion. Lens 1: is the metric real or blended? Lens 2: is the effect retention-real or a pull-forward that decays? Lens 3: is the lift causal or a mix-shift artifact? This is where premature victory claims die.
- **root-cause-first** — before any lever, state the break with evidence (retention, not acquisition, in the walkthrough). A growth fix aimed at the wrong branch is the domain's most expensive error.
- **assumption-flagging** — surface the hidden assumptions in growth plans: that PMF exists, that the channel scales, that the ICP is right, that virality is real. Resolve the high-risk ones (PMF, ICP) before spending.
- **plan-gate + verified-done** — gate growth experiments on a pre-registered target metric and MDE; "done" means the cohorted metric moved by ≥ MDE on aged cohorts with NRR intact, not "the experiment ran."

**Combination pattern for the modal task (diagnose a stall):** root-cause-first (isolate the branch) → statistical-analysis + evidence-reasoning (cohort the metrics from source) → adversarial-disproof (is the diagnosis real?) → plan-gate (pre-register the lever and MDE) → verified-done (judge on aged cohorts + NRR). Compose with the domain skills — **pmf-signal-reader**, **growth-model-selector**, **nrr-health-checker** — which supply the growth-specific measurement that the core skills then reason over.

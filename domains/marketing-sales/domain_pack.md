# Marketing & Sales — Domain Pack

Operating instructions for full-funnel marketing and sales work: awareness → acquisition → conversion → close → retention → expansion. Read this file before executing any task in this domain. These rules override generic behavior.

---

## 1. Domain Overview

### What makes this domain unique

Marketing and sales is a domain where **the measurement system is itself unreliable and adversarial**. Unlike code (deterministic tests) or finance (audited ledgers), the core feedback loops here are corrupted by design: attribution models disagree with each other by 2–5x on the same channel, ad platforms grade their own homework (Meta's reported conversions routinely exceed the business's actual new customers), survey data ("How did you hear about us?") contradicts click data, and every vendor's dashboard is engineered to justify more spend on that vendor. Treat every metric as a claim by an interested party until triangulated.

Second uniqueness: **the audience adapts against you**. A subject line that gets 40% open rates decays as recipients habituate. A winning ad creative fatigues in 2–6 weeks. A cold-email framework that works gets copied by ten thousand SDRs and burns out the pattern for everyone. Nothing here is a solved problem that stays solved — every asset has a decay curve. Static playbooks rot.

Third: **two functions with different incentives share one funnel**. Marketing is paid on volume (MQLs, pipeline sourced); sales is paid on revenue (closed-won). The handoff between them is where most revenue leaks, and the leak is usually definitional, not operational — the two teams literally mean different things by "qualified lead."

### Where AI adds the most value

- **Volume + variation:** generating 30 ad-copy variants, 12 subject lines, 8 landing-page headline tests — humans produce 3 and anchor on the first. Produce structured variant matrices, not one-offs.
- **Synthesis across silos:** joining CRM data, ad-platform data, web analytics, and call transcripts that no single human reads end-to-end. Cohort math, attribution triangulation, funnel-stage conversion decomposition.
- **Pattern detection at speed:** creative fatigue onset, deliverability drift, keyword cannibalization, pipeline slippage patterns across hundreds of deals — signals visible in data days before a human notices.
- **Framework discipline:** applying AIDA/PAS/MEDDIC/SPIN rigorously where humans skip steps under deadline pressure.
- **First-draft everything:** briefs, sequences, battle cards, discovery-call question sets, QBR decks. AI drafts, human owns the send.

### Where AI must defer to human expertise

- **Brand voice final authority.** AI matches a documented voice; it cannot arbitrate whether a new tone is "on brand" for an undocumented one. Flag, don't decide.
- **Pricing and discounting decisions.** Recommend structure; a human owns the number. Discount authority is a business decision with margin, precedent, and channel-conflict implications AI cannot fully see.
- **Anything legally exposed:** claims ("#1", "fastest", health/financial outcomes), sweepstakes, testimonial usage, CAN-SPAM/GDPR/CASL/TCPA compliance sign-off, competitor comparisons. Draft with compliance flags; human legal review is the gate.
- **Relationship judgment in live deals.** AI preps the call, drafts the follow-up, scores the deal risk. The rep decides when to push and when to walk. Never send outreach or deal communication autonomously without explicit authorization for that specific send.
- **Actually pressing "send" on anything customer-facing at scale.** Email blasts, ad launches, price changes. Produce the asset + the launch checklist; a named human executes.

---

## 2. Core Principles

Each principle is falsifiable — compliance is checkable by inspecting the work product.

1. **No metric without a denominator and a comparison.** Never report "1,200 MQLs" — report "1,200 MQLs (vs. 980 last month, vs. 1,400 target), converting to SQL at 18% (vs. 24% trailing-90-day)." Any deliverable containing a bare count fails.

2. **One primary conversion action per asset.** Every landing page, email, and ad has exactly one primary CTA. If a draft contains two competing CTAs of equal visual weight ("Book a demo" AND "Download the whitepaper"), the draft is wrong. Secondary links may exist but must be visually subordinate.

3. **Message hierarchy before copy.** Do not write headline copy until the positioning is stated in one sentence of the form: *For [segment] who [struggle/JTBD], [product] is the [category] that [key differentiator], unlike [alternative].* If asked to "write the landing page" without this, produce the positioning statement first and get it confirmed.

4. **Every A/B test declares its hypothesis, primary metric, MDE, and sample size before launch.** A test brief without a pre-registered minimum detectable effect and required sample size is not a test — it is a coin flip with a dashboard. Refuse to call a test "won" below the pre-declared sample or on a metric chosen after seeing results.

5. **Attribution claims require triangulation from ≥2 independent sources.** Platform-reported conversions (Meta, Google) alone never justify a budget decision. Corroborate with: CRM closed-won source fields, self-reported attribution ("how did you hear about us"), geo/holdout evidence, or MMM directionality. State the disagreement range explicitly.

6. **Pipeline and revenue metrics outrank engagement metrics in every recommendation.** Impressions, opens, likes, and traffic appear only as diagnostic intermediates, never as the headline result. A campaign summary whose top-line number is impressions fails review.

7. **The MQL→SQL definition must be written, dated, and dual-signed before any lead-volume work.** If asked to "generate more leads" and no shared qualification definition exists (specific firmographic + behavioral criteria both teams agreed to), producing the definition IS the first deliverable.

8. **Segment before you sequence.** No email sequence ships to "the list." Every send names its segment by explicit criteria (lifecycle stage, behavior, firmographics) and its exclusions (active opportunities, recent purchasers, support escalations, unsubscribes obviously, but also: currently-in-another-sequence).

9. **Deliverability is infrastructure — protect it like uptime.** Never recommend a send that violates: ramp-up on new domains/IPs, sunset policy for non-engagers (suppress after ~90–180 days no-open), list sources of provable consent only. Any plan involving a purchased list or a cold blast from the primary sending domain is rejected outright, not optimized.

10. **In sales assets, quantified pain beats feature lists.** Discovery prep, battle cards, and proposals lead with the prospect's stated problem and its cost (SPIN implication / MEDDIC "identify pain" with a number attached), then map capability to it. Any proposal that opens with the product's feature grid instead of the customer's problem is redrafted.

11. **Never fabricate social proof, statistics, or customer references.** Every stat carries a source; every logo/quote has documented usage permission. If a claim needs proof that doesn't exist, mark it `[PROOF NEEDED]` and ship the draft with the gap visible — do not paper over it.

12. **Forecast categories are behavioral, not aspirational.** A deal is "Commit" only with: verified economic buyer engagement, agreed paper process, and a customer-confirmed date. Auditing a pipeline, flag every late-stage deal missing next-step activity within 14 days as at-risk regardless of the rep's label.

13. **Creative is an inventory with a burn rate.** Every paid-media plan includes a refresh cadence and a variant pipeline (concepts in production ≥ concepts live). A media plan that scales budget without scaling creative supply is incomplete — flag frequency > 3–4 (Meta, 7-day) as the fatigue tripwire.

14. **One keyword intent, one page.** Before creating any new SEO content, check existing indexed pages for the same intent. Two pages targeting the same query intent is a defect (cannibalization) requiring consolidate/differentiate/canonical decision — never "publish and see."

15. **State the decay assumption.** Every recommendation that projects performance (CAC, conversion rate, reply rate) states its decay/fatigue assumption explicitly. "This cold-email sequence gets 8% replies" is incomplete; "8% at launch, expect 30–50% decay over 2 quarters as the pattern saturates" is compliant.

---

## 3. Master Framework — the 7 Stages in Marketing & Sales

### Stage 1: UNDERSTAND

Establish before any work:
- **Business model context:** B2B or B2C, ACV/AOV, sales cycle length, sales-led vs product-led. A $99 self-serve SaaS and a $250k enterprise deal invalidate each other's playbooks entirely.
- **Funnel position of the ask:** which stage does this task touch — awareness, consideration, conversion, retention, expansion? Whose number does it move?
- **The real metric:** translate the stated ask into the business metric. "We need more content" → what pipeline/revenue outcome is content supposed to cause, on what timeline?
- **ICP and segment:** who exactly. If the answer is "everyone," stop and narrow before proceeding.
- **Existing baselines:** current conversion rates, CAC, CPL, win rate, cycle length. No baseline = first task is establishing one.

Tools at this stage: analytics platform audit (GA4/Amplitude), CRM field audit (stage definitions, source fields), ICP document, positioning statement, prior test logs. If these don't exist, their absence is a finding — report it.

### Stage 2: DECOMPOSE

Decompose along the funnel, not along channels. "Grow revenue 20%" decomposes into: traffic × visitor→lead × lead→opp × opp→win × ACV — five levers with different owners, costs, and timelines. Compute the sensitivity of each lever before choosing where to work (a 2pt improvement in opp→win usually beats a 20% traffic increase).

For campaigns: decompose into audience × offer × message × channel × timing. Test one at a time.
For sales problems: decompose the pipeline by stage-to-stage conversion and stage age; the problem is almost never uniform — it lives at one specific stage transition or in one segment.

### Stage 3: PLAN

Every plan states: hypothesis, primary metric + guardrail metrics, budget/effort, timeline to first read (respecting the sales cycle — B2B pipeline impact of a top-funnel change takes one full cycle to appear), kill criteria, and what happens to the learning if it fails. Plans without kill criteria are commitments, not experiments.

Sequencing rule: fix leaks before pouring — never plan an acquisition push into a funnel with a known broken stage (e.g., 40% of demo requests never get a call within 48h). Bottom-of-funnel fixes compound everything upstream of them.

### Stage 4: EXECUTE

- Produce assets in structured variant sets with the framework named per variant (this headline is PAS, this one is Before-After-Bridge) so tests read as framework comparisons, not copy lotteries.
- Every asset ships with its measurement plumbing: UTMs following the documented convention, conversion events verified firing, CRM campaign association set. An asset launched without tracking is a write-off — check plumbing BEFORE launch, not after.
- Follow launch checklists (see common_patterns.md). Seed-test emails across Gmail/Outlook/Apple Mail before the segment send. Render-check ads at actual placement sizes.
- Never auto-send. Deliverables end at "ready to launch + checklist verified"; a human presses send.

### Stage 5: VERIFY

Verification here is statistical and adversarial, not visual:
- Did the conversion event fire in the analytics tool for a real test session, and does the count reconcile ±10% with the CRM?
- Is the test at pre-declared sample size? If not, no verdict — say "no verdict yet," never "trending positive."
- Do platform numbers reconcile with business numbers? (Meta says 400 conversions; how many net-new CRM records with matching timestamps exist?)
- Segment the result: an aggregate win can be a segment-level loss (Simpson's paradox is routine here — mobile vs desktop, new vs returning).
- Check guardrails: the variant that lifted CTR — did it hold lead quality (downstream SQL rate) or did it attract clickers who never buy?

### Stage 6: SELF-CORRECT

When results miss, diagnose in this order before changing creative: (1) tracking broken? (2) audience/segment wrong? (3) offer wrong? (4) message wrong? (5) channel wrong? Most teams jump to rewriting copy (5's little sibling) when the failure is at 1–3. Creative is the last thing to blame because it's the most fun to change.

Log falsifications explicitly: "cold outreach to CFO persona with ROI-calculator offer: 0.4% reply over 2,000 sends — do not repeat" is a durable asset. Keep a falsification log per account/program.

### Stage 7: ITERATE

Iteration means feeding the decay loop: rotate creative before fatigue (not after), refresh sequences quarterly, re-run positioning against new competitors, re-validate the MQL definition against the last 90 days of closed-won data (do the leads sales actually closed match the definition marketing scores against?). Schedule the re-checks — decay is on a timer whether you watch it or not.

---

## 4. Pitfalls Checklist

1. **Platform-reported ROAS worship.**
   *Looks like:* Meta dashboard shows 4.2x ROAS; budget doubled; blended CAC rises and total new customers don't move — Meta was claiming credit for buyers who would have converted anyway (branded-search and retargeting harvesting).
   *Detection:* platform conversions > total new customers in CRM for the period; ROAS stays flat while blended revenue/spend deteriorates; retargeting is the "best performing" campaign.
   *Prevention:* judge channels on blended CAC and incremental lift (geo holdout or audience holdout), never platform ROAS alone. Separate prospecting and retargeting in all reporting.

2. **MQL definition drift (the sales-marketing cold war).**
   *Looks like:* Marketing celebrates 140% of MQL target; sales says "the leads are garbage" and stops working them within 24 hours; SDRs cherry-pick, follow-up SLA quietly dies.
   *Detection:* MQL→SQL conversion below ~10–15% and falling; median time-to-first-touch on MQLs growing; closed-won deals' original sources don't match MQL-scored sources.
   *Prevention:* written dual-signed definition (firmographic + behavioral criteria), a follow-up SLA both directions (sales touches within X hours, marketing recycles rejects with reasons), monthly joint review of a random 20-lead sample.

3. **Creative fatigue denial.**
   *Looks like:* the winning ad's CPA doubles over 3 weeks; team responds by raising bids and budget on the same creative, accelerating the burn.
   *Detection:* frequency > 3–4 (7-day), CTR down >30% from peak on stable audience, CPM stable while CPA climbs (audience isn't pricier — they're ignoring you).
   *Prevention:* per-concept fatigue dashboard; refresh pipeline maintained at ≥2 concepts in production per concept live; declare a creative "spent" on trigger, not on feel.

4. **Deliverability death spiral.**
   *Looks like:* open rates slide 32% → 24% → 11% over six weeks; someone "fixes" it by emailing MORE (re-sends to non-openers), which drives spam-folder placement further; then a purchased-list send hits a spam trap and the domain is blocklisted.
   *Detection:* Gmail opens dropping faster than other providers; Google Postmaster spam rate > 0.1% (hard fail > 0.3%); rising "delivered but no opens across an entire domain" pattern; blocklist hits (Spamhaus).
   *Prevention:* sunset policy enforced (suppress 90–180-day non-engagers), no purchased lists ever, separate sending domains for marketing vs transactional vs cold-outbound, SPF/DKIM/DMARC verified quarterly, ramp any new domain over 4–6 weeks.

5. **SEO cannibalization by content-calendar enthusiasm.**
   *Looks like:* five blog posts over two years all targeting "email deliverability guide" variants; Google rotates which one ranks; all rank #8–15 where one consolidated page would rank #3.
   *Detection:* Search Console shows multiple URLs receiving impressions for the same query with alternating rank; combined CTR below what the top URL's position implies; ranking URL for a money query flips month to month.
   *Prevention:* keyword-to-URL map maintained as a registry; every new brief checks the map first; quarterly cannibalization audit (GSC query→page export, group by query, flag multi-URL queries).

6. **Vanity-metric campaign theater.**
   *Looks like:* campaign recap deck leads with "2.3M impressions, 40k engagements"; nobody can say how many opportunities it created; the campaign is renewed on applause.
   *Detection:* recap contains no pipeline/revenue line; no UTM-to-CRM join was ever built; "brand awareness" invoked for a performance budget without a brand-lift measurement.
   *Prevention:* every campaign brief pre-declares its business metric and how it will be joined to CRM. Awareness campaigns are legitimate — but then a brand-lift or branded-search-volume measurement is pre-committed, or the campaign doesn't run.

7. **Testing your way to nowhere (peeking + tiny samples).**
   *Looks like:* button-color test declared won at 200 visitors after 3 days because the dashboard showed 95% significance once; "winner" implemented; next month's numbers identical.
   *Detection:* test log shows verdicts at <1,000 conversions per arm on small-effect tests; multiple metrics reported post-hoc with the best one headlined; tests stopped the day they first crossed p<0.05.
   *Prevention:* pre-registered MDE + sample size (Principle 4); sequential-testing correction if peeking is operationally necessary; test registry that records hypothesis before launch.

8. **The everything-launch (confounded go-to-market).**
   *Looks like:* new pricing, new homepage, new ad campaign, and a PR push all launch the same week; conversion moves; nobody can attribute it; the one harmful change among the four survives for a year.
   *Detection:* multiple simultaneous changes in the change log with a shared date; post-launch analysis can only say "overall up/down."
   *Prevention:* stagger launches ≥1 measurement cycle apart where feasible; where a bundled launch is forced (real GTM moments), pre-declare that channel-level attribution is void and evaluate the bundle top-line only.

9. **Happy-ears forecasting.**
   *Looks like:* rep marks a deal Commit because "the champion loved the demo"; no economic buyer met, no paper process discussed; deal slips three consecutive quarters, then dies to "no decision."
   *Detection:* deals in Commit missing MEDDIC fields (no identified EB, no decision date confirmed by customer, no next meeting on calendar); slipped-deal rate > ~20% of commit; stage age > 2× median.
   *Prevention:* forecast category gates on verifiable facts (Principle 12); automated pipeline-hygiene flags; deal reviews interrogate exit criteria, not sentiment.

10. **Discount-as-closing-technique.**
    *Looks like:* every quarter-end, 15–25% discounts close deals that "were stuck"; buyers learn the pattern and time purchases; ACV erodes 12% YoY; renewal negotiations anchor on the discounted price forever.
    *Detection:* discount rate clustered in the last two weeks of quarters; win rate on discounted vs undiscounted deals similar (discount wasn't the reason they bought); renewal uplift disputes.
    *Prevention:* discounts trade for value (multi-year, case study rights, expanded scope, reference calls) — never given unilaterally; discount authority matrix enforced; track discounted-cohort NRR separately.

11. **Sequence spam-cannon (outbound volume worship).**
    *Looks like:* SDR team 5x's send volume with a "personalization token" template ({{first_name}}, {{company}} in an otherwise identical blast); reply rate falls from 6% to 0.8%; the sending domain's reputation tanks, hurting even the good reps.
    *Detection:* replies-per-100-sends falling as volume rises; spam-complaint upticks; positive-reply share of total replies falling (more "unsubscribe/never contact" replies).
    *Prevention:* volume caps per mailbox (~30–50 cold sends/day/mailbox), separate outbound domain, relevance floor per email (one verifiable account-specific observation, not a token), kill any sequence under ~1–2% positive reply after 200 sends.

12. **Retargeting the converted / suppressing nothing.**
    *Looks like:* customers see "20% off your first purchase" ads for weeks after buying; support tickets ask for retroactive discounts; ad spend buys resentment.
    *Detection:* customer-list overlap check against active ad audiences shows purchasers in prospecting/retargeting; "days since conversion" audit of retargeting pool shows converted users.
    *Prevention:* automated exclusion audiences synced from CRM/purchase events on every campaign, verified at launch checklist time; suppression sync latency < 24h.

13. **Positioning by committee (the mush statement).**
    *Looks like:* homepage headline reads "The intelligent platform for modern teams" — could be any of 4,000 companies; every stakeholder's word survived into the sentence; visitors can't tell what it does in 5 seconds.
    *Detection:* the swap test — replace your logo with a competitor's; if the page still works, positioning has failed. Homepage bounce high with healthy traffic quality; "what does your product actually do?" appears in sales calls.
    *Prevention:* enforce the positioning template (Principle 3); test message clarity with 5-second tests on ICP-matched panels; one differentiated claim beats four agreeable ones.

14. **Ignoring the sales cycle in measurement windows.**
    *Looks like:* B2B team kills a LinkedIn campaign after 30 days for "no pipeline" when the sales cycle is 90 days; the pipeline arrives in month 3 attributed to "direct" because the campaign's cookies expired and the UTMs are gone.
    *Detection:* channel evaluations shorter than one median sales cycle; late-arriving opportunity sources dominated by "direct/none."
    *Prevention:* evaluation windows ≥ 1 full sales cycle for pipeline verdicts; use leading indicators (qualified meetings booked, ICP-fit lead rate) for early reads, explicitly labeled as leading.

15. **Churn analysis that starts at the cancellation.**
    *Looks like:* "reduce churn" project interviews churned customers, adds a cancellation-flow discount, saves 4% of cancellations; churn barely moves because the causes were onboarding failure (never activated) and champion departure — both determined months earlier.
    *Detection:* churned-cohort usage curves show flatline from week 2 (never activated) or step-drop at a champion's departure date; save-offer acceptance high but saved-cohort re-churn within 2 quarters.
    *Prevention:* cohort churn by activation status and tenure, not aggregate; leading-indicator health model (usage depth, champion activity, support sentiment) with intervention at signal, not at cancellation.

---

## 5. Sample Task Walkthrough

**Task:** "Our demo requests are down 30% quarter-over-quarter. Fix it." — B2B SaaS, ~$40k ACV, sales-led, paid + organic + outbound motion.

**Stage 1 — Understand.** Do not accept "demo requests down" as the problem statement; it is a symptom at one funnel node. Establish the measurement first: pull demo-request counts from BOTH the marketing-automation form records and the CRM lead records for the last 3 quarters. In this scenario they disagree — forms show −30%, CRM shows −12%. That gap is the first finding: a form-to-CRM sync change, or a definition change. Check the change log. Finding: 8 weeks ago the website team consolidated three forms ("Book a demo," "Talk to sales," "Get pricing") into one "Contact us" form, and only submissions selecting "demo" in a dropdown now count as demo requests. Roughly half the drop is definitional. Report this before doing anything else — the real decline is ~12–15%, which changes the urgency and the plan.

**Stage 2 — Decompose.** Decompose the remaining real decline: demo requests = traffic × visit→request rate, by channel. Build the channel × month matrix. Results: organic traffic flat, organic conversion rate flat. Paid traffic down 35% — spend log shows Google Ads budget was cut 40% mid-quarter (finance decision nobody told marketing ops). Outbound-sourced meetings down 20% — two SDR seats vacant. Direct/brand traffic down 8%. The "marketing performance problem" is now: a definitional artifact + a budget cut + a hiring gap + a small real brand-demand softening.

**Stage 3 — Plan.** Three workstreams with pre-declared metrics and windows: (a) *Restore measurement:* re-instrument the consolidated form so all sales-intent submissions route and count consistently; backfill the definition change into all dashboards with an annotation. Metric: form-to-CRM reconciliation within ±5%. (b) *Paid recovery:* model expected demo volume at restored budget using pre-cut conversion rates; propose restoring the highest-intent campaigns first (branded and high-intent non-brand, which the cut hit indiscriminately). Kill criterion: if CPL on restored campaigns exceeds pre-cut CPL by >25% after 1,000 clicks, stop and reassess auction changes. (c) *Demand-softening check:* branded search impression volume (Search Console, not clicks — clicks are confounded by the paid cut) as the brand-demand proxy; if down >10% YoY, open a separate awareness investigation — explicitly out of scope for this sprint, logged as such (scope-fence).

**Stage 4 — Execute.** Rebuild the form routing with a hidden field preserving intent granularity; verify by submitting test entries for each intent path and confirming each lands in CRM with correct source, campaign, and lifecycle stage within 15 minutes. Draft the paid restoration plan as a one-page brief with the volume model, for the human budget owner to approve — do not assume the budget back. Annotate every affected dashboard with the definition-change date.

**Stage 5 — Verify.** Verification is specific: (1) Test submissions reconcile form→CRM at 100% across all three intent paths, checked with actual test records, not by reading the config. (2) Restated historical series published: real decline confirmed at −13% with the definitional artifact removed; both numbers shown with the annotation. (3) Two weeks post paid-restoration: demo requests from restored campaigns within 15% of the model's prediction — the model was falsifiable and survived. (4) Branded impressions: −6% YoY — below the 10% tripwire, logged as "watch, not act."

**What could go wrong, and how it's caught.** *Wrong:* declaring victory when the dashboard number recovers — half the "recovery" would be the definition fix, not new demand; caught because the restated series separates artifact from reality. *Wrong:* restoring paid budget into the same consolidated form that under-routes intent — caught because measurement was fixed FIRST (fix leaks before pouring). *Wrong:* the plausible-but-lazy answer ("rewrite the landing page copy") — caught at Stage 2, because conversion rate was flat; copy was never the failing variable, and touching it would have confounded the paid-recovery read. *Wrong:* missing the SDR gap entirely because "demo requests" sounded like a marketing metric — caught by decomposing to ALL demo sources, including sales-sourced.

**Deliverables:** restated metric series with annotation; form instrumentation fix (verified with test records); paid restoration brief with volume model and kill criterion (human approves spend); SDR-gap flag routed to sales leadership; falsification log entry: "Q3 demo decline: 55% definitional, 30% budget cut, 15% real — landing-page copy was never implicated."

---

## 6. Integration with Core Skills

**Most critical core skills for this domain:**

- **evidence-reasoning + adversarial-disproof** — the domain's spine. Every platform metric is a claim by an interested party. Before recommending budget shifts, actively construct the case that the channel's numbers are inflated (incrementality, cannibalization, attribution harvesting). Domain variation: "disproof" here means holdout logic and cross-source reconciliation, not code inspection.
- **statistical-analysis** — mandatory for every test verdict, cohort analysis, LTV:CAC computation, and forecast. Domain variation: pre-registration discipline (Principle 4), Simpson's paradox segment checks on every aggregate result, survival curves for churn rather than period churn rates.
- **root-cause-first** — funnel declines are always decomposed to the failing node before any creative or budget change (see walkthrough). Order of suspicion: tracking → audience → offer → message → channel.
- **assumption-flagging + uncertainty-handling** — attribution is irreducibly uncertain; state ranges, not point estimates ("paid social drives 15–40% of new pipeline depending on model"). Never let a single-model number travel into an exec deck unlabeled.
- **plan-gate + scope-fence** — campaign briefs are the plan gate: no asset production before the brief (audience, offer, metric, MDE, kill criterion) is confirmed. Scope-fence prevents the classic drift: "fix demo requests" ballooning into a website redesign.
- **verified-done** — "done" for a campaign = tracking verified with real test events + launch checklist complete + measurement window and read-out date scheduled. Not "assets delivered."
- **coverage-accounting** — for audits (deliverability, cannibalization, pipeline hygiene): enumerate the full population (all sending domains, all indexed URLs, all open opps) and account for every item; spot-checking misses the one blocklisted subdomain.
- **self-correction-loop** — the falsification log is the domain instantiation: every failed test/sequence/campaign recorded with evidence so the same dead end isn't re-run next quarter.
- **idea-generation** — for creative variant matrices and campaign concepts: generate wide (20+ headline candidates across named frameworks), then filter through positioning and proof constraints. Constrained divergence, not brainstorm soup.
- **multimodal-analysis + image-refinement** — ad-creative review (does the visual read at feed size, is the value prop legible in 1.5 seconds), landing-page hierarchy critique, competitor-creative teardowns.
- **document-mastery** — proposals, battle cards, QBR decks, GTM launch docs; structure by decision the reader must make, not by information available.
- **long-task-orchestration + context-budget-management** — GTM launches and ABM programs run for months across dozens of assets; maintain the single source-of-truth launch doc and per-account state rather than re-deriving context each session.

**How they combine on a typical hard task** (e.g., "reallocate $80k/mo across channels"): cartography-first (map every channel, its tracking integrity, and its attribution method) → evidence-reasoning (reconcile platform vs CRM vs blended numbers) → adversarial-disproof (attack each channel's claimed contribution) → statistical-analysis (incrementality estimates with uncertainty ranges) → assumption-flagging (label every unverifiable assumption in the reallocation model) → plan-gate (human approves the shift; staged rollout with kill criteria) → verified-done (blended CAC and pipeline tracked against pre-registered predictions at +30/+60/+90 days).

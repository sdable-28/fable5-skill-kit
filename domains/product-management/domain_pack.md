# Product Management & Strategy — Domain Pack

Operating instructions for end-to-end product work: discovery → prioritization → roadmapping → execution → metrics → strategy. Read this before touching any PM artifact. These rules override generic behavior.

---

## 1. Domain Overview

### What makes this domain unique

Product management is decision-making under irreducible uncertainty with contested evidence. Unlike code, there is no compiler. A PRD "compiles" only when it ships and moves a metric — months after the decision. The feedback loop is slow, noisy, and confounded. This creates the domain's central pathology: **plausible-sounding artifacts substitute for validated learning.** A beautiful roadmap, a confident TAM number, a well-formatted RICE sheet — all can be complete fiction while passing every surface-level quality check.

Second uniqueness: **every artifact has a political audience.** A prioritization decision is also a message to the stakeholder whose request lost. A metric choice is also a claim about what the team will be judged on. Treat every PM artifact as simultaneously an analytical object and a communication object. Optimizing one while ignoring the other produces either correct-but-dead-on-arrival or persuasive-but-wrong.

Third: **the unit of value is a decision, not a document.** A one-page memo that kills a bad initiative is worth more than a 40-page strategy deck that changes nothing. Always identify the decision the artifact serves before producing the artifact.

### Where AI adds most value

- **Synthesis at volume**: clustering 30 interview transcripts into jobs and forces, mining support tickets for opportunity signals, competitive teardown across 15 competitors. Humans sample; AI can be exhaustive — with citation discipline.
- **Framework rigor enforcement**: humans skip steps under deadline pressure (RICE scores pulled from air, TAM copied from a Gartner headline). AI enforces the methodology every time: show the arithmetic, cite the input, flag the guess.
- **Adversarial review**: red-teaming a PRD for unstated assumptions, checking an A/B design for power before launch, finding the confound in a retention claim.
- **Consistency across artifacts**: verifying the roadmap actually derives from the strategy, the OKRs actually connect to the North Star, the acceptance criteria actually cover the user story.
- **Statistical work**: MDE calculation, power analysis, cohort curve interpretation, metric tree construction. Most PMs do this badly; do it correctly by default.

### Where AI must defer to human expertise

- **Taste and conviction calls**: when evidence is genuinely ambiguous (it often is), the final bet is the human's. Present the evidence, the options, the risks — never manufacture false certainty to force a conclusion.
- **Organizational context**: who actually holds power, which stakeholder relationship is fragile, what was promised to the board last quarter. Ask; do not assume.
- **Direct user contact**: never fabricate user quotes, invent interview findings, or simulate what "users would say." Synthesize only what exists. If no user evidence exists, say "no user evidence exists" — that statement is itself the finding.
- **Pricing and legal commitments**: flag, never finalize.

---

## 2. Core Principles

Falsifiable, checkable rules. A violation is detectable in the artifact itself.

1. **Every number carries its derivation or its confession.** No metric, market size, effort estimate, or score appears without either (a) shown arithmetic from cited inputs, or (b) an explicit `[GUESS]` / `[ASSUMPTION]` tag with the range of uncertainty. Check: search the artifact for bare numbers; each must trace to a source or a tag.

2. **Problem validation precedes solution validation, and they are never the same activity.** Evidence that users have a problem is not evidence they want your solution; evidence they say they'd use your solution is not evidence they will. Every discovery artifact labels each piece of evidence as PROBLEM-evidence or SOLUTION-evidence. Check: the labels exist; no solution mockup was shown before problem severity was established.

3. **Interview questions about the past, not the future.** "Tell me about the last time you X" is admissible. "Would you use a tool that Y?" is inadmissible as evidence (usable only as a conversation opener). Check: any interview guide contains zero hypothetical-preference questions positioned as evidence-gathering.

4. **A roadmap item without a target metric movement is a task, not a bet.** Every roadmap entry states the metric it is expected to move, the expected direction, and rough magnitude. "Ship feature X" alone is banned. Check: each roadmap row has a metric column filled in.

5. **RICE/ICE inputs are estimates with owners, not scores with vibes.** Reach comes from named data (analytics query, segment size); Impact states its causal assumption; Confidence reflects evidence tier (see verification_gates.md Gate 3); Effort comes from engineering, not the PM. Check: every score cell has a provenance note.

6. **No A/B test launches without a pre-registered MDE, power calculation, and stop date.** If the required sample exceeds available traffic, the test does not run — redesign it (bigger change, coarser metric, longer window) or make the call without a test and say so. Check: the experiment doc contains sample size math dated before launch.

7. **Every success metric ships with a guardrail metric.** Activation up is meaningless if support tickets doubled. Name the metric this initiative could damage and monitor it in the same dashboard. Check: guardrails listed adjacent to success metrics in every PRD and experiment doc.

8. **DAU/MAU/signup counts never appear without a retention or engagement-depth companion.** A growth number alone is a vanity metric. Check: any usage number in a review doc is paired with the corresponding cohort retention or frequency figure.

9. **"No" is delivered with the prioritization logic, the losing request's score, and the condition under which it would win.** Never a bare refusal, never a fake "it's on the roadmap." Check: every declined request has a written response containing all three elements.

10. **The PRD states what is out of scope with the same precision as what is in scope.** Scope creep enters through the unstated. Check: PRD has a non-empty Non-Goals section with specific excluded capabilities, not "everything else."

11. **Acceptance criteria are testable by someone who did not write them.** Each criterion is a binary check an engineer or QA can run without asking the PM what it means. "Works well on mobile" fails; "primary CTA visible without scrolling on 375px viewport" passes. Check: read each criterion; if it requires interpretation, rewrite it.

12. **Strategy documents make at least one explicit trade-off — something the org will NOT do that a competitor is doing.** A strategy that excludes nothing is a wish list. Check: the doc names abandoned options and why.

13. **Competitive analysis reports what competitors' customers say, not what competitors' marketing says.** Feature matrices from landing pages are the floor, not the deliverable. Mine reviews (G2, app stores, Reddit), churn stories, pricing-page changes over time. Check: at least half the competitive evidence cites customer-voice sources.

14. **Cohort curves, not averages.** Any retention claim is made from a cohort triangle or curve, never a blended average (which mixes cohort quality with cohort age). Check: retention statements reference a specific cohort and time index ("Week-4 retention for the March signup cohort").

15. **Declare the kill condition before the launch.** Every initiative states, in writing, what result would prove it failed and what happens then (rollback, pivot, sunset). Check: the PRD or experiment doc has a Kill Condition section signed before ship.

---

## 3. Master Framework — the 7 Stages in PM Terms

### Stage 1 — Understand
Identify the **decision** the work serves, not the artifact requested. "Write a PRD for feature X" hides the real question: has X's problem been validated, and is X the right solution? Surface it.
- Ask: What decision does this artifact inform? Who makes it? By when? What's the reversibility (one-way vs two-way door)?
- Ask: What evidence already exists? (Prior research, analytics, support data, past experiments.) Never re-derive what the org already knows.
- Ask: Who are the stakeholders, what do they each want, and where do they conflict?
- Domain tools: JTBD job statement drafting ("When [situation], I want to [motivation], so I can [outcome]"), stakeholder map, decision one-pager.
- Gate: restate the decision and success criterion back to the requester before producing anything. If they say "just write the doc," write the doc — but flag the unvalidated assumption in it.

### Stage 2 — Decompose
Break the problem into the **opportunity solution tree**: desired outcome → opportunities (unmet needs, pains) → candidate solutions → assumption tests. Never jump outcome→solution.
- Separate the question stack: Is the problem real? Is it frequent/severe? Is it ours to solve? Is this solution desirable / viable / feasible / usable? Each layer gets its own evidence.
- For metrics work: decompose the North Star into a metric tree (inputs the team can act on → the output metric). For strategy: decompose into Where-to-play / How-to-win / Capabilities / Management-systems.
- Domain tools: opportunity solution tree, metric tree, assumption mapping (desirability/viability/feasibility/usability grid), story map (backbone = user journey, ribs = tasks, slices = releases).
- Gate: every leaf of the decomposition maps to either existing evidence or a named test. Unmapped leaves are declared unknowns.

### Stage 3 — Plan
Sequence by **risk retired per unit cost**, not by stakeholder loudness or build order. The riskiest assumption gets the cheapest adequate test first.
- Choose the validation instrument per assumption: interview (problem existence), fake door / landing page (demand), concierge / Wizard-of-Oz (solution fit), prototype test (usability), A/B test (impact at scale). Do not use an expensive instrument where a cheap one suffices.
- For roadmaps: Now/Next/Later with confidence decaying rightward. Now = committed with dates; Next = validated direction, no dates; Later = hypotheses. Refuse to attach dates to Later items — that refusal is a deliverable, defend it.
- Domain tools: riskiest-assumption test (RAT) matrix, RICE with provenance, capacity-vs-commitment check with engineering.
- Gate: the plan states what each step will prove or disprove, and what happens on each branch. A plan with no disprove-branch is theater.

### Stage 4 — Execute
Produce artifacts that are decision-grade: PRDs, interview syntheses, experiment designs, roadmaps, strategy memos.
- PRD order of construction: Problem & evidence → Goals/metrics + guardrails → Non-goals → User stories with acceptance criteria → Open questions → Kill condition. Write the metrics section before the solution section; if you can't, the initiative isn't ready for a PRD.
- User stories: "As a [specific persona], I want [action], so that [outcome]" — the persona is a researched segment, not "user." Acceptance criteria in Given/When/Then, each binary-testable.
- Cross-functional: engineering sees the PRD before it's "final"; design sees the problem before the solution; data reviews the metric definitions; a dependency list names owning teams and dates.
- Domain tools: PRD template (common_patterns.md P3), Given/When/Then, dependency register, Definition of Done checklist.
- Gate: an engineer can estimate from it, a designer can explore from it, an analyst can instrument from it — without a meeting.

### Stage 5 — Verify
Run the domain gates (verification_gates.md) against the artifact BEFORE it circulates.
- Numbers audit: every figure has provenance or a tag (Principle 1).
- Evidence audit: problem vs solution evidence labeled; no future-hypothetical quotes used as demand evidence.
- Statistical audit: any experiment has MDE/power/duration math; any retention claim is cohort-based; any lift claim addresses novelty effects and seasonality.
- Alignment audit: roadmap → strategy → company OKR chain is unbroken; each roadmap item names its metric.
- Political audit: read the artifact as each key stakeholder; identify where it will be attacked; pre-answer or explicitly concede.
- Domain tools: gates checklist, adversarial read ("what would the strongest skeptic in the room say"), pre-mortem.

### Stage 6 — Self-Correct
When evidence contradicts the artifact, the artifact changes — visibly.
- Maintain a decision log: date, decision, evidence at the time, expected result, actual result. When a bet fails, log the falsification; do not silently reshuffle the roadmap.
- Distinguish correction types: wrong problem (kill the line), wrong solution (return to opportunity tree), wrong sizing (re-estimate and re-rank), wrong metric (fix the tree, re-baseline).
- Never retro-fit the goal to the result ("we shipped it, engagement is flat, but really it was a platform investment"). If it was a platform investment, that was written down before launch or it wasn't one.
- Domain tools: decision log, falsification register, retro template keyed to the original success criteria.

### Stage 7 — Iterate
Feed outcomes back into the system, not just the backlog.
- Post-launch: compare actual metric movement to the PRD's prediction. Publish the delta. Update the team's Impact-estimation calibration (are we systematically 3x optimistic? Adjust future RICE Impact accordingly).
- Post-experiment: winning variants get a holdback or follow-up cohort check before "win" enters the narrative; losing variants get a documented learning, not deletion.
- Quarterly: re-derive the roadmap from the outcome targets. Items that survived three quarters without shipping or dying get forced adjudication.
- Domain tools: calibration ledger (predicted vs actual impact), quarterly roadmap re-derivation, sunset review.

---

## 4. Pitfalls Checklist

1. **Roadmap Theater**
   - Looks like: a Gantt-styled 4-quarter roadmap with feature names and dates, presented to the board, while the team's actual sprint boards contain 60% unlisted work (bugs, migrations, sales escalations).
   - Detection: diff the roadmap against the last 3 sprints' completed tickets. Overlap below ~70% = theater.
   - Prevention: Now/Next/Later with explicit capacity allocation (e.g., "25% reserved for KTLO/unplanned"); roadmap reviewed against actual sprint output monthly; dates only in Now.

2. **Vanity Metric Anchoring**
   - Looks like: "We hit 100k signups this quarter" as the headline; Week-4 retention is 6% and unmentioned. Team optimizes signup CTAs while the product leaks.
   - Detection: any growth number presented without its retention/depth companion (Principle 8). Ask "of the users acquired 30 days ago, how many are active today?" — if the room doesn't know, anchored.
   - Prevention: dashboard pairs every acquisition metric with the matching cohort retention; North Star chosen as a value-exchange metric (e.g., weekly active teams completing a core action), not a volume metric.

3. **HiPPO Prioritization Laundering**
   - Looks like: the VP wants feature X; the PM writes a RICE sheet where X's Confidence is 100% and Impact is 3 ("massive") with no evidence, so X ranks #1 "objectively."
   - Detection: score distribution audit — items requested by senior stakeholders cluster at high Confidence despite thin evidence tiers; scores were filled in after the ranking was already decided (check doc history/order).
   - Prevention: Confidence is mechanically bound to evidence tier (Gate 3); scores are entered by named owners before the ranking meeting; the sheet records who provided each input. If the exec overrides, record it as an explicit strategic override — that's legitimate and honest; laundering is not.

4. **Feature Factory Drift**
   - Looks like: velocity is celebrated, 14 features shipped last quarter, zero have post-launch impact reviews; success = "shipped on time."
   - Detection: count features shipped in the last 2 quarters vs post-launch metric reviews conducted. Ratio worse than ~1:1 = factory.
   - Prevention: no initiative closes at ship; it closes at the 30/60-day impact review against the PRD's predicted movement (Stage 7). Make "impact review completed" part of Definition of Done.

5. **Leading-Question Discovery**
   - Looks like: "Don't you find it frustrating when exports take forever? Would a one-click export help?" — user says yes (people are polite), PM reports "8/10 users validated the need."
   - Detection: read the interview guide; any question containing the proposed solution or a suggested emotion is contaminated. Transcript check: interviewer talks >30% of the time.
   - Prevention: guide built exclusively from past-behavior prompts ("Walk me through the last time you exported data. What did you do next?"); pilot the guide on one interview and audit before running ten.

6. **Top-Down TAM Fabrication**
   - Looks like: "The global HR software market is $32B (Gartner); if we capture 1% that's $320M." No connection between the Gartner category and the actual buyer.
   - Detection: the SOM has no bottom-up counterpart (number of reachable accounts × realistic ACV × plausible win rate); the "1%" has no mechanism.
   - Prevention: require bottom-up sizing as primary (skill: market-sizing-defensible), top-down only as a sanity cross-check; the two must reconcile within ~3x or the discrepancy is investigated in the doc.

7. **Solution Validation Masquerading as Problem Validation**
   - Looks like: PM shows a prototype in the first 5 minutes of every interview; all subsequent "pain" discussion is anchored on the prototype. Report claims the problem is validated.
   - Detection: interview structure — was the solution revealed before problem severity was independently established? Are all pain quotes phrased in the solution's vocabulary?
   - Prevention: split sessions (problem interviews and solution tests are separate studies with separate participants) or hard-order the guide: no artifact shown until problem section complete and severity scored.

8. **Peeking / Optional Stopping on Experiments**
   - Looks like: A/B test planned for 4 weeks; at day 6 the variant is +8% significant at p=0.03; PM ships it. Effect evaporates in the next month's numbers.
   - Detection: was the stop earlier than the pre-registered date without a sequential-testing correction? Was there a pre-registered date at all?
   - Prevention: pre-registered sample size and stop date in the experiment doc (Principle 6); if early stopping is desired, use a sequential design (e.g., alpha-spending) declared upfront; dashboard hides significance stars until the stop date.

9. **Novelty-Effect Win Claims**
   - Looks like: new onboarding flow shows +12% activation in week 1; declared a win; by week 6 the lift is +1%. The "win" is in three exec decks.
   - Detection: was the effect measured on a cohort long enough to cover the novelty window? Is there a holdback group still running?
   - Prevention: minimum measurement window keyed to the metric's natural cycle; keep a 5-10% holdback for 4+ weeks post-ship; report the time-series of the effect, not a single snapshot.

10. **Outcome-Washing an Output Roadmap**
    - Looks like: the same feature list as last quarter, but each item now has a metric pasted next to it post-hoc ("Dark mode → engagement"). The features were chosen first; metrics were decoration.
    - Detection: ask "if this metric target could be hit without this feature, would we still build it?" and "what else did we consider for this outcome?" — no answer means washed.
    - Prevention: roadmap construction order is enforced: outcome targets first, opportunity list per outcome second, solution candidates third (Stage 3). The doc shows the discarded candidates.

11. **Acceptance-Criteria Vagueness Debt**
    - Looks like: story reads "user can easily manage notifications." Engineering builds a settings page; PM expected granular per-channel mute; QA passes it; users file bugs; the sprint after next is rework.
    - Detection: read criteria as a hostile literalist — can two reasonable engineers build different things that both "pass"? Then it's vague.
    - Prevention: Given/When/Then with concrete values (Principle 11); PM+eng+QA review criteria at sprint planning, not at demo.

12. **Dependency Discovery at Demo Time**
    - Looks like: feature needs the platform team's new API; nobody told the platform team; the "done" feature waits 6 weeks behind their queue.
    - Detection: PRD has no dependency register, or the register lists teams that never acknowledged.
    - Prevention: dependency register with named owner, acknowledgment date, and delivery date per dependency — acknowledgment means the owning team wrote "yes, scheduled" — before the initiative enters a sprint.

13. **Strategy-as-Wish-List**
    - Looks like: strategy deck lists "delight customers, expand enterprise, grow PLG motion, win SMB, expand internationally" — every option, no trade-off, no capability argument.
    - Detection: apply Principle 12 — does the strategy name anything it will NOT do? Does it say why the org can win where it chooses to play (moat: network effects, switching costs, scale, brand, counter-positioning)?
    - Prevention: force Where-to-play/How-to-win structure; require a named moat mechanism and a named abandoned market; run Five Forces to check the chosen arena isn't structurally profitless.

14. **Fake "It's on the Roadmap" Deferrals**
    - Looks like: sales asks for SSO for a $200k deal; PM says "it's on the roadmap" to end the meeting; it isn't; three months later the same request returns with the deal lost and trust burned.
    - Detection: count "roadmap" promises made in stakeholder meetings vs items actually on the roadmap.
    - Prevention: use the structured decline (Principle 9 / common_patterns.md P5): here's the current ranking, here's where your request scored and why, here's what evidence or business change would re-rank it. Costs 5 minutes, preserves the relationship and the truth.

15. **Averaged-Away Retention Collapse**
    - Looks like: blended monthly retention looks flat at 35% while every new cohort is worse than the last — old loyal cohorts mask the decay. By the time the blend moves, six bad cohorts are locked in.
    - Detection: is the retention number a blend? Plot the cohort triangle; compare Week-4 retention across the last 6 monthly cohorts.
    - Prevention: cohort-first reporting (Principle 14); alert on cohort-over-cohort degradation, not blended level.

---

## 5. Sample Task Walkthrough

**Task:** "Sales says we're losing enterprise deals because we lack SSO/SAML. The CRO wants it committed this quarter. Evaluate and decide."

This is the canonical PM trap: an urgent, plausible, exec-sponsored feature request with anecdotal evidence. Run the full loop.

**Understand.** The requested artifact is a commitment; the actual decision is "is SSO the highest-value use of ~2 engineer-months this quarter, and is the lost-deals claim causally real?" Stakeholders: CRO (wants deal velocity), CTO (owns the auth roadmap — SSO touches their identity work), current roadmap owners (whose items SSO would displace). Reversibility: building SSO is a two-way door technically but a one-way door on quarter capacity. Ask the CRO's team for the actual lost-deal list before any analysis — not the anecdote, the CRM export.

**Decompose.** The claim splits into testable parts: (a) how many deals in the last 2 quarters cited SSO as a loss reason — and was it THE reason or A reason (deals cite 3+ reasons; SSO is an easy no-blame answer for reps); (b) how many open-pipeline deals have SSO as a stated requirement, at what ACV; (c) how many would have been lost anyway (price, missing core features); (d) what does SSO cost to build (engineering estimate, not mine); (e) what does it displace.

**Plan.** Cheapest evidence first: CRM loss-reason export (1 hour), then 15-minute calls with the 3 reps on the largest cited losses (half a day), then win/loss call recordings if they exist. Only then the RICE comparison against the displaced items.

**Execute.** The CRM export shows 11 deals in 2 quarters tagged "missing SSO," total ACV $840k. Adversarial pass on the data: 4 of the 11 also cite price >30% above competitor — SSO was likely not decisive. 2 were startups under 50 seats — SSO demand there is a checkbox, not a blocker; verify with the rep. Rep calls confirm 5 deals (~$510k ACV) where security review was the explicit kill point and SSO/SAML+SCIM was the named gap. Pipeline check: 9 open opportunities ($1.1M) have SSO in the security questionnaire. Engineering estimate: SAML + SCIM provisioning + audit logging (enterprise buyers require the bundle — scoping SSO alone is a classic under-scope) = 2 engineers × 6 weeks. RICE it against the two items it displaces, with provenance on every cell: Reach = 9 pipeline accounts + ~10/quarter run-rate (CRM), Impact = enables ~$500k+/yr ACV (discounted for other loss reasons: apply 60% causal weight, tagged `[ASSUMPTION: causal weight 0.6, from rep interviews]`), Confidence = 0.8 (direct buyer statements in security reviews = Tier 1 evidence), Effort = 12 eng-weeks (engineering's number). It ranks #1 against the displaced items — legitimately, not laundered.

**Verify.** Run the gates: every number traced (CRM export attached, rep call notes linked, eng estimate in writing). Guardrail check: SSO work displaces the activation-flow experiment — write down the predicted cost (activation improvement delayed a quarter, est. impact and its owner informed). Kill condition drafted: "if <3 of the 9 pipeline deals convert citing SSO within 90 days of launch, the causal model was wrong — feed that into future sales-request weighting." Political audit: the CRO gets what they want, so the risk is the displaced item's sponsor — pre-brief them with the comparison sheet before the decision meeting, not during.

**What could go wrong and how it's caught.** (1) Loss reasons are rep-reported and self-serving — caught by cross-checking against price/feature co-citations and by reading the actual security questionnaires, not the CRM tag. (2) Under-scoping — caught by asking engineering to estimate the enterprise bundle (SAML+SCIM+audit), not "SSO"; if only SAML had been estimated, the quarter commitment would have been fiction. (3) The commitment becomes roadmap theater — prevented by putting SSO in Now with a date only after the eng estimate, and moving the displaced item visibly to Next with a written note to its stakeholders. (4) Post-ship, nobody checks — prevented because the kill condition and 90-day review are in the decision doc, and Definition of Done includes the impact review.

**Self-Correct / Iterate.** At day 90: 4 of 9 pipeline deals closed citing SSO ($470k). Prediction was ~$500k at 0.6 causal weight — calibration ledger says sales-cited blockers at Tier-1 evidence run ~true; future requests with the same evidence tier keep Confidence 0.8. Log the decision, the prediction, and the actual in the decision log. The output is not "we shipped SSO" — it is "sales-blocker requests with security-review documentation are trustworthy at 0.8; ones with only CRM tags are not," which improves every future prioritization.

---

## 6. Integration with Core Skills

**Most critical core skills for this domain:**

- **evidence-reasoning** — the backbone. Every PM claim gets an evidence tier (see Gate 3). Domain variation: evidence about humans decays and is reactive — a 9-month-old interview study is stale, and users' stated preferences are systematically unreliable vs revealed behavior. Weight behavioral > stated, recent > old, paid > free.
- **assumption-flagging** — mandatory on all quantitative artifacts (Principle 1). Domain variation: assumptions in PM artifacts are often social ("legal will approve," "platform team has capacity") — flag those with the same rigor as numeric ones.
- **adversarial-disproof** — run against every "validated" claim before it circulates. Domain variation: the standard attacks are known — confirmation-biased interviews, novelty effects, survivorship in feedback (churned users don't file tickets), HiPPO laundering. Attack with this specific list, not generically.
- **statistical-analysis** — owns experiment design (MDE, power, sequential testing), cohort analysis, and metric-movement claims. Domain variation: business tempo pressures toward peeking and early calls; the skill's job is to make the cost of the shortcut explicit, then let the human choose with eyes open.
- **plan-gate** — no PRD before problem validation passes; no experiment before power math passes; no roadmap commitment before capacity check passes. The gates in verification_gates.md are the concrete gate contents.
- **scope-fence** — maps to Non-Goals sections and MoSCoW Won't-haves. Domain variation: in PM the fence must be socialized, not just written — a Non-Goal a stakeholder never saw is a future escalation.
- **uncertainty-handling** — PM decisions are bets; present them as bets with explicit confidence and reversibility class (one-way vs two-way door). Never collapse a 60/40 call into a confident recommendation without labeling it.
- **root-cause-first** — when a metric drops, decompose the metric tree before proposing fixes (mix shift? seasonality? instrumentation? actual behavior change?). When a feature request arrives, find the job behind it before evaluating the feature (the SSO walkthrough: the job was "pass security review," which scoped the bundle).
- **hypothesis-before-read** — before mining transcripts/tickets/analytics, write down what you expect and what would surprise you; otherwise synthesis becomes confirmation. Pairs with jtbd-interview-synthesis skill.
- **coverage-accounting** — for discovery: which segments were interviewed and which weren't (enterprise vs SMB, churned vs active); for competitive analysis: which competitors and sources covered. State coverage gaps in the artifact.
- **idea-generation** — solution ideation on the opportunity tree; generate wide before RICE narrows. Constraint: ideas attach to a validated opportunity node, never free-float.
- **long-task-orchestration / context-budget-management** — discovery programs and quarterly planning span weeks; maintain the decision log and evidence register as durable state so synthesis doesn't restart from zero.
- **document-mastery** — PRDs, strategy memos, board decks are the delivery vehicles; structure per common_patterns.md templates.

**How they combine on a typical flow:** feature request → root-cause-first (find the job) → hypothesis-before-read + evidence-reasoning (mine existing data) → adversarial-disproof (attack the demand claim) → statistical-analysis (size the impact honestly) → plan-gate (is it validated enough to build?) → scope-fence (PRD non-goals) → verified-done (impact review at 30/60 days, not at ship).

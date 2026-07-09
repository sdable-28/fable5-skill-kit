# Domain Pack — Business Analysis & Strategy Consulting

Operating instructions for strategic analysis, business problem framing, and structured recommendation development. Read this pack in full before starting any engagement-shaped task: market entry, growth strategy, cost transformation, make/buy/partner, pricing, competitive response, business case, org strategy.

---

## 1. Domain Overview

### What makes this domain unique

Strategy work has no compiler. Nothing red-underlines a wrong problem statement, a non-MECE decomposition, or a recommendation the client cannot execute. The failure signal arrives months later as a failed initiative — long after the analysis shipped. Every verification mechanism must therefore be built into the process itself, because the environment provides none.

Three structural properties dominate:

1. **The problem statement is the highest-leverage artifact.** A wrong problem definition invalidates everything downstream at zero marginal cost of detection. "How do we grow revenue?" and "How do we grow profitable revenue without breaking the sales org?" produce different issue trees, different analyses, and different answers. Wrong problem definition is the most expensive mistake in this domain — more expensive than any analytical error, because analytical errors get caught in review and problem-definition errors do not.
2. **Evidence is asymmetric and gameable.** Financial data is precise but backward-looking. Interviews are forward-looking but politically distorted (people describe the org they wish existed, or the one that protects their budget). Market data is external but often stale or definitionally mismatched (TAM figures that include segments the client cannot serve). Every synthesis must weight sources by their distortion profile, not their precision.
3. **The deliverable is a decision, not a document.** The output is only correct if a specific named decision-maker can act on it: it must fit their authority, their risk tolerance, their organization's change capacity, and this quarter's constraints. An analytically perfect recommendation the client cannot execute is a wrong answer.

### Where AI adds most value

- **Decomposition discipline at speed.** Building full MECE issue trees, enumerating hypotheses, and stress-testing branch coverage in minutes instead of days. Humans skip branches under time pressure; do not.
- **Exhaustive scenario and sensitivity work.** Running every sensitivity, every scenario permutation, every break-even calculation. Human analysts sample; compute the full grid.
- **Framework-fit auditing.** Checking whether a chosen framework actually matches the question (Five Forces answers "is this industry attractive," not "why are we losing share to one competitor").
- **Internal-consistency verification.** Cross-checking that the exec summary, the financial model, and the appendix all state the same numbers and the same answer. Decks routinely contradict themselves; catch it mechanically.
- **Adversarial review.** Playing the skeptical partner, the hostile CFO, the defensive division head — before the real ones do.

### Where to defer to human expertise

- **Political and relational context.** Which stakeholder killed the last three strategy efforts, what the CEO privately promised the board, which sacred cows are genuinely untouchable. Ask; never infer.
- **Ground truth about the client's actual operations.** Interview data, plant visits, sales-call shadowing. Flag every place where analysis rests on an operational assumption no one has verified in the field.
- **Risk appetite and value trade-offs.** Whether to bet the company, accept a 30% chance of a $50M loss, or exit a legacy business employing 2,000 people. Frame the trade-off precisely; do not make the call.
- **Data that does not exist in provided materials.** Never fabricate market sizes, growth rates, competitor financials, or benchmarks. Mark every unverifiable number as an assumption with a stated source requirement.

---

## 2. Core Principles

Each principle is falsifiable: a reviewer can check compliance against the artifact.

1. **No analysis before a testable problem statement.** The problem statement must name: the decision to be made, the decision-maker, the time horizon, the success metric, and the constraints. If any of the five is missing, stop and obtain it. Check: point to all five elements in one paragraph at the top of the work product.

2. **State the answer before completing the analysis — then try to kill it.** Work hypothesis-led: form a day-one answer, structure analysis to falsify it, and record what evidence would change it. Check: a written hypothesis with explicit falsification criteria exists before any data work.

3. **Every decomposition passes the MECE audit or is labeled non-MECE with the overlap named.** Test mutual exclusivity (can one fact land in two branches?) and collective exhaustion (name a scenario outside all branches — if you can, the tree is incomplete). Check: audit note attached to every tree.

4. **Frameworks are selected by question type, never by familiarity.** Before applying any framework, write one sentence: "The question is X; this framework answers questions of type Y; X is of type Y because Z." If the sentence cannot be completed honestly, the framework is wrong. Check: the fit sentence exists.

5. **Every number carries a source tag: FACT (from provided data, cite location), DERIVED (show calculation), or ASSUMPTION (state basis and sensitivity).** An untagged number is a defect. Check: scan any table — every cell traceable.

6. **Three scenarios minimum, with named assumption deltas.** Base, optimistic, pessimistic — and the write-up states which specific assumptions differ between scenarios and why those values were chosen. Scenarios that differ only by "±20% on revenue" are decoration, not analysis. Check: an assumption-delta table exists.

7. **Every financial recommendation survives its own sensitivity analysis.** Identify the two or three variables the answer is most sensitive to; report the break-even value of each ("the deal is NPV-negative if churn exceeds 7.2%"). If the recommendation flips within the plausible range of a key variable, say so in the executive summary, not the appendix. Check: break-even values stated for top drivers.

8. **Answer first, always.** The executive summary contains the complete recommendation, the top three supporting reasons, and the key risk — readable standalone in 60 seconds without opening anything else. "See slide 3" in an executive summary is a defect. Check: hand the summary alone to someone; they can state the recommendation and why.

9. **One slide, one message; the message is the title.** Every exhibit's title is a full sentence stating the takeaway ("Churn is concentrated in customers acquired through paid channels"), never a label ("Churn Analysis"). Check: read only the titles in sequence — they must narrate the full argument.

10. **Every data point gets a so-what or gets cut.** A fact without an implication is noise. For each exhibit, complete: "This means the client should ___." If the blank cannot be filled, delete the exhibit. Check: no orphan facts in the final product.

11. **No recommendation without an implementation path.** Every recommendation names: first 90 days of actions, owner role, required capabilities the client does/doesn't have, change-management burden, and the leading indicator that shows it is working or failing. "Pursue adjacent markets" is not a recommendation; it is a topic. Check: implementation section exists with all five elements.

12. **Directionally right now beats precisely right later.** When data is incomplete, produce the answer with stated confidence bounds and a list of which missing data would change it — never stall for perfect data. But never present a bounded estimate as precise: "$40–70M, most likely ~$55M" is honest; "$54.7M" from the same inputs is fabrication. Check: precision of stated numbers matches precision of inputs.

13. **Interview and stakeholder evidence is triangulated, never taken solo.** Any claim resting on a single interview is tagged "single-source — verify." Claims that survive only inside one department are treated as that department's position, not fact. Check: source count on every qualitative claim.

14. **Competitor and market claims must pass the "so could they" test.** Any strategy that a competitor can copy in one quarter is not a strategy; it is a feature. State explicitly why the recommended position is defensible (asset, capability, cost position, network, regulatory) or label it as temporary. Check: defensibility paragraph exists.

15. **The counter-case ships with the case.** Every final recommendation includes the strongest argument for the leading alternative and why it lost. If the counter-case section is weak or strawmanned, the recommendation has not been stress-tested. Check: a skeptical reader finds their objection already addressed.

---

## 3. Master Framework — the 7 Stages in This Domain

### Stage 1 — Understand
**Goal: a signed-off problem statement, not a topic.**
- Extract the decision, decision-maker, horizon, metric, constraints from the request. If the request is a topic ("look at our pricing"), convert it to a decision ("should we move from per-seat to usage-based pricing in the next 12 months, and if so how?") and confirm the conversion with the requester before proceeding.
- Run the **five-whys on the stated problem**: ask why this problem, why now, what happens if nothing is done, who loses if it's solved. This surfaces whether the stated problem is the real problem (see skill: `problem-reframing`).
- Inventory available evidence: what data exists, what is provided, what is claimed but unverified. Classify every input as FACT / CLAIM / ASSUMPTION at intake.
- Identify the audience's decision style: numbers-first CFO, narrative-first CEO, consensus board. This determines the communication architecture later — capture it now.
- **Tools at this stage:** SCQA framing (Situation-Complication-Question-Answer), stakeholder map, problem-statement template, five-whys.

### Stage 2 — Decompose
**Goal: a MECE issue tree with hypotheses on every branch.**
- Build the issue tree from the problem statement, not from a favorite framework. Choose the cut that matches the question: profit trees for profitability, value-chain cuts for cost, customer-journey cuts for growth, buy/build/partner for capability gaps.
- Run the MECE audit on every level (see skill: `issue-tree-mece`).
- Attach a hypothesis and a required-evidence spec to every leaf: "Hypothesis: churn is driven by onboarding failure. Evidence to confirm/kill: churn cohorts by onboarding completion."
- Prune ruthlessly: kill branches that cannot change the answer even if fully analyzed. Time spent on non-decisive branches is the domain's version of gold-plating.
- **Tools at this stage:** issue trees, hypothesis trees, profit/ROIC driver trees, 80/20 prioritization of branches.

### Stage 3 — Plan
**Goal: an analysis plan where every workstream maps to a branch and a deadline.**
- For each surviving branch: name the analysis, the data required, the owner, the output exhibit, and the kill criterion (what result closes this branch).
- Sequence by decisiveness: run the analysis most likely to kill the leading hypothesis first, not the easiest one. Front-load the analyses that could invalidate the whole direction.
- Pre-draft the storyline as a **ghost deck**: dummy slide titles forming the complete argument with empty exhibits. If the ghost deck cannot be drafted, the problem is not yet understood — return to Stage 1.
- Set the analysis-paralysis guard: a decision date after which the answer ships with whatever confidence bounds are achievable.
- **Tools at this stage:** ghost/dummy decks, analysis-plan matrix (branch → analysis → data → exhibit), decision deadline.

### Stage 4 — Execute
**Goal: analyses that are decision-grade, not academically complete.**
- Run analyses to the precision the decision requires, no further. A make/buy decision with a 3x cost gap does not need cost estimates to the third decimal.
- Tag every number FACT/DERIVED/ASSUMPTION as it enters the model. Retro-tagging never happens; do it inline.
- Build financial models with a separate, visible assumptions block — never hardcode an assumption inside a formula.
- For every framework applied, write the fit sentence (Principle 4) before filling it in.
- Log surprises: any result that contradicts the working hypothesis goes in a running "evidence against" list. This list is the raw material for Stage 6.
- **Tools at this stage:** unit-economics stack (LTV, CAC, payback, contribution margin), DCF with sensitivity tables, benchmarking with explicit comparability notes, framework battery (Five Forces, Value Chain, BCG, Ansoff, 7-S, JTBD, Blue Ocean, Balanced Scorecard) applied only on fit.

### Stage 5 — Verify
**Goal: the recommendation survives the gates in `verification_gates.md` before anyone sees it.**
- Run the full gate battery: problem-statement traceability, MECE audit, number-source audit, sensitivity survival, storyline test (titles-only read), exec-summary standalone test, implementation-path completeness, counter-case strength.
- Cross-foot everything: exec summary numbers = model numbers = appendix numbers. Check totals, check that percentages sum, check that the base year matches across exhibits.
- Sanity-check magnitudes against known anchors: does the projected market share imply the client outgrows the market? Does the cost saving exceed the addressable cost base? Does the NPV exceed the company's market cap? Absurdity checks catch more errors than re-derivation.
- **Tools at this stage:** verification gates, cross-footing checklist, magnitude anchors, the "so could they" defensibility test.

### Stage 6 — Self-Correct
**Goal: the strongest attack on the recommendation is run by you, before the client runs it.**
- Adopt three adversarial personas in sequence: the **hostile CFO** (attacks every assumption's value), the **defensive operator** (attacks implementability: "you clearly haven't seen our plant"), the **skeptical board member** (attacks the framing: "why is this even the question?"). Write their strongest objections and answer or concede each.
- Revisit the "evidence against" log from Stage 4. If contradicting evidence was rationalized rather than resolved, resolve it now or downgrade confidence.
- Check for motivated reasoning: did the answer stay identical to the day-one hypothesis despite surprises? Unchanged answers after surprising evidence are a red flag, not a sign of prescience.
- If a gate fails or an attack lands, loop back to the specific stage that produced the defect — a broken problem statement goes to Stage 1, a broken model to Stage 4. Never patch at the deck level what is broken at the analysis level.
- **Tools at this stage:** pre-mortem ("it is 18 months later and this strategy failed — why?"), red-team personas, assumption-kill list.

### Stage 7 — Iterate
**Goal: the answer sharpens with each pass; the process improves for next time.**
- Iterate at the storyline level first (does the argument hold?), then the exhibit level (does each exhibit earn its place?), then polish. Never polish a broken storyline.
- After delivery: record which assumptions were later validated or broken, which analyses were decisive vs. wasted, which stakeholder objections were predicted vs. missed. Feed this into the next engagement's Stage 1.
- Maintain a personal falsification log for the domain: frameworks that misfired, market-sizing methods that overshot, interview signals that proved political. Do not repeat killed approaches.
- **Tools at this stage:** storyline review, exhibit cull, post-decision review template.

---

## 4. Pitfalls Checklist

1. **Solving the stated problem instead of the real problem.**
   *Example:* Client asks "help us cut SG&A 15%." Real driver: an activist investor demanding margin parity with a peer whose margins come from product mix, not SG&A. The cost cut ships, margins barely move, the activist escalates.
   *Detection:* The stated problem has no stated "why now." No one can articulate what triggered the request or what happens if it's ignored.
   *Prevention:* Run five-whys and the trigger question ("what happened in the last 90 days that made this urgent?") before accepting any problem statement. Invoke `problem-reframing` on every new engagement.

2. **Framework-first analysis (framework without problem fit).**
   *Example:* Asked why the client is losing share to one specific competitor, the analysis opens with Porter's Five Forces — an industry-attractiveness tool that says nothing about a head-to-head share battle. Twenty pages later, no answer.
   *Detection:* The framework's output does not change the recommendation. Removing the framework section loses nothing.
   *Prevention:* Write the fit sentence (Principle 4) before applying any framework. If the question is "why are we losing to X," the tool is a head-to-head comparison on the buying criteria that decide deals — not an industry scan.

3. **Fake-MECE decomposition.**
   *Example:* Revenue decline decomposed into "pricing, competition, market, execution" — a fact like "competitor undercut our price" lands in three branches at once; the analysis triple-counts the same cause and the workstreams collide.
   *Detection:* The same interview quote or data point is cited in multiple branches. Two workstreams request the same data cut.
   *Prevention:* MECE audit at every tree level: assign five real facts to branches; any fact fitting two branches fails the tree. Prefer arithmetic cuts (price × volume; volume = market × share) which are MECE by construction.

4. **Analysis paralysis dressed as rigor.**
   *Example:* A market-entry decision delayed three cycles waiting for a commissioned market study, while a competitor enters. The eventual "perfect" answer is worthless because the option expired.
   *Detection:* The list of "data we still need" grows between reviews instead of shrinking. No decision date exists.
   *Prevention:* Set the decision deadline in Stage 3. At deadline, ship the directional answer with confidence bounds and a "what would change this" list. Ask of every pending data request: "would any plausible value change the recommendation?" If no — cancel it.

5. **Untagged numbers / fabricated precision.**
   *Example:* "The opportunity is $54.7M" — built from a TAM figure of unknown vintage, an assumed 8% share, and an assumed margin. The false precision anchors the client; when the real number is $20M, credibility is gone.
   *Detection:* A number with more significant figures than its weakest input. No source tag. Sensitivity analysis absent.
   *Prevention:* Principle 5 (tag every number) and Principle 12 (precision matches inputs). Present ranges with a most-likely point, never bare points from assumed inputs.

6. **Scenario theater.**
   *Example:* Base / optimistic / pessimistic cases that are the base case ±15% on revenue with everything else frozen. The pessimistic case is still NPV-positive, so "the deal works in all scenarios" — but a real downside (key customer loss + price war) was never modeled.
   *Detection:* Scenario deltas are uniform percentages rather than named events. The pessimistic case has no narrative ("what world produces these numbers?").
   *Prevention:* Each scenario is a coherent story with named assumption changes (Principle 6). The pessimistic case must include the most plausible bad event stakeholders fear, not a haircut.

7. **Recommendation without implementation path.**
   *Example:* "Shift 30% of sales effort to enterprise accounts" — delivered to a client whose sales force has no enterprise experience, whose comp plan rewards SMB velocity, and whose CRM can't track enterprise cycles. The strategy dies in month two.
   *Detection:* The recommendation names no owner, no first-90-days, no capability gap assessment, no change-management cost.
   *Prevention:* Principle 11. Run `recommendation-implementability` on every recommendation before finalizing. If the client lacks a required capability, the build/buy/hire path for that capability is part of the recommendation.

8. **Ignoring organizational change management.**
   *Example:* A pricing restructure that is analytically sound but cuts the sales team's commission base 20% in year one. Sales sandbags the rollout; the initiative is quietly dead in six months and the data "proves" the new pricing failed.
   *Detection:* No stakeholder loses anything in the plan's own telling. The words "incentive," "compensation," or "who resists this" appear nowhere.
   *Prevention:* For every recommendation, complete the table: who wins, who loses, who can block, what changes their incentive. If someone loses and can block, the mitigation is part of the recommendation.

9. **Executive summary that defers the answer.**
   *Example:* "This deck examines three strategic options for the European business (see slide 3 for framework, slide 14 for financials)." The CEO reads one page, finds no answer, and the deck's fate is decided by whoever summarizes it verbally.
   *Detection:* The summary contains forward references, or a cold reader cannot state the recommendation after reading only the summary.
   *Prevention:* Principle 8. Write the exec summary using pyramid principle: answer, three reasons, key risk, ask. Test it standalone. Invoke `pyramid-synthesis` before drafting.

10. **Orphan exhibits (data without so-what).**
    *Example:* A beautifully formatted slide of five-year competitor revenue trends with the title "Competitor Landscape." No one knows why it's there; in the meeting it triggers a 15-minute tangent about a competitor irrelevant to the decision.
    *Detection:* The slide title is a noun phrase, not a sentence. Deleting the slide changes nothing about the argument.
    *Prevention:* Principle 9 and 10. Titles-only read of the full deck: the titles alone must make the complete argument. Any slide whose title can't be a claim gets cut or merged.

11. **Single-source load-bearing claims.**
    *Example:* The entire market-entry thesis rests on one VP's statement that "customers are begging for this." The VP is the sponsor of the initiative. Post-launch, demand is a third of projection.
    *Detection:* Trace the recommendation's critical path: any link supported by one interview, one report, or one department's data is single-sourced.
    *Prevention:* Principle 13. Triangulate every load-bearing claim across at least two independent source types (e.g., interview + transaction data; claim + external benchmark). Tag untriangulated claims visibly.

12. **TAM inflation / market-sizing without a bottom-up check.**
    *Example:* "The market is $12B" from an analyst report that includes three segments the client's product cannot serve and two geographies it won't enter. Serviceable market is $900M; the business case was built on the $12B.
    *Detection:* Only a top-down size exists. The path from TAM to the client's obtainable revenue has no named filters.
    *Prevention:* Always size twice: top-down (market reports, filtered by serviceability) and bottom-up (target customers × win rate × ACV). If they disagree by >2x, reconcile before using either. State SAM/SOM, not TAM, in the business case.

13. **Benchmark misuse.**
    *Example:* "Best-in-class SG&A is 12% of revenue" — from a benchmark set of companies with different business models (product vs. services mix), used to justify a cut target that guts the client's service organization, which is its differentiator.
    *Detection:* The benchmark set's composition is unstated. No comparability adjustment appears.
    *Prevention:* Every benchmark ships with: who is in the set, why they are comparable, and what was adjusted. If comparability can't be established, use the benchmark as a conversation-starter, never a target.

14. **Sunk-cost framing and status-quo asymmetry.**
    *Example:* Evaluating whether to continue a struggling product line, the analysis compares "continue" against its own projections but never prices the status quo's risks — the do-nothing case is silently treated as safe. Continuation wins by default.
    *Detection:* The status-quo option has no risk section. Past investment appears as an argument for continuing.
    *Prevention:* Model "do nothing" as an active scenario with its own risks, decay rates, and opportunity costs. Strike any sentence where sunk investment justifies future spend.

15. **Confusing the client's data with the client's reality.**
    *Example:* CRM data shows a 45-day sales cycle; field interviews reveal reps only enter deals at verbal-commit stage. The real cycle is 130 days. The capacity model built on 45 days over-forecasts revenue by 2.5x.
    *Detection:* Operational metrics that look too good against industry norms. Data definitions never verified with the people who enter the data.
    *Prevention:* For every load-bearing operational metric, verify the data-generating process: who enters it, when, with what incentive to distort. Flag metrics where the enterer benefits from the distortion.

---

## 5. Sample Task Walkthrough

**Task:** A $180M-revenue B2B logistics-software company asks: "Build the business case for acquiring FreightPilot, a $14M-revenue competitor, at the asking price of $70M. The board votes in three weeks."

**Stage 1 — Understand.** The request arrives as a business case, i.e., an answer already assumed. Convert it back into a decision: "Should we acquire FreightPilot at up to $70M, and if not at $70M, at what price or under what structure?" Confirm this reframe with the sponsor — it matters, because a "build the case" framing forbids a "walk away" answer, and walk-away must stay on the table. Extract the five elements: decision (acquire/negotiate/walk), decision-maker (board, three weeks), metric (shareholder value; secondarily strategic defense — ask which dominates), constraints (cash on hand $40M, debt capacity unclear — flag as required input), horizon (5-year value). Run the trigger question: why now? Answer: a PE firm is rumored to be bidding. This changes the analysis — the real question includes "what does it cost us if a PE-backed FreightPilot competes against us?" The do-nothing case is not static.

**Stage 2 — Decompose.** Issue tree, MECE by construction: Value = standalone value + synergies − integration costs − price. Branches: (1) FreightPilot standalone: is $14M revenue growing, what's churn, what's real margin after normalizing owner add-backs? (2) Revenue synergies: cross-sell into our base — how many of our 2,400 customers have the freight-broker use case? (3) Cost synergies: infrastructure, G&A overlap. (4) Defensive value: expected loss if PE buys it and invests. (5) Integration cost and risk: tech-stack merge, team retention. (6) Deal structure: price, earnout, cash/stock. MECE audit: assign five known facts to branches — each lands in exactly one. Hypothesis on each leaf, e.g., branch 2 hypothesis: "cross-sell supports ≤$8M incremental ARR by year 3; evidence: count of our customers matching FreightPilot's ICP × observed attach rates from our last product launch."

**Stage 3 — Plan.** Ghost deck drafted day one: 12 titles forming the argument, ending with a recommendation slide with three blanks (price ceiling, structure, conditions). Sequence by decisiveness: FreightPilot's churn cohort analysis first — if churn is >20%, the standalone value collapses and everything else is moot. Decision deadline: day 15, leaving five days for board-ready polish.

**Stage 4 — Execute.** DCF on standalone: data room shows $14M revenue but cohort analysis reveals gross churn of 19%, masked by one whale customer added last year (28% of revenue). Tag: FACT (data room, cohort file). This is a surprise — log it in the evidence-against list. Normalize EBITDA: reported $3.2M includes $1.1M of owner salary add-backs claimed as one-time; only $0.4M verifiable. DERIVED normalized EBITDA: $2.5M. Synergy model bottom-up: 310 of our customers match the ICP (FACT: CRM query), our historical cross-sell attach rate is 11% (FACT: last launch), ACV $45k → year-3 synergy ARR ≈ $1.5M, not the sponsor's assumed $8M. Sensitivity grid on the full model: value is most sensitive to churn, whale retention, and attach rate. Break-evens computed: the deal is value-neutral at $70M only if churn falls to 9% AND attach rate hits 25% — neither has evidentiary support.

**Stage 5 — Verify.** Gates: every number tagged; cross-foot summary vs. model — catch that the summary used pre-normalization EBITDA ($3.2M) in the multiple table; fix. Magnitude check: at $70M the client pays 5x revenue for an asset churning 19% — anchor against comparable transactions (2–3x for similar churn profiles). Titles-only read of the deck narrates: asset is strategically real but overpriced; value at disciplined assumptions is $32–41M; defensive value adds at most $8M; recommend bid ≤$45M with a $10M earnout tied to whale retention; walk above $52M.

**Stage 6 — Self-Correct.** Hostile CFO attack: "your attach rate is from a product launch, not an acquisition — integration friction makes it lower." Concede; the $1.5M synergy becomes a range ($0.8–1.5M); recommendation unchanged — strengthens it. Defensive-operator attack: "you haven't priced losing the deal to PE." Addressed in branch 4: modeled PE-owned FreightPilot taking 3 points of share over 4 years = $6–8M NPV loss — real but far below the $25M+ overpayment. Pre-mortem: the failure mode is the board's fear of the rival bid stampeding them past $52M. Counter: put the walk-away price and its rationale on the exec summary itself, so the discipline is board-visible before auction dynamics start.

**What could go wrong and how it was caught:** (a) accepting the "build the case" framing — caught by the Stage 1 reframe rule; (b) the whale-masked churn — caught because cohort analysis is mandatory before accepting any topline growth figure; (c) sponsor's $8M synergy anchor — caught by bottom-up sizing rule (12); (d) pre-normalization EBITDA in the summary — caught by cross-footing gate; (e) unpriced do-nothing risk — caught by pitfall 14's rule that status quo is an active scenario.

**Delivered:** exec summary stating: recommend pursuing at ≤$45M with earnout, walk above $52M; three reasons (churn-adjusted standalone value, evidence-based synergy ceiling, bounded defensive value); key risk (rival bid stampede) and its mitigation (pre-committed walk-away). Board can act on the summary alone.

---

## 6. Integration with Core Skills

**Most critical core skills, in priority order:**

- **root-cause-first** — the domain's Stage 1 is root-cause analysis on the request itself. Domain variation: the "bug" is the client's stated problem; run five-whys on the ask before any analysis, exactly as you would refuse to patch a symptom in code.
- **hypothesis-before-read** — maps directly to hypothesis-led consulting. Form the day-one answer before opening the data room; structure every data pull as a test. Domain variation: also pre-register what evidence would *change* the answer, because motivated reasoning is the domain's dominant failure mode.
- **adversarial-disproof** — powers Stage 6. Domain variation: run it through personas (hostile CFO, defensive operator, skeptical board member) because objections in this domain are role-specific, not generic.
- **coverage-accounting** — the MECE audit is coverage accounting applied to problem space instead of code paths. Every tree level gets an explicit "what's outside all branches?" check, logged.
- **assumption-flagging** — implements Principle 5's FACT/DERIVED/ASSUMPTION tagging. Domain variation: assumptions also carry a sensitivity note (does the answer flip within this assumption's plausible range?) — flagging without sensitivity is incomplete here.
- **plan-gate** — the ghost deck is the plan gate. No analysis executes until the storyline skeleton exists and the sponsor confirms the problem statement. Gate fails → return to Understand.
- **verified-done** — "done" means all gates in `verification_gates.md` pass, not "deck looks finished." The exec-summary standalone test and cross-footing are the domain's equivalent of running the test suite.
- **uncertainty-handling** — governs Principle 12: ranges with most-likely points, confidence stated, missing-data-that-would-change-this list attached. Never let deliverable polish imply precision the inputs don't have.
- **mathematical-reasoning / statistical-analysis** — DCF mechanics, cohort math, sensitivity grids, break-even algebra. Domain variation: statistical rigor is bounded by decision-precision needs (Stage 4) — compute the full sensitivity grid cheaply, but don't demand significance tests where a 3x magnitude gap decides the answer.
- **scope-fence** — engagement scope creep is endemic ("while you're in there, can you also look at our org?"). Fence at the problem statement: new questions become logged follow-ups, not silent expansions.
- **long-task-orchestration / context-budget-management** — multi-week engagement structure: persist the issue tree, assumption log, and evidence-against list as durable artifacts that survive context loss; every session reloads them first.
- **document-mastery** — the deliverable layer: decks, models, memos. Subordinate to pyramid-synthesis — structure before formatting, always.
- **idea-generation** — used inside Blue Ocean / option-generation steps, but always followed by the kill discipline: generate wide, then cull against the problem statement.

**Combination pattern:** root-cause-first + hypothesis-before-read open the engagement; coverage-accounting + assumption-flagging run continuously through decomposition and execution; adversarial-disproof + verified-done close it. plan-gate (ghost deck) sits between decomposition and execution as the single go/no-go checkpoint.

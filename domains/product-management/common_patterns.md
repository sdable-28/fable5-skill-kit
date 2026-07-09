# Common Patterns — Product Management & Strategy

## 1. Triaging a feature request from a large customer
**Trigger:** Sales or CS escalates a "deal-blocking" feature ask; an exec forwards a customer email; a request lands with revenue attached.
**Approach:** 1. Separate the request from the problem — ask what the customer is trying to accomplish, in their workflow terms. 2. Check the request against existing capability (often a discoverability gap, not a feature gap). 3. Count how many other customers/segments hit the same problem; pull support tickets and interview notes. 4. Score it with your standard framework (RICE) using the *problem*, not the requested solution. 5. Respond with a decision and a why — never silence, never a fake "it's on the roadmap."
**Template:** `Request: ___ | Underlying job: ___ | Requesting segment + ARR: ___ | Other evidence of same problem (n=___): ___ | RICE: R__ I__ C__ E__ = ___ | Decision: build / build-differently / workaround / no | Committed response date: ___`
**Variation to watch:** Building the literal request for one whale — you ship a bespoke feature, the customer churns anyway, and the codebase carries it forever. Solve the job, price customization separately, or say no.

## 2. Designing an A/B test for a feature change
**Trigger:** A change ships behind a flag; someone asks "did it work?"; a metric move needs causal attribution.
**Approach:** 1. Write the hypothesis as `changing X will move metric Y by Z% because MECHANISM`. 2. Pick one primary metric and 2-3 guardrails (retention, latency, revenue, complaint rate). 3. Compute MDE and required sample size from baseline rate and power (0.8) BEFORE launch; derive the run duration in whole weeks. 4. Pre-register the analysis: segments, exclusions, stop date. 5. Do not peek-and-stop; read results only at the pre-set date or with sequential-testing corrections. 6. Ship/kill on the primary metric; block ship if any guardrail regresses beyond its tolerance.
**Checklist:** `[ ] Hypothesis w/ mechanism  [ ] Primary metric + baseline  [ ] Guardrails + tolerances  [ ] MDE + sample size + duration computed pre-launch  [ ] Randomization unit stated (user/session/account)  [ ] Stop date pre-registered  [ ] No mid-test peeking-based stops  [ ] Decision rule written before results`
**Variation to watch:** Peeking daily and stopping the first day p<0.05 — this inflates false positives severalfold. Second failure: declaring victory on a secondary metric after the primary is flat (HARKing).

## 3. Writing a PRD for a validated problem
**Trigger:** Discovery has confirmed a problem worth solving; engineering needs a spec; a bet enters "Next."
**Approach:** 1. State the problem with evidence (interview quotes, funnel data) before any solution text. 2. Define success as a measurable outcome metric with target and timebox. 3. Write user stories with acceptance criteria in Given/When/Then form. 4. List explicit non-goals — what this deliberately does not do. 5. Enumerate dependencies, edge cases, and rollout plan (flag, % ramp, kill criteria). 6. Review with eng + design BEFORE it's "final"; the PRD is a conversation artifact, not a handoff contract.
**Template sections (verbatim):** `Problem & Evidence / Success Metric + Target / Non-Goals / User Stories + Acceptance Criteria / Dependencies & Risks / Rollout & Kill Criteria / Open Questions`
**Variation to watch:** The solution-first PRD — 6 pages of UI spec, one sentence of problem. Symptom: no one can say what metric moves if it ships. Rewrite the problem section from data or stop.

## 4. Running a discovery interview to validate a problem
**Trigger:** A new opportunity on the solution tree needs evidence; an assumption in the Lean Canvas is unverified; conversion data shows a drop-off you can't explain.
**Approach:** 1. Recruit 5-8 people who recently experienced the situation (not "would you ever" hypotheticals). 2. Ask about the last time it happened: "Walk me through the last time you ___." 3. Probe for workarounds, money spent, and time lost — these are severity signals. 4. Never pitch the solution or ask "would you use X?" — people lie to be polite. 5. Tag transcripts to opportunities on the solution tree; a problem is validated when ≥N independent interviewees describe the same struggle unprompted.
**Question bank (reuse verbatim):** `"Tell me about the last time you ___." / "What did you do next?" / "What have you tried to fix this?" / "What did that cost you?" / "Why was that hard?"` Banned: `"Would you use...?" / "Do you like...?" / "How much would you pay for...?"`
**Variation to watch:** Leading the witness — describing your feature then harvesting agreement. If your notes contain more of your words than theirs, the interview produced zero evidence.

## 5. Building a metric tree and picking a North Star
**Trigger:** New product area; leadership asks "what should we measure"; teams are optimizing metrics that don't connect to revenue/retention.
**Approach:** 1. Pick the North Star as the metric that captures value *delivered to users*, not value extracted (e.g., weekly active teams completing a core action — not DAU, not signups). 2. Decompose it into input metrics each team can actually move (acquisition × activation × frequency × retention). 3. Attach a guardrail to every input metric (growth input → quality guardrail). 4. Kill vanity metrics: any count that only goes up (cumulative signups, total downloads) is banned from dashboards. 5. Validate each edge in the tree with cohort data — does moving the input historically move the parent?
**Template:** `North Star: ___ (value moment: ___) | Input 1: ___ owned by ___, guardrail: ___ | Input 2: ... | Vanity metrics removed: ___ | Correlation evidence per edge: ___`
**Variation to watch:** DAU-as-North-Star — it rises with notification spam while retention curves flatten to zero. Always plot the retention curve by cohort; if it doesn't flatten above zero, growth metrics are a leaky-bucket illusion.

## 6. Saying no to a stakeholder while preserving the relationship
**Trigger:** HiPPO drops a pet feature; another team requests roadmap space; a loud voice mistakes volume for priority.
**Approach:** 1. Restate their ask and the outcome they want — prove you heard it. 2. Show the current priority stack and the scoring of their item against what it would displace ("yes to this means no to ___"). 3. Offer the cheapest alternative that serves their outcome (workaround, partner, later slot with entry criteria). 4. Name the condition that would change the answer ("if 3 more enterprise accounts hit this, it re-scores above X"). 5. Write the decision down where they can see it; invisible nos get relitigated.
**Script:** `"You're asking for ___ to achieve ___. Against our current goal of ___ it scores ___ vs ___ for what's in flight, so it doesn't make this quarter. What would change that: ___. Meanwhile, ___ gets you partway."`
**Variation to watch:** The soft yes — "we'll look into it" to avoid conflict. It converts into roadmap theater: a roadmap full of placations nobody intends to build, and trust dies when the quarter ends.

## 7. Converting an output roadmap to an outcome roadmap
**Trigger:** Roadmap review reads as a feature list with dates; teams ship everything and metrics don't move; "feature factory" complaints surface.
**Approach:** 1. For every roadmap item, force the question "what number changes if this ships?" — items with no answer get parked. 2. Rewrite rows as outcomes with a metric and target ("reduce onboarding drop-off 40% → 25%"), and demote features to candidate bets beneath them. 3. Restructure to Now / Next / Later: Now = committed outcomes with teams attached; Next = validated problems awaiting capacity; Later = directional themes, no dates. 4. Communicate the change to stakeholders with a mapping table (old promise → new outcome) so nothing looks silently dropped. 5. Review quarterly: kill bets whose metric didn't move; do not auto-roll them forward.
**Checklist:** `[ ] Every Now item has metric + target + team  [ ] No dates beyond Now  [ ] Each feature listed under an outcome, marked as a bet  [ ] Old-roadmap mapping table sent to stakeholders  [ ] Quarterly kill review scheduled`
**Variation to watch:** Outcome-washing — relabeling the same feature list with vague outcomes retrofitted to justify it ("improve engagement" above every pet feature). Test: if no bet under an outcome could ever be killed by its metric, it's still an output roadmap.

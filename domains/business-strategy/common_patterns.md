# Common Patterns — Business Analysis & Strategy Consulting

## 1. Market Entry Assessment
**Trigger:** Client asks "should we enter market/segment/geography X?" or a competitor's entry forces a response.
**Approach:** 1. Write the problem statement with decision-maker, deadline, and success metric. 2. Size the market top-down AND bottom-up; reconcile the two — a gap >2x means an assumption is broken. 3. Run Porter's Five Forces on the target market; score each force H/M/L with one evidence point each. 4. Map entry modes (build / buy / partner) against required capabilities from a Value Chain scan. 5. Build the business case per mode: 5-yr DCF, IRR, payback, with sensitivity on the 3 assumptions that move NPV most. 6. Deliver answer-first: GO/NO-GO/CONDITIONAL, then the support.
**Template:** `Decision: __ | Market size (TAM/SAM/SOM, both methods): __ | Five Forces scores + evidence: __ | Entry mode comparison table (capex, time-to-revenue, control, exit cost): __ | NPV/IRR/payback per mode: __ | Kill conditions: __`
**Variation to watch:** Sizing the market and stopping — attractiveness without "can WE win?" (right-to-win, capability gaps) is half an answer and the half clients already knew.

## 2. Profitability Decline Diagnostic
**Trigger:** Margin or profit falling over 2+ periods with no obvious single cause; "figure out why we're losing money."
**Approach:** 1. Decompose MECE: Profit = Revenue (price × volume × mix) − Costs (fixed / variable, by function). 2. Quantify each branch's contribution to the decline in dollars — the tree must sum to the total gap. 3. Benchmark the 1-2 dominant branches against competitors or prior years to separate market-wide from company-specific. 4. Form a hypothesis for each dominant branch; kill hypotheses with data before generating fixes. 5. Recommend fixes ranked by dollar impact × implementation difficulty.
**Checklist:** `[ ] Tree branches sum to total profit gap [ ] Price vs volume vs mix separated [ ] Fixed vs variable cost split done [ ] Industry-wide vs company-specific isolated [ ] Each recommendation tagged with $ impact and owner`
**Variation to watch:** Data-led drowning — pulling every report before structuring the tree. Build the tree first; pull only the data each branch demands.

## 3. Unit Economics Teardown
**Trigger:** Growth-stage business questions viability, pricing change proposed, or investor asks "does this business work at scale?"
**Approach:** 1. Define the unit precisely (customer, order, seat, location) — get the client to sign off on the definition before computing anything. 2. Compute contribution margin per unit, fully loaded (include payment fees, support, returns). 3. Compute CAC by channel, blended AND marginal. 4. Compute LTV using observed retention curves, not assumed averages; state the discount rate. 5. Report LTV:CAC and CAC payback months. 6. State the break condition: at what CAC, churn, or price does the model stop working.
**Template:** `Unit: __ | Contribution margin/unit: __ | CAC (blended / marginal, by channel): __ | LTV (retention curve source, discount rate): __ | LTV:CAC: __ | Payback: __ mo | Model breaks when: __`
**Variation to watch:** LTV inflated by using gross revenue instead of contribution margin, or average retention instead of cohort curves. Both flatter the ratio by 2-3x.

## 4. Build / Buy / Partner Decision
**Trigger:** Capability gap identified (technology, product line, distribution) and leadership debates acquisition vs internal build vs alliance.
**Approach:** 1. Specify the capability needed and the date it must be operational — the deadline often decides alone. 2. Score each option on: time-to-capability, total cost (build cost vs acquisition premium vs partner margin give-up), control, integration/execution risk, reversibility. 3. Risk-adjust the financials: apply probability of build failure, integration failure, partner conflict. 4. Check strategic-asset test: if the capability is core to future differentiation, weight control heavily; if commodity, weight cost. 5. Recommend one option with the trigger conditions that would flip the answer.
**Checklist:** `[ ] Hard deadline stated [ ] All three options costed on same time horizon [ ] Risk-adjusted, not raw, financials compared [ ] Core-vs-commodity test applied [ ] Reversibility / exit cost per option noted [ ] Flip conditions listed`
**Variation to watch:** Comparing raw build cost against acquisition price while ignoring build failure probability and time value — internal builds systematically win the spreadsheet and lose in reality.

## 5. Scenario Planning for Strategic Uncertainty
**Trigger:** A discontinuity (regulation, technology shift, demand shock) makes single-point forecasts indefensible; board asks "what if?"
**Approach:** 1. Identify the 2 uncertainties with highest impact AND lowest predictability; fix everything else as trend. 2. Build a 2×2 → select 3 scenarios minimum (base, upside, disruption) — never just optimistic/pessimistic on one axis. 3. For each scenario write explicit, falsifiable assumptions with the leading indicator that signals it is materializing. 4. Stress the current strategy against each scenario; log where it breaks. 5. Split recommendations into no-regret moves (do now), options (small bets that pay in specific scenarios), and big bets (defer until an indicator fires).
**Template:** `Uncertainty axes: __ × __ | Scenario name / narrative / assumptions / leading indicators / P(occur): __ | Strategy break points per scenario: __ | No-regret moves: __ | Options: __ | Trigger-gated bets: __`
**Variation to watch:** Scenarios as three shades of the base case (revenue ±10%). If the disruption scenario doesn't break the current strategy somewhere, it isn't a real scenario.

## 6. Recommendation Deck Assembly (Pyramid Principle)
**Trigger:** Analysis is done; steering committee or exec readout is scheduled.
**Approach:** 1. Write the governing thought first — one sentence containing the full answer, including the action and the number. 2. Structure 3-5 supporting arguments MECE beneath it; each becomes a section. 3. One slide, one message: the slide title IS the takeaway sentence, never a topic label ("Pricing Analysis" → "Raising price 8% loses <2% of customers"). 4. Attach a so-what to every exhibit; delete any chart whose implication you cannot state. 5. Executive summary carries the entire answer — assume the meeting ends after slide one. 6. Final section is the implementation path: owners, 90-day milestones, resource asks, and the change-management plan (who loses power/budget and how that resistance is handled).
**Checklist:** `[ ] Answer on slide 1 with the number [ ] Every title is a full sentence claim [ ] Every exhibit has a stated so-what [ ] Support structure MECE, 3-5 branches [ ] Implementation: owner + milestone + cost per recommendation [ ] Change-management resistance named and addressed`
**Variation to watch:** Recommendation without implementation path — "enter the market" with no owner, sequence, or funding ask reads as analysis, not advice, and dies in the meeting.

---
name: scenario-stress-planner
description: Build the financial spine of a recommendation - minimum three scenarios (base/optimistic/pessimistic) with explicit named assumptions, unit economics, DCF with sensitivity, and a kill condition for the recommendation. Trigger phrases - "build the business case", "what's the ROI", "model the scenarios", "make vs buy vs partner", "is this worth doing", "stress test the numbers". Do NOT use for generic statistical work with no investment decision attached, or for trading-system backtests - it governs business-case economics only.
---

# Scenario Stress Planner

A single-point forecast is a guess wearing a suit. Every recommendation ships with three scenarios and the assumption that breaks it.

## When invoked

1. List every assumption driving the economics as a named variable with a base value and a source (market data / client actuals / analogue / judgment — label which). Judgment-sourced assumptions get flagged; they are the ones that kill business cases.
2. Build unit economics first: contribution margin, CAC, LTV, payback period. If unit economics are negative at scale, stop — no DCF can rescue a business that loses money per unit. Report that and exit.
3. Construct exactly three scenarios minimum — base, optimistic, pessimistic — by moving the flagged assumptions, not by scaling the answer ±20%. Each scenario states WHICH assumptions moved, to WHAT value, and WHY that world is plausible (name the trigger event).
4. Run DCF per scenario: NPV at the client's stated discount rate (ask if unknown — never assume silently), IRR, payback. For make/buy/partner questions, run all three options through the same three scenarios — a 3×3 grid, same assumptions across options.
5. Run one-way sensitivity on the top 5 assumptions; identify the switching value — the assumption level at which the recommendation flips. That is the kill condition.
6. State the kill condition in plain language in the output: "This recommendation dies if churn exceeds 4.1%/month" — plus the leading indicator that would show it early and when to check it.
7. Risk-adjust: probability-weight the scenarios only if probabilities can be defended; otherwise present the range and let the pessimistic case carry the risk message.

## Output format

A **Scenario Case Pack**: (a) assumption register (variable / base / source / flag), (b) unit economics block, (c) three-scenario table (assumptions moved, NPV, IRR, payback per scenario), (d) sensitivity tornado ordered by NPV swing, (e) kill condition sentence with leading indicator and review date, (f) for make/buy/partner: the 3×3 option-by-scenario grid.

## Quality gate

PASS only if: three or more scenarios exist and differ by named assumption values (not uniform scaling), every assumption has a source label, the pessimistic-case NPV is reported even when negative, and a kill condition with a numeric threshold is stated. A case where all three scenarios show positive NPV and no kill condition exists FAILS — the pessimistic case was not pessimistic.

## Integration

- Takes the recommendation candidate from the mece-decomposer/framework-fit-gate chain; its numbers feed so-what-enforcer's governing answer and exec summary.
- Step 5-6 is adversarial-disproof in financial form: find the world where the recommendation is wrong.
- Assumption sourcing is evidence-reasoning applied to inputs; sensitivity math routes through statistical-analysis.
- If the pessimistic case is fatal, loop back to problem-statement-lock — the decision may need reframing, not better numbers.

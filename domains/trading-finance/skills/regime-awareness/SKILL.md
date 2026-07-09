---
name: regime-awareness
description: >
  Identify the prevailing market regime before applying, evaluating, or modifying any strategy,
  and detect when a strategy's assumed regime has ended. Triggers: "why did it stop working",
  "strategy broke in April", "trending vs ranging", "should this signal fire today", "regime
  filter", "the edge disappeared", "market character changed", "correlation broke down".
  Do NOT use for one-off bar-pattern questions or for pure statistical clustering with no
  strategy attached to the regime label.
---

# When invoked

1. Classify the regime on at least two horizons with observable, lagging-honest inputs: higher-timeframe trend state (daily/4H structure — HH/HL vs LH/LL), and volatility state (current ATR or realized vol vs its own 20-period distribution). Name the regime as a compound label, e.g. BEAR-TREND/HIGH-VOL or NEUTRAL/COMPRESSED. "It feels choppy" is not a classification.
2. State the strategy's regime dependency explicitly: in which labeled regimes did its historical edge concentrate? Pull the per-regime P&L split — if it has never been computed, compute it before any verdict about "the strategy broke."
3. Test for regime change vs bad luck: a drawdown inside the strategy's home regime is variance; a drawdown coinciding with a regime-label flip is regime failure. Check the flip date against the drawdown start date.
4. Beware the lag trap: any regime filter built on N-day lookbacks flips N days late and whipsaws at transitions. Quantify the lag cost — count trades taken in the wrong regime during transition windows — before shipping any regime gate.
5. Treat regime as CONTEXT (sizing down, tightening filters, journaling) before treating it as a SELECTION oracle (blocking/flipping signals). Regime-as-selector must clear backtest-discipline full-stack on both halves; most fail there.
6. Check correlation regime separately when multiple instruments or strategies are involved: correlations estimated in calm regimes compress toward 1 in stress. Never net exposures using calm-period correlations.

# Output format

A **Regime Card**: `REGIME: {trend-label}/{vol-label} as of {date}`, the observable inputs and thresholds that produced each label, `STRATEGY HOME REGIME: {labels} (per-regime P&L split)`, `CURRENT MATCH: IN-REGIME | OUT-OF-REGIME | TRANSITION`, and one sentence of prescribed adjustment (size, filter, or stand-down) with its justification.

# Quality gate

PASS only if the regime label derives from stated numeric thresholds on named inputs and the strategy's per-regime P&L split is shown. FAIL if the label is narrative ("market seems weak"), single-horizon, or if a regime-based signal block is recommended without a two-half full-stack validation reference.

# Insight

A strategy that earns most in down/chop months and least in bull months is not "collapsing" during bull months — it is out of regime. Down-shifting expectations beats re-fitting parameters.

# Integration

Supplies regime splits to backtest-discipline (its H1/H2 check is a crude regime split — this skill refines it). Feeds risk-first-sizing a shrink-only multiplier in hostile regimes. Pairs with adversarial-disproof when proposing any regime gate: attempt to show the gate is a lagging refit of the losing period before believing it. trade-journaling tags every trade with the regime card so per-regime splits stay computable.

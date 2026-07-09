---
name: risk-first-sizing
description: >
  Derive position size from maximum tolerable loss and account constraints — never from
  conviction, recent wins, or target profit. Triggers: "how many contracts/shares", "position
  size", "can I size up", "Kelly", "drawdown limit", "trailing drawdown", "daily loss cap",
  "will this blow the account", "prop firm rules". Do NOT use for whether to take the trade
  (that is strategy/regime territory) or for portfolio asset-allocation theory with no live
  loss constraint.
---

# When invoked

1. Write the loss chain top-down before any size math: account equity → survival constraint (trailing drawdown floor, margin call level, or firm daily limit) → daily loss budget → per-trade max loss. Each level must be a hard dollar number with its source (broker rule, firm rule, or explicit policy).
2. Compute size as `floor(per_trade_max_loss / (stop_distance × point_value × slippage_factor))`. Stop distance is the ACTUAL stop after any widening/floors the execution layer applies — if the system widens stops post-signal, recalculate contracts after widening, never before.
3. Stress the sequence, not the single trade: at this size, how many consecutive losses reach the daily cap? How many losing days reach the survival constraint? If fewer than 2 losers fit in the daily budget, cut size — one bad trade must never end the day.
4. Check trailing-drawdown mechanics precisely: does the floor trail intraday equity highs or end-of-day balance? Does it lock? Available drawdown is computed against the CURRENT floor, not the starting one. State the exact available-dollars figure and its as-of date.
5. Cap Kelly-style or conviction-scaled sizing at the loss-chain ceiling. Conviction may reduce size below the cap; it may never raise size above it. Fractional Kelly (≤0.25) only, and only with 100+ trade sample behind the win-rate estimate.
6. Recovery math is asymmetric — a 10% drawdown needs 11.1% to recover, 50% needs 100%. Quote the recovery percentage whenever proposed size makes a >10% drawdown plausible within 20 trades.

# Output format

A **Sizing Ledger**: the four-level loss chain with dollar figures and rule sources, the size formula with every input named (stop pts, point value, slippage factor), `SIZE: n contracts/shares`, `CONSECUTIVE LOSSES TO DAILY CAP: k`, `LOSING DAYS TO FLOOR: m`, and any cap that bound (which constraint was the binding one).

# Quality gate

PASS only if size traces arithmetically from a named hard constraint and the binding constraint is identified. FAIL if size was justified by conviction, expectancy, or profit target anywhere in the chain, or if the stop distance used differs from the stop the execution layer will actually place.

# Integration

Runs inside plan-gate before any live sizing change ships. execution-analysis supplies the slippage factor from measured fills, not guesses. regime-awareness can only shrink the budget (volatile regime → smaller), never expand it. backtest-discipline validates any sizing-ladder change full-stack — ladder interactions dominate per-trade math.

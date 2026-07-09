---
name: backtest-discipline
description: >
  Enforce methodological rigor on any backtest — running one, reading one, or judging whether a
  strategy change "worked." Triggers: "run a backtest", "did the edge improve", "validate this
  strategy", "compare to baseline", "the backtest shows", "walk-forward", "out-of-sample",
  "is this overfit". Do NOT use for live-trade P&L review (use execution-analysis), for sizing
  decisions (use risk-first-sizing), or for generic statistics questions with no market data —
  those belong to core statistical-analysis.
---

# When invoked

1. Name the baseline BEFORE looking at the new result: exact figure, exact result file/commit it came from, and the parameter set that produced it. No baseline named = no comparison allowed.
2. Check the data split. Demand an untouched out-of-sample segment (minimum: final 20% of the period, or a full held-out half). If every date in the dataset influenced a parameter choice, label the result IN-SAMPLE ONLY and say so in the first line of output.
3. Hunt look-ahead bias explicitly: any indicator computed on the full series then indexed by bar, any `get_bars(n).tail(n)`-style end-of-dataset access, any fill assumed at a price the bar never traded through, any session-level value (IB, VWAP, daily trend) referenced before the bar that finalizes it.
4. Interrogate fill assumptions: fill at signal price vs next-bar open vs limit-touch. State which assumption the run used and how many trades are fill-fragile (entry within 1 tick of bar extreme).
5. Split the result by regime halves (H1/H2 minimum, per-month preferred). An edge that lives in one contiguous window is a regime artifact, not an edge.
6. Count the researcher degrees of freedom: how many parameter variants were tried before this one? If >5 variants preceded it, apply an explicit "winner's curse" discount and demand out-of-sample confirmation before any DONE claim.
7. Never declare improvement from a per-signal isolated simulation when the live system has interacting components (sizing ladders, daily caps, chain blocks). Full-stack run or no verdict.

# Output format

A **Backtest Verdict Block**: `BASELINE: $X (file, params)` / `CANDIDATE: $Y (file, params)` / `DELTA: $Z` / `SPLIT: H1 $a | H2 $b` / `TRADES: n, WR: w%` / `BIAS CHECKS: look-ahead [pass/fail + evidence], fill-assumption [stated], variants-tried [count]` / `VERDICT: CONFIRMED EDGE | IN-SAMPLE ONLY | REGIME ARTIFACT | FALSIFIED`.

# Quality gate

PASS only if the verdict block cites a baseline with file path, reports both halves separately, and states the fill assumption verbatim. FAIL if any of the three is missing, or if "improved" is claimed with only aggregate P&L and no split.

# Integration

Feeds adversarial-disproof: every CONFIRMED verdict must survive one deliberate falsification attempt (shuffle dates, invert the rule, test the complement). Feeds evidence-reasoning: the verdict block is the evidence object. regime-awareness supplies the regime labels for step 5. trade-journaling records FALSIFIED verdicts permanently so the same idea is never re-run.

---
name: execution-analysis
description: >
  Quantify the gap between modeled trades and real fills — slippage, missed fills, latency,
  partial fills, venue quirks. Triggers: "live vs backtest", "why did live underperform",
  "slippage", "fill quality", "phantom fill", "the bot got a different price", "order didn't
  fill", "execution gap". Do NOT use for judging whether a strategy has edge at all (use
  backtest-discipline) or for generic performance profiling of code — this is about order
  fills, not CPU.
---

# When invoked

1. Build the trade-pair table first: every modeled trade matched to its live counterpart by date+signal, with entry, stop, exit, and size for both sides. Unmatched trades go in two explicit lists — MODELED-NOT-FILLED and FILLED-NOT-MODELED. These lists ARE the finding; never average over them.
2. Decompose the per-trade gap into named components, in this order: (a) fill existence (did the order fill at all), (b) entry slippage in ticks, (c) exit slippage in ticks, (d) size difference, (e) timing/latency drift. Report dollars per component, not a blended number.
3. Distinguish order types in the model vs reality: a backtest "fill at level" is a limit-touch assumption; live market orders pay spread + impact, live resting stops fill on penetration. Instant-rejection signals (price touches level and reverses same bar) are the classic phantom — flag every trade whose modeled entry bar's extreme equals the entry price.
4. Attribute each gap component to a mechanism (order routing, queue position, latency, contract rollover, session halt, broker rule) with evidence from logs — timestamps, order IDs, venue messages. No mechanism = mark UNEXPLAINED, never hand-wave.
5. Produce the honest baseline: restate expected strategy P&L using live-realistic fill rules, and state it as the number all future comparisons use.

# Output format

An **Execution Gap Report**: trade-pair table (or its file path), then `GAP TOTAL: $X` decomposed as `FILL-EXISTENCE $a / ENTRY-SLIP $b / EXIT-SLIP $c / SIZE $d / LATENCY $e / UNEXPLAINED $f`, then `HONEST BASELINE: $Y`, then a ranked mechanism list with log evidence per mechanism.

# Quality gate

PASS only if the component dollars sum to the total gap (±rounding) and every phantom-fill candidate is individually listed. FAIL if the report contains only an aggregate slippage average, or if UNEXPLAINED exceeds 25% of the gap without being flagged as the top follow-up.

# Insight

The largest execution losses are usually fill-existence, not slippage — trades that never happened or happened when they shouldn't. Check existence before polishing tick-level slippage models.

# Integration

Uses root-cause-first for each mechanism attribution. Hands the honest baseline to backtest-discipline as the new comparison anchor. trade-journaling stores per-trade fill records that make step 1 possible. Any code fix proposed here goes through verified-done with a full signal-to-flat variable trace before touching live order paths.

---
name: statistical-analysis
description: Use for any analysis drawing conclusions from data — backtests, A/B comparisons, performance measurements, survey results, "does X improve Y" questions. Hypothesis stated BEFORE the analysis runs; reports effect size + confidence interval + p-value + N + power; flags underpowered claims; never conflates statistical with practical significance. Trigger keywords - "is this significant", "does it work better", "compare the results", "is the improvement real". Do NOT use for purely descriptive summaries with no inferential claim.
---

# statistical-analysis

The two ways to lie with data are running the test after peeking at the answer, and reporting the one number (p-value) that sounds most scientific while omitting the four that matter. This skill blocks both: hypothesis first, full reporting always.

## When invoked

1. **State the hypothesis BEFORE touching the data.** Written, directional where honest: "H1: variant B's mean daily P&L exceeds A's." Also state what result would REFUTE it. A hypothesis formed after seeing the data is exploration — legal and useful, but it must be labeled EXPLORATORY and its findings demoted to "hypotheses for future data," never reported as confirmations. Data cannot confirm the hypothesis it generated.
2. **Check N before running anything.** Rough power check: can this sample plausibly detect an effect of the size that would matter? 30 trades cannot resolve a 3% win-rate difference — say so BEFORE the analysis, not as a post-hoc excuse. If underpowered: report that as the finding ("N is insufficient for this claim; need ~{k}"), don't run the ritual anyway and hedge.
3. **Report all five numbers, always:**
   - **Effect size** — the magnitude, in the problem's units (dollars, points, percentage points). This is the number decisions are made on.
   - **Confidence interval** — the honest range; a CI spanning zero says more than any p-value.
   - **p-value** — reported, not worshipped.
   - **N** — and how it was arrived at (exclusions listed — silent exclusions are the analyst's thumb on the scale).
   - **Power context** — what effect size this N could reliably detect.
4. **Statistical vs practical significance — always separate.** A real-but-tiny effect (significant at N=10,000, worth $40/year) and a huge-but-uncertain one (2× improvement, p=0.2 at N=12) get opposite treatments from naive reading. State both dimensions explicitly: "statistically {clear/unclear}, practically {matters/doesn't} because {threshold it does/doesn't cross}."
5. **Multiple-comparison honesty.** Count every test run, including the informal ones ("we looked at 7 signal types") — at 20 looks, one spurious p<0.05 is expected. Correct, or at minimum disclose the look-count.
6. **Robustness before belief.** For load-bearing conclusions: does the effect survive reasonable re-slicing (halves of the period, with/without the outlier day, alternative metric)? An effect that lives entirely in one subsample or one outlier is reported as exactly that. Beware regime effects: two time-halves are not independent samples from one population if the world changed between them.
7. **Stopping rules stated.** If data collection could have stopped early on a good result (the classic backtest sin), the analysis inherits that bias — disclose when it applies.

## Output format

```
HYPOTHESIS (pre-stated): {H1; refutation condition} | mode: CONFIRMATORY / EXPLORATORY
N: {n} ({exclusions}) | POWER: detectable effect ≈ {size}
RESULT: effect = {size [units]} | CI{level} = [{lo}, {hi}] | p = {p}
LOOKS: {number of comparisons run} {correction applied / disclosed}
ROBUSTNESS: {re-slices tried → survived/died where}
VERDICT: statistically {clear/unclear/underpowered} × practically {material/immaterial}: {one-sentence decision-relevant conclusion}
```

## Integration

- All arithmetic inside via **mathematical-reasoning**; conclusions enter reports under **evidence-reasoning** tiers.
- **adversarial-disproof** on any surprising effect — L1 asks "is the measurement itself broken?" (too-good results are usually pipeline bugs, not alpha).
- Robustness re-slicing pairs with the falsification ledger: a died-on-reslice effect is a falsification worth persisting.
- Trading-domain rule (Master Framework 4.2): no "edge" claim without both-halves/out-of-sample stability; SIM vs LIVE populations never pooled.

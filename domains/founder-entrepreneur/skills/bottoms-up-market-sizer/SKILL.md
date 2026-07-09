---
name: bottoms-up-market-sizer
description: >
  Build market size from actual buying behavior upward — count reachable buyers, real price
  points, and observed conversion — and destroy top-down "1% of a $50B market" claims.
  Trigger phrases: "TAM SAM SOM", "market size for my pitch", "how big is this market",
  "is this market big enough", "investors asked about TAM", "1% of the market".
  Do NOT use for public-equity or macro market analysis, or for sizing an internal product's
  user base inside one company. Do NOT use when zero customer-discovery evidence exists —
  price points and segments must come from momtest-auditor output, not analogy.
---

# Bottoms-Up Market Sizer

## When invoked
1. Reject any inbound top-down number on sight ("$X B market growing Y%") and quarantine it in a "narrative only" note. It may appear in a pitch deck for context; it may never drive a decision.
2. Define the atomic buyer from JTBD evidence: WHO writes the check (person/role, not "companies"), for WHAT job, replacing WHAT current spend (competitor, indirect substitute, or status quo — spreadsheet, intern, doing nothing). If the current spend is $0 and the pain is tolerated, flag: category-creation risk, size estimate gets a confidence penalty.
3. Count the buyers bottom-up with a countable proxy: LinkedIn role counts, industry association membership, app-store install counts of the incumbent, number of establishments in the NAICS code, GitHub repos using the library. Name the proxy and its known bias. No proxy = no count = say "unknown," never interpolate.
4. Price from behavior: what have real prospects paid, or what do they currently pay for the displaced alternative (including labor hours × loaded cost for manual workarounds)? Use observed price, not aspirational pricing.
5. Compute the ladder: `reachable buyers × evidenced price × honest attainable share` where attainable share comes from observed conversion in manual-traction-ladder data if it exists, else a stated assumption with a range, never a point estimate. Produce three numbers: obtainable-now (current channel + team), obtainable-3yr, and theoretical ceiling.
6. Run the "is it big enough" test against the founder's actual goal: venture-scale requires the ceiling to support ~$100M ARR; a bootstrapped target may need only obtainable-now × 12 > founder salary. State which game is being played — a market too small for VC can still be an excellent business, and pitching VC with it is the mistake.

## Output format
A **Market Ledger**: (1) buyer definition block (check-writer, job, displaced spend); (2) count table `segment | proxy source | raw count | reachability haircut | net buyers`; (3) price evidence list with sources; (4) three-number ladder with the arithmetic shown inline; (5) verdict: `VENTURE-SCALE / BOOTSTRAP-SCALE / TOO-SMALL-AS-DEFINED`, plus the single assumption whose failure most changes the answer.

## Quality gate
FAIL if: any number in the ladder traces back to a top-down report percentage; price is aspirational with observed price available; the ladder is a single point estimate without ranges; or a proxy count appears without its named bias. PASS only when every ladder input has a cited source or an explicitly labeled assumption, and the arithmetic reproduces from the table values.

## Integration
Inputs come from momtest-auditor (JTBD, displaced spend) and manual-traction-ladder (observed conversion, real prices) — this skill never invents what those measure. Run under **statistical-analysis**: ranges and sensitivity on the dominant assumption, not false precision. Apply **adversarial-disproof** to a VENTURE-SCALE verdict by constructing the smallest defensible market definition and checking the verdict survives. Output feeds `term-sheet-analyzer` (valuation-cap sanity: cap vs obtainable-3yr) and **plan-gate** on any fundraising plan — TOO-SMALL-AS-DEFINED blocks a VC raise plan but not a bootstrap plan.

---
name: term-sheet-analyzer
description: >
  Decompose a term sheet, SAFE, or convertible note into economics, control, and noise —
  then compute what the founder actually keeps at exit. Trigger phrases: "got a term sheet",
  "SAFE with a cap", "convertible note terms", "should I take this deal", "valuation cap vs
  discount", "pro-rata rights", "liquidation preference", "board seat request". Do NOT use
  for public-market securities analysis, employee offer letters, or M&A definitive agreements
  — those have different mechanics. Do NOT use when no written terms exist yet (verbal
  interest is not a deal; redirect to pitch-prep and investor selection).
---

# Term Sheet Analyzer

## When invoked
1. Ingest the actual document text. Refuse to analyze from the founder's summary alone — founders systematically misread their own terms. If only a summary exists, list the exact clauses to go retrieve.
2. Sort every clause into three bins:
   - **ECONOMICS** — valuation (pre/post — state which, and convert to the other), cap, discount, option pool (pre- or post-money pool shuffle: compute the effective valuation hit), liquidation preference (multiple + participating/non-participating), anti-dilution (broad-based weighted average vs full ratchet), dividends, pro-rata.
   - **CONTROL** — board composition, protective provisions (list each veto), drag-along, information rights, founder vesting reset, IP re-assignment, MFN, right of first refusal.
   - **NOISE** — standard boilerplate that costs nothing to concede (legal fees caps at market rate, standard reps, confidentiality). Name it as noise so the founder spends zero negotiation capital on it.
3. Build the dilution waterfall: current cap table → this round (including pool expansion) → modeled next round at 2 stated scenarios → exit at 3 exit values (low/base/high). Show founder %, founder $ at each stage. For SAFEs: convert at cap AND at discount, take the investor-favorable one, and stack ALL outstanding SAFEs simultaneously — the single most common founder blind spot is un-stacked SAFE dilution.
4. Flag every off-market term against stage norms (pre-seed/seed/A). For each flag state: what's standard, what this term costs in the waterfall, and whether it is a walk-away, a negotiate, or an accept.
5. Rank the negotiation asks: at most 3, ordered by waterfall impact per unit of negotiation capital. Everything else: concede explicitly.

## Output format
A **Deal Memo** with: (1) three-bin clause table `clause | bin | market-standard? | $ impact`; (2) dilution waterfall table (rows = events, cols = founder %, founder $, investor %); (3) SAFE stack conversion table if applicable; (4) "Negotiate these 3, concede the rest" list; (5) one-line verdict: `SIGN / NEGOTIATE / WALK`, with the single decisive reason.

## Quality gate
FAIL if: pre/post-money ambiguity survives into the waterfall; the option pool shuffle is not priced into effective valuation; any outstanding SAFE is missing from the stack; a participating preference is modeled as non-participating; or the memo contains more than 3 negotiation asks. PASS only when the waterfall arithmetic reconciles (ownership sums to 100% at every stage) and the verdict cites a waterfall number.

## Integration
Waterfall math runs under **statistical-analysis** discipline — show the arithmetic, no rounded hand-waves. Apply **adversarial-disproof** to a SIGN verdict: model the down-round scenario and confirm anti-dilution + preference don't zero the founder. Cross-check against `cofounder-agreement-checklist` — a raise with unvested-founder or unassigned-IP issues fails diligence; fix those first. Gate through **plan-gate**: no signature recommendation until the Deal Memo quality gate passes, and **verified-done** requires the founder confirms the clause list matches the executed document.

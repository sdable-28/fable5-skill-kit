---
name: pmf-signal-reader
description: >
  Measure product-market fit as a quantified verdict, never a feeling. Trigger phrases: "do we have PMF",
  "are we ready to scale", "should we hire more sales/engineers", "our users love it", "traction looks good",
  "is this retention okay", "Sean Ellis test", "should we raise". Also invoke BEFORE any scaling decision
  (hiring spree, paid spend ramp, Series A pitch) — scaling pre-PMF is the leaky-bucket failure. Do NOT use
  when the question is about optimizing growth of a product with already-verified PMF (retention flat,
  Ellis >40% on record) — use growth-model-selector or growth-loop-mapper instead. Do NOT use for
  feature-level adoption questions.
---

# PMF Signal Reader

## When invoked
1. Demand the raw data before opining: cohort retention table (weekly or monthly, by signup cohort), Sean Ellis survey results if run, organic vs paid acquisition split, and the qualitative pipeline (unsolicited inbound, word-of-mouth referrals). If any is missing, name it as missing — a PMF verdict without retention cohorts is invalid; say so and stop at "INSUFFICIENT DATA" for that signal.
2. Read the retention curve SHAPE first, not the number. Plot cohorts: does the curve flatten to an asymptote, and at what percentage and by which week/month? Flattening curve = some PMF exists at that plateau level. Curve decaying to zero = no PMF regardless of top-line growth. Never accept "month-1 retention is X%" alone — one point cannot show flattening.
3. Score the Sean Ellis test correctly: >40% "very disappointed" among users who experienced the core value in the last 2 weeks. Reject surveys of all signups (dilution gives false negatives) and surveys of power users only (selection gives false positives). Record the denominator definition.
4. Compute the organic ratio: (word-of-mouth + direct + unattributed-organic signups) / total signups, trended over 3+ months. Rising organic share with flat spend is the strongest single PMF signal.
5. Segment before concluding. Cut retention and Ellis score by segment (industry, company size, use case, acquisition channel). Hunt explicitly for PARTIAL PMF: one segment with a flat curve buried under a decaying blended curve. Partial PMF changes the recommendation from "keep searching" to "narrow ICP and go deep".
6. Distinguish "some people use it" from PMF: usage without retention flattening, growth driven by paid with organic <20%, and Ellis <25% all read as usage-not-fit. State this bluntly if found.
7. Issue the verdict and the hiring corollary: if verdict is NO-PMF or PARTIAL, state explicitly that headcount growth (especially sales) should freeze until the flat-cohort segment is confirmed — hiring against no-PMF converts runway into a faster-leaking bucket.

## Output format
Produce a **PMF Verdict Card**:
- `verdict`: PMF | PARTIAL-PMF (name the segment) | NO-PMF | INSUFFICIENT-DATA
- `signals` table: signal (retention shape / Ellis / organic ratio / qualitative density) x reading x threshold x pass-fail
- `retention`: plateau %, week/month of flattening, per key segment
- `strongest-segment`: segment, its curve plateau, its Ellis score
- `scaling-license`: GRANTED / DENIED, with the one sentence of evidence that decides it
- `next-measurement`: the single cheapest data collection that would upgrade confidence

## Quality gate
PASS only if: (a) every signal in the card cites a number or is marked INSUFFICIENT-DATA — zero adjective-only entries ("strong", "decent"); (b) at least one segment cut was performed or its absence justified; (c) the verdict is falsifiable — a stated future observation that would reverse it. FAIL and redo if the verdict rests on top-line growth or total signups anywhere.

## Integration
- **evidence-reasoning**: every card entry chains claim → data source → threshold. No vibes.
- **adversarial-disproof**: before finalizing a PMF verdict, argue the opposite — find the strongest reading of the data that says NO-PMF, and defeat it or downgrade.
- **statistical-analysis**: cohort sizes under ~50 users get wide-interval caveats; do not call an Ellis result on n<40 responses.
- **plan-gate**: a DENIED scaling-license blocks growth-model-selector and stage-playbook-enforcer from recommending any scale motion — they must consume this card first.
- **growth-model-selector** consumes `strongest-segment` as the ICP seed when verdict is PARTIAL-PMF.

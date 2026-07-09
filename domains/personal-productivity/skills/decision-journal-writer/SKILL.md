---
name: decision-journal-writer
description: >
  Capture a decision at the moment it is made — context, alternatives, expected outcome
  with probability, review date — and score past entries against actual outcomes.
  Triggers: "I've decided to...", "should I do X or Y" (after the choice is made),
  "log this decision", "review my past decisions", "was I right about...".
  Do NOT use for trivial reversible choices (lunch, tool defaults) — journal only
  decisions that are costly to reverse or will take >1 week to show results.
  Do NOT use to MAKE the decision; use it to record and later grade one.
---

# Decision Journal Writer

## When invoked

1. Classify the decision first: **reversible** (two-way door) or **irreversible** (one-way door). If reversible and low-stakes, stop and say the journal is overkill — recommend deciding fast and moving on. Journal only if irreversible OR reversible-but-expensive.
2. Capture, in the decider's own words, BEFORE any analysis colors it:
   - The decision as a single sentence starting with a verb.
   - Context: what is known, what is unknown, current emotional state (tired/anxious/excited — mood at decision time is a known distorter and must be on record).
   - Alternatives seriously considered, and why each was rejected in one line.
   - Expected outcome: a falsifiable prediction with a number and a date ("revenue +15% by March", not "things improve").
   - Confidence: a probability from 50–95%. Refuse "100%" — force a real number.
3. Run a 3-line pre-mortem: "It is [review date] and this failed. The most likely cause was ___." Record the top failure cause and one early-warning signal for it.
4. Set the review date (default: the prediction's date; cap at 6 months). Instruct the user to store the entry where the review will actually find it.
5. On a **review** invocation: retrieve the entry, record the actual outcome, grade it CORRECT / WRONG / MIXED against the falsifiable prediction only — never against how the person feels now. Log whether the pre-mortem's failure cause fired.

## Output format

A **Decision Entry** block with fixed headers: `Decision / Date / Reversibility / Context / Alternatives Rejected / Prediction (falsifiable) / Confidence % / Pre-mortem Top Risk / Early Warning / Review Date`. Review invocations append an **Outcome** block: `Actual / Grade / Pre-mortem Fired? / Calibration Note`.

## Quality gate

PASS only if the Prediction line contains both a measurable quantity and a date, and Confidence is a number in 50–95. FAIL any entry whose prediction could be argued true under any outcome ("we'll learn a lot") — rewrite it or reject the entry.

## Quality gate on reviews

PASS only if the grade cites the original prediction verbatim. Grading against remembered intent instead of the written prediction is hindsight laundering — FAIL.

## Integration

- **adversarial-disproof**: the pre-mortem step IS an adversarial pass — invoke it fully for irreversible decisions above the user's stated stakes threshold.
- **evidence-reasoning**: reviews feed calibration — after 10+ graded entries, compare stated confidence vs. hit rate.
- **statistical-analysis**: with 20+ entries, compute the calibration curve; report systematic over/underconfidence.
- **weekly-review-runner**: surfaces entries whose review date falls inside the review week.

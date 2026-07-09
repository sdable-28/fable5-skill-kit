---
name: momtest-auditor
description: >
  Audit customer-discovery evidence for Mom Test violations — separate what interviewees
  actually DID from what they politely SAID. Trigger phrases: "validate my idea",
  "customers said they'd buy", "everyone loves it", "interview notes", "do people want this",
  "survey says", "positive feedback from users". Do NOT use when the founder already has
  paying customers and the question is about growth, pricing, or retention — that is
  post-validation territory; use manual-traction-ladder instead. Do NOT use for investor
  feedback (investor interest is not market demand — flag and redirect).
---

# Mom Test Auditor

## When invoked
1. Collect every claim of validation the founder presents: interview notes, survey results, quotes, waitlist counts, LOIs, "they said they'd pay."
2. Classify each claim into exactly one bucket: **BEHAVIOR** (past-tense, specific, verifiable: money spent, tool bought, hack built, hours lost last month), **COMMITMENT** (real cost paid now: prepayment, signed pilot, intro to their boss, calendar time given), or **OPINION** (compliments, hypotheticals, "I would definitely use this", feature wishes, generic pain agreement).
3. For every OPINION item, write the Mom Test rewrite: the past-behavior question that should have been asked instead ("When did this last happen? What did it cost you? What did you do about it? What else did you try?").
4. Check for the three classic contaminations and flag each occurrence: (a) founder pitched before asking (answers are now polluted), (b) question mentioned the founder's idea (leading), (c) interviewee is friend/family/investor (compliment bias).
5. Identify the Job To Be Done implied by the BEHAVIOR evidence only. If BEHAVIOR evidence implies a different JTBD than the founder's stated idea, say so explicitly — this is the most common silent killer.
6. Count evidence: N interviews total, N containing at least one BEHAVIOR data point, N containing a COMMITMENT. State whether the validation threshold is met: **minimum 5 independent BEHAVIOR data points describing the same problem, plus at least 1 COMMITMENT, before building anything.**

## Output format
A **Validation Ledger** with four sections: (1) Evidence table — one row per claim: `claim | bucket | source | contaminated? | weight`; (2) Rewrite list — each OPINION with its past-behavior replacement question; (3) JTBD statement derived from BEHAVIOR rows only, with a match/mismatch verdict against the founder's idea; (4) Verdict line — `VALIDATED / NOT YET VALIDATED / INVALIDATED`, with the exact next 3 discovery questions to ask.

## Quality gate
FAIL if any of: the ledger contains a row where a compliment or hypothetical was bucketed as BEHAVIOR; the verdict is VALIDATED with fewer than 5 uncontaminated BEHAVIOR rows; the JTBD section quotes the founder's pitch instead of interviewee actions. PASS only when every OPINION row has a rewrite and the verdict cites row counts.

## Integration
Runs under **evidence-reasoning** — every ledger row must cite its source verbatim, no paraphrased memory. Apply **adversarial-disproof** to the VALIDATED verdict: actively construct the story in which all evidence is politeness and check it survives. Feed the verdict into **plan-gate** before any build plan is approved: NOT YET VALIDATED blocks the plan. The JTBD output is the required input to the bottoms-up sizing step in `term-sheet-analyzer` pitch-prep mode and to `manual-traction-ladder` target selection.

---
name: cofounder-agreement-checklist
description: >
  Force the co-founder conversation and paperwork BEFORE the first conflict — equity split
  rationale, vesting, roles, IP assignment, and the departure plan. Trigger phrases:
  "starting a company with a friend", "how should we split equity", "50/50 split",
  "my co-founder and I", "vesting cliff", "co-founder leaving", "founder breakup".
  Do NOT use for employee/advisor equity grants (that is cap-table territory) or for
  disputes already in litigation — an executed-agreement dispute needs a lawyer, not
  a checklist. Do NOT use to arbitrate who is "right" in an active fight; use it to
  check what the signed documents say and what is missing.
---

# Co-founder Agreement Checklist

## When invoked
1. Establish document state first: is there a signed founder agreement, signed stock purchase agreements with vesting, and signed IP assignment for EACH founder? Answer per-founder, per-document, with dates. "We agreed verbally" = NOT SIGNED.
2. Interrogate the equity split. If the split is 50/50 (or equal N-way), demand the affirmative case for it — equal splits chosen to avoid an awkward conversation are the default failure mode. Score each founder on: idea origination, capital contributed, full-time vs part-time, opportunity cost, replaceability, pre-existing IP brought in. An equal split must survive that scoring, not precede it.
3. Verify vesting mechanics: 4-year vest / 1-year cliff on ALL founder shares including the CEO's; acceleration terms (single vs double trigger — flag single-trigger-on-termination as a poison pill); what happens to unvested shares on voluntary quit vs for-cause termination vs death/disability.
4. Verify IP assignment: every founder has assigned all relevant pre-formation IP to the company via signed PIIA/CIIA, and no founder's current or former employer has a claim (moonlighting clauses, invention assignment from a day job). This is the item most often missing and it blocks every future financing.
5. Check role and decision clarity: who is CEO (exactly one), tie-break mechanism for deadlocked decisions, who can hire/fire, who signs checks above a threshold, expected time commitment in writing.
6. Check the parting plan while everyone still likes each other: buy-back rights on vested shares (right of first refusal), non-solicit, what "for cause" means in writing, board seat forfeiture on departure.
7. For each missing item, state the concrete failure it causes and the deadline: **all items signed before any fundraise, any revenue, or any third hire — whichever comes first.**

## Output format
A **Founder Pact Scorecard**: (1) document matrix `document | founder A | founder B | ... | signed date or MISSING`; (2) equity split table with per-founder factor scores and the resulting defensible split range; (3) gap list ordered by kill-probability, each gap with its failure story and fix action; (4) verdict: `FUNDABLE / FIXABLE / FRAGILE`, one line each on why.

## Quality gate
FAIL if: any founder lacks a row in the IP-assignment column; a 50/50 split is accepted without the factor-score table; vesting is marked OK without cliff length and acceleration terms explicitly recorded; or the verdict is FUNDABLE with any MISSING cell in the document matrix. PASS only when every MISSING cell maps to a gap-list entry with a deadline.

## Integration
Runs before **plan-gate** on any fundraise or hiring plan — a FRAGILE verdict blocks both. Feeds `term-sheet-analyzer` diligence: investors will re-run steps 3-4, so close gaps first. Apply **root-cause-first** to any active founder tension surfaced during the interview: the presenting fight (title, salary) is rarely the real one (contribution asymmetry, commitment asymmetry). Use **evidence-reasoning**: only signed documents count as evidence; recollections of verbal agreements are recorded as claims, never as facts.

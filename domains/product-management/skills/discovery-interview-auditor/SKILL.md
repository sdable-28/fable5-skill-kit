---
name: discovery-interview-auditor
description: >
  Design or audit user discovery interviews — strip leading questions, separate problem
  validation from solution validation, and grade whether transcript evidence actually
  supports the claimed insight. Trigger phrases: "write interview questions", "review my
  discovery script", "did these interviews validate", "users said they'd use it",
  "synthesize these interview notes", "JTBD interview". Do NOT use for usability testing
  of a built UI (task-completion protocols differ), for survey/questionnaire statistical
  design, or for sales call analysis where the goal is deal progression not learning.
---

# discovery-interview-auditor

## When invoked
1. Determine mode: DESIGN (write/fix a script) or AUDIT (grade transcripts/notes against a claimed insight). State which mode you are in.
2. In either mode, classify every question against the four kill-patterns: (a) leading ("wouldn't it be easier if..."), (b) hypothetical-future ("would you use/pay for..."), (c) solution-first (pitches the feature then asks opinion), (d) compliment-fishing ("do you like it?"). Rewrite each violation into past-behavior form: "Tell me about the last time you [did the job]. What did you do? What did that cost you?"
3. Enforce the problem/solution firewall: problem-validation questions (does the pain exist, how do they cope today, what have they already paid/hacked to solve it) must complete before any solution is shown. If a script mixes them, restructure — solution reactions from someone who hasn't independently described the pain are worthless.
4. In AUDIT mode, grade each claimed insight by evidence tier: Tier 1 = past behavior with specifics (dates, money spent, workaround built); Tier 2 = unprompted complaint about the problem; Tier 3 = agreement with interviewer's framing; Tier 4 = hypothetical intent ("I would definitely use that"). Only Tier 1-2 count as validation. Count supporting participants per insight — fewer than 3 independent Tier 1-2 sources = "signal, not validated."
5. Check sample composition: are these buyers, users, or bystanders relative to the JTBD? Flag insights sourced only from people who don't own the job.
6. Flag interviewer-contamination in transcripts: places where the participant's answer merely mirrors the interviewer's vocabulary introduced seconds earlier.

## Output format
DESIGN mode: the final script with questions grouped `Problem discovery → Current coping → (firewall) → Solution reaction`, plus a table of every rewritten question (`Original | Kill-pattern | Rewrite`). AUDIT mode: a table `Claimed insight | Evidence tier | Independent sources (n) | Verdict (VALIDATED / SIGNAL / UNSUPPORTED)` plus a contamination list with transcript line references.

## Quality gate
PASS only if: zero questions asking about hypothetical future behavior survive in a final script, and in AUDIT mode no insight is marked VALIDATED on Tier 3-4 evidence or on fewer than 3 sources. FAIL immediately if the output ever treats "participants said they would use it" as validation — that phrase is the canonical false positive of this entire domain.

## Integration
Audited-VALIDATED insights raise the Confidence cap in `hypothesis-prioritizer` to the 0.5 qualitative tier; SIGNAL/UNSUPPORTED insights do not. Use core `evidence-reasoning` tiers as the backbone for step 4 grading. Use core `adversarial-disproof` to write one disconfirming question per hypothesis into every script (a question the answer to which could kill the idea). Feed validated jobs into `market-sizing-builder` as the segment definition.

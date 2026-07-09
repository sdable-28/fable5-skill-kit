---
name: contract-risk-scan
description: >
  Clause-by-clause risk review of a contract draft or counterparty paper (MSA, NDA, SLA, DPA,
  employment agreement, option grant, term sheet). Trigger phrases: "review this contract",
  "what's risky in this agreement", "redline this", "is this NDA okay", "check the indemnity".
  Hunts asymmetries, missing carve-outs, and silent gaps — what the document does NOT say.
  Do NOT use for regulatory/framework compliance questions (use compliance-gap-mapper), for
  pure business-terms negotiation strategy with no legal-risk component, or before
  jurisdiction-first has pinned the governing-law premise.
---

# contract-risk-scan

## When invoked
1. Confirm a jurisdiction-first block exists for this matter; if not, run **jurisdiction-first** now. Read the governing-law and forum clauses first — they recolor every other clause.
2. Identify which side the reader is on and the contract's economic center of gravity (what the reader pays/receives, what they can lose). Risk is directional; never review "neutrally."
3. Sweep the load-bearing clause set in fixed order and record each as present/absent/asymmetric: liability cap and its exclusions; indemnification (scope, triggers, control of defense, whether mutual); IP ownership and license-back; confidentiality term and carve-outs; termination rights and effects; warranty and disclaimer; payment and offset; assignment and change-of-control; dispute resolution; force majeure; insurance; audit rights; auto-renewal.
4. For every clause, run the three domain checks:
   - **Asymmetry:** does the same word ("indemnify", "confidential", "terminate for convenience") bind one party but not the other?
   - **Missing carve-out:** liability cap without exclusions for IP infringement, confidentiality breach, or indemnity obligations creates unintended liability shifts — flag any cap or waiver whose standard carve-outs are absent.
   - **Silence:** name obligations the document never addresses that the deal type normally requires (e.g., a DPA missing sub-processor consent, an option grant silent on acceleration). Silence is a finding, not a pass.
5. Trace defined terms: any risk term ("Losses", "Confidential Information", "Services") whose definition expands or shrinks a clause's real scope gets flagged at the clause, not just the definitions section.
6. Grade each finding: DEAL-BREAKER (uncapped/one-way exposure), NEGOTIATE (asymmetric but market-fixable), ACCEPT-WITH-EYES-OPEN (unfavorable but common). Tie every grade to concrete exposure — who pays what, under which trigger.
7. Close with the licensed-attorney caveat and the reader-side assumption stated explicitly.

## Output format
A **Clause Risk Register**: table with columns `clause | location (§) | status (present/absent/asymmetric) | finding | exposure scenario | grade | suggested position`. Followed by a "Silent gaps" list (obligations the document never mentions) and the standing attorney caveat. Findings ordered DEAL-BREAKER first.

## Quality gate
FAIL if the register omits any clause from the step-3 fixed sweep list (absent clauses must appear with status=absent). FAIL if any finding lacks a concrete exposure scenario (who pays, how much, on what trigger). FAIL if the review side is unstated. PASS otherwise.

## Quality gate cross-check
Pick the single worst finding and verify it against the actual contract text — quote the clause verbatim. If the quote does not support the finding, the whole register is suspect: re-verify every DEAL-BREAKER.

## Integration
- Requires **jurisdiction-first** output as input; enforceability of non-competes, liability waivers, and choice-of-law depends on the pinned regime.
- Feeds **privacy-reach-triage** when the contract processes personal data (DPA terms, SCCs).
- Uses core **evidence-reasoning**: every finding quotes or pinpoints the clause (§ reference) — no finding from memory of "typical" contracts.
- Uses core **adversarial-disproof** on DEAL-BREAKER findings: attempt to construct the counterparty's benign reading before finalizing the grade.

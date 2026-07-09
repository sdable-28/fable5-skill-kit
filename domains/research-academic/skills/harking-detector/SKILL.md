---
name: harking-detector
description: Detect HARKing (hypothesizing after results are known), p-hacking signatures, and garden-of-forking-paths problems in a study writeup, results section, or analysis plan. Trigger phrases - "review my results section", "does this analysis hold up", "check for p-hacking", "is my hypothesis section honest", "pre-registration", "exploratory vs confirmatory". Use on any document that pairs hypotheses with statistical results. Do NOT use for choosing which statistical test to run (use statistical-analysis) or for auditing citation quality (use source-hierarchy-enforcer).
---

# HARKing Detector

## When invoked
1. Extract the stated hypotheses verbatim from the introduction, and the reported findings verbatim from the results. Build a two-column ledger.
2. Run the timeline test on each hypothesis: is there any artifact predating the data — pre-registration, grant aim, protocol, dated analysis plan, earlier draft? If no artifact exists, mark the hypothesis TIMELINE-UNVERIFIED. Do not accept "we always intended to" as an artifact.
3. Hunt suspicious fits: hypotheses that predict an interaction, subgroup, or nonlinearity that only makes sense after seeing the data; hypotheses whose direction matches every significant result and no non-significant one. Perfect hypothesis-result concordance across 4+ tests is itself a red flag — real confirmatory work has misses.
4. Scan for p-hacking signatures: a cluster of p-values in .01-.05 with none below .001; covariates that appear in some models without justification; outcome variables mentioned in methods but absent from results (outcome switching); sample sizes that differ across tables without an exclusion accounting; "marginally significant" language.
5. Count the forking paths: list every analytic decision (exclusions, transformations, covariate sets, subgroups, outcome operationalizations) and whether each was fixed before analysis. Undisclosed flexibility on 3+ decisions means reported p-values are uninterpretable as stated.
6. For each flagged item, draft the honest reframe: move the finding to an explicitly labeled exploratory section, or add the pre-dating artifact citation. Never recommend deleting a result to hide the problem — that is a second integrity violation, worse than the first.

## Output format
A **HARKing Audit** with three sections: (1) Hypothesis-Result Ledger with per-row status CONFIRMATORY-VERIFIED / TIMELINE-UNVERIFIED / LIKELY-HARKED; (2) P-hacking Signature List, each item citing the exact sentence or table cell; (3) Remediation Plan — per flagged item, the exact rewrite (confirmatory→exploratory relabel, artifact to cite, or disclosure sentence to add).

## Quality gate
PASS only if every hypothesis in the document has a status, every status of TIMELINE-UNVERIFIED or worse has a remediation entry, and the audit quotes at least one verbatim sentence per flag (no flag without anchored evidence). An audit that finds zero issues must state which pre-dating artifacts it verified — "found nothing" without named artifacts is a FAIL.

## Integration
Invoke adversarial-disproof on any CONFIRMATORY-VERIFIED label — try to break the timeline evidence before trusting it. Feed forking-path counts to statistical-analysis for multiplicity correction. Remediation rewrites flow to claims-boundary-auditor, since exploratory findings demand weaker generalization language. Run before so-what-extractor: implications built on HARKed findings are void.

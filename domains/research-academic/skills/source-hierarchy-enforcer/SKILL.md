---
name: source-hierarchy-enforcer
description: Enforce evidence-tier discipline on every citation in a research document or literature review. Trigger phrases - "check my sources", "is this citable", "literature review", "cite this", "source quality", "can I use this blog post/preprint/news article". Use whenever a claim is being attached to a reference, or a bibliography/reference list is being built or audited. Do NOT use for evaluating the statistical validity of a study's internal methods (use statistical-analysis) or for general web-source fact-checking outside an academic/report deliverable.
---

# Source Hierarchy Enforcer

## When invoked
1. Extract every claim-citation pair from the draft or reference list. One row per pair, not per source — the same source can be adequate for one claim and inadequate for another.
2. Classify each source into a tier: T1 primary empirical (peer-reviewed original data, RCTs, primary documents, datasets), T2 peer-reviewed synthesis (systematic reviews, meta-analyses), T3 peer-reviewed secondary (narrative reviews, textbooks, published commentary), T4 gray literature (preprints, dissertations, government/NGO reports, standards), T5 non-scholarly (news, blogs, vendor whitepapers, Wikipedia).
3. Classify each claim by weight: EMPIRICAL (asserts a finding), CONSENSUS (asserts field agreement), CONTEXT (background/definition), METHOD (justifies a design choice).
4. Apply the matching rule: EMPIRICAL claims require T1-T2; CONSENSUS requires T2 or 3+ independent T1s; CONTEXT tolerates T3-T4; T5 is citable only as an object of study, never as evidence. Flag every violation.
5. For each T1-T2 source cited from an abstract or a secondary mention, demand confirmation the primary text was actually read — a citation copied from another paper's reference list is a chain-of-custody failure. Flag it.
6. Check recency bias and its inverse: flag EMPIRICAL claims resting solely on sources >10 years old in fast-moving fields, and flag reviews that cite only the last 3 years when foundational work exists.
7. Check independence: if 3+ citations trace to the same lab, dataset, or author group, mark the claim as single-lineage, not multiply-supported.

## Output format
A **Citation Audit Table** with columns: `claim (verbatim) | source | tier | claim-weight | verdict (PASS / UPGRADE-NEEDED / STRIKE) | replacement action`. Below the table, a **Lineage Notes** list for any single-lineage clusters, and a one-line **Bibliography Health** score: percent of EMPIRICAL claims resting on T1-T2.

## Quality gate
PASS only if every EMPIRICAL claim in the document appears in the table with an explicit tier verdict, and zero claims carry a T5 source as evidence. If any row says UPGRADE-NEEDED without a named replacement action, the skill has not finished.

## Integration
Run before synthesis-matrix-builder — do not synthesize sources that will be struck. Feed STRIKE rows to adversarial-disproof as candidate weak points a reviewer will attack. Pairs with evidence-reasoning: the tier assigned here is the confidence ceiling for any downstream inference from that source. claims-boundary-auditor inherits the tier table to bound generalization language.

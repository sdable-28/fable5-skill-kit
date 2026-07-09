---
name: claims-boundary-auditor
description: Match every claim's generalization scope to the sample, design, and analysis that produced it, and generate the mandatory limitations section from the mismatches. Trigger phrases - "write the limitations section", "am I overclaiming", "check my abstract against my results", "external validity", "can I generalize this", "reviewer says overgeneralized". Use on discussion sections, abstracts, titles, and press-facing summaries after results exist. Do NOT use to detect whether hypotheses were retrofitted to results (use harking-detector) or to audit source quality (use source-hierarchy-enforcer).
---

# Claims Boundary Auditor

## When invoked
1. Extract the study's actual evidentiary footprint: sample (N, population, recruitment, geography, era), design class (experimental / quasi-experimental / observational / qualitative), measures used, and analysis run. This is the boundary. Write it down first, before reading any claim.
2. Extract every claim from title, abstract, discussion, and conclusion — these sections overclaim most; results sections rarely do. Include implicit claims: a title like "X improves Y" is a causal universal claim.
3. Audit each claim on four axes: CAUSALITY (causal verbs — "improves", "drives", "reduces" — require experimental design or defended identification; observational data gets "is associated with"); POPULATION (claims about "people/users/patients" from a WEIRD undergraduate or single-site sample must name the sampled population); CONFOUNDING (for any causal or comparative claim, list the top 2-3 uncontrolled confounders by name — "there may be confounders" is a non-answer); TEMPORAL/SETTING (cross-sectional data cannot support "leads to"; lab effects do not auto-transfer to field).
4. For each violation, write the corrected claim — the strongest sentence the footprint actually supports. Shrink scope, do not delete the claim: "improves recall" → "was associated with higher recall among first-year students at one university". Preserve whatever strength is legitimate; under-claiming is also a defect.
5. Build the limitations section FROM the violation list — each limitation names the constraint, the specific claims it bounds, and the concrete study that would lift it. Ban boilerplate limitations ("small sample size" with no consequence stated). A limitation that bounds no claim in the paper is filler; cut it.
6. Cross-check abstract and title last: they must not exceed the corrected claims. The abstract is where reviewers and press will quote from — it gets zero slack.

## Output format
(1) An **Evidentiary Footprint** block (sample / design / measures / analysis, 4 lines); (2) a **Claim Boundary Table**: `claim (verbatim, with section) | axis violated | corrected claim`; (3) a drafted **Limitations Section** where every paragraph maps to named rows of the table and names the study design that would lift it.

## Quality gate
PASS only if the footprint block was written before any claim was audited, every causal-verb claim in title and abstract appears in the table, every violation row contains a corrected claim (not just a flag), and every limitation paragraph cites at least one table row. FAIL if the limitations section contains any constraint that bounds no specific claim.

## Integration
Runs after harking-detector (exploratory findings get automatically tighter boundaries) and before so-what-extractor (ACTIONs must fit corrected claims, not original ones). Uses root-cause-first when a claim overreaches: determine whether the cause is language drift or a genuinely missing analysis — the second requires statistical-analysis, not a rewrite. Feed corrected claims to verified-done as the checklist for the final read-through of title, abstract, and conclusion.

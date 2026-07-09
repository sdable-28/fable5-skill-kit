# Common Patterns — Healthcare & Life Sciences

Recurring task shapes with reusable approaches. Match the incoming request to a pattern, then execute its template. Every pattern runs through the safety-trigger scan first.

---

## Pattern 1 — Appraise a Therapy/Efficacy Claim

**Trigger conditions:** "Does drug/intervention X work for Y?", "Is treatment A better than B?", a shared headline or study, a patient/friend anecdote about a prescribed therapy, "the doctor said it reduces risk by…".

**Standard approach:** Reframe to PICO. Locate the best evidence tier. Convert relative to absolute; compute NNT/NNH. Separate surrogate from hard endpoints. Surface the strongest counter-evidence and publication-bias risk. Assess applicability to the asker's population. Close informational.

**Template / checklist:**
- [ ] PICO stated (Population, Intervention, Comparator, Outcome)
- [ ] Best available evidence tier named
- [ ] Relative effect + absolute effect + NNT/NNH + baseline rate
- [ ] Endpoints classified surrogate vs hard
- [ ] Strongest counter-trial / disagreeing meta-analysis surfaced
- [ ] Publication-bias considered (missing negatives, sponsorship)
- [ ] Applicability to asker's population flagged
- [ ] Informational-not-advice close

**Variation to watch:** If the request is about an individual's own prescribed therapy, keep it general — appraise population evidence, route the individual decision to the treating clinician. If the "evidence" is a single small industry-funded trial, weight down and say so.

---

## Pattern 2 — Interpret a Diagnostic Test / Screening Result

**Trigger conditions:** "What does a positive X mean?", "Should I get screened for Y?", "How accurate is test Z?", sensitivity/specificity questions, screening-threshold debates.

**Standard approach:** Anchor pre-test probability (prevalence in the relevant population). Apply test characteristics (sensitivity/specificity or LR+/LR−). Compute post-test probability / PPV / NPV. Contrast with the low-prevalence intuition trap. For screening, weigh benefits against overdiagnosis, false positives, and downstream harms; cite the issuing body and note body disagreements.

**Template / checklist:**
- [ ] Pre-test probability / prevalence stated for the relevant population
- [ ] Sensitivity/specificity or LR+/LR− stated
- [ ] Post-test probability / PPV / NPV computed
- [ ] Low-prevalence false-positive trap addressed if relevant
- [ ] For screening: overdiagnosis / harm-benefit balance discussed
- [ ] Guideline body + year cited; disagreements flagged
- [ ] Jurisdiction flagged
- [ ] Informational close

**Variation to watch:** Rare disease + "very accurate" test = most positives are false positives — always run the numbers. Screening recommendations are contested (USPSTF vs ACS vs specialty societies); never present one as universal.

---

## Pattern 3 — Explain a Study / Meta-Analysis / Statistic

**Trigger conditions:** "Break down this study," "What does hazard ratio 0.72 mean?", "Is this meta-analysis trustworthy?", questions about NNT/OR/RR/ARR, "they found a significant effect."

**Standard approach:** Identify study design and its tier. Translate the headline statistic into plain absolute terms. Report effect size with CI; separate statistical from clinical significance. For meta-analyses, assess heterogeneity (I²), included-study quality, and funnel-plot/publication bias. Flag surrogate endpoints and p-hacking/multiplicity in subgroup or secondary findings.

**Template / checklist:**
- [ ] Study design and evidence tier identified
- [ ] Headline statistic translated to absolute terms + NNT/NNH
- [ ] Effect size + confidence interval reported
- [ ] Statistical vs clinical significance separated
- [ ] Meta-analysis: heterogeneity (I²), study quality, publication bias
- [ ] Primary (pre-registered) vs secondary/subgroup findings distinguished
- [ ] Surrogate endpoints labeled
- [ ] Informational close

**Variation to watch:** A significant subgroup with no multiplicity correction is hypothesis-generating, not a finding. High I² undermines a pooled estimate — report it. Composite endpoints can be driven by the softest component; decompose them.

---

## Pattern 4 — Map a Product to Its Regulatory Pathway

**Trigger conditions:** "What approval does this device/drug need?", "IND vs NDA vs 510(k)?", "How do phase trials work?", biosimilar/generic questions, "how long to get FDA approval?".

**Standard approach:** Classify the product (small-molecule drug, biologic, device class I/II/III, diagnostic, combination). Map to the correct pathway (IND→NDA/BLA for drugs/biologics; 510(k)/De Novo/PMA for devices; ANDA for generics; 351(k) for biosimilars). State the phase or submission requirements. Name the jurisdiction (FDA vs EMA differ) and flag divergences.

**Template / checklist:**
- [ ] Product classified (drug/biologic/device class/diagnostic/combination)
- [ ] Correct pathway named for the jurisdiction
- [ ] Phase requirements or submission type stated
- [ ] Key endpoints/evidence the regulator requires
- [ ] Jurisdiction named; FDA vs EMA divergence flagged
- [ ] Timeline/expedited-program note if relevant (Fast Track, Breakthrough, PRIME)
- [ ] Informational close — not legal/regulatory advice

**Variation to watch:** Device classification drives everything (510(k) predicate vs PMA). Combination products route by primary mode of action. Expedited pathways (Breakthrough, Accelerated Approval) rely on surrogate endpoints — flag the surrogate-vs-hard-outcome caveat.

---

## Pattern 5 — Operational / Coding / Interoperability Task

**Trigger conditions:** ICD-10/CPT/DRG coding, revenue-cycle logic, HL7/FHIR mapping, EHR workflow, fee-for-service vs value-based care questions, denial/claim analysis.

**Standard approach:** Identify the coding system and jurisdiction (ICD-10-CM is US-specific). Map the clinical scenario to codes with specificity (laterality, encounter type, complications). For interoperability, identify the standard (HL7 v2 message type, FHIR resource) and the mapping. Treat any patient data as PHI; use synthetic placeholders. State that final coding requires certified-coder/compliance review.

**Template / checklist:**
- [ ] Coding system + jurisdiction identified (ICD-10-CM/PCS, CPT, DRG, SNOMED)
- [ ] Codes mapped with required specificity (laterality, acuity, encounter)
- [ ] Interoperability: correct standard + resource/segment named (FHIR resource, HL7 segment)
- [ ] PHI handled — synthetic-only placeholders, no fabricated real-looking identifiers
- [ ] Compliance caveat: final code assignment requires certified coder/auditor
- [ ] Jurisdiction and payer-rule dependence flagged

**Variation to watch:** Coding errors are compliance and fraud exposure — never "guess" a code to fit a desired reimbursement. FHIR versions differ (DSTU2/STU3/R4/R5); confirm the version. Value-based vs fee-for-service changes the incentive logic of the whole analysis.

---

## Pattern 6 — Patient-Safety / Adverse-Event Analysis

**Trigger conditions:** "Analyze this near-miss," medication-error review, root-cause analysis, FMEA request, "how could this process fail?", incident-report structuring.

**Standard approach:** Apply a structured framework — RCA for a specific event that occurred (find contributing factors and the root cause, not blame), FMEA for prospective process risk (score severity × occurrence × detectability → RPN). Distinguish active failures from latent system conditions (Swiss-cheese model). Focus on system redesign over individual blame.

**Template / checklist:**
- [ ] Framework chosen and justified (RCA for occurred event, FMEA for prospective risk)
- [ ] Contributing factors mapped (human, system, environmental)
- [ ] Root cause vs symptom distinguished; latent vs active failures separated
- [ ] For FMEA: severity, occurrence, detectability scored → RPN
- [ ] System-level corrective actions prioritized over individual blame
- [ ] Recommendations mapped to the safety hierarchy (forcing functions > automation > reminders > education)

**Variation to watch:** Do not stop at "human error" — that is a symptom; find the latent condition. Blame-focused analysis is a failure mode. High-severity failures warrant forcing functions, not just training.

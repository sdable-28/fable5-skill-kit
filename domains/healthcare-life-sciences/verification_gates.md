# Verification Gates — Healthcare & Life Sciences

Domain-specific pass/fail gates. Run every gate before any clinical, research, operational, or life-sciences deliverable is declared done. A single fail blocks the output until corrected. These gates are in addition to — not a replacement for — core quality checks.

---

### Gate 1 — Evidence Tier Attached
**Passes:** every efficacy, harm, or causation claim names its study design and hierarchy tier (systematic review/meta-analysis of RCTs → RCT → cohort → case-control → case series → mechanistic/expert opinion).
**Fails:** any clinical claim asserted with no tier, or an unsupported "studies show" / "it is known that."
**How to check:** scan each declarative clinical sentence; if you cannot point to the tier word, it fails.

---

### Gate 2 — Relative Effect Has Absolute Companion
**Passes:** every relative measure (RRR, HR, OR, RR) appears with its absolute counterpart (ARR/ARI) and, where meaningful, NNT or NNH, with the baseline event rate stated.
**Fails:** "reduces risk by X%," a hazard ratio, or an odds ratio standing alone with no baseline and no absolute figure.
**How to check:** locate every percentage/ratio; confirm a baseline rate and absolute figure sit beside it. Recompute one NNT by hand (1/ARR) to confirm arithmetic.

---

### Gate 3 — Correlation/Causation Language Matches Design
**Passes:** causal verbs (causes, prevents, reduces) used only for randomized or strong quasi-experimental evidence; observational findings use "associated with / linked to."
**Fails:** "causes" or "prevents" applied to cohort, case-control, or cross-sectional data.
**How to check:** for each causal verb, trace back to the study design of the supporting evidence; downgrade language if observational.

---

### Gate 4 — Surrogate Endpoints Labeled
**Passes:** surrogates (LDL, HbA1c, blood pressure, tumor response, viral load, bone density, ejection fraction) are explicitly named as surrogates; hard outcomes (mortality, MI, stroke, fracture, hospitalization, QoL) named as such. Any hard-outcome benefit is backed by a trial powered on that outcome.
**Fails:** a surrogate improvement used to imply a hard-outcome benefit without dedicated evidence.
**How to check:** highlight every endpoint; classify each as surrogate or hard; confirm no unlicensed jump from one to the other.

---

### Gate 5 — Bayesian Context for Diagnostic Reasoning
**Passes:** any test-interpretation content states pre-test probability (or prevalence), test characteristics (sensitivity/specificity or LR+/LR−), and the resulting post-test probability or PPV/NPV.
**Fails:** a positive/negative result interpreted as diagnostic from sensitivity/specificity alone with no prevalence anchor.
**How to check:** confirm the three-part chain (pre-test → test characteristic → post-test) is present and directionally correct (a positive result raises probability, a negative lowers it).

---

### Gate 6 — Clinical Decision Rule Applied Correctly
**Passes:** any decision rule (HEART, Wells, CURB-65, PERC, CHA₂DS₂-VASc, Ottawa, Centor) is named, applied by exact validated criteria and cutoffs, and used only within its validated indication/population.
**Fails:** improvised criteria, altered cutoffs, wrong indication (e.g., Wells-DVT used for PE), or a rule applied outside its derivation setting.
**How to check:** enumerate the rule's official inputs; confirm each is used correctly; confirm the indication matches.

---

### Gate 7 — Terminology and Units Verified
**Passes:** drug names (generic + brand), units (mg/mcg/mL/units/IU), routes, frequencies (QD/BID/TID/QID/PRN), and anatomical terms are precise; abbreviations expanded on first use; no homophone/collision ambiguity in load-bearing positions.
**Fails:** ambiguous abbreviation (MS, PT, DC), near-homophone confusion (ureter/urethra, hypo/hyper), or a unit/magnitude that is unverified or inconsistent.
**How to check:** read every unit and every abbreviation as an isolated token; confirm it maps to exactly one clinical meaning in context. For any dose figure, confirm order of magnitude against a primary reference — or engage deferral.

---

### Gate 8 — Jurisdiction Flagged
**Passes:** whenever approval status, controlled-substance scheduling, coding system (ICD-10-CM vs ICD-10 WHO), scope-of-practice, or guideline applicability depends on country, the assumed jurisdiction is named and the dependency flagged.
**Fails:** jurisdiction-specific content presented as universal, or coding/regulatory claims with no country stated.
**How to check:** ask "would this differ in another country?"; if yes, confirm the flag is present.

---

### Gate 9 — Safety Deferral for Hard Triggers
**Passes:** any content touching (a) controlled substances, (b) specific individualized dosing/titration, or (c) an emergency/time-critical scenario explicitly routes the actionable decision to a licensed professional or emergency services and does not produce the individualized instruction.
**Fails:** an opioid conversion schedule, a benzodiazepine taper, a pediatric dose calculation, or differential-diagnosis triage of active emergency symptoms is produced as actionable output.
**How to check:** run the three-trigger scan; for any hit, confirm the deferral is present and no individualized actionable instruction survives.

---

### Gate 10 — Counter-Evidence Surfaced
**Passes:** for any efficacy/safety claim, the strongest contradicting trial, failed replication, or disagreeing meta-analysis is presented; publication-bias risk is considered (missing negative trials, funnel asymmetry, sponsorship).
**Fails:** one-sided evidence presentation even when cited studies are real; uniformly positive evidence base accepted without asking where the negatives are.
**How to check:** confirm at least one genuine counter-consideration or an explicit statement that the evidence is consistent and why.

---

### Gate 11 — Statistical vs Clinical Significance Separated
**Passes:** effect size and confidence interval reported; significance interpreted against a minimal clinically important difference, not by p-value alone. Subgroup/secondary findings flagged as hypothesis-generating.
**Fails:** "significant (p<0.05)" carrying the interpretive weight with no effect size, or a subgroup finding presented as established.
**How to check:** for each significance claim, confirm the magnitude and CI are present and the clinical meaning is addressed.

---

### Gate 12 — Informational Frame and No Fabricated Citations
**Passes:** clinical content closes with the explicit informational-analysis-not-medical-advice frame; every specific citation is one that can be grounded, and where a specific reference is unavailable the evidence type is described with a note that the citation must be confirmed. No fabricated patient data presented as real; synthetic data clearly marked.
**Fails:** a missing informational frame on individualized clinical content; an invented trial name/journal/DOI; realistic-looking patient identifiers that could be mistaken for PHI.
**How to check:** confirm the closing frame is present; audit each citation for groundedness; confirm any example data is unmistakably synthetic.

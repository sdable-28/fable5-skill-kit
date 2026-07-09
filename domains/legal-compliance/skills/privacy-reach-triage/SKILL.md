---
name: privacy-reach-triage
description: >
  Determine which privacy regimes actually attach to a specific data flow, and what that
  attachment obligates — GDPR extraterritoriality, CCPA/CPRA thresholds, HIPAA PHI status,
  cross-border transfer mechanics (SCCs, adequacy, DPAs). Trigger phrases: "does GDPR apply to
  us", "can we send this data to X", "do we need a DPA", "is this PHI", "cookie/tracking
  compliance", "data residency". The signature failure this prevents: assuming a non-EU company
  is outside GDPR. Do NOT use for general security-control assessment against a framework (use
  compliance-gap-mapper), or for contract clause review where data terms are one clause among
  many (use contract-risk-scan and pull this skill in only for the data clauses).
---

# privacy-reach-triage

## When invoked
1. Draw the data flow before citing any law: what data elements, about whom, collected where, stored where, processed by whom (controller/processor/sub-processor roles named), transferred to which countries. No regime analysis until this map exists — privacy law attaches to flows, not to companies in the abstract.
2. Classify the data honestly at the element level: personal data vs. special-category (GDPR Art. 9) vs. PHI (only if a HIPAA covered entity/BA relationship exists — health data outside that relationship is NOT PHI, a chronic misclassification in both directions) vs. cardholder data vs. de-identified (state the de-identification standard used; "we removed names" is not de-identified).
3. Run extraterritoriality checks in this order, and never conclude "doesn't apply" from the company's home country alone:
   - GDPR Art. 3(2): offering goods/services to people in the EU (currency, language, shipping signals) or monitoring their behavior (analytics, tracking pixels) attaches GDPR to entities with zero EU presence.
   - CCPA/CPRA: revenue/volume/selling thresholds against California residents.
   - Other regimes flagged by the jurisdiction-first block (UK GDPR, PIPEDA, LGPD, state laws like VCDPA/CPA).
4. For each attached regime, derive the concrete obligation set for THIS flow: lawful basis, notice, data-subject rights plumbing, DPA/BAA requirement, breach-notification clock, and transfer mechanism. For any EU→third-country transfer, name the mechanism (adequacy decision, SCCs + transfer impact assessment, BCRs) — "we'll use SCCs" without module selection and TIA is an open item, not a solution.
5. State retention and minimization consequences: attached regimes convert "keep everything forever" into a finding.
6. Close with the attorney caveat, noting that privacy enforcement positions shift quickly — route all attachment conclusions through **authority-hierarchy-check** with currency flags.

## Output format
A **Data Flow Attachment Map**: (a) the flow diagram in text form (element → role → location → transfer), (b) a table `regime | attaches? (YES/NO/LIKELY) | attachment trigger | obligations for this flow | transfer mechanism required | open items`, (c) an "assumed facts" list whose falsification would flip any YES/NO, (d) the attorney caveat.

## Quality gate
FAIL if any regime is marked NO with reasoning that references only the company's home jurisdiction. FAIL if a YES row for GDPR involving a third-country transfer names no transfer mechanism. FAIL if health-related data is labeled PHI (or not-PHI) without the covered-entity/BA test stated. PASS otherwise.

## Integration
- Consumes the **jurisdiction-first** block; extends it with flow-level attachment that jurisdiction-first only gestures at.
- Feeds **compliance-gap-mapper** the list of mandatory regimes and **contract-risk-scan** the required DPA/BAA/SCC terms to look for in counterparty paper.
- All attachment conclusions pass through **authority-hierarchy-check** before shipping (privacy is the fastest-moving currency-risk area).
- Uses core **root-cause-first** on any discovered violation: fix the flow (minimize, relocate, re-role), not just the notice text describing it.

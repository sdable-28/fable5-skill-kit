# Common Patterns — Legal & Compliance

Framing rule for every pattern below: output is analysis support, not legal advice. Specific advice requires a licensed attorney in the relevant jurisdiction. State this once per deliverable, prominently.

## 1. Contract Redline Review (MSA/NDA/SLA/employment)
**Trigger:** Counterparty sends a draft or redline; user asks "what should I push back on?"
**Approach:** 1. Establish governing law and venue clause first — it controls interpretation of everything else. 2. Identify the user's side (customer/vendor, discloser/recipient, employer/employee) and read every clause from that posture. 3. Sweep the risk-allocation core: indemnification, limitation of liability (cap + carve-outs), IP ownership/license scope, warranties, termination rights. 4. Check definitions against operative clauses — a broad "Confidential Information" definition with a narrow use restriction leaks. 5. Flag missing clauses (silence is a position): no liability cap, no data-protection terms, no assignment restriction. 6. Rank findings: deal-breaker / negotiate / accept-with-note.
**Template:** `| Clause § | Issue | Risk to [party] | Market position | Proposed redline | Priority |`
**Variation:** Carve-outs from the liability cap (indemnity, confidentiality breach, gross negligence) silently swallow the cap — always trace what the cap does NOT cover before pronouncing the cap "standard."

## 2. Jurisdiction & Applicability Determination
**Trigger:** Any "does law X apply to us?" question — GDPR, CCPA, state non-compete bans, securities rules.
**Approach:** 1. Refuse to analyze until facts are pinned: entity's place of incorporation, where users/employees/customers sit, where data or money flows. 2. Map each fact to the statute's territorial/threshold triggers (GDPR Art. 3 targeting; CCPA revenue/records thresholds; blue-sky state nexus). 3. Cite the primary source section for each trigger, not a blog summary. 4. State the conclusion as conditional: "If [fact], then [law] likely applies because [cited trigger]."
**Checklist:** [ ] Entity domicile [ ] Customer/user locations [ ] Employee locations [ ] Data flows [ ] Revenue thresholds [ ] Statutory trigger cited to section [ ] Effective/amendment date of statute checked
**Variation:** GDPR extraterritoriality is chronically underestimated — offering goods/services to EU residents or monitoring their behavior triggers it with zero EU presence. Never conclude "no EU entity, no GDPR" without the Art. 3(2) analysis.

## 3. Compliance Gap Assessment (SOC 2 / ISO 27001 / HIPAA / PCI DSS)
**Trigger:** Customer security questionnaire, audit-prep request, or "are we HIPAA compliant?"
**Approach:** 1. Fix the scope: which framework, which trust criteria/controls, which systems in-scope. 2. Enumerate the framework's control list from the authoritative source (AICPA TSC, ISO Annex A, HIPAA Security Rule safeguards, PCI DSS requirements). 3. For each control, demand evidence, not assertion: policy doc, config screenshot, log, ticket. 4. Grade each: Implemented / Partial / Missing / Not-applicable-with-justification. 5. Sequence remediation by audit-blocking severity, then effort.
**Template:** `| Control ID | Requirement | Evidence found | Status | Gap | Remediation owner | Target date |`
**Variation:** "Compliant" claimed from a policy document that no one follows — the auditor tests operating effectiveness, not paper. Every "Implemented" needs evidence the control ran within the review period.

## 4. Regulatory Change Impact Memo
**Trigger:** New statute, amendment, or agency rule announced (state privacy law, SEC rule, FTC non-compete action); user asks "does this affect us?"
**Approach:** 1. Pull the primary text and confirm status: proposed / final / enjoined / effective date. Regulatory lag and litigation stays change everything. 2. Extract who is covered, what is required, when, and penalties. 3. Diff against current obligations — often the new rule duplicates existing GDPR/CCPA work. 4. List concrete deltas: new notices, new consents, new filings, contract amendments. 5. Date-stamp the memo and state the next checkpoint (comment deadline, effective date, pending appeal).
**Template:** header block — `Rule: / Status as of [date]: / Effective: / Covered entities: / Net-new obligations: / Existing coverage: / Action items + deadlines: / Re-check date:`
**Variation:** Analyzing a proposed or enjoined rule as if it were in force. Verify current status the day you write — a rule vacated last month invalidates last quarter's memo.

## 5. Founder/Startup Document Sanity Check (term sheet, option grant, DPA)
**Trigger:** User received a term sheet, equity grant, or vendor DPA and wants a plain-English decode before paying counsel.
**Approach:** 1. Identify document type and the 5–8 economic/control terms that dominate it (term sheet: valuation, liquidation preference, board seats, pro rata, anti-dilution; option grant: vesting, cliff, exercise window, 409A price, acceleration; DPA: processor role, subprocessors, SCCs, breach notice window). 2. Translate each into one sentence of consequence: "1x non-participating preference means investors take $X before common sees anything." 3. Compare against the stated market norm and name the norm source. 4. Output a question list for their attorney — the deliverable is better questions, not a signature decision.
**Checklist (term sheet):** [ ] Valuation pre/post [ ] Preference multiple + participation [ ] Anti-dilution formula [ ] Board composition [ ] Protective provisions [ ] Pro rata rights [ ] Drag-along [ ] Exclusivity/no-shop period
**Variation:** Over-confident "this is standard" without noting stage/geography — a 2x participating preference reads differently in a bridge round vs. a Series A, and Delaware norms are not everywhere's norms.

## 6. Employment Classification & Restrictive Covenant Check
**Trigger:** Hiring a contractor, drafting an offer with a non-compete, or converting contractor→employee.
**Approach:** 1. Jurisdiction first — non-compete enforceability ranges from void (California) to reasonable-scope tests; classification tests differ (IRS common-law vs. state ABC tests). 2. Run the applicable classification factors against the actual working relationship, not the contract label. 3. For covenants, test scope (duration, geography, activity) against that state's reasonableness case law and any statutory bans. 4. Flag misclassification exposure in concrete terms: back taxes, penalties, benefits claims.
**Checklist:** [ ] State(s) of worker [ ] Classification test that governs [ ] Control/independence facts [ ] Covenant type (non-compete/non-solicit/NDA) [ ] Statutory ban or income threshold [ ] Garden-leave/consideration requirement [ ] Attorney referral stated
**Variation:** Applying the contract's choice-of-law clause to the covenant — many states (CA, WA, CO) override foreign choice-of-law for their resident workers. The worker's state usually wins.

# Legal & Compliance — Verification Gates

Domain-specific pass/fail gates. This is analysis support, not legal advice — specific advice requires a licensed attorney in the relevant jurisdiction. Run before delivering any legal or compliance analysis.

### Gate 1 — Not-Legal-Advice Framing
- **Pass:** The deliverable states it is informational analysis and that specific advice requires a licensed attorney in the relevant jurisdiction.
- **Fail:** The analysis reads as definitive legal advice with no disclaimer.
- **Check:** Confirm the framing line is present and prominent.

### Gate 2 — Jurisdiction Established First
- **Pass:** Governing law and jurisdiction are pinned before any substantive analysis.
- **Fail:** Analysis proceeds without stating which law applies.
- **Check:** Confirm the jurisdiction is named before the first legal conclusion.

### Gate 3 — Primary-Source Authority
- **Pass:** Every rule-assertion cites primary authority (statute, regulation, case) of the correct rank for the pinned jurisdiction.
- **Fail:** Conclusions rest on secondary sources or memory with no citation.
- **Check:** Each legal claim has a primary citation; verify the source exists and says what's claimed.

### Gate 4 — Extraterritorial Reach
- **Pass:** Cross-border regimes (GDPR Art. 3(2), CCPA thresholds, FCPA) are checked for reach even when the entity is elsewhere.
- **Fail:** Foreign-law applicability is assumed away because the company is domestic.
- **Check:** Confirm each applicable regime's reach test was run against the actual data/activity flows.

### Gate 5 — Carve-Out Completeness
- **Pass:** Contract review checks that indemnities, limitations, and warranties have the carve-outs that prevent unintended liability.
- **Fail:** A missing carve-out silently expands liability and goes unflagged.
- **Check:** For each risk-allocation clause, confirm the standard carve-outs are present or their absence is flagged.

### Gate 6 — Regulatory-Currency
- **Pass:** Cited law is confirmed current; regulatory-lag or pending changes are flagged.
- **Fail:** Superseded or amended law is cited as current.
- **Check:** Confirm the effective/amended date of each cited rule and flag anything the technology has outpaced.

### Gate 7 — Compliance-Control Evidence
- **Pass:** Each framework control (SOC 2, ISO 27001, HIPAA, PCI DSS) is marked MET/PARTIAL/GAP/UNKNOWN with evidence required for MET.
- **Fail:** Controls marked satisfied on assertion with no evidence.
- **Check:** Confirm every MET has an evidence pointer; every UNKNOWN is listed, not hidden.

### Gate 8 — Confidence Calibration on Conclusions
- **Pass:** Legal conclusions carry explicit confidence and name what a licensed attorney must confirm.
- **Fail:** A firm conclusion is stated where the law is unsettled or fact-dependent.
- **Check:** Confirm uncertain conclusions are labeled and routed to attorney review.

### Gate 9 — Classification Rigor
- **Pass:** Employment vs. contractor and security-vs-non-security determinations apply the actual multi-factor test, not a label.
- **Fail:** A classification is asserted by title without running the test.
- **Check:** Confirm the governing test's factors are each addressed for the pinned jurisdiction.

### Gate 10 — Privacy Data-Flow Mapping
- **Pass:** Privacy analysis maps actual data flows (what personal/PHI data, from whom, to where) before applying a regime.
- **Fail:** A privacy conclusion is drawn without knowing the data flow.
- **Check:** Confirm a data-flow map exists and each regime is attached at the flow where it triggers.

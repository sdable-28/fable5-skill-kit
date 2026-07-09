---
name: compliance-gap-mapper
description: >
  Map an organization's current state against a named compliance framework (SOC 2, ISO 27001,
  HIPAA, PCI DSS, GDPR, FINRA/SEC rules, OSHA, ADA, FCPA) and produce a control-level gap
  register. Trigger phrases: "are we SOC 2 ready", "HIPAA gap analysis", "what do we need for
  ISO 27001", "PCI compliance check", "audit readiness". Do NOT use for reviewing a single
  contract (use contract-risk-scan), for deciding WHICH framework applies (that is
  jurisdiction-first / privacy-reach-triage territory), or for generic security hardening with
  no named framework as the yardstick.
---

# compliance-gap-mapper

## When invoked
1. Pin the exact framework version and scope boundary before mapping anything: SOC 2 Type I vs Type II and which Trust Services Criteria; ISO 27001:2022 vs 2013; PCI DSS 4.0 SAQ type and cardholder-data-environment boundary; HIPAA covered-entity vs business-associate role. A gap register against an unversioned framework is invalid — frameworks change and regulatory lag cuts both ways.
2. Confirm applicability first (via **jurisdiction-first** / **privacy-reach-triage** output): do not map HIPAA controls for an org that is neither covered entity nor business associate. Scoping errors waste the entire exercise.
3. Enumerate the framework's controls/requirements from the primary source (the standard text, the regulation, the SAQ), not from a blog summary. Where the primary text is unavailable, mark the enumeration itself as UNVERIFIED.
4. For each control, demand evidence of the current state — a policy document, a config, a screenshot, a process owner's name. Classify: MET (evidence exists), PARTIAL (practice exists, evidence/formalization missing), GAP (nothing), N/A (out of scoped boundary, with justification), UNKNOWN (could not verify). "We probably do that" is UNKNOWN, never MET.
5. Distinguish the two failure modes auditors actually test: control not designed (no policy) vs. control not operating (policy exists, nobody follows it). A written policy with no operating evidence is PARTIAL at best.
6. Prioritize gaps by audit consequence, not effort: gaps that block certification/attestation outright > gaps auditors note as exceptions > hygiene. For regulated frameworks (HIPAA, PCI, FINRA), attach the enforcement exposure (fines, breach-notification duties) to each blocking gap.
7. Close with the attorney/qualified-assessor caveat: gap analysis supports preparation; formal attestation requires a licensed auditor/QSA/assessor, and legal exposure questions require counsel.

## Output format
A **Gap Register**: header block (framework + version, scope boundary, assessment date, evidence sources consulted) then a table `control ID | control text (abridged) | status (MET/PARTIAL/GAP/N-A/UNKNOWN) | evidence cited or missing | remediation | priority (BLOCKING/EXCEPTION/HYGIENE)`. Followed by a summary count per status and the qualified-assessor caveat.

## Quality gate
FAIL if any control is marked MET without a named piece of evidence. FAIL if framework version or scope boundary is missing from the header. FAIL if the register contains zero N/A and zero UNKNOWN entries across a full framework (signals rubber-stamping, not assessment). PASS otherwise.

## Integration
- Consumes **jurisdiction-first** and **privacy-reach-triage** to settle which frameworks are mandatory vs. voluntary for this org.
- Sends contractual compliance obligations it discovers (customer DPAs promising SOC 2, BAAs) to **contract-risk-scan** for the reverse check: what did we already promise in writing?
- Uses core **verified-done**: a gap is closed only when its evidence artifact exists and is cited — never when remediation is merely "planned".
- Uses core **statistical-analysis** for sampling-based controls (access reviews, change tickets): state sample size and selection method, or mark the control PARTIAL.
- Uses **authority-hierarchy-check** to verify the framework text cited is current (PCI 4.0 retired 3.2.1; HIPAA Security Rule updates).

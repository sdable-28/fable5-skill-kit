# Legal & Compliance — Domain Pack

> **Standing disclaimer rule:** Every deliverable in this domain is analysis support, not legal advice. State this once, prominently, at the top of every output. Do not repeat it after every paragraph — one clear framing statement plus a closing escalation note ("engage licensed counsel in [jurisdiction] before acting") is the standard. Omitting it entirely is a gate failure (see verification_gates.md, Gate 1).

---

## 1. Domain Overview

### What makes this domain unique for AI

Legal work is adversarial by construction. Every contract clause, every regulatory position, every compliance control will eventually be read by someone whose incentive is to break it — opposing counsel, a regulator, an auditor, a plaintiff's attorney. Code fails when it hits an edge case; legal text fails when it hits a motivated adversary. Draft and review accordingly: the question is never "does this clause say what we mean," it is "what is the worst reading a hostile party can extract from this clause."

Three structural properties dominate:

1. **Jurisdiction is the type system.** A legally correct answer under Delaware law can be void under California law (non-competes), and a compliant data flow under CCPA can be an infringement under GDPR. There is no "the law" — there is only "the law of X as applied to facts Y at time Z." Analysis without an established jurisdiction is not incomplete; it is meaningless, the way `x + y` is meaningless without types.
2. **Authority is hierarchical and dated.** A statute beats a regulation beats a case beats a treatise beats a blog post — but only if it is still good law. Legal knowledge decays: cases get overruled, statutes get amended, regulations get vacated. Training-data knowledge of law is presumptively stale. Every load-bearing legal claim needs a citation and a currency check.
3. **Omissions are the dominant failure mode.** In code, missing logic usually crashes visibly. In contracts, a missing carve-out, a missing survival clause, or a missing cap exclusion sits silently for years and detonates during a dispute. Review work is therefore coverage work: the checklist of what MUST be present matters more than critique of what IS present.

### Where AI adds most value

- **Coverage and completeness.** Clause-by-clause contract review against a canonical checklist; cross-reference integrity ("Section 8.2 references Section 12.4 which does not exist"); defined-term consistency; finding the clause that ISN'T there. Humans skim; run exhaustively.
- **First-pass issue spotting at scale.** Reading a 90-page MSA and surfacing the 12 provisions that deviate from market, ranked by exposure.
- **Cross-framework mapping.** SOC 2 CC6.1 ↔ ISO 27001 A.9 ↔ HIPAA §164.312(a) control crosswalks — mechanical, high-volume, exactly the work humans do badly.
- **Structured risk framing.** Converting a pile of findings into severity × likelihood × exposure with explicit assumptions, so a human decision-maker can triage.
- **Plain-language translation** in both directions: legalese → business impact, business intent → issues list for counsel.
- **Regulatory horizon scanning** — identifying which regimes plausibly apply to a described activity (the "you have an EU-shaped problem" alarm).

### Where to defer to human expertise — hard stops

- **Never render a legal conclusion as advice.** "This contract is enforceable," "you can safely classify these workers as contractors," "this offering qualifies for the Reg D exemption" — these are practice-of-law outputs. Deliver the analysis, the factors, the risk framing, and the explicit hand-off: a licensed attorney in the relevant jurisdiction must make the call.
- **Never sign off on filings.** Securities filings, patent applications, court submissions, HSR filings — analysis support only.
- **Litigation strategy and privilege.** Flag privilege issues (e.g., "routing this analysis through counsel may preserve privilege; done directly, it may be discoverable") but do not manage privilege.
- **Anything where the user's facts are thin.** Legal answers are fact-pivoting. If the facts that determine the answer are missing (e.g., worker classification without knowing degree of control), the correct output is the list of determinative facts, not a guess.
- **Novel or unsettled law.** Where circuits split, where a regulation is under challenge, where technology outruns the statute — present the split, do not resolve it.

---

## 2. Core Principles

Falsifiable, checkable rules. A reviewer can audit any output against these.

1. **Jurisdiction before analysis, always.** No substantive legal statement until governing law is established or explicitly assumed. If the user hasn't specified, either ask, or state the assumption in the first three lines of output ("Assuming Delaware corporate law and California employment law based on: HQ in SF, DE C-corp"). An output that analyzes "the law" without naming whose law fails review.
2. **Every load-bearing legal claim carries a citation to a primary source or an explicit uncertainty flag.** "GDPR requires a DPA with processors" → cite Art. 28(3). "Courts generally enforce liability caps" → that's a generalization; flag it as one and name at least the doctrine (unconscionability, gross-negligence carve-out) that limits it. No naked authority.
3. **Date-stamp legal knowledge.** State the as-of date of the analysis and flag every area known to be moving (AI regulation, state privacy laws, non-compete enforceability, crypto/securities). Training data is presumptively stale for: enacted-within-2-years statutes, pending litigation, agency guidance. If currency cannot be verified, say "verify current status — this area changed materially in [year] and may have changed since."
4. **Never state a conclusion with more confidence than the weakest authority supporting it.** A conclusion resting on one district court case is "a court has held"; on a circuit split is "unsettled — courts divide"; on a statute's plain text is "the statute provides." Match the verb to the authority.
5. **Contract review is coverage-first, critique-second.** Run the missing-provisions checklist for the contract type BEFORE analyzing the provisions that exist. Report must contain a "provisions expected but absent" section. A review with no absence-analysis is incomplete regardless of how good the clause commentary is.
6. **Read every clause as the counterparty's litigator.** For each material clause, articulate the most hostile plausible reading and whether the drafting survives it. If you cannot construct the hostile reading, you have not finished reading the clause.
7. **Trace every defined term and cross-reference.** Verify each capitalized term is defined exactly once, each definition is actually used, each section cross-reference points to an existing section that says what the referencing clause assumes. Report dangling references as defects, not nitpicks — they are ambiguity fuel in disputes.
8. **Exceptions and carve-outs are the deal.** Liability cap: what's excluded from it (indemnity? confidentiality breach? IP? gross negligence?). Non-compete: what activities survive? License grant: what's carved back? Analyze the exception structure of every risk-allocation clause explicitly. A cap analyzed without its exclusions is analyzed wrong.
9. **GDPR reach is presumed, not assumed away.** Any scenario involving personal data plus ANY of: EU users, EU employees, monitoring behavior of people in the EU, offering goods/services to the EU → run the Art. 3 extraterritoriality analysis explicitly before concluding GDPR is out of scope. "US company, US servers" does NOT end the inquiry.
10. **Distinguish legal risk from enforcement risk from reputational risk.** "Technically violates X but never enforced against companies like yours" and "compliant but will look terrible in discovery" are different findings. Label which kind every finding is.
11. **Regulatory lag cuts both ways — say which way.** Where law hasn't caught up to the technology (AI training data, biometric inference, tokenized assets), state (a) the closest existing regime and how a regulator would stretch it, and (b) the direction pending rules are moving. "No law directly on point" is the START of that analysis, never the conclusion.
12. **Compliance frameworks are floors with scopes.** Before mapping controls, establish scope: SOC 2 covers what the audit covers; PCI DSS applies to the cardholder data environment as scoped; HIPAA applies to covered entities and business associates, not "health-adjacent data" generally. A framework finding without a scoping statement is unverifiable.
13. **Facts before law.** When the legal answer pivots on facts not provided (control factors for worker classification, "sale" of data for CCPA, investor accreditation status), enumerate the determinative facts as questions before analyzing. Guessing facts to complete an analysis is fabrication.
14. **Both-sides drafting check.** Before proposing contract language, state which party it favors and what the counterparty will demand in response. One-sided language proposed without noting its one-sidedness misleads the user about negotiability.
15. **Escalation triggers are explicit outputs.** Every deliverable ends with a specific "engage licensed counsel when/for" list — not a generic disclaimer but concrete triggers ("before sending this redline," "before the Reg D filing," "before terminating this employee"). Generic boilerplate alone fails the gate.

---

## 3. Master Framework — Legal & Compliance Adaptation

### Stage 1 — Understand
Establish the legal frame before the substantive question.
- **Identify the true question behind the question.** "Review this NDA" usually means "can I sign this without getting hurt." "Are we GDPR compliant" usually means "what's our exposure and what do we fix first." Restate the operative question.
- **Jurisdiction triage (mandatory, first).** Which entity, formed where, operating where, counterparty where, users/data subjects where, governing-law clause says what. Run the `jurisdiction-triage` skill. Output: governing law per issue (corporate issues can be Delaware while employment issues are California — layered, not singular).
- **Role and posture.** Whose side is the user on (buyer/seller, employer/employee, controller/processor)? Reviewing, drafting, or negotiating? Pre-signature or post-dispute? Posture changes everything.
- **Fact inventory.** List the determinative facts you have and the ones you don't. Missing determinative facts become explicit questions or labeled assumptions — never silent guesses.
- Tools: jurisdiction-triage skill, fact/assumption ledger, party-posture statement.

### Stage 2 — Decompose
Legal problems decompose by issue, and each issue carries its own law.
- **Issue-spot exhaustively before analyzing anything.** IRAC discipline: enumerate every Issue first. For a contract: every risk-allocation axis (liability, indemnity, IP, confidentiality, term/termination, payment, warranties, compliance flow-downs, dispute resolution). For a compliance question: every plausibly applicable regime.
- **Assign law per issue.** The employment issue and the IP-assignment issue in the same agreement may be governed differently. Build the issue × jurisdiction matrix.
- **Separate the three risk channels** per issue: legal validity, enforcement likelihood, reputational/discovery exposure.
- **Rank by exposure, not by document order.** Analyze the liability cap before the notice provision.
- Tools: issue matrix (issue | governing law | authority needed | facts needed | exposure rank), contract-type coverage checklist.

### Stage 3 — Plan
- **Plan the authority hunt.** For each issue: what primary source resolves it (statute section, regulation cite, controlling case)? What is the fallback if no primary source is on point (persuasive authority, agency guidance, market practice)? Where currency matters, plan the verification (recent amendments, pending rules).
- **Set the confidence ceiling per issue in advance.** Some issues will end at "unsettled — here are the factors"; decide that before drafting so you don't drift into false certainty under narrative momentum.
- **Plan deliverable shape for the audience.** GC gets an issues memo with cites; a founder gets a risk-ranked summary with cites in footnotes; a redline gets in-document comments. Same analysis, different container.
- **Plan-gate:** For any multi-document or multi-regime task, present the issue matrix and analysis order before executing. Cheap to fix a wrong frame; expensive to redo a 40-clause review under the wrong governing law.

### Stage 4 — Execute
- **IRAC per issue:** Issue → Rule (with citation and currency note) → Application (to THESE facts, flagging assumed facts) → Conclusion (with confidence matched to authority per Principle 4).
- **Contracts: two passes, always.** Pass 1 coverage (checklist of expected provisions, mark present/absent/deviant). Pass 2 adversarial (hostile reading of each material clause, exception-structure analysis, cross-reference trace). Never merge the passes — coverage discipline collapses when you start critiquing mid-inventory.
- **Write the hedge into the sentence, not around it.** "Section 7's cap likely excludes indemnity obligations (the carve-out in 7.3(b) is standard but the 'arising from' language is ambiguous — a court could read it narrowly)" beats a clean conclusion followed by a paragraph of throat-clearing.
- **Quote operative language verbatim** when analyzing it. Paraphrased contract language is a defect source — the analysis must be checkable against the actual words.

### Stage 5 — Verify
Run the gates in verification_gates.md. Domain-specific verification:
- **Jurisdiction audit:** every conclusion traceable to the established governing law. Grep the draft for legal claims; each must sit under a named jurisdiction.
- **Citation audit:** every "the law requires/provides/prohibits" sentence has a cite or an uncertainty flag. Every cite is real (never fabricate — a plausible-looking fake citation is the single most damaging output this domain can produce; if you cannot verify a citation exists, cite the doctrine generically and flag it).
- **Coverage audit (contracts):** the absent-provisions list was produced from the checklist, not from memory of what "feels missing."
- **Adversarial audit:** for each material conclusion, is the strongest counter-argument stated? If a section has no counter-argument, either the point is trivial or the analysis is one-sided — decide which.
- **Fact-dependency audit:** every assumed fact appears in the assumptions ledger AND the conclusion it supports is conditioned on it.

### Stage 6 — Self-Correct
- When verification finds a jurisdiction error (US framework applied to EU facts, wrong state's employment law), **re-run the affected issues from the Rule step, not from the Conclusion step.** Patching conclusions while keeping the wrong-rule reasoning is the domain's signature self-correction failure.
- When a citation cannot be verified: downgrade the claim's confidence, restructure the sentence to survive without the cite, and flag for counsel verification. Do not shop for a substitute citation that "probably says the same thing."
- When the hostile-reading pass breaks proposed contract language, redraft the language, don't defend it.

### Stage 7 — Iterate
- Feed dispute/negotiation outcomes back into the checklists: every clause the counterparty attacked that the review didn't flag becomes a checklist entry.
- Track moving-law areas encountered; maintain the "verify currency" list per regime.
- After every engagement, update the missing-provisions checklist for that contract type with anything discovered absent-and-costly.

---

## 4. Pitfalls Checklist

1. **Jurisdiction smearing.**
   - *Looks like:* Analyzing a non-compete for a Lisbon-based employee under US state-law standards; citing the FTC non-compete rule for a UK contractor; applying Delaware fiduciary standards to a German GmbH.
   - *Detection:* Output contains legal standards from a jurisdiction never established as governing; the word "generally" doing jurisdictional work ("non-competes are generally enforceable if reasonable").
   - *Prevention:* Jurisdiction-triage before any rule statement; per-issue governing-law column in the issue matrix; final grep for legal claims not anchored to a named jurisdiction.

2. **GDPR extraterritoriality underestimation.**
   - *Looks like:* "US SaaS company, no EU office, so GDPR doesn't apply" — while the product has EU users, prices in EUR, or tracks EU visitor behavior. Art. 3(2) targeting/monitoring tests ignored.
   - *Detection:* GDPR ruled out in one sentence; no Art. 3 analysis in a personal-data scenario with any cross-border element.
   - *Prevention:* Principle 9 — Art. 3(2)(a) (offering goods/services) and 3(2)(b) (monitoring behavior) run explicitly whenever EU-located individuals could touch the system. Same reflex for UK GDPR, and for CCPA's revenue/volume thresholds in reverse.

3. **Fabricated or unverifiable citations.**
   - *Looks like:* A confident cite to "Smith v. TechCorp, 9th Cir. 2021" that doesn't exist; a plausible statute section number that's actually the neighboring section. Catastrophic — this is the *Mata v. Avianca* failure mode and it destroys all credibility of the deliverable.
   - *Detection:* Any citation produced from memory without verification access; unusual specificity (pincites, exact quotes) in an offline analysis.
   - *Prevention:* Cite only what is verified or verifiable. Without verification access: cite statute/article numbers only where highly confident (GDPR Art. 28, 17 U.S.C. §102(b) class), otherwise name the doctrine and flag "cite to be confirmed by counsel." Never invent case names. Ever.

4. **Missing carve-out blindness (liability cap edition).**
   - *Looks like:* "Liability is capped at 12 months' fees — acceptable" — without checking whether the indemnification obligations, confidentiality breaches, and data-breach costs are excluded from the cap. Client later eats an uncapped indemnity or, in reverse, discovers their data-breach recovery is capped at $40k.
   - *Detection:* Cap analyzed with no list of exclusions; the words "subject to Section" in the cap clause not traced.
   - *Prevention:* Exception-structure analysis is mandatory for every risk-allocation clause (Principle 8). Template: cap amount | what's excluded | what SHOULD be excluded for this party's posture | delta.

5. **Reviewing what's there, missing what isn't.**
   - *Looks like:* A thorough clause-by-clause NDA review that never notices there's no residuals clause (bad for recipient) or no return/destruction obligation (bad for discloser); an MSA review that misses the absent limitation on the customer's indemnity.
   - *Detection:* Review deliverable has no "absent provisions" section.
   - *Prevention:* Coverage pass with the contract-type checklist BEFORE clause critique (Framework Stage 4). Checklists live in common_patterns.md.

6. **Confidence-authority mismatch.**
   - *Looks like:* "This choice-of-law clause will be enforced" (rests on a general trend with fact-specific exceptions); "these tokens are not securities" (rests on contested *Howey* application under active litigation).
   - *Detection:* Declarative legal conclusions ("is," "will," "cannot") in areas the analysis itself describes as fact-specific or unsettled; conclusions stronger than the cited authority.
   - *Prevention:* Principle 4 verb-matching; adversarial pass asks "what would make this conclusion wrong, and did I say so."

7. **Regulatory lag misread as permission.**
   - *Looks like:* "No law specifically regulates AI-generated voice cloning, so it's permitted" — ignoring right-of-publicity, wiretap statutes, FTC §5 unfairness, and state AI statutes in flight.
   - *Detection:* "No law directly addresses X" appearing as a conclusion rather than a transition.
   - *Prevention:* Principle 11 — the nearest-regime-stretch analysis plus pending-rules direction is mandatory whenever the direct-regulation answer is "none."

8. **Compliance framework scope inflation/deflation.**
   - *Looks like:* "We're SOC 2 certified so we're secure/compliant" (SOC 2 attests to controls in scope, over a period, against criteria the company chose); "HIPAA applies because we handle health data" (a fitness app with no covered-entity relationship is typically NOT a HIPAA-regulated entity — but may face FTC Health Breach Notification Rule instead).
   - *Detection:* Framework conclusions without a scoping statement; HIPAA invoked without covered-entity/business-associate analysis; PCI obligations analyzed without CDE scoping.
   - *Prevention:* Principle 12 — every framework finding opens with what's in scope and why the framework applies at all.

9. **Worker classification / securities exemption analyzed on vibes.**
   - *Looks like:* "They set their own hours so they're contractors" — skipping the ABC test (California) vs. economic-realities (FLSA) vs. common-law control test, which differ and can give different answers for the same worker. Or "friends-and-family round, no filing needed" without checking accreditation and Reg D 506(b)/(c) conditions.
   - *Detection:* Multi-factor legal test resolved by citing one factor; the applicable TEST never named.
   - *Prevention:* Name the test, name whose test (jurisdiction + agency), list every factor, apply each factor to a stated fact or flag the fact as missing (Principle 13).

10. **One-sided redline proposed as neutral.**
    - *Looks like:* Proposing an uncapped IP indemnity, unilateral termination rights, and a one-way fee-shifting clause for the user's side and presenting it as "standard language" — user burns negotiation credibility when counterparty's counsel reacts.
    - *Detection:* Proposed language with no note on which party it favors or its market position.
    - *Prevention:* Principle 14 — every proposed clause ships with (favors-whom, market-position: aggressive/market/conservative, expected counter).

11. **Privilege contamination unflagged.**
    - *Looks like:* Producing a written "here are all the ways our data practices violate CCPA" memo for a business team with no counsel involvement — a discoverable roadmap for plaintiffs.
    - *Detection:* Candid liability-enumeration deliverable with no privilege note; distribution audience includes non-legal recipients.
    - *Prevention:* Any deliverable that enumerates the user's own potential violations carries a header note: consider having counsel commission/receive this analysis; limit distribution; this document may be discoverable.

12. **Defined-term and cross-reference rot.**
    - *Looks like:* "Confidential Information" defined narrowly in §1 but the NDA's obligations use lowercase "confidential information" in §4; indemnity in §9 keyed to "Losses" which is never defined; survival clause references "Sections 6, 8, and 11" after a renumbering left indemnity at §9.
    - *Detection:* Mechanical trace: list every capitalized term → check single definition → check usage; list every §-reference → resolve it → confirm content matches intent.
    - *Prevention:* Cross-reference trace is a mandatory execute-stage step for any drafted or amended contract; run it again after ANY renumbering.

13. **Stale-law confidence in moving areas.**
    - *Looks like:* Stating the FTC non-compete rule status, state privacy-law count, EU AI Act obligations, or DOL contractor rule as settled from training data — all of these moved repeatedly 2023-2026.
    - *Detection:* Present-tense regulatory status claims in known-moving areas with no as-of date and no verify-currency flag.
    - *Prevention:* Principle 3 date-stamping; maintain the moving-areas list (AI, privacy, non-competes, worker classification, crypto/securities, platform liability) and auto-flag anything touching it.

14. **DPA role confusion.**
    - *Looks like:* Drafting a controller-processor DPA when the parties are actually joint controllers (Art. 26 arrangement needed instead); calling a vendor a "processor" who uses the data for its own model training (that's a controller use — the DPA's processing-restrictions are being violated by design).
    - *Detection:* DPA analysis with no controller/processor/joint-controller determination step; "acts on documented instructions" asserted against a vendor whose product improves from customer data.
    - *Prevention:* Role determination (who determines purposes and means, per use) precedes DPA drafting/review; check the vendor's actual data use against the processor role before accepting the label.

15. **Remedy-blind risk assessment.**
    - *Looks like:* Flagging a GDPR gap with "fines up to 4% of global turnover" as the risk framing — when the realistic exposure is a supervisory-authority corrective order and remediation costs; or conversely treating a "small" contract defect as minor when it voids the entire IP assignment (present-assignment language missing → company doesn't own its core IP → kills the acquisition).
    - *Detection:* Risk stated as the statutory maximum with no realistic-exposure analysis; contract defects ranked without asking "what transaction/right does this break."
    - *Prevention:* Every finding carries realistic exposure (who enforces, against whom, typical outcome) alongside theoretical maximum; contract findings ranked by what breaks, not by clause length.

---

## 5. Sample Task Walkthrough

**Task:** "We're a 40-person Delaware C-corp SaaS company (HQ Austin, TX). A UK enterprise prospect sent us their paper — an MSA plus DPA. Sales wants to sign this week. Review it and tell us what to push back on."

**Stage 1 — Understand.** Restate the operative question: not "review this MSA" but "what in this paper hurts us enough to risk the deal timeline, ranked." Posture: we are the vendor/processor reviewing customer paper — expect it to be customer-favorable; the job is finding the intolerable, not the merely unfavorable. Jurisdiction triage: MSA governing-law clause says England and Wales — flag immediately that English contract law differs materially from the US baseline (no US-style consequential-damages doctrine framing; "best endeavours" vs "best efforts" carries specific English meaning; UCTA reasonableness can apply to standard terms; liquidated damages vs. penalty doctrine differs). Data: UK customer, presumably UK/EU data subjects → UK GDPR applies to the processing, and if any EU-member-state data subjects are in scope, EU GDPR too; we are the processor. US company processing UK personal data → international transfer analysis required (IDTA or EU SCCs + UK Addendum). Assumptions ledger opens: assume no US-government-customer flow-downs; assume our sub-processors include AWS us-east-1 (CONFIRM — determines transfer analysis); assume no special-category data (CONFIRM).

**Stage 2 — Decompose.** Issue matrix, exposure-ranked: (1) liability cap and its exclusions under English law; (2) indemnities we give (IP, data breach) and whether they sit inside or outside the cap; (3) DPA: processor obligations, audit rights, sub-processor consent mechanics, transfer mechanism, breach-notification clock; (4) IP — who owns feedback, usage data, and anything touching our models; (5) SLA and service-credit exclusivity; (6) termination for convenience and data-return; (7) UK-specific drafting traps (endeavours language, UCTA); (8) non-solicit/publicity/insurance boilerplate. Each issue tagged with governing law: contract issues → England & Wales; data protection → UK GDPR/EU GDPR; our corporate authority → Delaware (trivial here).

**Stage 3 — Plan.** Authority plan: GDPR/UK GDPR article cites are stable and citable from knowledge (Arts. 28, 32-36, 44-49; UK Addendum existence) — but flag adequacy-decision status and transfer-mechanism currency as verify-current (this moved repeatedly: Privacy Shield → Schrems II → DPF; the UK-US data bridge status must be confirmed as of today). English-law doctrines cited at doctrine level, no invented cases. Deliverable: risk-ranked memo, three tiers (deal-breakers / push hard / accept-with-eyes-open), plus a redline-instructions list per finding. Plan-gate: present the issue matrix and the "customer paper, vendor posture" frame before drafting — cheap confirmation that we're not supposed to be negotiating FOR balance but AGAINST the intolerable.

**Stage 4 — Execute.** Coverage pass first, against the vendor-side MSA checklist: found ABSENT — any cap on OUR liability for data-protection breaches (the cap clause carves out "data protection obligations" entirely → our GDPR-related liability is uncapped); any limitation on the customer's audit rights (DPA grants annual on-site audit with no notice period, no cost allocation, no SOC-2-report-first mechanic); a mutual confidentiality clause (theirs protects only their information). Adversarial pass on what exists: the IP clause reads "all data, outputs, and derivatives generated in connection with the Services vest in Customer" — hostile reading: our model improvements trained on usage telemetry become customer property; this clause, quoted verbatim in the memo, is the sleeper deal-breaker sales would have signed. DPA pass: 24-hour breach notification (Art. 33 gives the controller 72h to the authority; 24h vendor→customer is aggressive but negotiable to 48/72); sub-processor changes require prior WRITTEN CONSENT per change (operationally impossible at 40 people — push to general authorization + notice + objection right, Art. 28(2) permits this); transfer mechanism references old SCCs — flag as verify-current, propose the current mechanism generically and mark for counsel confirmation.

**Stage 5 — Verify.** Gate-run: every finding has (a) quoted operative language, (b) governing-law tag, (c) exposure statement in realistic terms ("uncapped data liability against a 40-person company is existential; their insurance requirement of £5m cyber cover implies they expect claims of that order"), (d) the counter-position the customer will take. Citation audit: GDPR article numbers verified against the regulation's structure; no case names invented; three items carry "verify current status" flags (transfer mechanism, UK adequacy, ICO guidance on audit clauses). Coverage audit: absent-provisions section present with three entries. Cross-reference trace on their paper: DPA §7 references "MSA Section 11 (Liability)" but liability is MSA §12 — noted as a defect to fix in the redline (ambiguity about whether the DPA liability position incorporates the cap at all — this materially interacts with finding #1).

**What could go wrong and how it's caught:** (1) Treating the cap carve-out as standard because "data carve-outs are market" — the exposure statement forces sizing it against company scale, which reclassifies it deal-breaker. (2) Missing the IP telemetry grab because the clause lives in "Customer Data" not "Intellectual Property" — the coverage checklist has a dedicated "usage data / ML training rights" line precisely because this clause migrates. (3) Confidently naming the current UK transfer mechanism from stale memory — the moving-areas list forces the verify-current flag instead. (4) The DPA/MSA cross-reference defect only surfaces because the trace is mechanical, run on their paper too, not just ours.

**Close:** memo ends with escalation triggers: "Before sending this redline: UK-qualified counsel must confirm the transfer mechanism and review the endeavours/UCTA points — English-law drafting conventions are outside safe generalization. Before signing: counsel sign-off on the liability structure." This is analysis support; the negotiation call and the English-law conclusions belong to licensed counsel.

---

## 6. Integration with Core Skills

**Most critical, in order:**

1. **uncertainty-handling** — the load-bearing skill. Domain variation: uncertainty must be typed (jurisdictional uncertainty vs. factual uncertainty vs. unsettled-law uncertainty vs. currency uncertainty) because each type has a different resolution path (ask the user / flag for counsel / present the split / verify-current flag). Confidence language is regulated by Principle 4's authority-matching rule, which is stricter than the generic skill.
2. **assumption-flagging** — every legal analysis runs on a facts-and-jurisdiction assumptions ledger created in Stage 1 and audited in Stage 5. Domain variation: assumptions about FACTS (what the client does) and assumptions about LAW (which jurisdiction, current status) are ledgered separately; a legal-status assumption always carries a verify-current flag in moving areas.
3. **adversarial-disproof** — the hostile-litigator reading pass (Principle 6) is this skill weaponized. Every material clause and every material conclusion gets the "strongest attack" treatment. Domain variation: the adversary is specific — opposing counsel for contracts, the regulator for compliance positions, the plaintiff's bar for policies.
4. **coverage-accounting** — powers the missing-provisions pass (Principle 5) and framework control-mapping. Domain variation: coverage runs against canonical per-contract-type and per-framework checklists (common_patterns.md), and the "expected but absent" section is a mandatory deliverable component, not an internal artifact.
5. **evidence-reasoning** — citations are evidence; the authority hierarchy (statute > regulation > controlling case > persuasive case > secondary) is the domain's evidence-weighting rule. Domain variation: evidence has a currency dimension code evidence lacks — good law vs. overruled/amended — and fabricated evidence (Pitfall 3) is a fire-everything failure.
6. **plan-gate** — mandatory before multi-document reviews, multi-regime compliance assessments, and any drafting task: present issue matrix + posture + jurisdiction assignment first. Wrong governing law discovered after execution means full re-run (Stage 6), so the gate has unusually high ROI here.
7. **scope-fence** — legal engagements bleed ("while you're reviewing the MSA, is our privacy policy okay?"). Fence to the asked question; surface adjacent issues spotted as a flagged list ("noted, out of scope: your policy's CCPA notice looks thin") without analyzing them uninvited.
8. **verified-done** — done means gates passed: jurisdiction audit, citation audit, coverage audit, hedging audit, escalation triggers present. A legal deliverable is never done on "the prose is finished."
9. **document-mastery** — contracts, statutes, and framework specs are long structured documents; defined-term tracing, cross-reference resolution, and clause-location work are document-mastery applied with the domain's mechanical-trace requirements (Pitfall 12).
10. **hypothesis-before-read** — before opening a 90-page agreement, hypothesize where the pain lives for this posture (customer paper → expect the cap, indemnity, IP, and audit clauses to bite) and read those adversarially first; then still run the full coverage pass so the hypothesis doesn't become tunnel vision.
11. **statistical-analysis / evidence-reasoning combo** for compliance risk quantification (breach-cost estimation, fine benchmarking) — always labeled as estimates with stated bases, never as predictions.
12. **security-threat-modeling** — direct crossover for SOC 2 / ISO 27001 / HIPAA Security Rule work: the control frameworks are threat models with audit trails; use the skill to test whether mapped controls actually mitigate the risks the framework targets, not just whether a policy document exists.

**Combination pattern for the standard engagement:** plan-gate(issue matrix + jurisdiction) → coverage-accounting(checklist pass) → adversarial-disproof(hostile reading) → uncertainty-handling + assumption-flagging(typed hedging throughout) → verified-done(gates). The domain skills in `skills/` implement the domain-specific segments of this chain.

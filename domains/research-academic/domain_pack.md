# Research & Academic Writing — Domain Pack

## 1. Domain Overview

### What makes this domain unique

Research is the only domain where the deliverable's value is *entirely* a function of the process that produced it. A working app is a working app regardless of how it was built. A research finding produced by a flawed process is worthless even when the conclusion happens to be true — because nobody, including the author, can distinguish a true finding from a lucky artifact. Every rule in this pack follows from that asymmetry: **process integrity IS the product.**

Three structural facts drive everything else:

1. **Claims are graded, not binary.** "X causes Y," "X is associated with Y," "X was associated with Y in this sample," and "participants reported believing X affects Y" are four different claims requiring four different evidence bases. Most research failures are claim-evidence mismatches, not fabrication.
2. **The sequence of decisions matters as much as the decisions.** A hypothesis stated before data collection is a test; the same hypothesis stated after seeing results is exploration dressed as confirmation (HARKing). Timestamps of analytic decisions are part of the evidence.
3. **The author is the least qualified person to spot their own confirmation bias.** Adversarial self-review is not optional polish — it is a mandatory stage with its own protocol.

### Where AI adds most value

- **Coverage and recall:** exhaustive keyword permutation, database strategy design, forward/backward citation chasing, detecting the paper the author's search missed.
- **Consistency enforcement:** every citation checked against what the source actually says; every statistic checked against reporting standards; every claim graded against its evidence.
- **Adversarial reading:** generating the strongest counterargument, the most plausible confounder, the alternative explanation the author is motivated not to see.
- **Structural editing:** argument-flow diagnostics, synthesis-vs-summary detection, abstract compression, revision passes with a defined objective per pass.
- **Methods pattern-matching:** recognizing that a design cannot support the intended inference *before* data collection (e.g., no control group but causal aims).

### Where AI must defer to human expertise

- **Domain-insider judgment:** whether a research question matters to the field, which venue fits, which controversy a framing steps into. Flag, do not decide.
- **Data provenance:** never assert what happened during data collection. If the protocol document doesn't say it, ask — do not reconstruct plausible procedure.
- **Ethics and IRB scope:** identify issues (consent, deception, vulnerable populations, data privacy); never certify compliance.
- **Statistical claims beyond verification:** verify reported statistics for internal consistency (df, p from t, CI symmetry) always; refuse to invent effect sizes or fill in unreported values with "typical" numbers.
- **Authorship of interpretation:** propose interpretations as candidates with explicit evidence chains; the human author owns which interpretation the paper commits to.

---

## 2. Core Principles

Each rule is checkable. A reviewer can audit compliance by inspecting the artifact.

1. **State the claim type before gathering evidence for it.** Every claim in a draft carries an implicit grade: causal / associational / descriptive / self-report / speculative. Write the grade first; then verify the evidence supports that grade and not merely a weaker one. Check: pick any sentence with a citation — can you name its grade and point to the design feature that licenses it?

2. **A citation is a checkable promise, not decoration.** Every citation must be traceable to a specific finding, page, or section in the source, and the source must actually say what the sentence uses it for. Citing a paper for a claim made only in its own literature review is a violation. Check: for a random 10% sample of citations, locate the exact supporting passage.

3. **Search before you believe. Log the search.** No literature claim ("no prior work has...", "the dominant view is...", "evidence consistently shows...") without a logged search: databases, query strings, date, hit counts, inclusion decisions. Check: the search log exists and reproduces roughly the same result set.

4. **Hypotheses are timestamped.** Confirmatory claims require the hypothesis to predate the analysis that tests it. If the hypothesis emerged from the data, label the analysis exploratory and demand replication before confirmatory language. Check: can the author produce a pre-analysis note, preregistration, or dated document?

5. **One analysis per hypothesis unless corrections are applied.** Running 5 outcome measures, 3 subgroups, and 2 covariate sets, then reporting the significant cell, is p-hacking regardless of intent. Report the full analytic garden of forking paths or correct for it. Check: does the methods section's analysis count match the results section's test count?

6. **Power analysis before data collection; sensitivity analysis after.** A study designed without a power calculation cannot interpret a null result. Post hoc, compute the minimum detectable effect and state it. Check: methods contains either an a priori power calculation or a sensitivity bound on what the study could detect.

7. **The limitations section is written by the adversary.** Draft limitations as the harshest competent reviewer would: what design flaw most threatens the central claim, what population the sample cannot generalize to, what confounder was not measured. Generic limitations ("small sample size" with no consequence stated) fail. Check: each limitation names the specific claim it weakens and by how much.

8. **Synthesize by variable, never by paper.** A literature review organized as "Smith found X. Jones found Y. Lee found Z." is an annotated bibliography. Organize by construct, method, or tension: "Across twelve studies, effect sizes cluster by measurement approach: self-report designs (n=7) show r≈.4; behavioral designs (n=5) show r≈.1." Check: do paragraph topic sentences name concepts or name authors?

9. **Every figure passes the lie-factor test.** Visual effect magnitude must equal data effect magnitude. Truncated y-axes on bar charts, area encodings of linear quantities, and dual axes chosen to force correlation are violations. Check: compute lie factor (size of visual effect ÷ size of data effect); it must be ~1.0, and data-ink that carries no information must justify its existence.

10. **Numbers appear once, consistently, everywhere.** Sample sizes, means, p-values, and percentages must match across abstract, results, tables, and figures — including after revisions. Check: extract every number from the abstract and grep the results section for each.

11. **The abstract must survive alone.** Problem → method → key result (with magnitude, not just direction) → implication, readable by someone who will never open the paper, containing no claim the paper doesn't support. Check: hand only the abstract to a naive reader; every question they form must be answerable by the paper.

12. **Report what would falsify the claim.** For every central claim, the paper states what evidence would overturn it. If nothing could, the claim is not empirical and must be reframed. Check: the discussion identifies at least one concrete disconfirming observation.

13. **Recency is a bias, not a virtue.** Foundational work is not superseded by being old; a 2024 citation is not better evidence than a 1979 one unless it supersedes it substantively. Deliberately check whether the seminal source predates the search window. Check: the reference list spans the intellectual history of the construct, not just the last five years.

14. **Method transparency beats method sophistication.** A simple analysis fully described is worth more than an advanced analysis a reader cannot reproduce. Every methods section must pass the replication test: could a competent stranger repeat the study from the text alone? Check: list every decision a replicator would need; confirm each appears in the text.

15. **Recommendations are actions; observations are not recommendations.** "Engagement was low" is an observation. "Reduce onboarding steps from 7 to 3; re-measure activation at 30 days" is a recommendation. Every recommendation names an actor, an action, and a success measure. Check: each recommendation sentence contains a verb an identifiable person can execute.

---

## 3. Master Framework — Adapted for Research & Academic Writing

### Stage 1: UNDERSTAND — Define the inferential target

- Identify the *claim type* the work must ultimately support: causal, predictive, associational, descriptive, interpretive. This determines everything downstream — design, sample, analysis, and permissible language.
- Identify the audience and reporting standard NOW (APA 7 / AMA 11 / IEEE / journal-specific / internal report). Standards shape structure; retrofitting is expensive.
- Distinguish the research question from the researcher's hoped-for answer. Write both down. The gap between them is the confirmation-bias exposure for the whole project.
- Tools: claim-type taxonomy; PICO/PECO framing for empirical questions (Population, Intervention/Exposure, Comparison, Outcome); FINER check (Feasible, Interesting, Novel, Ethical, Relevant).
- Gate: one-sentence research question + declared claim type + declared standard, confirmed before any search or drafting.

### Stage 2: DECOMPOSE — Split by evidence obligation

- Break the project into claims, and each claim into its evidence obligations: what literature must be covered, what data must exist, what analysis licenses the claim, what counterargument must be rebutted.
- For literature reviews: decompose by construct and by methodological tradition, not by paper. Build the synthesis matrix skeleton (rows = studies, columns = design, sample, measures, effect, limitations) before reading deeply.
- For empirical work: decompose into design → sampling → instrumentation → analysis plan → reporting, each with its own verification gate.
- Tools: claims inventory table; synthesis matrix; analysis plan document (hypotheses, tests, alpha, corrections — dated).
- Gate: every planned section maps to at least one claim; every claim maps to at least one evidence source or planned analysis.

### Stage 3: PLAN — Preregister the process, even informally

- Write the analysis plan or review protocol BEFORE touching data or committing to a narrative. For systematic reviews: search strings, databases, inclusion/exclusion criteria, screening procedure — the PRISMA skeleton. For quantitative work: hypotheses, tests, power, exclusion rules. For qualitative work: interview protocol, coding approach (deductive/inductive/hybrid), rigor strategy.
- Plan the writing sequence: methods first (it exists before results), then results, then introduction (it frames what actually happened), then discussion, abstract last.
- Budget revision passes explicitly: one pass per objective (argument flow → evidence fidelity → paragraph craft → sentence craft → standards compliance). Never combine objectives in one pass.
- Tools: PRISMA flow template; pre-analysis note; reverse outline template; revision-pass schedule.
- Gate: the plan is written down and dated. Deviations later are permitted but must be logged with reasons (this is what separates adaptation from HARKing).

### Stage 4: EXECUTE — Build evidence before prose

- Populate the synthesis matrix or run the analysis plan before writing narrative sections. Prose written before evidence is complete becomes a commitment the evidence then gets bent to serve.
- Extract from every source into the matrix at read time: full citation, design, N, measures, effect size and direction, key limitation, page numbers for quotable claims. Never trust memory of a paper read three days ago.
- Draft in argument units: claim sentence → evidence with citation → reasoning connecting them → anticipated objection → response. Paragraphs that lack the reasoning step are lists, not arguments.
- Write statistics to standard at first draft (test statistic, df, exact p, effect size, CI) — retrofitting APA/AMA statistical formatting across a full results section reliably introduces transcription errors.
- Tools: synthesis matrix; citation manager with verified metadata (never hand-typed references); argument-unit template; standards quick-reference for the declared style.

### Stage 5: VERIFY — Audit claims, citations, numbers, and figures separately

- Run four independent audits; do not merge them into one read-through:
  1. **Claim-evidence audit:** grade every claim; confirm the evidence licenses that grade (see `skills/claim-evidence-audit`).
  2. **Citation fidelity audit:** sample citations; open sources; confirm each says what it's cited for, at the cited location.
  3. **Numerical consistency audit:** every number cross-checked abstract ↔ text ↔ tables ↔ figures; statistical internal consistency (df match N, p matches test statistic — GRIM/statcheck-style logic).
  4. **Figure integrity audit:** lie factor ≈ 1, axes labeled with units, N stated, error bars defined (SD vs SE vs CI — say which).
- Reverse-outline the draft: one sentence per paragraph, in order. If the outline doesn't read as a coherent argument, the paper doesn't either.
- Gate: all four audits logged with findings and fixes. An audit that finds zero issues in a full draft is itself a red flag — rerun it.

### Stage 6: SELF-CORRECT — Adversarial pass

- Adopt Reviewer 2. Write the rejection review of your own draft: the fatal flaw, the missed literature, the alternative explanation, the overreach. Then answer each point in the text or concede it in limitations.
- Actively search for disconfirming literature: rerun searches with negation terms ("no effect", "null", "failed to replicate", "criticism of"). A review that found only supporting studies did not look.
- Check the causal language leak: search the draft for "causes", "leads to", "results in", "improves", "drives", "impacts" — each instance must be licensed by design or downgraded.
- Tools: adversarial review template; negation-term search list; causal-verb greplist.
- Gate: at least three substantive self-objections generated and resolved, in writing.

### Stage 7: ITERATE — Revision as separate disciplines

- Revise in ordered passes, coarse to fine: (1) argument structure — does the thesis hold and does every section serve it; (2) synthesis quality — kill paper-by-paper paragraphs; (3) evidence fidelity — re-run citation audit on changed text only; (4) prose economy — cut 10–15% of words, no loss of content; (5) standards compliance — references, headings, statistical formatting.
- After ANY content revision, re-run the numerical consistency audit on affected sections. Revision is where numbers desynchronize.
- Abstract is rewritten last, from the final draft, never patched from an earlier version.
- Stop condition: two consecutive passes producing only cosmetic changes = done. Endless revision is a form of avoidance; ship against the declared standard, not against perfection.

---

## 4. Pitfalls Checklist

1. **HARKing (Hypothesizing After Results are Known)**
   - Looks like: intro states "we hypothesized that anxiety moderates the effect" — but the moderation analysis was run only after the main effect came back null, and the hypothesis was written in during revision.
   - Detection: hypothesis has no dated pre-analysis trace; the "hypothesized" effect is suspiciously exactly what the data show, including direction of a three-way interaction nobody predicts a priori.
   - Prevention: date-stamp hypotheses before analysis. Any post-data hypothesis gets labeled exploratory in both methods and discussion, with confirmatory language stripped.

2. **The garden of forking paths (p-hacking without noticing)**
   - Looks like: outcome measured 3 ways, tried with and without covariates, outliers excluded under two different rules — the manuscript reports the one combination with p = .041 as "the analysis."
   - Detection: results section reports fewer tests than the data structure implies were possible; exclusion criteria are described in results rather than methods; p-values cluster just under .05.
   - Prevention: analysis plan written before analysis; report all specifications or a specification curve; exclusion rules fixed in methods, not tuned in results.

3. **Citation laundering**
   - Looks like: draft cites Chen (2021) for "meditation reduces cortisol by 30%" — but Chen (2021) is a narrative review citing Park (2015), which actually reported a nonsignificant 12% reduction in a pilot of n=14.
   - Detection: cited source is a review/textbook/press release; effect size in the sentence can't be located in the cited document; chain of citations all point at each other.
   - Prevention: cite primary sources for empirical claims, always. When a review is cited, cite it only for the synthesis claim the review itself makes. Trace every quantitative claim to the study that generated the number.

4. **Confounding blindness**
   - Looks like: observational finding "employees who use the wellness program have 20% lower turnover" written up with a recommendation to expand the program — ignoring that program users are self-selected, tenured, already-engaged employees.
   - Detection: causal or action language on a non-randomized comparison; no mention of selection into groups; no confounders measured or discussed.
   - Prevention: for every group comparison, list mechanically how units ended up in each group. If assignment wasn't random, name the top three selection variables and either adjust, bound, or downgrade the claim to associational.

5. **The annotated-bibliography literature review**
   - Looks like: six consecutive paragraphs each beginning with an author's name, each summarizing one paper, connected by "Similarly" and "In addition."
   - Detection: reverse outline shows topic sentences naming authors instead of concepts; no paragraph cites more than two sources; no sentence compares studies to each other.
   - Prevention: build the synthesis matrix first; write paragraphs from matrix columns (constructs, methods, tensions), never from matrix rows (papers). Require ≥3 sources interacting per synthesis paragraph.

6. **Overgeneralization from convenience samples**
   - Looks like: survey of 212 undergraduates at one US university → "consumers prefer..." in the abstract; usability test of 8 internal employees → "users find the feature intuitive."
   - Detection: population words in claims ("people", "users", "consumers", "clinicians") where the sample was a narrow slice; abstract claims broader than the limitations section admits.
   - Prevention: write claims with the sample's actual population noun first ("undergraduate participants preferred..."), then consciously argue any generalization step in the discussion, explicitly, with transferability reasoning.

7. **Survivorship in the search itself (publication-bias amplification)**
   - Looks like: literature review of a treatment effect built entirely from published journal articles concludes "evidence consistently supports efficacy" — the file drawer of null results is invisible and unmentioned.
   - Detection: no grey-literature search (theses, preprints, trial registries, conference proceedings); every included effect points the same direction; no funnel-plot logic or bias discussion.
   - Prevention: search trial registries and preprint servers alongside databases; explicitly search for null/failed results (Principle 13's negation terms); state publication-bias exposure in limitations even for narrative reviews.

8. **Instrument invalidity dressed as measurement**
   - Looks like: a homemade 5-item "engagement scale" invented for this study, no pilot, no reliability statistic, double-barreled items ("The tool is fast and easy to use"), then results reported to two decimals.
   - Detection: no citation for the instrument; no Cronbach's alpha / McDonald's omega / test-retest figure; items contain "and", absolutes, or leading language; response scale midpoint ambiguity.
   - Prevention: use validated instruments where they exist and cite the validation study. For new instruments: pilot, report reliability, one construct per item, balanced scale anchors, and label the study's measurement as exploratory.

9. **The lying figure**
   - Looks like: bar chart with y-axis from 62 to 68 making a 3% difference look like a 4× difference; 3D pie chart where the front wedge reads as larger; dual-axis line chart engineered so two unrelated series appear to track.
   - Detection: compute the lie factor; check whether the visual impression survives redrawing with a zero baseline (for bars) or single axis; check ink that encodes nothing (gradients, 3D, decorative icons).
   - Prevention: bars start at zero, always; effect sizes shown with CIs; one axis unless units are genuinely paired and both axes are labeled with the pairing rationale; delete every non-data pixel that doesn't aid reading.

10. **Numerical drift across revisions**
    - Looks like: abstract says n=847, methods says 852, table says 847 (analysis sample) — the abstract was written from draft 3, methods updated in draft 5 after exclusions changed, table regenerated in draft 6.
    - Detection: extract every number in the abstract; search body for each; mismatches. Check df in reported tests against stated N.
    - Prevention: single source of truth for all statistics (analysis output file, not memory); re-run the numerical audit after every revision pass that touched results; abstract regenerated last.

11. **Findings without a "so what"**
    - Looks like: a professional research report ending with "engagement declined 14% in Q3 among mobile users" and nothing else — the reader knows a fact and cannot act.
    - Detection: recommendations section absent, or contains restated observations; no sentence names an actor and an action; executive summary answers "what" but not "therefore."
    - Prevention: every key finding gets a forced completion: "Finding → because (mechanism, or candidate mechanisms) → therefore (actor + action + measure of success) → confidence level." If no action follows, say explicitly why the finding is monitor-only.

12. **Qualitative rigor theater**
    - Looks like: "themes emerged from the data" with no codebook, no description of how many coders, no negative-case analysis, no quotes traceable to participants — themes that happen to mirror the interview questions.
    - Detection: theme names are paraphrases of the interview guide questions; no participant IDs on quotes; no mention of disconfirming cases; coding process described in one sentence.
    - Prevention: maintain a codebook with definitions and example excerpts; report the coding process (who, how many passes, how disagreements resolved); actively hunt and report negative cases; distinguish themes (patterns across data) from topics (things you asked about).

13. **The stealth causal verb**
    - Looks like: methods correctly describe a cross-sectional survey; discussion says the intervention "improved outcomes" and "drove adoption." The design supports "was associated with" at most.
    - Detection: grep the draft for causal verbs (causes, leads to, results in, improves, reduces, increases, drives, impacts, boosts) and check each against design. Also check the abstract, where causal leaks concentrate.
    - Prevention: maintain a design→language table (RCT: causal allowed; quasi-experimental: causal with threats named; observational: associational; cross-sectional: associational, no temporal ordering). Apply it as a mechanical pass.

14. **Recency bias in sourcing**
    - Looks like: a review of measurement invariance citing only 2019–2025 papers, missing the foundational works the entire field's methods derive from — and thereby misattributing established ideas to recent authors.
    - Detection: reference list's earliest date is within ~5–8 years for a construct that is decades old; foundational names in the area absent; "recently, researchers have begun to..." for a question studied since the 1970s.
    - Prevention: for each core construct, explicitly search for the origin paper (backward-chase from reviews' reference lists); include the seminal citation alongside the current state of the art.

15. **Abstract-body divergence**
    - Looks like: abstract claims "results demonstrate significant improvement across all metrics"; the body shows 2 of 5 metrics significant, one in the wrong direction. Abstract was written from hope, or from a prior draft.
    - Detection: line up every abstract claim against the results section; check each direction, magnitude, and significance status; check that abstract implications don't exceed discussion claims.
    - Prevention: write the abstract last, from the final results section, sentence-by-sentence sourced; run the abstract through the same claim-evidence audit as the body.

---

## 5. Sample Task Walkthrough

**Task:** A product organization asks for a research report answering: "Does our new onboarding flow improve 30-day retention?" Available: analytics data from before/after the flow launched (launched to all users on March 1), a survey of 300 recent signups, and 12 user interviews conducted by the design team. Deliverable: professional research report with executive summary and recommendations, two weeks.

**Stage 1 — Understand.** The question as asked demands a causal claim ("does it improve"). First act: check whether the available evidence can license causation. The flow launched to *all* users simultaneously — there is no concurrent control group. This is a before/after observational design, vulnerable to seasonality, marketing-mix changes, and product changes shipped in the same window. Declare this to the stakeholder immediately, in writing: "The data supports 'retention changed after launch and is consistent/inconsistent with the flow helping' — not 'the flow caused it.' If a causal answer is required, the recommendation will be a holdback experiment." Declared claim type: associational with causal-candidacy reasoning. Standard: internal report, but statistics reported to APA-adjacent rigor (exact effects, CIs, Ns).

**Stage 2 — Decompose.** Claims inventory: (C1) 30-day retention before vs. after launch, quantified; (C2) confounders in the launch window, enumerated and assessed; (C3) survey evidence on onboarding experience, graded as self-report; (C4) interview evidence on mechanism, graded as qualitative/interpretive; (C5) recommendation set. Each claim gets its own evidence obligation and audit.

**Stage 3 — Plan.** Write the analysis plan *before* opening the analytics data: retention defined as ≥1 session between day 28–32 post-signup (state the definition — "30-day retention" has a dozen operationalizations and picking one after seeing results is a forking path). Comparison cohorts: signups in the 8 weeks pre-launch vs. 8 weeks post-launch, excluding a 1-week washout. Pre-committed confounder checklist: paid-acquisition share by cohort (channel mix shifts retention massively), concurrent releases (pull the release log), seasonality (pull same-window data from the prior year), pricing/promo changes. Survey analysis: descriptive only, with the instrument's questions attached in an appendix — check them now for leading wording; the design team wrote "How much did the new onboarding help you get started?" which presupposes help. Flag: that item's data is unusable for direction, usable only for magnitude-among-those-who-say-it-helped. Interview analysis: hybrid coding against a small codebook; hunt negative cases explicitly.

**Stage 4 — Execute.** Cohort analysis: pre-launch retention 31.2% (n=14,210), post-launch 34.8% (n=15,873), +3.6pp, 95% CI [2.5, 4.7]. Do not stop here — run the confounder checklist. Finding: paid-acquisition share dropped from 41% to 29% between cohorts (a campaign ended Feb 20), and paid users retain ~9pp worse than organic. Stratify: within organic, +1.4pp [0.1, 2.7]; within paid, +1.1pp [−0.6, 2.8]. The headline effect is mostly channel-mix shift. This single check changes the report's central number from 3.6pp to ~1.2pp — this is exactly the confounding-blindness pitfall, caught by the pre-committed checklist rather than by luck. Prior-year seasonality check: March cohorts historically retain +0.5pp over January — shaves the residual further. Interviews: 8 of 12 describe the checklist step positively; 3 describe abandoning at the profile step; 1 negative case (power user who found the flow patronizing) — reported, not buried. Survey: high satisfaction among completers, but 22% skipped the flow entirely — survivorship caveat attached.

**Stage 5 — Verify.** Four audits. Claim-evidence: the draft executive summary said "onboarding improved retention by 3.6pp" — fails twice (causal verb on observational design; unstratified number). Rewritten: "Retention rose 3.6pp after launch; ~2.2pp of this is attributable to channel-mix shift and seasonality. The residual ~1.2pp is consistent with a modest onboarding effect but is not causally identified." Citation/source fidelity: every number in the report traced to a saved query (queries appended); interview quotes carry participant IDs. Numerical consistency: exec summary, body, and figures cross-checked — caught one figure still showing the unstratified 34.8% with a y-axis starting at 30 (lie factor ~3.2); redrawn from zero with CI whiskers. Figure audit: all Ns on all charts, error bars labeled as 95% CI.

**Stage 6 — Self-correct.** Adversarial pass: strongest objection — "the stratified effect could still be regression to the mean or a definition artifact." Response: re-ran with two alternate retention definitions (day-30 exact, week-4 any) — direction holds in both; reported as a robustness note. Second objection: interviews sampled by the design team from flow completers — sampling bias named in limitations with its consequence ("mechanism evidence speaks only to users who finished the flow").

**Stage 7 — Iterate.** Recommendations forced through the actor-action-measure template: (R1) Growth team: run a 4-week 10% holdback experiment to causally estimate the flow's effect; success = CI excluding zero on 30-day retention. (R2) Design team: fix the profile-step abandonment (3/12 interviews + funnel data show 18% drop there); measure step-completion pre/post. (R3) Analytics: alert on channel-mix shifts >5pp so future before/after reads carry an automatic caveat. Executive summary rewritten last, standing alone: question, method in two sentences, the ~1.2pp residual with honest uncertainty, the three actions. Final check: hand the exec summary to someone who hasn't seen the work — they must not come away believing causation was established.

**What could have gone wrong, and the exact catch:** shipping 3.6pp as the answer (caught by the pre-committed confounder checklist, Stage 3); the leading survey item contaminating direction claims (caught by instrument review before analysis); the truncated-axis figure (caught by the mechanical lie-factor check, not by eyeballing); causal language leaking into the exec summary (caught by the causal-verb grep in the claim-evidence audit).

---

## 6. Integration with Core Skills

**Most critical core skills for this domain, in load order:**

- **plan-gate** → becomes the *pre-analysis plan / review protocol* gate. Nothing touches data or literature synthesis before the plan is written and dated. Domain variation: the plan is itself an artifact of record — deviations are logged, not silently absorbed, because the deviation log is what distinguishes adaptation from HARKing.
- **hypothesis-before-read** → the domain's native discipline. Before opening any paper or dataset, write what you expect and what would surprise you. In literature search, this powers the negation-term searches; in analysis, it is the timestamped hypothesis of Principle 4.
- **adversarial-disproof** → maps directly to Stage 6 and the limitations section. Domain variation: the adversary has a name — Reviewer 2 — and a fixed attack surface (design validity, missed literature, alternative explanations, overgeneralization). Run all four attacks every time; do not stop at the first survivable draft.
- **coverage-accounting** → governs literature search completeness (databases × terms × forward/backward chasing, all logged) and claims coverage (every claim has evidence; every piece of evidence supports a claim; orphans on either side are findings).
- **evidence-reasoning** → the claim-grading engine. Every inferential step in the paper is claim → evidence → warrant; the warrant (why this evidence licenses this claim grade) must be explicit at least once per central claim.
- **statistical-analysis** → applied to both producing statistics (test selection, power, corrections) and *auditing* them (internal consistency of df/p/N, GRIM-style plausibility of reported means).
- **assumption-flagging** → every unverifiable statement about data provenance, participant behavior, or field consensus gets flagged rather than smoothed over. Domain variation: flags surface in the manuscript itself (limitations, methods caveats), not just in working notes.
- **verified-done** → done means all four Stage-5 audits ran and logged findings, the reverse outline coheres, and the abstract passed the standalone test. "The draft reads well" is not done.
- **uncertainty-handling** → confidence must appear in the deliverable's language: effect sizes with intervals, hedged verbs matched to evidence grade, explicit "we cannot distinguish X from Y with this design."
- **document-mastery** → long-manuscript mechanics: cross-reference integrity, style-standard compliance, reference-list ↔ in-text citation reconciliation.
- **long-task-orchestration + context-budget-management** → a literature review of 60 papers cannot be held in working context. The synthesis matrix is the externalized memory; extract at read time, synthesize from the matrix, never from recollection.
- **scope-fence** → prevents the review that swallows the field. The inclusion/exclusion criteria ARE the fence; expanding them mid-review is a logged protocol amendment, not a drift.

**Combination pattern:** plan-gate + hypothesis-before-read at the front (protocol before contact with evidence); coverage-accounting + context-budget-management during execution (matrix as ledger); adversarial-disproof + evidence-reasoning + statistical-analysis as the verification battery; verified-done as the exit gate. The domain-specific skills in `skills/` implement the pieces of this pipeline that exist nowhere else: systematic search (`systematic-lit-search`), synthesis (`synthesis-matrix`), methods integrity (`methods-integrity-audit`), claim grading (`claim-evidence-audit`), and qualitative trustworthiness (`qualitative-rigor`).

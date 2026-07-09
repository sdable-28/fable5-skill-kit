# Common Patterns — Research & Academic Writing

## 1. Scoping a literature review
**Trigger:** New research question, grant proposal, or thesis chapter requires mapping prior work.
**Approach:** 1) Decide systematic vs narrative — systematic if the question is answerable ("does X affect Y"), narrative if exploratory. 2) Select 2–3 databases matched to field (PubMed/Scopus/Web of Science/IEEE Xplore/PsycINFO) — never one database alone. 3) Build a keyword matrix: concepts as columns, synonyms/MeSH terms as rows; combine with AND across, OR within. 4) Pilot the search, record hit counts, tighten until 100–500 results. 5) Log inclusion/exclusion criteria BEFORE screening. 6) Screen title/abstract → full text; track counts per PRISMA if systematic. 7) Export to citation manager on first pass, not later.
**Template:** `Question | Type (sys/narr) | Databases | Search string per DB | Date range | Inclusion criteria | Exclusion criteria | Hits → screened → included (PRISMA counts)`
**Variation:** Keyword drift — search string mutates between databases so results aren't comparable. Freeze the matrix; document any deviation per database.

## 2. Choosing the statistical test
**Trigger:** Data collected (or power analysis needed pre-collection); "which test do I run?"
**Approach:** 1) State hypothesis as a comparison or association BEFORE looking at data. 2) Classify DV and IV: continuous/ordinal/categorical; count groups; paired vs independent. 3) Check assumptions (normality, homogeneity of variance, independence) — pick parametric or non-parametric accordingly. 4) Run power analysis first when designing: effect size (from pilot or literature) + α=.05 + power=.80 → required n. 5) Pre-register the analysis; run exactly that. 6) Report effect size + CI, not p alone.
**Checklist:** `[ ] Hypothesis written pre-analysis [ ] Variable types classified [ ] Assumptions tested & reported [ ] Test justified in one sentence [ ] Effect size + CI reported [ ] All tests run are reported (no drawer)`
**Variation:** P-hacking by iteration — trying tests/subgroups until p<.05, then reporting only the winner (HARKing when the hypothesis is rewritten to match). The pre-registered analysis plan is the defense; deviations go in a labeled "exploratory" section.

## 3. Building a survey instrument
**Trigger:** Construct must be measured and no validated instrument fits.
**Approach:** 1) Search for an existing validated instrument first — adapt before inventing. 2) Define the construct and write items only against that definition. 3) One idea per item; kill double-barreled ("useful and easy") and leading items. 4) Fix the scale: 5- or 7-point Likert, labeled endpoints, consistent direction, deliberate reverse-coded items. 5) Cognitive-pretest with 5–10 respondents thinking aloud. 6) Pilot n≥30; compute Cronbach's α (target ≥.70); drop items that raise α when deleted. 7) Document validity evidence (content, construct) before fielding.
**Template:** `Construct def | Source instrument (if any) | Item pool | Scale + anchors | Reverse-coded items | Pretest findings | Pilot n / α | Items dropped + why`
**Variation:** Construct creep — items drift into adjacent constructs (satisfaction items in a trust scale), inflating α while measuring nothing coherent. Re-check every item against the written construct definition.

## 4. Coding qualitative interview data
**Trigger:** Transcripts in hand; themes needed for findings section.
**Approach:** 1) Choose deductive (codebook from framework) or inductive (grounded, codes emerge) and state it. 2) Read all transcripts once without coding. 3) Open-code 2–3 transcripts; draft codebook with name/definition/example per code. 4) Second coder codes a 10–20% sample; compute agreement (κ ≥.70) or resolve by discussion; revise codebook. 5) Code the corpus; memo throughout. 6) Cluster codes into themes; a theme needs multiple sources, not one vivid quote. 7) Triangulate against other data; hunt negative cases explicitly.
**Checklist:** `[ ] Approach stated [ ] Codebook with definitions+examples [ ] Second coder / reliability step [ ] Negative cases sought [ ] Themes span multiple participants [ ] Audit trail of codebook versions`
**Variation:** Anecdote-as-theme — one articulate participant's quote becomes a "theme." Require frequency/spread evidence per theme and report how many participants support each.

## 5. Writing the abstract last
**Trigger:** Paper/report drafted; abstract, executive summary, or conference submission due.
**Approach:** 1) Write it after the full draft — never first. 2) Follow the fixed spine: problem (1–2 sentences) → method (1–2, include n and design) → results (2–3, with actual numbers and effect direction) → implications (1, the "so what"). 3) Include the headline quantitative result verbatim from Results — no rounding drift. 4) Cut every sentence that only appears in the abstract; if it matters, it belongs in the paper. 5) Verify against word limit and required structure (structured abstract for AMA journals). 6) For reports: the executive summary must stand alone — a reader who stops there gets findings AND recommendations.
**Template:** `Problem: ___ | Method: design=___, n=___, analysis=___ | Results: ___ (stat), ___ (stat) | Implication: ___`
**Variation:** Results-free abstracts ("results are discussed") and claims stronger than the paper supports. Diff every abstract claim against the Results section; the abstract may never overreach the limitations section.

## 6. Pre-submission argument audit
**Trigger:** Draft complete; before advisor review, journal submission, or client delivery.
**Approach:** 1) Extract the thesis; confirm it is contestable, not descriptive. 2) For each major claim, trace claim → evidence → reasoning; flag any claim resting on a single source or on secondary sources where primary exists. 3) Verify the strongest counterargument is stated and rebutted, not omitted. 4) Check literature integration: paragraphs organized by idea with multiple citations, not one-source-per-paragraph summaries. 5) Confirm limitations section exists and covers sampling, generalizability, and confounds actually present. 6) Verify every in-text citation appears in the reference list and vice versa; check style (APA/AMA/IEEE) mechanically, not by memory. 7) Check recommendations are actions ("do X by Y") not observations restated.
**Checklist:** `[ ] Contestable thesis [ ] Claim→evidence map complete [ ] Counterargument + rebuttal present [ ] Synthesis not serial summary [ ] Limitations honest & specific [ ] Citations reconciled both directions [ ] Recommendations actionable [ ] "So what" answerable in one sentence`
**Variation:** Cherry-picked evidence base — the review cites only supporting studies. For each key claim, search explicitly for disconfirming studies and address the strongest one found.

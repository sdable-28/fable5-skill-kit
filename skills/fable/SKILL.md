---
name: fable
description: Master domain router for the Fable Kit. Invoke at session start to activate the right discipline for the work. Reads context, identifies the primary domain (and secondary if multi-domain), applies condensed principles and critical verification gates for that domain, and lists which skills to invoke. Handles multi-domain work with explicit blending and crossover rules. Trigger keywords - /fable, "what framework applies here", "activate fable", "which domain is this", "what gates apply". Do NOT invoke for trivial single-question lookups answerable in one search — use specific domain skills directly instead.
---

# fable — Master Domain Router

Detects domain(s) from conversation context. Outputs the activation block for the detected domain: condensed principles, critical gates, and skills to use. Handles multi-domain blending with explicit crossover rules.

## When invoked

1. **Read the task.** Identify what the user is building, reviewing, analyzing, or deciding. One sentence restating the core work.
2. **Detect domain(s).** Match against the 17 domain detection signals below. Name PRIMARY + SECONDARY if applicable.
3. **Check crossover map.** If two domains are active, apply the blending rule.
4. **Output the activation block.** Domain + principles + gates + skills + posture. Nothing more.
5. **Proceed.** Work under the activated discipline for the session.

---

## DOMAIN DETECTION SIGNALS

Match the task to the domain whose signals are most prominent. When multiple apply, name the one that governs the primary deliverable as PRIMARY.

| Domain | Key signals |
|--------|------------|
| software-engineering | code, bug fix, refactor, PR review, API, database query, test, deployment |
| trading-finance | backtest, strategy, signal, position, drawdown, futures, options, alpha, P&L |
| architecture-systems | system design, scalability, microservices, distributed systems, ADR, database choice, capacity |
| marketing-sales | campaign, leads, CAC, conversion, email sequence, content strategy, channel, pipeline |
| legal-compliance | contract review, GDPR, compliance audit, terms, IP assignment, liability, regulation |
| creative-media | copywriting, video, ad creative, brand voice, podcast, social media, content series |
| data-science-ml | model training, prediction, ML, AI, dataset, features, classification, LLM eval |
| devops-infrastructure | Terraform, Kubernetes, CI/CD, deploy, cloud, Docker, monitoring, incident response |
| product-management | roadmap, PRD, feature prioritization, backlog, A/B test, North Star, user story |
| research-academic | literature review, study design, hypothesis, methodology, citation, paper draft |
| operations-supply-chain | inventory, supply chain, logistics, demand forecasting, process improvement, procurement |
| business-strategy | market entry, competitive analysis, M&A, growth strategy, scenario planning, P&L review |
| personal-productivity | time management, productivity system, habits, decisions, focus, calendar, attention |
| founder-entrepreneur | startup founding, fundraising, pitch, co-founder, equity, term sheet, first customers |
| startup-growth | growth model, PLG, viral, CAC payback, NRR, scaling, ARR, Series A/B/C |
| security-engineering | security review, threat model, STRIDE, vulnerability, auth, access control, XSS, injection |
| healthcare-life-sciences | clinical, medical, drug, diagnosis, treatment, patient care, HIPAA, FDA, RCT, evidence |

---

## DOMAIN ACTIVATION BLOCKS

Output the block matching the detected domain.

---

### SOFTWARE ENGINEERING

**PRINCIPLES (apply throughout)**
1. Reproduce before you fix — observe the failure directly before the first edit; "should fix it" without a before-observation is a guess.
2. Map before edit — enumerate every caller of a modified function before touching it; one Grep/CodeGraph query minimum.
3. Never claim done without executed evidence — "tests pass" alone is insufficient; the changed behavior must be observed in a running context.
4. Treat all input as hostile at trust boundaries — string-concatenated SQL, unsanitized HTML, and eval on external input are automatic failures.
5. Idempotency is the default for anything that can retry — queues, webhooks, cron, payment paths.

**CRITICAL GATES**
- **Reproduction**: Failure observed BEFORE the first edit; same trigger produces correct behavior AFTER. Transcript must show both.
- **Regression-proof test**: A test fails on pre-fix code and passes on post-fix code — bidirectional proof required.
- **Behavioral execution**: Changed path executed in a running context (curl, browser, CLI), not only under test.
- **Blast radius**: Every caller of a changed function enumerated; every consumer of a changed schema/API enumerated. N/N accounting.
- **Security boundary**: Diff grepped for SQL interpolation, innerHTML, dangerouslySetInnerHTML, pickle.loads, yaml.load, verify=False.

**SKILLS** `/debug-isolator` (bug isolation) · `/refactor-gate` (safe refactor) · `/api-contract-verifier` (API changes) · `/code-investigation` (gap analysis) · `/root-cause-first` (production issues)

**POSTURE:** Verify behavior, not intent. Every claim requires executed output in the transcript.

---

### TRADING & FINANCE

**PRINCIPLES**
1. No result without its denominator — "62% WR" is banned; "62% WR over 48 trades, NQ, Jan–May, next-bar-open fills, 1 tick slippage" passes.
2. Out-of-sample is spent once — the moment you iterate on a parameter after seeing OOS results, that period is in-sample forever.
3. Every backtest states its fill model or it is invalid — limit orders require price to trade through, stops fill with adverse slippage.
4. Signal computation uses only data available at signal time — trace timestamps, do not read variable names.
5. Drawdown math before profit math — compute worst-case streak vs available drawdown before evaluating expectancy.

**CRITICAL GATES**
- **Look-ahead freedom**: Trace 3 sampled signals end-to-end; every input has a finalization timestamp ≤ signal timestamp.
- **Fill model realism**: Sample 10 trades; verify each fill was physically obtainable from the bar's range.
- **P&L reconciliation**: Sum of per-trade P&L equals reported net to the cent; positions flat at session close.
- **Out-of-sample integrity**: IS/OOS split declared BEFORE first run; OOS evaluated at most once per strategy variant.
- **Cost & slippage survival**: Net result computed at 0×, 1×, and 2× slippage; edge survives at 2× or is labeled cost-marginal.

**SKILLS** `/backtest-discipline` · `/execution-analysis` · `/risk-first-sizing` · `/regime-awareness` · `/trade-journaling`

**POSTURE:** Leakage and fill-model integrity before everything. An edge built on leaky data is not an edge.

---

### ARCHITECTURE & SYSTEMS DESIGN

**PRINCIPLES**
1. No design without numbers — peak QPS, payload size, data volume at 1×/10×/100×, growth rate. A design doc with zero arithmetic is incomplete.
2. Partition tolerance is not a choice — the only decision is CP vs AP per operation; "we chose CA" is wrong.
3. Every cross-service write names its consistency mechanism — outbox, saga with compensations, idempotent retry with named dedup key, or justified 2PC.
4. No ADR, no one-way-door decision — datastore, shard key, sync/async boundary, tenancy model. Written context, ≥2 real options, consequences.
5. Design the failure path before elaborating the happy path — slow (not dead) is the hard case; it exhausts pools and isn't caught by timeouts.

**CRITICAL GATES**
- **Numbers gate**: Every capacity claim has a number with a source. Scale adjectives (high, large, fast) adjacent to figures.
- **Consistency declaration**: Every read path labeled strong/eventual; every cross-store write has a named mechanism.
- **Failure-path gate**: Run six drills: partition mid-write, 10× overload, slow dependency, hot key, restart storm, clock skew. Each terminates in "handled by" or "accepted risk."
- **ADR gate**: Every one-way door has an ADR with ≥2 genuine options, quantified trade-offs, and a reopen trigger.
- **Timeout coherence**: Timeout table exists; timeouts strictly decrease down the call chain; retry amplification product ≤3.

**SKILLS** `/adr-writer` · `/capacity-planner` · `/failure-mode-mapper` · `/migration-strategist` · `/observability-designer`

**POSTURE:** Numbers and failure modes before happy path. A design that only works when everything succeeds is a sketch.

---

### MARKETING & SALES

**PRINCIPLES**
1. No metric without a denominator and a comparison — "1,200 MQLs" is banned; "1,200 MQLs vs 980 last month, converting at 18% vs 24% trailing 90d" passes.
2. Message hierarchy before copy — state the positioning sentence (For [segment] who [JTBD], [product] is the [category] that [differentiator]) before writing one word of headline copy.
3. Every A/B test declares hypothesis, primary metric, MDE, and sample size before launch — "won" below pre-declared sample is not won.
4. Attribution requires triangulation from ≥2 independent sources — platform-reported conversions alone never justify a budget decision.
5. Pipeline and revenue outrank engagement in every recommendation — impressions/opens/likes appear only as diagnostic intermediates.

**CRITICAL GATES**
- **Attribution model named**: Every ROAS/CAC claim states which model produced it (first-touch/last-touch/linear/data-driven).
- **LTV:CAC grounding**: Computed stepwise from named inputs, per segment — not blended.
- **Lead-definition alignment**: MQL/SQL definition is written, dated, agreed by both marketing and sales before any lead-volume work.
- **Incrementality over correlation**: Major budget reallocations attach a holdout/incrementality test, not just attributed ROAS.
- **Vanity vs pipeline**: Success claim maps to pipeline or revenue, not impressions or follower count.

**SKILLS** `/icp-sharpener` · `/channel-attribution-auditor` · `/copy-testing-loop`

**POSTURE:** Revenue trace before execution. Every deliverable traces back to a business outcome, not a channel metric.

---

### LEGAL & COMPLIANCE

**PRINCIPLES**
1. Jurisdiction before analysis — no substantive legal statement until governing law is established or explicitly assumed in the first three lines.
2. Every load-bearing legal claim cites a primary source — statute, regulation, case — or carries an explicit uncertainty flag.
3. Date-stamp legal knowledge — state the as-of date; flag areas known to be moving (AI regulation, state privacy laws, non-compete).
4. Contract review is coverage-first, critique-second — run the missing-provisions checklist before analyzing provisions that exist.
5. Escalation triggers are explicit outputs — concrete "engage counsel when/for" list, not a generic disclaimer.

**CRITICAL GATES**
- **Not-legal-advice framing**: Deliverable states it is informational analysis; specific advice requires a licensed attorney.
- **Jurisdiction established first**: Governing law named before the first legal conclusion.
- **Primary-source authority**: Every rule-assertion cites primary authority at the correct rank for the pinned jurisdiction.
- **Regulatory currency**: Cited law confirmed current; pending changes flagged.
- **Compliance-control evidence**: Each framework control marked MET/PARTIAL/GAP/UNKNOWN; MET requires an evidence pointer.

**SKILLS** `/jurisdiction-first` · `/contract-risk-scan` · `/compliance-gap-mapper`

**POSTURE:** This is analysis support, not legal advice. Route to licensed counsel at every defined trigger.

---

### CREATIVE & MEDIA PRODUCTION

**PRINCIPLES**
1. No generation before a hardened brief — brief specifies persona, single desired action, platform spec, voice reference, 2+ concrete examples, and explicit exclusions.
2. One asset, one job — exactly one primary CTA; two competing CTAs of equal weight means the draft is wrong.
3. First revision cuts ≥20% of words — draft long, then cut; the cut targets adverbs, hedges, throat-clearing.
4. Iterate on named failure modes, never on "better" — banned: "improve this," "make it pop." Required: "hands malformed," "hook buries tension until sentence 3."
5. Lock the style block before generating a series — freeze character descriptors, palette, lighting, seed; vary only the content slot.

**CRITICAL GATES**
- **Brief compliance**: Field-by-field table — brief requirement → where in the asset it is satisfied. Any row without a location fails.
- **Swap-test genericness**: Replace brand name with a competitor's — the asset must break. Zero breaking sentences = generic = fail.
- **Voice rule scoring**: Zero unjustified violations of the falsifiable voice rules.
- **Claim audit**: Every stat, quote, and capability claim mapped to a verifiable source; unresolvable claims cut before publish.
- **Platform spec measurement**: Dimensions, duration, frame rate, file size measured (not preset-trusted); text inside safe zones.

**SKILLS** `/brief-sharpener` · `/consistency-enforcer` · `/iterative-image-refiner`

**POSTURE:** Brief first, generate second. A soft brief produces generic output regardless of execution quality.

---

### DATA SCIENCE & AI/ML

**PRINCIPLES**
1. No model before a baseline — majority-class predictor, domain heuristic, and persistence baseline recorded BEFORE the first model run.
2. Temporal data gets temporal splits, always, no exceptions — random K-fold on timestamped data predicting the future is an automatic invalid result.
3. Every feature carries a timestamp proof — if availability at prediction time cannot be proven, the feature is presumed leaky and removed.
4. A result that is too good is a bug report, not a win — AUC >0.95 on human behavior triggers a mandatory leakage audit before any communication.
5. Never train ML models on backtest/simulated outcomes — models learn the simulator's bugs; train only on live-labeled data.

**CRITICAL GATES**
- **Baseline beaten**: Candidate model beats all three baselines (trivial, heuristic, random-at-capacity) logged before the first model run.
- **Leakage audit clean**: Feature manifest has `available_at` for 100% of features; shuffled-label test at chance level; no fit outside the training fold.
- **Split integrity**: Temporal cutoff with purge gap ≥ label horizon; no entity on both sides of a group split.
- **Plausibility cleared**: Any metric above the pre-registered plausibility bar triggers a re-audit note explaining the legitimate source.
- **Monitor and rollback shipped**: Deployment PR includes drift monitor, alert threshold, and one-command rollback.

**SKILLS** `/leakage-detector` · `/eval-metric-alignment` · `/drift-monitor-designer`

**POSTURE:** Leakage and temporal integrity before model quality. A fast model on leaky features is wrong, not promising.

---

### DEVOPS & INFRASTRUCTURE

**PRINCIPLES**
1. No apply without a read plan — never run `terraform apply`, `kubectl apply`, or a pipeline deploy without reading the full diff/plan and stating every destroy/replace.
2. Every change ships with its rollback written first — literal rollback commands in the change description before execution begins.
3. Destroy/replace lines in a plan are stop signs — stateful resources (database, volume, queue, KMS key) halt execution until the replacement is justified in writing.
4. Secrets never transit code, logs, or shell history — if already exposed, treat as compromised; rotation is the fix, not deletion from HEAD.
5. Never debug production by mutating it — no `kubectl edit` or console clickops during diagnosis except as a declared break-glass action logged and reconciled same day.

**CRITICAL GATES**
- **Blast radius bounded**: Change states maximum failure scope; staged to limit that radius.
- **Plan reviewed before apply**: `terraform plan` output inspected; no unintended destroy/replace.
- **Rollback path proven**: Rollback procedure exists and is runnable AFTER the change (not before).
- **No secret sprawl**: Secrets in vault; none in code, logs, env dumps, or IaC state.
- **Observability trinity**: Change is observable via metrics, logs, AND traces sufficient to debug in prod.

**SKILLS** `/blast-radius-estimator` · `/runbook-writer` · `/cost-anomaly-scanner`

**POSTURE:** Rollback before apply. Write the rollback commands before writing the execution commands.

---

### PRODUCT MANAGEMENT

**PRINCIPLES**
1. Every number carries its derivation or its confession — no metric or estimate without shown arithmetic or an explicit `[GUESS]` tag with uncertainty range.
2. Problem validation precedes solution validation and they are never the same activity — problem evidence and solution evidence are labeled separately.
3. Interview questions about the past, not the future — "tell me about the last time you X" is admissible; "would you use a tool that Y?" is not evidence.
4. A roadmap item without a target metric movement is a task, not a bet — each roadmap entry states the metric and expected direction.
5. Every success metric ships with a guardrail metric — name the metric this initiative could damage and monitor it in the same dashboard.

**CRITICAL GATES**
- **Problem-before-solution**: Problem validated (non-leading interviews) before any solution is specified.
- **Outcome-based roadmap**: Each roadmap item states the metric it moves, not the feature it ships.
- **North Star with guardrails**: North Star metric paired with guardrail metrics that catch gaming.
- **A/B test power and MDE**: MDE, sample size, and duration from a power calculation before launch.
- **Feature-impact closure**: Shipped features measured against predicted outcome; misses logged.

**SKILLS** `/hypothesis-prioritizer` · `/north-star-aligner` · `/stakeholder-no-framer`

**POSTURE:** Name what the work should move before specifying what to build. A feature without a target metric is a guess.

---

### RESEARCH & ACADEMIC WRITING

**PRINCIPLES**
1. State the claim type before gathering evidence — causal / associational / descriptive / self-report / speculative. The grade is written first; then verify the evidence licenses it.
2. A citation is a checkable promise — traceable to a specific finding or page; the source must say what the sentence uses it for.
3. Hypotheses are timestamped — confirmatory claims require the hypothesis to predate the analysis; post-hoc findings are labeled exploratory.
4. One analysis per hypothesis unless corrections are applied — reporting only the significant cell from 5 outcomes × 3 subgroups × 2 covariates is p-hacking regardless of intent.
5. Synthesize by variable, never by paper — "Smith found X. Jones found Y." is an annotated bibliography, not a literature review.

**CRITICAL GATES**
- **Hypothesis pre-registration**: Hypothesis stated before results; post-hoc findings labeled exploratory.
- **Source hierarchy enforced**: Claims rest on primary sources at the correct evidence level for the claim type.
- **Study design matches claim**: Causal verbs (causes, prevents) used only for RCTs or strong quasi-experimental designs.
- **Multiple-comparison honesty**: Every test run is counted; corrections applied or look-count disclosed.
- **So-what present**: Every finding carries an implication; abstract closes on implications.

**SKILLS** `/source-hierarchy-enforcer` · `/harking-detector` · `/so-what-extractor` · `/evidence-reasoning` · `/adversarial-disproof`

**POSTURE:** Claim type first. Permissible language is determined by study design, not by what the author wants to say.

---

### OPERATIONS & SUPPLY CHAIN

**PRINCIPLES**
1. Units and time-bucket integrity — every quantity traces to a unit (eaches/cases/kg/$) and a time bucket (day/week/month); every join confirms dimensional consistency.
2. Every stochastic input is mean + dispersion — safety stock from a mean-only formula is wrong by construction; demand variance is required.
3. As-is grounding for process work — every current-state process map cites its evidence per step: observed, interviewed, or event-log-derived.
4. Constraint named for throughput work — identify the bottleneck with data before proposing any improvement.
5. Savings are dated cash — split hard (specific budget line, start date) from soft (capacity/avoidance); payback in months; implementation costs on the same timeline.

**CRITICAL GATES**
- **Units & time-bucket integrity**: Two-column table (quantity → unit, bucket) for every input; every formula dimensionally consistent.
- **Variance term present**: Every stochastic input enters as mean + dispersion, or carries a flagged assumption with a sensitivity line.
- **Naïve baseline beaten**: Forecast scored on a holdout window against the seasonal-naïve baseline.
- **Constraint named**: Bottleneck identified with data; improvement expressed in system-level throughput terms.
- **Savings are dated cash**: Cash timeline reconstructible month-by-month from the deliverable alone.

**SKILLS** `/bullwhip-detector` · `/process-reality-checker` · `/sop-writer`

**POSTURE:** The variance term before the formula. A safety-stock calculation without demand dispersion is arithmetically incomplete.

---

### BUSINESS STRATEGY

**PRINCIPLES**
1. No analysis before a testable problem statement — names the decision, decision-maker, time horizon, success metric, and constraints. All five required.
2. State the answer before completing the analysis — hypothesis-led: form a day-one answer, structure analysis to falsify it, record what evidence would change it.
3. Every decomposition passes the MECE audit — mutual exclusivity (can one fact land in two branches?) and collective exhaustion (name a scenario outside all branches).
4. Every financial recommendation survives its own sensitivity analysis — identify the 2–3 variables the answer is most sensitive to; report break-even values in the executive summary, not the appendix.
5. Every recommendation includes an implementation path — first 90 days, owner role, required capabilities, change-management burden, leading indicator.

**CRITICAL GATES**
- **Problem-statement precision**: Problem stated as one falsifiable question with a decision attached.
- **MECE decomposition**: Branches mutually exclusive and collectively exhaustive; audit note attached.
- **So-what discipline**: Every data point and exhibit carries an explicit implication ("therefore...").
- **Business-case sensitivity**: Break-even value stated for each top-driver assumption; recommendation states if it flips within the plausible range.
- **Implementation path**: Deliverable names first actions, owners, capability gaps, and the leading indicator of success/failure.

**SKILLS** `/mece-decomposer` · `/so-what-enforcer` · `/scenario-planner` · `/evidence-reasoning`

**POSTURE:** Answer-first in the deliverable, even though analysis precedes the answer in the work. "See slide 3" in an executive summary is a defect.

---

### PERSONAL PRODUCTIVITY

**PRINCIPLES**
1. Capture is complete or it is worthless — every commitment in exactly one trusted system; anything held in the head or an unprocessed inbox >48h is a system failure.
2. A next action names a physical, visible behavior — "Plan offsite" is a project; "Email Priya three candidate dates" is an action.
3. The Weekly Review is the heartbeat — skip two consecutive weeks and declare the system dead, not paused. Dead systems produce false confidence.
4. MITs before inbox — 1–3 Most Important Tasks chosen the prior evening; the first block goes to MIT #1, not to email.
5. Classify reversibility before analysis depth — a week deliberating on a reversible tool choice is a violation; deciding a hire in one afternoon is one too.

**CRITICAL GATES**
- **Capture integrity**: 5 commitments from the last 2 weeks sampled across email/chat/notes and cross-referenced to the trusted system.
- **Next-action concreteness**: 5 random items from the active list each start with a physical verb and are executable within 60 seconds of reading.
- **Output over tidiness**: Week's review answers "what important work shipped?" with named deliverables BEFORE any discussion of list hygiene.
- **Deep-work block authenticity**: Blocks ≥90 minutes, single deliverable named, notifications off — "deep work" with Slack open is a shallow block in costume.
- **Intervention falsifiability**: Every new habit/tool/schedule ships with observable success signal, kill criterion, and review date ≤14 days.

**SKILLS** `/context-switch-minimizer` · `/decision-journal-writer` · `/weekly-review-runner`

**POSTURE:** The system's success metric is important work shipped, not list cleanliness or inbox state.

---

### FOUNDER & ENTREPRENEUR

**PRINCIPLES**
1. No opinion counts as evidence — every validation data point tagged BEHAVIOR (they did something costly) or OPINION (they said something); conclusions rest only on BEHAVIOR rows.
2. Market size is bottoms-up or not at all — required form: (# identifiable buyers) × (price they demonstrably pay for adjacent solutions) × (defensible penetration).
3. Manual before machine — first 10 customers won personally by a founder, delivery done by hand, ~$10k MRR before any spend on ads, SEO, or sales hires.
4. IP assignment before money, always — every founder and past contractor has signed IP assignment before any fundraise step; missing is a raise-blocking finding.
5. Flag the irreversible — before any output touching equity, entity, IP, or employment classification: append a one-way-door notice naming what requires licensed professional review.

**CRITICAL GATES**
- **Mom-test compliance**: Every validation quote references something the buyer already did/paid, not a future promise.
- **Market sizing bottoms-up**: Number traces to (buyers × ACV × penetration); reject percentage-of-big-number.
- **IP assignment before raise**: Signed IP assignment exists for every founder and contractor before capital.
- **First-traction manual proof**: First 10 customers won by direct founder outreach; delivery was manual before any scaling proposal.
- **Survival-metric priority**: Success metric is runway, retention, or MRR — not press, launch splash, or investor meeting count.

**SKILLS** `/momtest-auditor` · `/term-sheet-analyzer` · `/cofounder-agreement-checklist` · `/plan-gate` · `/adversarial-disproof`

**POSTURE:** Behavior over opinion. Every validation claim traces to something a buyer did, not something they said they would do.

---

### STARTUP GROWTH

**PRINCIPLES**
1. Do not claim PMF without two independent measures agreeing — Sean Ellis ≥40% "very disappointed" AND retention curve flattens to a horizontal asymptote.
2. Retention curve shape gates everything — if the curve decays to zero, do not spend on acquisition; growing acquisition on a leaky bucket accelerates the leak.
3. Cohort, never blend — retention, CAC, and NRR are reported by cohort and by segment; a blended headline number hides the truth when mix shifts.
4. Match the playbook to the stage explicitly — before any tactic, state the company's ARR band (0→$1M / $1M→$10M / $10M→$100M) and confirm the tactic belongs to it.
5. NRR/NDR is a first-class metric from first dollar of expansion revenue — NRR <100% means the company shrinks without new logos; dashboards focused on new MRR hide this.

**CRITICAL GATES**
- **PMF two-signal confirmation**: PMF claimed only when Sean Ellis ≥40% AND retention curve has a visible flat tail.
- **Retention curve flattens before scale**: Acquisition-scaling recommendations only follow a cohort retention curve with a flat tail above 0%.
- **Cohorted, never blended**: Retention, CAC, NRR reported by cohort and segment — no blended headline.
- **Stage-match**: Every recommendation names its ARR band and the tactic belongs to it.
- **NRR as first-class metric**: NRR computed and trended alongside new MRR; below 100% flagged explicitly.

**SKILLS** `/pmf-signal-reader` · `/growth-model-selector` · `/nrr-health-checker` · `/scope-fence`

**POSTURE:** Retention curve before acquisition. PMF is two-measure-confirmed or it is a hypothesis.

---

### SECURITY ENGINEERING

**PRINCIPLES**
1. Model the attacker path, not the checklist — a finding requires source (attacker-controlled input) → flow → sink (dangerous operation). No path, no finding.
2. Reach the code, not just the diagram — every enumerated threat maps to the `file:line` where it is introduced or mitigated; architecture-only threat models are incomplete.
3. Assess exploitability, not CVE presence — a flagged dependency CVE is not a finding until reachability is argued.
4. Fix the class, not the instance — one SQL injection via string formatting is remediated by mandating parameterized queries across the sink, not by escaping the one input.
5. Authorization at the data layer, every object access — every object fetch enforces "does this principal own this ID" server-side; no object returned on client-supplied ID without an ownership check.

**CRITICAL GATES**
- **Threat model reaches code**: Every DFD element has a STRIDE row; each threat cites a `file:line` or names the missing-control location.
- **Every finding has an attacker path**: Source → flow → sink named for each finding.
- **Exploitability, not CVE count**: Each dependency finding carries a reachability verdict, not just a CVE ID and severity.
- **No secret in tree or history**: Secret scan of working tree AND full git history; exposed keys rotated (deletion from HEAD is not remediation).
- **Security paths fail closed**: Exception handling in authn/authz/validation code denies on exception, never allows.

**SKILLS** `/security-threat-modeling` · `/code-investigation` · `/adversarial-disproof` · `/root-cause-first`

**POSTURE:** Source → flow → sink. A claim of vulnerability without a complete attacker path is not a finding.

---

### HEALTHCARE & LIFE SCIENCES

**PRINCIPLES**
1. Every clinical claim carries an explicit evidence level — state the study design and hierarchy tier (meta-analysis of RCTs → RCT → cohort → case series → expert opinion) for any efficacy, harm, or causation assertion.
2. Absolute effects accompany every relative effect — never report RRR, HR, or OR without the absolute risk reduction and NNT/NNH; baseline risk must be stated.
3. Distinguish correlation, association, and causation in words — "causes" is reserved for randomized or strong quasi-experimental designs; observational data yields "associated with."
4. Surrogate endpoints are labeled as surrogates — LDL, HbA1c, tumor response, viral load are surrogates; mortality, MI, stroke, fracture are hard endpoints; never let a surrogate improvement imply a hard-outcome benefit.
5. Controlled substances, dosing, and emergencies trigger the deferral protocol — route the actionable decision to a licensed professional; do not produce individualized dosing instructions.

**CRITICAL GATES**
- **Evidence tier attached**: Every efficacy/harm/causation claim names its study design and hierarchy tier.
- **Relative effect has absolute companion**: Every HR/OR/RRR has an ARR and a stated baseline rate.
- **Correlation/causation language matches design**: Causal verbs used only for RCTs or strong quasi-experimental evidence.
- **Safety deferral for hard triggers**: Controlled substances, specific dosing, emergency scenarios route to licensed professional; no individualized actionable instruction produced.
- **Informational frame and no fabricated citations**: Content closes with the informational-analysis-not-medical-advice frame; every citation is groundable; no fabricated patient data.

**SKILLS** `/evidence-reasoning` · `/adversarial-disproof` · `/uncertainty-handling` · `/coverage-accounting`

**POSTURE:** Evidence tier before conclusion. State the study design hierarchy before drawing any clinical claim from it.

---

## CROSSOVER MAP

Apply when two domains are both active.

**marketing-sales ↔ startup-growth**
Boundary: marketing-sales governs channel EXECUTION mechanics (campaign setup, creative ops, email deliverability, SEO specifics). startup-growth governs GROWTH MODEL strategy, unit economics, and stage-sequencing (when to scale which channel, PLG vs SLG selection, NRR).
Blending rule: Apply marketing-sales gates to execution deliverables. Apply startup-growth gates to model/unit-economics questions. When a channel recommendation crosses both (e.g., "should we invest in paid now?"), apply startup-growth Stage-Match gate first — if the stage doesn't support it, the channel execution question is moot.

**research-academic ↔ startup-growth**
Boundary: research-academic governs EXPERIMENTATION CRAFT (power calculations, split integrity, p-hacking prevention, result interpretation). startup-growth governs METRICS BY STAGE (what metrics matter at what ARR, what PMF looks like).
Blending rule: Use research-academic gates on any A/B test or experiment design. Use startup-growth gates on metric selection and stage-appropriate interpretation. Conflict example: research-academic says "test is underpowered" — startup-growth says "we need a signal now." Resolution: flag the underpowered nature explicitly, run the test, and label any result as directional-only until properly powered.

**founder-entrepreneur ↔ startup-growth**
Boundary: founder-entrepreneur governs 0→first traction (pre-PMF, manual proof, survival, equity structure, fundraising). startup-growth governs POST-PMF SCALING (growth model selection, NRR optimization, international, Series B+).
Blending rule: Apply founder-entrepreneur discipline until PMF is CONFIRMED by two independent measures (startup-growth Gate 1). Only then transition to the startup-growth playbook. If both are active and PMF is unconfirmed, founder-entrepreneur takes precedence — do not apply scaling tactics to a pre-PMF company.

---

## OUTPUT FORMAT

When /fable is invoked, produce exactly this structure — no more:

```
DOMAIN ACTIVATED: [PRIMARY NAME]
[SECONDARY: NAME — reason it also applies] (omit if single domain)
[CROSSOVER ACTIVE: one-sentence blending rule] (omit if not applicable)

PRINCIPLES IN EFFECT:
[The 5 principles for the detected domain, numbered]

GATES TO RUN:
[The 5 critical gates for this task, named with one-line pass/fail]

SKILLS TO USE:
[3-5 skills with brief trigger condition per skill]

POSTURE: [The one-sentence posture for this domain]
```

Then proceed immediately under the activated discipline. Do not re-announce the domain mid-session unless it changes.

## Integration

- Pairs with `/fable-mode` — invoke `/fable` for domain routing, then `/fable-mode` for max investigation rigor on a hard task within the domain.
- Domain skills (e.g., `/backtest-discipline`, `/momtest-auditor`) implement the domain's specific protocol; `/fable` activates the context that makes those skills coherent.
- Core skills (`/adversarial-disproof`, `/evidence-reasoning`, `/code-investigation`) work in any domain — use them when the task calls for them regardless of which domain is active.
- When confidence on domain detection is low (task spans 3+ domains equally), output: "DOMAIN UNCLEAR — state the primary deliverable and its decision-maker" and wait for one clarifying sentence before activating.

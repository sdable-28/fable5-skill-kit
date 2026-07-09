# Creative & Media Production — Domain Pack

Operating instructions for end-to-end creative production: text, image, audio, video. AI-augmented workflows, iterative quality improvement, multi-asset campaigns.

---

## 1. Domain Overview

### What makes this domain unique for AI

Creative work has no compiler. There is no test suite that fails when the copy is off-brand, no stack trace when an image series breaks character consistency. Every other domain gets a hard oracle; this one gets subjective judgment that must be **converted into checkable criteria before work starts** — or the work is unverifiable and revisions become infinite.

Three structural facts govern everything in this domain:

1. **Quality is defined upstream, judged downstream.** The brief, the voice guide, and the reference set ARE the spec. A vague brief does not produce a wrong output — it produces a *generic* output that is technically compliant and strategically worthless. The failure is invisible at delivery and only surfaces as poor performance weeks later. Treat brief-hardening as the highest-leverage activity in the domain.
2. **Generation is cheap; selection and consistency are expensive.** AI can produce 40 image variants in minutes. The bottleneck moved from "can we make it" to "can we tell which one is right, and can we make #41 match #1–40." Consistency across a series (voice across 30 posts, a character across 12 images, tone across 8 video scenes) is the hardest technical problem here and the one AI degrades fastest without explicit anchoring.
3. **Every asset lives inside a distribution system.** A piece of content has no intrinsic value — it has value at a specific position in a funnel, on a specific platform, in a specific format, for a specific persona. A brilliant 3,000-word essay delivered when the calendar slot needed a 30-second vertical clip is a failed deliverable.

### Where AI adds most value

- **Volume with a locked spec:** derivative assets (long-form → clips → emails → threads), variant generation for A/B tests, drafting against a hardened brief and codified voice guide.
- **Structured iteration:** naming specific failure modes in generated images/copy and fixing exactly those, instead of vibes-based "make it better" loops.
- **Systemization:** voice guides with falsifiable rules, content calendars with pillar coverage accounting, prompt libraries with locked style blocks, consistency tokens for image series.
- **First-pass editing:** cut passes, active-voice conversion, readability leveling, redundancy removal — mechanical discipline applied without ego.

### Where AI must defer to human expertise

- **Taste calls on final selection.** Present ranked options with explicit reasoning; the human picks. Never silently discard variants the human hasn't seen when the call is subjective.
- **Brand-defining decisions:** naming, taglines, voice-guide creation from scratch, visual identity direction. AI drafts and stress-tests; humans ratify.
- **Legal/rights exposure:** talent likeness, music licensing, trademark proximity, AI-generation disclosure requirements per platform. Flag, never assume clearance.
- **Cultural and timing risk:** humor near tragedy, trend-jacking, region-specific connotation. Flag anything that reads differently across audiences; do not self-clear.
- **Anything claiming factual authority in regulated verticals** (health, finance, legal). Draft with citations; human expert signs off.

---

## 2. Core Principles

Each rule is checkable. If compliance cannot be verified against the artifact, the rule was not followed.

1. **No generation before a hardened brief.** A brief is hardened when it specifies: audience persona (named, with pain point), single desired action, platform + format spec, voice reference (link or guide section), 2+ concrete reference examples ("like this / not like this"), and explicit exclusions. Missing any one → interrogate the brief first (see `brief-hardening` skill). Check: the brief document contains all six fields before the first draft exists.
2. **One asset, one job.** Every deliverable names exactly one primary action for the audience (read next, click, reply, save, share). If a draft serves two CTAs, split it or cut one. Check: count CTAs in the final asset; the count is 1.
3. **First revision cuts ≥20% of words.** Draft long, then cut. The cut pass targets: adverbs, hedges, throat-clearing openers, redundant restatement, passive constructions without a reason. Check: word count before/after pass one; reduction ≥20% or a written justification for why the draft was already tight.
4. **Voice rules are falsifiable or they are not rules.** "Friendly but professional" is not a rule. "Contractions always; no exclamation marks in body copy; sentence length averages under 17 words; we say 'you', never 'users'" are rules. Check: any sentence of output can be scored pass/fail against each rule.
5. **Iterate on named failure modes, never on "better."** Every regeneration request names the specific defect: "hands malformed," "lighting flat, needs rim light," "hook buries the tension until sentence 3." Banned prompts: "improve this," "make it pop," "more professional." Check: the iteration log contains a named defect per round.
6. **Lock the style block before generating a series.** For any multi-image or multi-scene job, freeze a reusable style/character block (subject descriptors, palette, lighting, lens, mood, seed/reference-image strategy) and vary ONLY the per-asset content slot. Check: prompts in the series diff only in the content slot.
7. **Platform specs are inputs, not export settings.** Aspect ratio, duration ceiling, safe zones, caption norms, and hook timing (first 1.5s for vertical video, first line for feed posts) shape the creative from the planning stage. Check: the plan states the platform spec before scripting/prompting begins.
8. **Repurposing flows downhill from one canonical asset.** Long-form parent → clips, emails, threads, quotes. Never write derivatives from memory of the parent; extract verbatim, then adapt. Check: every derivative maps to a timestamped/quoted span of the parent.
9. **Hooks are written last and tested first.** Write 5–10 hook/headline variants after the body exists; select against the persona's scroll context, not aesthetic preference. Check: the working file contains the discarded variants.
10. **Claim discipline: every factual assertion has a source or a hedge.** Statistics, quotes, product capabilities — cite or soften. AI-fabricated statistics in published content is a fire-your-agency offense. Check: annotated draft with source per claim before publishing gate.
11. **Trend fit is strategic, not reflexive.** Adopt a trending format only if it maps to a content pillar and the persona actually inhabits that trend space. Check: written one-line pillar mapping for any trend-format asset; no mapping → reject.
12. **Consistency is verified visually/aurally, not assumed.** For image series: place all frames in one contact sheet and compare. For audio: A/B loudness and tone across episode segments. For copy series: read three pieces back-to-back aloud. Check: the review artifact (contact sheet, level meter readings, read-through notes) exists.
13. **Silence is a decision.** Publishing cadence bends to quality gates. A calendar slot with no gate-passing asset ships nothing, not a filler. Check: no asset in the published log carries an unresolved gate failure.
14. **Human sign-off boundaries are explicit.** Final selection among creative options, brand-new voice/visual direction, legal-adjacent content, and crisis-adjacent timing decisions go to the human with a ranked recommendation. Check: delivery notes show a recommendation + rationale, not a unilateral pick, at these boundaries.
15. **Every published asset gets a measurement hypothesis.** Before shipping: "this should move [metric] because [reason], measured at [time horizon]." Check: hypothesis written in the calendar entry. No hypothesis → the asset is decoration, not strategy.

---

## 3. Master Framework — Creative & Media Production

### Stage 1 — Understand
Interrogate the brief until it is hardened (Principle 1). Identify: persona, funnel stage, platform, format spec, voice source-of-truth, references, exclusions, deadline, and the measurement hypothesis. Pull the actual voice guide and 3 top-performing prior assets — do not work from a remembered impression of the brand. If no voice guide exists, extracting one from existing high-performing content is the first deliverable, not a skipped step.
**Tools:** brief-hardening skill; persona one-pagers; platform spec sheets; prior-performance data if available.

### Stage 2 — Decompose
Break the deliverable into its asset tree and dependency order. A "campaign" decomposes into: canonical parent asset → derivative matrix (platform × format) → per-asset specs. A single video decomposes into: script → scene list → per-scene prompts/shots → VO script → music/SFX map → edit assembly → export matrix. Identify which components are generative (cheap to redo) and which are locked-once decisions (voice, style block, structure) — locked decisions get verified first because errors there cascade into every downstream asset.
**Tools:** repurpose-cascade skill; scene/shot lists; asset-tree diagram in the working doc.

### Stage 3 — Plan
Sequence by cascade risk: style block and structure before volume generation; hooks planned as a variant set; consistency anchors (character sheet, seed strategy, voice rules) frozen and written down before batch work. Define the verification artifact for each asset class up front (contact sheet, read-aloud pass, level check, spec table). Budget iterations: cap generative refinement at 3 named-defect rounds per asset before escalating to a strategy change (wrong tool, wrong style block, wrong brief).
**Tools:** plan-gate (present plan before batch generation); calendar slotting; iteration budget written into the plan.

### Stage 4 — Execute
Generate against the locked spec only. For copy: draft full, then run the 20% cut pass, then run voice-rule scoring. For images: run the prompt template with only the content slot varied; generate in small batches (4–8), select, then continue — never generate the whole series before checking frame 1 against the anchor. For video: assemble scenes against the shot list; lay VO before music; check sync at every scene boundary. For audio: record against the quality checklist (input level −12dB peak target, room noise floor checked) before any content take. Log every prompt/seed/setting used — regenerating "that one good variant" without its parameters is a total loss.
**Tools:** prompt library with locked blocks; iteration log (prompt → defect → change); versioned working files.

### Stage 5 — Verify
Run the domain gates (see `verification_gates.md`). Minimum: brief-compliance check (asset vs hardened brief, field by field), voice-rule scoring, consistency review artifact, platform spec table (dimensions/duration/safe zones measured, not assumed), claim audit, and the read-aloud or contact-sheet pass. Verification is against the brief and the gates — never against "does this feel good," which is the human's call at selection time.
**Tools:** verification_gates.md; contact sheets; ffprobe/mediainfo for format specs; word-count and readability tooling.

### Stage 6 — Self-Correct
When a gate fails, name the defect class before fixing: is it a **spec defect** (wrong format, missing CTA — fix the asset), a **consistency defect** (drift from anchor — re-lock the anchor and regenerate), or a **brief defect** (asset is compliant but generic/wrong — the brief was soft; go back to Stage 1, not Stage 4). The most common self-correction error in this domain is polishing an asset whose brief was broken. Three failed iteration rounds on the same defect = the approach is wrong, not the execution; change tool, style block, or structure.
**Tools:** prompt-forensics skill; root-cause-first; iteration log review.

### Stage 7 — Iterate
Post-publish: check the measurement hypothesis at its stated horizon. Feed results back into the system, not just the next asset: hook patterns that won update the hook library; voice rules that got violated repeatedly get rewritten or deleted; personas that never engage get re-researched. Maintain a falsification log — formats and hypotheses that failed, with evidence — so the same dead end is not re-entered next quarter.
**Tools:** performance review template; hook/prompt library updates; falsification log.

---

## 4. Pitfalls Checklist

1. **Brief compliance theater.** Looks like: the brief said "post about our new feature," the output is a competent generic feature post that could be any company's. Detection: swap-test — replace the brand name with a competitor's; if the asset still works, it is generic. Prevention: hardened brief with "only-we-can-say-this" angle required before drafting.

2. **Voice drift across a series.** Looks like: post 1 is dry and technical, post 14 has three exclamation marks and "game-changer." Happens when each asset is generated in a fresh context against a vibes-level voice memory. Detection: read assets 1, N/2, and N back-to-back aloud; score each against the falsifiable voice rules. Prevention: voice-lock skill — codified rules + a 3-sample anchor pasted into every generation context.

3. **Character/brand consistency breakdown in image series.** Looks like: the mascot's proportions shift in frame 5, the brand blue drifts teal by frame 9, the illustration line weight changes. Detection: contact sheet of all frames viewed at once; any frame that visibly "belongs to a different set" fails. Prevention: locked style block + reference-image/seed strategy + batch-of-4 checkpoints against frame 1 (series-consistency skill).

4. **"Make it better" iteration spiral.** Looks like: 11 regeneration rounds, each prompt appending vague quality words ("stunning, professional, high quality, masterpiece"), output oscillating without converging. Detection: iteration log has rounds without a named defect. Prevention: Principle 5 — every round names one specific failure mode and changes one thing; 3-round cap per defect.

5. **Hook written first, buried tension.** Looks like: article opens with context/setup; the actual surprising claim appears in paragraph 4; social clip spends its first 3 seconds on a logo animation. Detection: does the strongest sentence in the piece appear in the first two lines? Does anything happen in second 1 of the video? Prevention: write body first, then extract the sharpest claim as the hook; vertical video rule — cold-open on the payload, logo never first.

6. **Repurposing from memory.** Looks like: the "clip from the podcast" paraphrases what the guest sort of said; the thread misquotes the article's own statistic. Detection: diff each derivative against its parent span — any claim in the derivative absent from the parent fails. Prevention: extract verbatim with timestamps first, adapt second (repurpose-cascade skill).

7. **Fabricated specificity.** Looks like: "73% of marketers say…" with no source; a customer quote that no customer gave; a product capability the product doesn't have. Detection: claim audit — highlight every number, quote, and capability claim; each needs a source link or removal. Prevention: Principle 10 gate before publish; treat unsourced statistics in a draft as bugs, not placeholders.

8. **Platform spec applied at export, not at conception.** Looks like: a 16:9 composition center-cropped to 9:16 losing the subject; a 4-minute video "shortened" to 60s by cutting the resolution of the argument; text in the bottom 15% covered by platform UI. Detection: view the asset inside a platform-frame mockup with safe zones overlaid. Prevention: Principle 7 — spec sheet in the plan; compose for the tightest target first.

9. **Trend-format mismatch.** Looks like: a B2B compliance-software brand doing a thirst-trap audio meme because it's trending; engagement spikes, pipeline doesn't, brand voice takes damage. Detection: the pillar-mapping line is missing or reads as a stretch. Prevention: Principle 11 — one-line mapping to a content pillar and persona habitat required; no mapping, no asset.

10. **VO/visual desync in AI video.** Looks like: narration says "as you can see on the left" over a centered shot; scene cuts mid-word; music swell lands two seconds after the reveal. Detection: watch the assembly muted (do visuals tell the story?), then listen without watching (does audio stand alone?), then together at 1× checking every scene boundary. Prevention: VO script and shot list built as a two-column sync document before generation; music mapped to named beats, not laid under at the end.

11. **Audio published against a broken recording, fixed in post.** Looks like: heavy noise reduction artifacts ("underwater" voice), de-esser crushing sibilance, levels riding ±6dB between hosts. Detection: noise floor and peak levels measured on the raw capture; LUFS check on the master (−16 LUFS stereo podcast target, −14 for platform-loudness-normalized). Prevention: recording checklist passes BEFORE the content take; re-record beats repair below a quality floor.

12. **Calendar-driven quality collapse.** Looks like: Thursday's slot ships a filler post that fails the swap-test because "we can't miss a day." Detection: published log contains assets with unresolved gate failures. Prevention: Principle 13 — a missed slot is a scheduling incident; a shipped gate-failure is a brand incident. The second is worse.

13. **Persona fiction.** Looks like: content aimed at "Marketing Mary, 32, loves innovation" — a persona invented in a workshop, never validated, matching no actual customer. Every asset "for her" is really for no one. Detection: can the persona be traced to real inputs (interviews, support tickets, community threads, sales calls)? Prevention: personas cite their evidence; unvalidated personas are flagged as hypotheses in the brief.

14. **Style-block contamination.** Looks like: mid-series, someone "improves" the prompt template — new lighting keyword, different model version — and frames 15–30 subtly mismatch 1–14. Detection: prompt diff across the series shows changes outside the content slot. Prevention: the style block is frozen and version-tagged; changing it mid-series requires regenerating the series or an explicit human decision to accept a visible seam.

15. **CTA multiplication.** Looks like: email ends with "read the blog, book a demo, follow us on LinkedIn, and reply with your thoughts!" — four asks, zero action. Detection: count the asks. Prevention: Principle 2; secondary links allowed only in a visually subordinate position (footer, P.S.), never as parallel CTAs.

---

## 5. Sample Task Walkthrough

**Task:** A B2B SaaS client (developer-tools company, product: API observability platform) recorded a 47-minute podcast episode with a principal engineer from a well-known fintech. Deliver the full repurposing package: show notes, one long-form article, three vertical clips (TikTok/Reels/Shorts), a 5-email nurture insert, and one X/LinkedIn thread. Brand voice guide exists. Deadline: 5 working days.

**Stage 1 — Understand.** Pull the voice guide and the last three top-performing posts. Harden the brief: persona = senior backend engineers evaluating observability tooling (validated — traced to 14 sales-call notes); funnel stage = awareness→consideration; primary CTA per asset class (article → newsletter signup; clips → follow; emails → docs page; thread → article link). Exclusions from the client: no competitor names, guest's employer name requires their comms approval — **flag immediately**, because if approval fails, every asset naming the employer must be rewritten. Get that approval request sent on day 1, not day 4. Measurement hypothesis written: clips should lift profile follows 15% week-over-week because the guest has 40k engineer followers.

**Stage 2 — Decompose.** Asset tree: transcript (canonical) → moment map → {article, clips ×3, emails ×5, thread, show notes}. Locked-once decisions: which 3 clip moments (cascades into everything — clips drive the thread's hook and the article's pull-quotes), article thesis, employer-name approval. Generative/cheap: email subject lines, thread phrasing, clip captions.

**Stage 3 — Plan.** Day 1: transcript + moment map + approval request. Day 2: moment selection (human sign-off — this is a taste call with 8 candidates, present ranked with reasoning: candidate #3 has the strongest tension but requires the employer name; #5 is safe and self-contained). Day 3: article draft + clip edits. Day 4: derivatives + gates. Day 5: fixes + delivery. Iteration budget: 3 rounds per clip on hook timing.

**Stage 4 — Execute.** Transcribe; build the moment map — every candidate moment logged with timestamp, verbatim quote, and a one-line "why this stops a scroll." Real defect caught here: the auto-transcript renders the guest saying "we cut our MTTR by forty percent" but the audio actually says "we cut our alert noise by forty percent" — a claim-changing mishear. Caught because the moment map rule is *verbatim from audio, not from transcript* for any quantitative claim (Pitfall 6/7). Article drafted at 2,100 words, cut pass takes it to 1,640 (22% — Principle 3 passes). Clips: the two-column sync doc maps caption timing to speech; clip 2's payload sentence starts at 0:04 after context — recut to cold-open on "Nobody reads dashboards during an incident," context moved after (Pitfall 5).

**Stage 5 — Verify.** Gates run: swap-test on the article (fails first pass — the intro could be any observability vendor's; rewritten around the guest's specific incident story, which only this episode has). Voice scoring: email 3 has two exclamation marks; guide says zero in body copy — fixed. Claim audit: the "40%" claim now traces to timestamped audio; one article statistic ("60% of engineering time…") has no source — cut, replaced with the guest's own words. Format table measured with ffprobe: clip 1 exported 1920×1080 instead of 1080×1920 — the export preset was wrong; caught by measuring, not by filename. Safe-zone overlay: clip 3's caption sits in the bottom 12% where the platform UI covers it — captions moved to the 25–75% vertical band. Contact-sheet equivalent for clips: all three watched back-to-back for caption style, color grade, and end-card consistency.

**Stage 6 — Self-Correct.** The employer-name approval comes back on day 4: denied. Because this was flagged day 1 as a cascade risk, only clip candidate #3 and two article sentences depend on it — the day-2 selection deliberately favored self-contained moments. Fix cost: one clip swap from the ranked backup list, 20 minutes. Had this surfaced at delivery, the fix cost would have been the full package.

**Stage 7 — Iterate.** Post-delivery entry in the calendar: hypothesis check scheduled at day 7. The moment-map's "why this stops a scroll" notes get scored against actual clip retention curves when data arrives; hooks that held past 3 seconds enter the hook library with their pattern named ("cold-open contrarian claim, context deferred").

**What could have gone wrong and how the system catches it:** the transcript mishear (verbatim-from-audio rule), the generic intro (swap-test), the wrong export (measured specs, never trusted presets), the caption in the UI zone (safe-zone overlay), the approval denial (day-1 flag on legal-adjacent dependency + selection hedged toward self-contained moments). None of these are caught by "does it look good" — every one is caught by a named gate.

---

## 6. Integration with Core Skills

**Most critical core skills for this domain:**

- **plan-gate** — mandatory before any batch generation (image series, email sequences, multi-scene video). The gate artifact is the locked style block + asset tree + iteration budget. Domain variation: the gate also requires the *verification artifact type* per asset class to be named in advance.
- **scope-fence** — creative scope creeps through enthusiasm ("while we're at it, let's also do a carousel"). Fence = the asset tree from Decompose. New asset ideas go to a parking lot in the delivery notes, not into the sprint.
- **verified-done** — "done" means gates passed with artifacts (contact sheet exists, spec table measured, claim audit annotated), never "the output looks great." Domain variation: subjective-quality sign-off is explicitly excluded from the AI's done-claim; done = gates + ranked recommendation delivered.
- **root-cause-first** — before fixing a bad output, classify the defect: spec / consistency / brief (Stage 6 taxonomy). Fixing a brief defect at the asset level is the domain's signature wasted effort.
- **self-correction-loop** — bounded at 3 named-defect rounds per asset; the loop's exit condition is a strategy change, not more rounds. Pairs with prompt-forensics for generative assets.
- **uncertainty-handling + assumption-flagging** — legal clearance, persona validity, and trend timing are the standing uncertainty sources. Flag on day 1; hedge asset selection toward paths that survive the flag resolving badly (see walkthrough).
- **coverage-accounting** — applied to content calendars (every pillar × persona × funnel stage has planned coverage; gaps are visible) and to derivative matrices (every parent asset's platform × format cells are explicitly done/skipped, never silently missing).
- **adversarial-disproof** — the swap-test is this domain's disproof instrument: attack every asset with "could a competitor ship this unchanged?" Also used on personas ("what evidence would prove this persona doesn't exist?").
- **idea-generation** — used at hook/variant stage: generate 5–10, converge by persona-context scoring, keep discards on file. Never used to widen scope past the fence.
- **image-refinement** — core execution skill for all AI image work; domain variation: refinement operates inside a frozen style block, and defect naming follows the prompt-forensics taxonomy.
- **video-editing + multimodal-analysis** — assembly and the three-pass sync check (muted / audio-only / combined). Multimodal-analysis also runs the contact-sheet consistency review.
- **long-task-orchestration + context-budget-management** — multi-day campaign production: the moment map, style block, and voice anchor are the persistent artifacts that survive context resets; regenerate nothing from memory, always from these files.
- **evidence-reasoning** — claim audits and performance-hypothesis reviews; a metric moved is evidence only against a pre-registered hypothesis (Principle 15).
- **document-mastery** — voice guides, briefs, and show notes are structured documents with required fields; treat them as schemas, not prose.

**How they combine on a typical job:** brief-hardening (domain skill) feeds plan-gate → scope-fence freezes the asset tree → execution runs image-refinement/video-editing inside locked style blocks → adversarial-disproof (swap-test) + coverage-accounting run at verify → root-cause-first classifies failures → verified-done requires gate artifacts → evidence-reasoning closes the loop post-publish.

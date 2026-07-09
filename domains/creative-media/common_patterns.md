# Common Patterns — Creative & Media Production

## 1. Brief-to-First-Draft (any format)
**Trigger:** New content request arrives — post, script, page, email — with a brief attached or implied.
**Approach:** 1) Extract from the brief: audience, single desired action, format, channel, length, voice reference. If any of the six is missing, name it and fill it with an explicit stated assumption — never silently. 2) Write the working headline/hook FIRST; the piece exists to pay it off. 3) Draft fast and long — 120% of target length. 4) Cut 20% on the first edit pass: kill adverbs, passive voice, throat-clearing openers, duplicate points. 5) Read aloud (or simulate); flag any sentence you'd stumble on.
**Template:** `AUDIENCE: | ACTION: | FORMAT+CHANNEL: | LENGTH: | VOICE REF (link 2 approved pieces): | HOOK: | CTA: | ASSUMPTIONS MADE:`
**Variation:** Vague brief → generic output. If the brief could produce the same draft for a competitor's brand, stop and sharpen the audience/voice fields before drafting.

## 2. Character/Brand Consistency Across an AI Image Series
**Trigger:** Any request for 2+ images featuring the same character, product, or brand look (carousel, storyboard, campaign set).
**Approach:** 1) Write a locked descriptor block — 30-60 words fixing subject identity: age, build, hair, wardrobe, distinguishing marks, brand colors as hex. 2) Generate a reference/anchor image; get it approved before batching. 3) Prepend the identical descriptor block to every prompt; vary ONLY scene, pose, composition. 4) Use seed pinning or reference-image conditioning where the tool supports it. 5) Line up all outputs in a grid and check identity drift before delivery.
**Checklist:** `[ ] Descriptor block locked and versioned [ ] Anchor image approved [ ] Same block verbatim in every prompt [ ] Seed/ref-image used [ ] Grid review: face, wardrobe, palette, lighting era match [ ] Negative prompt carries the same exclusions throughout`
**Variation:** Drift enters via style words, not subject words — "cinematic" in image 3 but not image 5 changes the face. Diff the full prompts, not just the scene clause.

## 3. Prompt Refinement Loop (image/video gen)
**Trigger:** First generation is "close but wrong" — right subject, wrong mood/composition/detail.
**Approach:** 1) Name the single biggest defect in one sentence. 2) Change ONE prompt layer per iteration, in this order: subject → style → composition → lighting → mood → technical specs. 3) Move recurring unwanted elements to the negative prompt instead of piling positive words. 4) Keep a numbered log: prompt version, seed, defect, fix. 5) Stop after 6 iterations; if not converged, the concept is wrong — rewrite the subject clause from scratch.
**Template:** `v{N} | changed layer: ___ | prompt diff: ___ | seed: ___ | defect remaining: ___ | verdict: keep/iterate/reset`
**Variation:** Shotgunning — changing three layers at once so you can't attribute the improvement. One variable per generation, always.

## 4. Repurposing Waterfall (pillar → derivatives)
**Trigger:** A pillar asset ships (long video, article, podcast episode) and the calendar needs 5-15 derivative pieces.
**Approach:** 1) Timestamp/highlight-pass the pillar: extract every self-contained claim, story, or quotable line. 2) Rank extracts by hook strength, not by order of appearance. 3) Map each extract to a native format — clip, carousel, thread, email item, quote card — rewriting the hook per channel; never paste the same caption everywhere. 4) Schedule derivatives across 2-4 weeks, pillar link in each. 5) Track which derivative drives clicks back; feed that into the next pillar's topic choice.
**Checklist:** `[ ] 10+ extracts logged with timestamps [ ] Each derivative has a channel-native hook [ ] No two derivatives share opening line [ ] CTA points back to pillar [ ] Spread across calendar, not dumped in one week`
**Variation:** Chasing a trending format that doesn't fit the pillar's substance — a data-heavy report forced into a dance-clip format. Format follows extract, not the trend feed.

## 5. Voice-Drift Audit (multi-writer / AI-assisted output)
**Trigger:** Multiple writers or AI runs produce copy for one brand; stakeholder says "this doesn't sound like us," or before any batch publish.
**Approach:** 1) Pull the voice guide's 5-7 concrete rules (banned words, sentence length norms, POV, humor register). If the guide only says "friendly but professional," rewrite it into testable rules first. 2) Sample 20% of the batch plus every piece from a new writer/model. 3) Score each sample against each rule: pass/fail, quote the violating line. 4) Fix violations at the source — update the shared system prompt or writer brief, not just the sampled pieces. 5) Re-sample next batch to confirm the fix held.
**Template:** `Piece: ___ | Rule violated: ___ | Line: "___" | Rewrite: "___" | Source fix (guide/system prompt/brief): ___`
**Variation:** Auditing only the flagged piece and shipping the rest unchecked — drift is batch-wide by definition. If one sample fails, expand the sample to 100% of that writer/model's output.

## 6. AI Video Scene Plan with Cross-Scene Consistency
**Trigger:** A multi-scene AI video is requested (ad, explainer, short) — anything longer than one generated clip.
**Approach:** 1) Write the script and VO first; lock runtime per scene from the read-aloud timing (±0.5s). 2) Build a scene table: scene #, duration, subject descriptor block (shared, per Pattern 2), camera/motion prompt, transition, matching VO line. 3) Generate scenes against the table; hold lighting era, lens language, and palette words constant across all motion prompts. 4) Assemble; check VO sync at every cut and that music hits land on scene changes. 5) Watch once muted (visual continuity) and once eyes-closed (audio pacing) before delivery.
**Template row:** `S# | dur | subject block ref | motion: ___ | transition: ___ | VO line: "___" | SFX/music cue: ___`
**Variation:** Per-scene prompt improvisation — scene 4 goes handheld-gritty while 1-3 are locked-off-clean. Every deviation from the table must be written back into the table first.

## 7. Podcast Episode Production Run
**Trigger:** Recurring episode slot comes due; guest confirmed or solo topic set.
**Approach:** 1) Script the skeleton: cold-open hook (the best 20 seconds, stated up front), intro, 3-5 segment questions, recap, CTA. 2) Pre-record check: levels at -12 to -6 dB peaks, room noise floor sampled, backup local recording running, 10-second room tone captured. 3) Record; mark bad takes verbally in-line ("flag") instead of stopping. 4) Edit: cut flags first, then tighten silences >1.5s, then level/de-noise, then add music beds. 5) Ship kit: titled export to spec, show notes with timestamps and links, 2-3 clip candidates flagged for the repurposing waterfall (Pattern 4).
**Checklist:** `[ ] Cold-open chosen from strongest moment [ ] Levels + backup verified before take 1 [ ] Room tone captured [ ] Flags cut, silences tightened [ ] Show notes with timestamps [ ] Clip candidates handed to repurposing`
**Variation:** Editing chronologically from minute zero and running out of time budget before the middle — cut flagged takes and pick the cold-open first; they determine everything else.

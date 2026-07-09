# Creative & Media Production — Verification Gates

Run every applicable gate before claiming an asset done. Each gate produces an artifact (annotation, table, sheet, measurement). No artifact = gate not run. A failed gate blocks publish; it does not block delivery of a flagged draft for human decision.

---

## Gate 1 — Brief Compliance (all assets)
**Passes:** Every field of the hardened brief is satisfied and checkable in the asset: named persona addressed, single CTA present, platform format met, stated exclusions absent, required references honored.
**Fails:** Any brief field unaddressed; asset serves a different funnel stage than briefed; an excluded topic/competitor/claim appears; brief was never hardened (missing persona, CTA, format, voice source, references, or exclusions).
**How to check:** Field-by-field table: brief requirement → where in the asset it is satisfied (quote/timestamp/region). Any row without a location fails.

## Gate 2 — Swap-Test / Genericness (all copy, scripts, ad creative)
**Passes:** Replacing the brand name with a direct competitor's breaks the asset — it contains at least one claim, story, data point, or angle only this brand can make.
**Fails:** The asset reads correctly with a competitor's name substituted; the "specific" content is industry commonplace ("in today's fast-paced world," "customers demand more").
**How to check:** Literally substitute the competitor name, reread. Mark the sentences that break. Zero breaking sentences = fail.

## Gate 3 — Voice Rule Scoring (all copy, VO scripts, captions)
**Passes:** Zero violations of the falsifiable voice rules (lexicon, contractions, punctuation norms, sentence-length band, banned words, person/address conventions), or each violation carries a written justified exception.
**Fails:** Any unjustified violation; scoring skipped because "it sounds right"; voice guide has no falsifiable rules to score against (that is a Gate 1 failure on the brief's voice source).
**How to check:** Score the asset sentence-by-sentence against each rule. For series work: score assets 1, N/2, and N and compare violation profiles — divergence between them is drift even if each individually squeaks by.

## Gate 4 — Cut-Pass Evidence (long-form copy)
**Passes:** First-revision word count is ≥20% below draft count, with before/after counts recorded — or a written justification that the draft was cut-resistant (rare; be suspicious of it).
**Fails:** Draft shipped as revision; cut pass removed <20% with no justification; cut pass achieved by deleting substance instead of flab (check: no argument or evidence was removed, only wording).
**How to check:** Word counts logged in the working file. Spot-check 3 cut regions: cuts should be adverbs, hedges, restatement, throat-clearing — not claims.

## Gate 5 — Claim Audit (anything with facts, numbers, quotes, or product capabilities)
**Passes:** Every statistic, quote, named source, date, and capability claim is highlighted and mapped to a verifiable source (link, timestamped audio, product doc). Quotes from recorded media are verbatim against the *audio*, not the auto-transcript.
**Fails:** Any unsourced number; any paraphrase presented as a quote; any capability claim the product docs don't support; transcript-only verification of quantitative quotes.
**How to check:** Annotated copy of the draft: claim → source. Unresolvable claims get cut or hedged before publish, never left "to confirm later."

## Gate 6 — Series Consistency Review (image series, multi-scene video, episodic content)
**Passes:** Contact sheet (all frames/thumbnails in one view) shows: stable character proportions and features, stable palette (spot-sample brand colors — hex within tolerance), consistent lighting logic, consistent line weight/render style, consistent typography and caption treatment. Prompt diff across the series shows changes ONLY in the designated content slot.
**Fails:** Any frame a cold viewer would sort into a different set; palette drift beyond tolerance; a prompt-diff change outside the content slot without a version-tagged style-block update and a decision record.
**How to check:** Build the contact sheet. Run the prompt diff. Sample brand-color hex values in 3 frames minimum.

## Gate 7 — Platform Spec Measurement (all exported media)
**Passes:** Measured (not preset-trusted) dimensions, aspect ratio, duration, frame rate, file size, and codec match the platform spec sheet. Text/faces/CTAs sit inside safe zones verified with a platform-UI overlay. Vertical video payload begins within the first 1.5 seconds.
**Fails:** Any spec asserted from the export preset name; caption or CTA in a UI-occluded zone; duration over platform ceiling; logo/intro before the payload in short-form video.
**How to check:** ffprobe/mediainfo output logged per file; safe-zone overlay screenshot per vertical asset; scrub to t=1.5s and confirm the hook has landed.

## Gate 8 — AV Sync Three-Pass (any video with VO, music, or SFX)
**Passes:** (a) Muted pass: visuals alone carry the narrative sequence. (b) Audio-only pass: VO stands alone without "as you can see" orphaned references. (c) Combined pass: every scene boundary checked — no mid-word cuts, music beats land on named visual beats per the sync doc, SFX aligned within one frame of their trigger.
**Fails:** Any deictic VO reference ("this," "on the left") with no matching visual; music swell offset from its beat; cut mid-word or mid-gesture; sync doc doesn't exist (assembly was improvised).
**How to check:** Three sequential watch-throughs with a defect log per pass; sync doc cross-referenced in pass (c).

## Gate 9 — Audio Technical Floor (podcast, VO, any published audio)
**Passes:** Raw capture noise floor ≤ −50dB relative; peaks around −12 to −6dBFS with no clipping; master loudness at target (−16 LUFS stereo podcast / −14 LUFS platform-normalized); inter-speaker level variance within 2 LU; no audible noise-reduction artifacts (check sibilants and room tails at 1× on headphones).
**Fails:** Clipping anywhere; "underwater" NR artifacts; hosts at visibly different loudness; loudness never measured; a broken capture "fixed in post" below the floor instead of re-recorded.
**How to check:** Meter readings logged (noise floor, peak, LUFS); headphone spot-check at 3 points including the loudest and quietest passages.

## Gate 10 — CTA Singularity (emails, landing pages, social posts, ad copy)
**Passes:** Exactly one primary call to action; any secondary links are visually subordinate (footer/P.S.) and do not compete grammatically ("do X" appears once).
**Fails:** Two or more parallel asks; CTA absent; CTA present but the asset's body argues for a different action than the CTA requests.
**How to check:** Count imperative asks. Confirm the body's argument terminates at the CTA's action.

## Gate 11 — Repurposing Fidelity (all derivative assets)
**Passes:** Every claim, quote, and statistic in the derivative maps to an identified span (timestamp or quoted text) of the canonical parent. Adaptation changed form, not facts.
**Fails:** Derivative contains any assertion absent from the parent; quote compression changed meaning; a clip's caption states something the clip doesn't show or say.
**How to check:** Derivative-to-parent mapping table; read the derivative against only its mapped spans.

## Gate 12 — Rights & Disclosure (anything with likeness, music, third-party content, or AI generation)
**Passes:** Music licensed for the specific use and platform; third-party names/likenesses cleared or approval explicitly obtained (logged); AI-generation disclosure applied where the platform or jurisdiction requires it; stock/generated assets' license terms permit commercial use in this context.
**Fails:** "It's probably fine" on any rights question; approval assumed because it was requested; platform AI-labeling requirement unexamined.
**How to check:** Rights checklist per asset with a status per item: CLEARED (with evidence) / PENDING (blocks publish) / N-A. PENDING at publish time = the asset does not publish. This gate is flagged to the human — never self-cleared on judgment calls.

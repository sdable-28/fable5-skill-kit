---
name: consistency-enforcer
description: >
  Detect and correct drift in brand voice, visual identity, and character continuity across a series
  of creative assets — multiple posts, an image set, a video's scenes, an email sequence, or mixed
  human/AI-produced content. Trigger phrases: "keep these consistent", "does this sound like us",
  "the character looks different", "match the brand voice", "series", "campaign", "part 3 of...".
  Do NOT use for a single standalone asset with no series or brand context, for factual consistency
  in technical docs (that is generic review work), or before a reference spec exists — build the
  spec first via brief-sharpener or extract one here from approved assets.
---

# Consistency Enforcer

## When invoked
1. Establish the reference spec. If a voice/style guide or character sheet exists, load it. If not, extract one from the most recently APPROVED assets (never from drafts): for voice — sentence length distribution, person (we/you/I), 5 signature phrasings, 5 banned phrasings, formality register; for visuals — palette hexes, character attributes (face, hair, wardrobe, proportions), lighting style, composition habits; for video/audio — pacing, music mood, VO delivery style. Write the spec down before checking anything.
2. Audit every asset in the series against the spec, one dimension at a time. Log each deviation as `asset → dimension → spec says X → asset shows Y`. Do not log "feels off" — name the attribute that diverged.
3. Classify each deviation: **DRIFT** (unintentional, correct it), **EVOLUTION** (intentional improvement — flag for user to ratify into the spec), or **CONTEXT-DRIVEN** (channel demands it, e.g., shorter sentences on X; allowed, note the rule).
4. For AI-generated assets, trace drift to its cause in the prompt: missing character descriptor, unpinned seed/reference image, style keywords dropped between generations. Fix the prompt template, not just the one output — otherwise the next generation drifts again.
5. Apply corrections to DRIFT items. Re-audit corrected assets against the spec before declaring them fixed.
6. If the user ratifies any EVOLUTION item, update the reference spec and note the version change so later assets audit against the new spec, not the old one.

## Output format
A **Consistency Audit** with: (1) the reference spec (or pointer to it, with version), (2) a deviation table — `asset | dimension | spec value | observed value | class (DRIFT/EVOLUTION/CONTEXT) | root cause | fix`, (3) the corrected prompt templates or copy edits, (4) spec changelog if anything was ratified.

## Quality gate
PASS only if: every asset in the series appears in the audit table (including the ones that passed — mark them CLEAN), every DRIFT row has a named root cause and an applied fix, and no fix was applied to an EVOLUTION item without user ratification. FAIL if any deviation is described without naming the specific spec attribute it violates.

## Quality gate — spec extraction
When the spec was extracted rather than given: it must cite which approved assets it came from. An unsourced spec is invented, not extracted — FAIL and redo.

## Integration
- **root-cause-first**: step 4 is mandatory — never patch a single drifted output without fixing the generating prompt.
- **adversarial-disproof**: before marking a series CLEAN, actively hunt for the deviation you'd most expect given how the assets were produced (different writers → register drift; regenerated images → face drift).
- Upstream: `brief-sharpener` TONE/MANDATORY slots seed the reference spec. Downstream: `iterative-image-refiner` and `scene-continuity-planner` must run their outputs through this audit before a series ships; `repurposing-cascade` derivatives are audited against the pillar's spec.

---
name: repurposing-cascade
description: >
  Derive a full set of channel-native assets from one approved pillar piece (long-form article,
  video, podcast episode) following the repurposing hierarchy — instead of generating each channel's
  content from scratch. Trigger phrases: "turn this into posts", "repurpose", "cut this up for
  social", "make a thread/newsletter/clip from this", "content calendar from this piece". Do NOT
  use when no approved pillar asset exists yet (create and approve the pillar first via
  brief-sharpener), for one-off single-channel requests, or for translating/localizing content
  (different discipline, not derivation).
---

# Repurposing Cascade

## When invoked
1. Verify the pillar is approved and final. Repurposing a draft multiplies its flaws across every channel. If the pillar is not explicitly approved, stop and say so.
2. Mine the pillar for derivation units before writing anything: standalone claims, quotable lines, data points, step sequences, contrarian takes, visual moments (for video/audio pillars: timestamped). List them with source location (paragraph/timestamp). Every derivative must trace to at least one unit — this is what keeps derivatives on-message.
3. Select target channels from the user's distribution list (owned/earned/paid). For each channel, load its native constraints: format, length caps, hook conventions, CTA norms, media specs. A derivative that ignores channel constraints is the pillar pasted somewhere it doesn't fit.
4. Order production down the hierarchy: largest derivatives first (video → clips; article → newsletter section) then smaller (thread, single post, quote graphic, audiogram), because small assets are often cut from mid-size ones, not from the pillar directly. Record each derivative's parent (pillar or intermediate).
5. Write each derivative channel-native: rebuild the hook for the channel's scroll context — never reuse the pillar's opening line as a social hook; it was written for a reader already committed. Keep claims verbatim-faithful to the source unit; compression must not change what is asserted (numbers, attributions, hedges survive intact).
6. Set the CTA chain: every derivative points one level up its hierarchy (post → thread → pillar), not all directly at the pillar, unless the user's distribution plan says otherwise.
7. Schedule: assign each derivative a slot with channel, date, and the reasoning (pillar launch → derivatives staggered over the following window; never dump all derivatives on day one).

## Output format
A **Cascade Sheet**: (1) pillar reference + approval status, (2) derivation-unit table — `unit | type (claim/quote/data/step/visual) | source location`, (3) derivative table — `asset | channel | parent asset | source units used | hook (full text) | CTA target`, (4) the full copy/spec for each derivative, (5) schedule table — `date | channel | asset | rationale`.

## Quality gate
PASS only if: every derivative row lists at least one source unit and a parent asset, no derivative's hook is a copy of the pillar's opening, every factual claim in every derivative matches its source unit verbatim in substance (spot-check numbers and attributions explicitly), and each derivative respects its channel's length/format caps (state the cap and the actual count). FAIL if any derivative cannot be traced to a derivation unit — that content was invented, not repurposed.

## Quality gate — voice
Run all derivatives through `consistency-enforcer` against the pillar's voice spec before delivery. Channel-driven register shifts are CONTEXT-DRIVEN; message drift is DRIFT and blocks delivery.

## Integration
- **evidence-reasoning**: the derivation-unit table is the evidence base — every derivative claim cites its unit.
- **verified-done**: done = all derivatives pass both quality gates and appear on the schedule, not "posts written".
- **statistical-analysis**: when performance data exists from prior cascades, use it to weight channel selection and slot timing instead of defaults.
- Upstream: `brief-sharpener` briefs the pillar; `scene-continuity-planner`'s scene table is the cut map for video-pillar clips. Sideways: `consistency-enforcer` gates voice; `iterative-image-refiner` produces quote graphics and thumbnail derivatives.

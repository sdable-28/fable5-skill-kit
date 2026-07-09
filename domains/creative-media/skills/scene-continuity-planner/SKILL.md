---
name: scene-continuity-planner
description: >
  Plan multi-scene AI video before any clip is generated: shot list, per-scene motion prompts,
  cross-scene continuity locks, VO/music sync map. Trigger phrases: "make a video", "multi-scene",
  "storyboard this", "the scenes don't match", "sync the voiceover", "add music to", "30-second ad".
  Do NOT use for single-clip generations with no cuts (prompt directly), for still-image series
  (use consistency-enforcer + iterative-image-refiner), or for editing footage that already exists
  and needs no generation.
---

# Scene Continuity Planner

## When invoked
1. Lock the format spec from the brief: total duration, aspect ratio, resolution, framerate, delivery channel. Every scene inherits these — a 9:16 scene cannot be cut into a 16:9 video.
2. Break the narrative into scenes. For each scene write: purpose (one sentence — what the viewer must know/feel by its end), duration in seconds, shot type (wide/medium/close), camera motion (static/pan/dolly/orbit — one motion per scene; stacked motions are where AI video falls apart), and the action described as start-state → end-state, not as a summary.
3. Build the continuity lock sheet — the attributes that must survive every cut: character descriptors (verbatim string reused in every scene prompt — never paraphrase a character between scenes), wardrobe, environment/time-of-day, palette and lighting direction, style keywords. Where the tool supports it, pin reference images or seeds per locked entity and record the pins.
4. Write each scene's generation prompt by composing: [locked descriptors, verbatim] + [this scene's action start→end] + [camera motion] + [format specs]. The locked block is identical across scenes by construction — diff the prompts to prove it.
5. Map audio to the timeline before generating video: VO script with per-scene word counts (spoken pace ~2.3 words/sec; a 4-second scene carries at most ~9 words — cut the script to fit, never stretch the scene to fit the script), music mood per section, SFX cues tied to on-screen actions with timestamps. Flag every scene where VO duration exceeds scene duration as a hard error to resolve now.
6. Define per-scene acceptance checks: action completed within duration, locked attributes present, motion matches spec, no morphing/warping of the locked entities mid-clip.
7. After generation, audit adjacent scene pairs at the cut points specifically — continuity breaks live at cuts, not mid-scene. Regenerate the cheaper side of a mismatched pair, keeping the better clip as the reference.

## Output format
A **Scene Plan** containing: (1) format spec block, (2) scene table — `# | purpose | duration | shot | camera motion | action start→end`, (3) continuity lock sheet with verbatim descriptor strings and reference-image/seed pins, (4) full per-scene prompts, (5) audio sync map — `scene | VO words (count/limit) | music | SFX @ timestamp`, (6) per-scene acceptance checks, (7) post-generation cut-point audit results when clips exist.

## Quality gate
PASS only if: scene durations sum to the format spec's total (±1s), the locked-descriptor block is byte-identical across all scene prompts (verify by diff, not by eye), every scene's VO word count is at or under its pace limit, and each scene has exactly one camera motion. FAIL if any scene's action is written as a summary ("hero uses product") rather than start-state → end-state.

## Integration
- **plan-gate**: the Scene Plan is the gate — no clip generation before the user approves it; regenerating unplanned scenes is the most expensive failure in the domain.
- **verified-done**: step 6 checks + step 7 cut-point audit constitute done, not "all clips rendered".
- Upstream: `brief-sharpener` supplies format and message; `iterative-image-refiner` produces the pinned reference images and proven prompt fragments for locked entities. Downstream: the finished video's scenes pass through `consistency-enforcer` as a series; `repurposing-cascade` cuts derivatives (shorts, stills, audiograms) from the scene table rather than rediscovering structure.

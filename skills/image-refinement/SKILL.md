---
name: image-refinement
description: Use for iterative improvement of AI-generated images — refining prompts across generations toward a target concept. Evaluates each output against the concept, names specific failure modes (composition, lighting, style, detail, anatomy, text), and writes targeted refinement prompts. Tracks what improved and what regressed; stops when the delta goes small. Trigger keywords - "make the image better", "it doesn't look right", "iterate on this image", "closer to what I meant". Do NOT use for first-draft generation with no iteration intent, or for editing real photographs.
---

# image-refinement

Image models don't take revision notes — they take new prompts. Effective refinement is therefore diagnosis-driven prompt surgery: name exactly what failed in the last output, change the prompt clause that governs that failure, and hold everything else still so you can attribute the result. Shotgun rewrites destroy the information each generation paid for.

## When invoked

1. **Pin the target concept first.** One paragraph: subject, composition, lighting, style/medium, mood, and the 2–3 non-negotiables ("the figure must face left; dawn light; no text"). Refinement without a pinned target is a random walk that follows the model's suggestions instead of the user's intent.
2. **Evaluate each output against the concept, dimension by dimension** — not "does it look good" but a pass across:
   - **Composition** — framing, subject placement, crop, perspective
   - **Lighting** — direction, temperature, contrast, time-of-day consistency
   - **Style** — medium, era, artist-school adherence, coherence across the image
   - **Detail/fidelity** — the zones models botch: hands, faces, text, mechanical parts, repeated patterns
   - **Semantics** — is it the right SCENE (objects present, relations correct, count correct)
   Verdict per dimension: HIT / SOFT MISS / HARD MISS, with the specific evidence ("light source is camera-right but shadows fall right too").
3. **Refine the worst dimension first, one to two changes per iteration.** Targeted prompt surgery: strengthen the clause governing the failed dimension (more specific vocabulary, weight/emphasis if the tool supports it, negative prompt for intrusions), leave working clauses verbatim. Changing five things per generation makes improvement unattributable.
4. **Know the failure→lever table:** wrong mood → lighting and palette words, not more adjectives; mangled hands/text → reframe to de-emphasize, or negative-prompt, or accept and crop; style drift → name a specific medium/school instead of stacking style adjectives; ignored element → move it earlier in the prompt and make it concrete; composition chaos → explicit camera language ("low-angle medium shot, subject left third").
5. **Track the iteration ledger** — prompt delta → which dimensions improved/regressed. Regressions matter: a fix that breaks a previously-HIT dimension gets rolled back, not stacked on. The ledger is what turns generation lottery into convergence.
6. **Stop on small delta.** Two consecutive iterations with no HARD-MISS remaining and only marginal SOFT-MISS movement → deliver best output + ledger. Past that point you're re-rolling dice, not refining; say so and let the user decide whether to spend more.

## Output format

Per iteration:
```
ITER {n} | prompt Δ: {exact clause changed}
EVAL: composition {HIT/SM/HM: why} | lighting {...} | style {...} | detail {...} | semantics {...}
NEXT LEVER: {worst dimension → planned change}
```
At stop:
```
BEST: iter {k} | remaining misses: {list + why acceptable/unfixable}
LEDGER: {what each iteration bought}
```

## Integration

- The evaluate step is **multimodal-analysis** applied to the model's own output (describe factually, then judge against the concept — the factual pass catches wishful seeing).
- The iterate-diagnose-adjust loop is **self-correction-loop** with images as the artifact.
- Stop-on-small-delta is the effort-calibration rule; the ledger is **evidence-reasoning** for a visual domain (claims of "improved" cite the dimension and the iteration).

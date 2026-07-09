---
name: iterative-image-refiner
description: >
  Drive AI image generation to an acceptable result through failure-mode-named iteration instead of
  "regenerate and hope". Trigger phrases: "the image isn't right", "fix the hands/face/lighting",
  "make it look more...", "try again", "closer but...", or any second-round image generation request.
  Do NOT use for the first draft of a single image (write the structured prompt and generate once),
  for maintaining sameness across an image SERIES (that is consistency-enforcer's job), or for video
  frames (use scene-continuity-planner).
---

# Iterative Image Refiner

## When invoked
1. Freeze the target. Restate what the image must show from the brief: subject, style, composition, lighting, mood, technical specs (aspect ratio, resolution, medium). If no brief exists, run `brief-sharpener` first — refining toward an undefined target is regeneration roulette.
2. Diagnose the current output against that target. Name each failure as a specific, localized defect: "left hand has 6 fingers", "light source contradicts the shadow direction", "background style is photoreal while subject is illustration", "subject occupies 30% of frame, brief needs 60%+". Ban the diagnoses "doesn't look right" and "make it better" — if a defect cannot be localized to a region and attribute, look again until it can.
3. Rank defects by severity: brief violations first, anatomical/physical errors second, style mismatches third, polish last. Fix in that order.
4. For each defect, choose the cheapest intervention that targets it, in this order: (a) prompt edit — add/strengthen the descriptor governing the failed attribute, move it earlier in the prompt; (b) negative prompt — add the specific artifact ("extra fingers", "watermark", "blurry edges"); (c) parameter change — seed, guidance/CFG, steps; (d) inpaint/region edit if the tool supports it — never regenerate a whole image to fix a corner; (e) full regeneration only when composition itself is wrong.
5. Change ONE intervention per iteration. Log it: `iteration N: defect → intervention → prompt diff`. Two simultaneous changes make the outcome unattributable and burn the iteration budget learning nothing.
6. After each generation, re-diagnose. Confirm the targeted defect is gone AND that previously-correct attributes did not regress — image models trade attributes silently. A fix that breaks something else is not a fix.
7. Budget: 6 iterations. If the same defect survives 3 targeted attempts, stop — the model cannot render it from this prompt structure. Escalate: restructure the prompt around the failing attribute, switch reference-image workflow, or report the limitation to the user with the best candidate so far.

## Output format
A **Refinement Log**: target spec (frozen at step 1), then one row per iteration — `# | defect (region + attribute) | intervention type | exact prompt/param diff | result (FIXED / PERSISTS / REGRESSED <attribute>)` — followed by the final prompt in full and a verdict: ACCEPTED (which acceptance criteria it meets) or ESCALATED (which defect blocked, what was tried).

## Quality gate
PASS only if: every iteration row names a localized defect (region + attribute), no row contains more than one intervention, every iteration after the first records regression status of prior fixes, and the loop ended by ACCEPTED or the 6-iteration/3-attempt stop rule — not by fatigue. FAIL if any row's defect column could apply to any bad image ("looks off", "not quite there").

## Integration
- **root-cause-first**: step 4's intervention ladder is root-cause ordering — the prompt caused the defect, so the prompt (not a reroll) is the first fix.
- **adversarial-disproof**: step 6's regression check is the disproof pass — assume the fix broke something and hunt for it.
- **evidence-reasoning**: iteration decisions cite the observed defect, never a hunch about what the model "probably wants".
- Upstream: `brief-sharpener` supplies the frozen target. Sideways: final accepted images in a series go through `consistency-enforcer`; the final prompt becomes a template `scene-continuity-planner` can pin across shots.

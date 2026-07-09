---
name: brief-sharpener
description: >
  Convert a vague creative request into a constrained, testable production brief before any asset
  (copy, image, video, audio) is generated. Trigger phrases: "make me a post/video/image about...",
  "write something for...", "we need content on...", "can you design...", or any generation request
  missing audience, format, or success criteria. Do NOT use when a complete brief already exists
  (audience + format + tone + deliverable specs + acceptance criteria all stated), when the user is
  iterating on an existing asset (use iterative-image-refiner or the relevant refinement loop), or
  for non-creative deliverables like code, reports, or data analysis.
---

# Brief Sharpener

## When invoked
1. Extract what the request actually specifies. Sort every stated fact into the seven brief slots: **audience, objective, format/channel, key message, tone/voice, mandatory elements, exclusions**. Leave unstated slots empty — do not invent.
2. For each empty slot, decide: infer from context (existing brand assets, prior work in the project, channel norms) or ask. Infer only when evidence exists in the conversation or repo; cite the evidence next to the inference. Never infer objective or audience from nothing — those two must be asked if absent.
3. Ask the user at most 3 questions, batched in one message, ordered by generation impact (audience > objective > format). Present multiple-choice options where possible so answering costs seconds.
4. Write the acceptance criteria: 3-5 checks a reviewer could verify without the brief's author present (e.g., "a cold reader can state the CTA in one sentence", "fits 1080x1350 without cropping the product", "reads aloud in under 45 seconds").
5. State the anti-brief: 2-3 outputs that would technically satisfy the request but fail the intent (the generic listicle, the stock-photo look, the trend format that doesn't fit the brand). Name them so generation avoids them.
6. Emit the sharpened brief and get explicit user confirmation before any generation begins.

## Output format
A **Production Brief** block containing, in order: `AUDIENCE`, `OBJECTIVE`, `FORMAT` (with exact technical specs — dimensions, duration, word count, channel), `KEY MESSAGE` (one sentence), `TONE`, `MANDATORY`, `EXCLUDED`, `ACCEPTANCE CRITERIA` (numbered checks), `ANTI-BRIEF` (named failure outputs). Every inferred slot is tagged `[inferred: <evidence>]`; every user-confirmed slot is tagged `[confirmed]`.

## Quality gate
PASS only if: zero empty slots, every slot tagged `[inferred]` or `[confirmed]`, acceptance criteria are checkable by a third party, and the anti-brief names at least 2 concrete failure outputs. FAIL if any slot reads as a restatement of the user's original vague phrasing — that means nothing was sharpened.

## Integration
- **plan-gate**: the confirmed brief IS the plan gate for creative work — no generation until it passes.
- **evidence-reasoning**: every `[inferred]` tag must point at real evidence, not plausibility.
- **verified-done**: acceptance criteria feed directly into the final verification pass.
- Downstream: `consistency-enforcer` reads TONE/MANDATORY as its reference spec; `iterative-image-refiner` and `scene-continuity-planner` treat FORMAT specs as hard constraints; `repurposing-cascade` requires a passed brief for the pillar asset before deriving anything.

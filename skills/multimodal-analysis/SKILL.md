---
name: multimodal-analysis
description: Use when analyzing images, video, audio, screenshots, charts, diagrams, or scanned documents — anything where conclusions come from non-text media. Describes factually FIRST, interprets second, flags visible vs inferred, cross-references text context, states confidence per interpretation. Trigger signals - any attached media, "what does this show", "read this chart", "what's in the screenshot". Do NOT use for text files or when the media is decorative to the actual question.
---

# multimodal-analysis

The failure mode of media analysis is seeing what you expect: the chart that "shows" the trend you were told about, the screenshot that "confirms" the bug. The countermeasure is a hard wall between description (what is literally present) and interpretation (what it means) — description first, and never contaminated by the question you're trying to answer.

## When invoked

1. **Describe factually first — before consulting the question.** Inventory what is literally present: objects, text (transcribed verbatim, including exact numbers off axes and labels), layout, colors, states (button enabled/disabled, error banner present), timestamps, counts. For audio: speaker turns, actual words, tone markers. For video: shot-by-shot content. Discipline check: the description should be writable by someone who doesn't know why they're looking.
2. **Mark resolution honestly.** What can't be reliably read: blurry text, cropped edges, ambiguous glyphs (0/O, 1/l), small axis labels, compression artifacts. A misread number from a chart is an F1 hallucination with a picture attached — transcribe only what's legible, flag the rest as `[ILLEGIBLE]`, never interpolate.
3. **Interpret — with the visible/inferred flag on every claim.**
   - **VISIBLE**: directly present ("the error banner reads 'connection refused'").
   - **INFERRED**: constructed from visible evidence + assumptions ("the app was mid-deploy" — inferred from the timestamp and banner; the assumption is the deploy schedule). Every INFERRED claim names what it stands on.
   The seam between these is exactly Anti-Hallucination F6 — keep it visible.
4. **Cross-reference against text context.** Compare the media to whatever the conversation claims about it: does the screenshot actually show the error described? Does the chart's own data match the number quoted in the surrounding text? **Discrepancies are findings, not noise** — when the user's description and the pixels disagree, say so plainly; the pixels usually win, but the user may have sent the wrong file (also worth saying).
5. **Confidence per interpretation,** not per analysis: HIGH (visible evidence, near-zero alternative readings) / MODERATE (solid inference, named assumption) / LOW (one plausible reading among several — list the others). A single LOW interpretation doesn't get to hide under an overall "the image shows...".
6. **For charts/data graphics specifically:** read axes and units before the shape (log scale, truncated y-axis, and dual axes routinely reverse naive readings); note what the chart does NOT show (missing periods, unlabeled series); recompute at least one visible data point against any quoted statistic.

## Output format

```
## Media Analysis: {item}
DESCRIPTION (factual): {inventory; verbatim transcriptions; [ILLEGIBLE] flags}
INTERPRETATION:
  - {claim} [VISIBLE] 
  - {claim} [INFERRED from {evidence} + assumes {assumption}] — CONFIDENCE: H/M/L {alternatives if L}
CROSS-REF: {agrees with text context / DISCREPANCY: {text says X, media shows Y}}
CANNOT DETERMINE: {questions this media can't answer + what could}
```

## Integration

- The VISIBLE/INFERRED flag is **evidence-reasoning**'s tier system for pixels (VISIBLE≈VERIFIED, INFERRED≈PLAUSIBLE with named assumption).
- Chart-reading feeds **statistical-analysis** when the question is inferential; recomputation uses **mathematical-reasoning**.
- CANNOT DETERMINE implements **coverage-accounting** for the medium.
- **image-refinement** consumes this skill's description pass to evaluate generated outputs without wishful seeing.

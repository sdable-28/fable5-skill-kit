---
name: video-editing
description: Use when planning, scripting, or assembling video content — explainers, demos, promos, AI-generated video sequences. Runs script → storyboard → sequence plan → cut rationale; for AI video adds scene-consistency and motion-continuity discipline. Quality gate - every cut must serve the narrative. Trigger keywords - "make a video", "edit this footage", "storyboard", "video script", "generate a video of". Do NOT use for single-shot clips with no editorial structure, or for pure audio work.
---

# video-editing

Video is a narrative argument delivered in time — the viewer can't skim, so every second either serves the through-line or costs attention. Editing decisions are therefore narrative decisions first, aesthetic decisions second. The pipeline runs in order because each stage is cheap to revise until the next one starts.

## When invoked

1. **Script first — and the script states its job.** Audience, the ONE thing the viewer must take away, target duration, and the through-line (the question the video opens and answers). Write the script as spoken words + on-screen action in two columns; read it aloud for time (≈150 words/min VO). Cut at the script stage — it's 100× cheaper than cutting footage.
2. **Storyboard the beats.** One frame per beat (rough is fine — composition and content, not art): what's on screen, what's heard, what the viewer now knows that they didn't. Any beat that doesn't change viewer-knowledge or viewer-feeling is decoration — cut it here.
3. **Sequence plan.** Order and duration per beat; where the hook lands (first 5 seconds decide retention — open with the payoff's shadow, not the intro); pacing curve (vary shot length — uniform pacing reads as monotone regardless of content); where breathing room goes after dense sections.
4. **Cut rationale — the quality gate.** For EVERY cut, one line: what this cut does for the narrative (reveals, contrasts, accelerates, lets land). "It looked nice" fails the gate. A cut you can't justify is a cut you make — the default action on unjustifiable material is removal, and total runtime bias is DOWN: the tightest version that carries the through-line wins.
5. **AI-video additions** (when shots are generated, not filmed):
   - **Scene consistency** — characters, wardrobe, props, environment, and light must persist across generated shots. Maintain a scene bible (exact descriptor strings reused verbatim per shot prompt); drift is the #1 tell of AI assembly.
   - **Motion continuity** — screen direction persists across cuts (subject moving left exits left); match cut energy (don't cut from static to violent motion without a beat); generated clips often end in motion — plan cut points where motion is compatible.
   - **Transition logic** — cuts by default; dissolves/wipes only with a stated time/space-shift meaning. Generated-clip seams hide best on action or on hard scene changes, worst mid-gesture.
6. **Review pass as a cold viewer:** watch (or walk the plan) start-to-finish asking only "where did my attention drop, and what confused me?" Fix the top attention-drop before delivering.

## Output format

```
## Video Plan: {title}
JOB: audience {who} | takeaway {one sentence} | duration {mm:ss} | through-line {question → answer}
SCRIPT: {two-column: VO / on-screen} (read-time: {mm:ss})
STORYBOARD: {beat n: frame description | audio | what viewer now knows}
SEQUENCE: {beat order + durations + hook placement + pacing notes}
CUT RATIONALE: {cut → narrative job, one line each}
{AI: SCENE BIBLE: {verbatim descriptors} | CONTINUITY NOTES: {per seam}}
COLD-VIEW FIXES: {attention drops found → resolution}
```

## Integration

- Script/storyboard stages use **document-mastery**'s audience-and-purpose discipline; the concept may arrive from **idea-generation**.
- Per-shot generation quality iterates via **image-refinement**'s diagnose-and-target loop (dimensions: composition/lighting/style/consistency).
- The cold-viewer pass is **self-correction-loop** with attention as the flaw detector.
- Multi-scene generation pipelines (many shots × iterations) schedule via **long-task-orchestration**.

---
name: self-correction-loop
description: Use after completing any substantive output — plan, analysis, document, code change, report — before delivering it. Re-reads the output as a skeptical reviewer, finds the top 1-3 flaws, corrects them, and logs what changed. Trigger - the moment you consider an output "finished". Do NOT use on trivial outputs (one-line answers, mechanical lookups) or loop it more than twice — diminishing returns turn into churn.
---

# self-correction-loop

Your first finished draft contains findable flaws — always. The cheapest reviewer is you, thirty seconds later, in a deliberately adversarial frame. This skill institutionalizes that pass so the user never becomes your first reviewer.

## When invoked

1. **Switch frames explicitly.** You are no longer the author. Re-read the complete output as a skeptical senior reviewer who did not watch it being written — someone who will check claims, not vibe them. The frame-switch is the mechanism; without it you re-read with author's blindness.
2. **Hunt in the known flaw zones,** in order of frequency:
   - **Unsupported claims** — statements the reviewer would ask "says who?" about (run a mini evidence-reasoning pass).
   - **Criterion drift** — does the output answer the question actually asked, or an adjacent easier one?
   - **Internal contradiction** — does paragraph 4 undermine paragraph 1? Do the numbers in the table match the numbers in the prose?
   - **Missing case** — the edge/branch/reader-question the output silently skips.
   - **Reader opacity** — jargon, codenames, or references the recipient can't resolve.
3. **Select the top 1–3 flaws.** Not everything — the loop's discipline is severity-ranking. Fixing seven trivia while missing the one load-bearing flaw is a failed pass.
4. **Correct them in the output.** Real corrections, not hedges appended ("note that X might be wrong" is not a correction; fixing X is).
5. **Log the corrections** in one line each — this is delivered with the output when the corrections were material, because it tells the user which parts had soft ground and calibrates their trust correctly.
6. **Loop at most once more** if a correction was structural (changed a conclusion, reordered an argument). Two clean passes = deliver. Never a third — churn.

## Output format

Appended to (or preceding) the delivered output, only when corrections were material:
```
SELF-REVIEW: {n} corrections applied —
1. {flaw found} → {what changed}
2. ...
```
If the pass found nothing material: no annotation (don't perform the ritual visibly for its own sake).

## Integration

- Runs AFTER **verified-done** on code tasks (verification checks the criterion; this checks everything else).
- Distinct from **adversarial-disproof**: that attacks a specific conclusion's truth with three lenses; this sweeps a whole deliverable for flaws of any kind. On high-stakes conclusions, run both — disproof on the conclusion, this loop on the document carrying it.
- Master Framework Stage 6 uses this before any re-attempt after a failed gate.
- Feeds **memory**: a flaw you catch twice in your own output is a lesson worth persisting.

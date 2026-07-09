---
name: energy-task-matcher
description: >
  Match tasks to the user's actual energy curve instead of the clock — map peak/trough/
  recovery windows, classify tasks by cognitive demand, and assign accordingly.
  Triggers: "I'm useless after lunch", "when should I do my hardest work",
  "I schedule deep work but can't focus in it", "energy management", complaints that
  a time-blocked plan keeps failing at the same hour daily. Do NOT use when the failure
  is interruptions rather than energy (use context-switch-minimizer), when the user has
  no recurring daily pattern yet (prescribe a 5-day energy log first), or for teams —
  this is a single-person instrument.
---

# Energy Task Matcher

## When invoked

1. Establish the energy map from evidence, not vibes. Ask for: wake time, the hour work reliably feels effortless, the hour focus reliably collapses, caffeine timing, and any 5+ days of self-observation. If the user has no observations, stop and prescribe a 5-day log (rate energy 1–5 at 3 fixed times daily) — do not fabricate a curve from chronotype stereotypes.
2. Segment the day into three window types: **PEAK** (deep analytical/creative work), **TROUGH** (typically 1–3h post-lunch; admin, email, mechanical tasks only), **RECOVERY** (collaborative work, review, light writing). State each window's hours explicitly.
3. Classify the task list by cognitive demand: **DEEP** (novel thinking, writing, hard decisions), **SHALLOW** (email, filing, scheduling, expense reports), **SOCIAL** (calls, reviews, pairing). One tag per task; when torn, tag by the hardest 20% of the task.
4. Assign: DEEP→PEAK only. SHALLOW→TROUGH only — spending peak hours on email is the single most expensive misallocation and must be called out wherever detected in the current schedule. SOCIAL→RECOVERY preferred.
5. Audit the collisions: list every currently-scheduled task sitting in the wrong window, with the mismatch named (e.g., "strategy doc at 2:30pm = DEEP in TROUGH"). Irreducible collisions (meeting fixed by others in PEAK) get a mitigation: protect the remaining peak minutes around it.
6. Cap DEEP allocation at the peak window's real length (usually 2–4 h/day). If the DEEP task list exceeds capacity, say so with the arithmetic — the fix is fewer commitments, not longer peaks.

## Output format

An **Energy Allocation Map**: the three windows with hours, then a task table (task | demand tag | assigned window | previously scheduled window | collision?), then a `DEEP capacity: X h available / Y h demanded` line with the overflow verdict.

## Quality gate

PASS only if: (a) the energy map cites at least one piece of user-supplied evidence per window or the output is a 5-day logging prescription instead, (b) zero DEEP tasks are assigned to TROUGH, (c) the capacity line's arithmetic is shown. FAIL any map built purely from "most people are morning people."

## Integration

- **evidence-reasoning**: the energy map is a claim about the user — it needs their observations as evidence; the 5-day log is the data-collection fallback.
- **statistical-analysis**: with 2+ weeks of logs, fit the actual curve and correct the window boundaries.
- **context-switch-minimizer**: run AFTER this skill — first decide which window each task belongs in, then batch within windows.
- **weekly-review-runner**: recurring same-hour failures found in reconciliation route here.
- **decision-journal-writer**: never journal irreversible decisions made in a TROUGH window without flagging the timing in Context.

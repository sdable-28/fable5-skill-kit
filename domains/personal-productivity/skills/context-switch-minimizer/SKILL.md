---
name: context-switch-minimizer
description: >
  Audit a day/week of work for context-switch cost and restructure it into batched,
  single-context blocks. Triggers: "I keep getting pulled in different directions",
  "my day is fragmented", "too many interruptions", "help me batch my tasks",
  "plan my deep work blocks", any request to schedule or re-sequence a task list.
  Do NOT use when the user wants to prioritize WHAT to do (use energy-task-matcher
  or an MIT decision) rather than WHEN/HOW to sequence it, or when the task list
  has fewer than 4 items — sequencing overhead exceeds switch savings there.
---

# Context Switch Minimizer

## When invoked

1. Elicit or extract the raw task inventory: every task, meeting, and recurring obligation for the target window (day or week). Refuse to proceed on a partial list — hidden tasks are the ones that cause the switches.
2. Tag each item with its **context** — the tool/mode/mental state it requires (e.g., "code", "writing", "calls", "admin", "errands"). Use the user's own labels where given; infer otherwise and state the inference.
3. Count the switches in the current sequence. Price them: each switch between unlike contexts costs ~23 minutes of recovery (state this base rate explicitly; adjust only with user-supplied evidence). Compute total switch tax in minutes.
4. Re-sequence: group same-context items into contiguous blocks of 60–180 minutes. Place the highest-cognitive-load block at the user's stated peak-energy window; if unknown, ask once, then default to first 3 hours of the workday.
5. Insert explicit buffers: 10–15 min between unlike blocks, none between like blocks. Pin immovable meetings first and pack around them — never propose moving a meeting the user didn't flag as movable.
6. Recount switches in the proposed sequence. If the proposal doesn't cut switch count by ≥40%, say so and explain the structural constraint (usually meeting fragmentation) instead of shipping a cosmetic reshuffle.

## Output format

A **Switch Audit Table** (task | context | current slot | proposed slot) followed by a **Before/After line**: `Switches: N → M. Estimated recovery time reclaimed: X min/day.` Then the proposed block schedule as a time-ordered list.

## Quality gate

PASS only if: (a) every input task appears exactly once in the proposed schedule, (b) switch count is computed for both before and after with the arithmetic shown, (c) no unmovable meeting was moved. FAIL any output that presents a schedule without the before/after switch count.

## Integration

- **plan-gate**: the proposed schedule is a plan — run it through plan-gate before the user commits a calendar to it.
- **statistical-analysis**: if the user has time-tracking data, replace the 23-min base rate with their measured recovery time.
- **productivity-theater-detector**: run after scheduling — a beautifully batched calendar full of low-value work is still theater.
- **weekly-review-runner**: feed the switch audit into the weekly review's calendar-vs-reality comparison.

---
name: long-task-orchestration
description: Use for any task expected to span multiple sessions or exceed ~30 minutes of work — migrations, large builds, multi-phase investigations, batch processing. Defines phases, checkpoints, verification gates, and handoff state BEFORE starting. Trigger signals - "this will take a while", multi-day roadmaps, work that survives a context compaction or restart. Do NOT use for tasks completable in one sitting with no interruption risk — checkpoint overhead isn't free.
---

# long-task-orchestration

Long tasks die at interruptions: context compaction, session end, an error forty minutes in. The defense is checkpointing designed BEFORE work starts — never start a long task without a checkpoint plan, because by the time you need one, the context that could write it is gone.

## When invoked

1. **Phase the work.** Split into phases where each ends at a natural consistency point — a state from which resumption needs no memory of how you got there (all files in set A migrated; investigation phase 2 complete and its output written). Phase boundaries are where interruptions are survivable; mid-phase they are expensive. Target: no phase over ~30 minutes of work.
2. **Define per-phase, before starting phase 1:**
   - **Done-criterion** — checkable, per verified-done standards.
   - **Verification gate** — what gets run/checked before the phase counts as complete. A phase whose gate fails does not checkpoint as done.
   - **Checkpoint artifact** — what gets WRITTEN TO DISK at phase end: results so far, decisions made, exact next action. Disk, not context — context is the thing that dies.
3. **Write the resume file first.** Before any work: create the task's state file (format below) with the phase plan. Update it at every phase boundary. The test: a cold model given only this file can continue the work without transcript access — absolute paths, exact commands, no "as established earlier."
4. **Execute phase by phase.** Complete → verify gate → write checkpoint → THEN start next phase. Never run two phases interleaved "for efficiency" — interleaving destroys the consistency points that make resumption possible.
5. **On interruption/resumption:** read the state file, verify the last checkpoint's claim (trust but verify — re-run its gate cheaply if possible; the interruption may have landed mid-write), continue from NEXT ACTION.
6. **Renegotiate visibly.** If mid-task discoveries change the phase plan (phase 3 turns out 5× bigger), update the state file's plan section with the change and reason — silent plan drift makes old checkpoints misleading.

## Output format

State file (`{task}-state.md` in the project or scratchpad):
```
# {task} — state
PLAN: {phase list, each: done-criterion + gate}
COMPLETED:
  - P1: {done-criterion met} | gate: {what ran, result} | artifact: {path}
IN PROGRESS: P{n} — {what's done within it, if interrupted mid-phase}
NEXT ACTION: {exact command or edit — executable cold}
DECISIONS: {made along the way, with why}
PLAN CHANGES: {renegotiations + reasons}
```

## Integration

- Each phase internally runs the normal stack: **plan-gate** (for build phases), **verified-done** (as the gate), **scope-fence** (per phase).
- Multi-session investigations: one **code-investigation** phase per checkpoint.
- **context-budget-management** decides what stays in context between phases; this skill decides what goes to disk.
- The state file IS the session handoff (Operating Manual 2.5) for the task's slice of the session.

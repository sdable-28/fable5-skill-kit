---
name: context-budget-management
description: Use during any long-running task where context is a finite resource — extended investigations, multi-phase builds, sessions approaching compaction. Tracks what's consuming context, compresses completed phases to summaries, and triages what must survive vs what can drop. Trigger signals - long session, large tool outputs accumulating, an approaching compaction, fan-out reads. Do NOT use on short tasks — premature compression loses detail you still need.
---

# context-budget-management

Context is working memory, and it degrades two ways: it runs out (compaction, with lossy summarization you don't control), and it silts up (buried constraints stop influencing behavior — Anti-Hallucination F4). Managing the budget means choosing deliberately what occupies it, compressing what's settled, and putting the irreplaceable on disk before anything is lost.

## When invoked

1. **Know the retention priority.** What MUST stay live, in order:
   1. Current task state — objective, fence, phase, next action.
   2. Verification gates passed — which claims are VERIFIED and by what (losing this silently downgrades your evidence tiers).
   3. Open questions and carried assumptions.
   4. Hard constraints/fences — these decay fastest under drift; re-anchor them explicitly after any compaction.
   What can DROP: intermediate reasoning that led to settled conclusions, completed sub-task mechanics, raw tool outputs already distilled, dead-end explorations (keep the one-line lesson, drop the transcript).
2. **Compress completed phases proactively.** At each phase boundary, reduce the phase to: conclusion + evidence pointers (file:line, not re-quoted bodies) + decisions + anything the next phase consumes. The full detail lives in the phase's checkpoint artifact on disk (long-task-orchestration), so in-context compression is safe.
3. **Don't ingest what you can point to.** Prefer index/Grep hits and sliced reads over whole files (the kit's standing rule — it is a context rule as much as a token rule). For bulk material, spawn a subagent: it burns its own context and returns a conclusion sized for yours.
4. **Before an expected compaction, save to disk:** every exact number, ID, command, and decision that must survive verbatim — compaction preserves gist, and gist gets numbers wrong. This is the pre-compact protocol (Operating Manual 2.3).
5. **After compaction, re-anchor in one line:** current task, active fence, next action — stated fresh, so the constraints re-enter live attention rather than resting in a summary you won't re-read.
6. **Watch the silt signals:** re-reading files already read this session; re-deriving established facts; a fence violation that would have been caught earlier. Each means retrieval is failing — compress and re-anchor now rather than pushing on.

## Output format

Lightweight ledger at phase boundaries or on demand:
```
CONTEXT LEDGER
KEEP LIVE: {task state | verified-gates | open questions | fences}
COMPRESSED: {phase → one-line conclusion + evidence pointer}
TO DISK: {what was saved verbatim, where}
DROPPED: {what, and why it's safe}
```

## Integration

- Sibling of **long-task-orchestration**: that skill decides what goes to disk at checkpoints; this one decides what stays live between them.
- Subagent offloading follows **multi-agent-orchestration**'s inline-vs-spawn rule.
- Protects **evidence-reasoning**: a VERIFIED claim whose evidence pointer survived compression stays VERIFIED; one whose evidence vanished silently degrades to ASSUMPTION and must be re-checked before reuse.
- The pre-compact save implements Anti-Hallucination F4's prevention discipline.

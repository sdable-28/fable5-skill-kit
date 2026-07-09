---
name: root-cause-first
description: Use before writing ANY fix — bug fix, test failure, unexpected behavior, wrong output, performance problem. Requires the root cause stated with evidence before any code changes. Trigger keywords - "bug", "broken", "failing", "wrong output", "doesn't work", "crashed", "fix this". Do NOT use when the cause is already established with evidence in this session, or for pure feature work with no defect involved.
---

# root-cause-first

Before any fix, state the root cause with evidence. A fix without a cause is a guess wearing a fix's clothes — it may suppress the symptom while the cause continues damaging something else, and it teaches you nothing when it fails.

## When invoked

1. **Reproduce or evidence the symptom.** Get the failure in front of you: the actual error, the actual wrong value, the actual log line. A symptom described secondhand ("it sometimes books wrong P&L") gets pinned down to a concrete instance before analysis.
2. **Trace backward from symptom to cause.** Follow the data/control flow upstream, using hypothesis-before-read at each hop: "expect the wrong value enters at X" → check → revise. Stop when you reach a point where correct input becomes incorrect output — that transformation is the candidate cause.
3. **State the root cause with evidence.** Format: "ROOT CAUSE: {mechanism} at {file:line}, evidenced by {snippet/output}. The symptom follows because {causal chain, each link checkable}." If you cannot fill this in, you do not have the cause — return to step 2, do not proceed to a fix.
4. **Distinguish root from proximate.** Ask once: "why did THAT happen?" If the answer is another defect (e.g., the null-check is missing *because* two code paths were copy-pasted and one drifted), decide explicitly which level to fix and say why. Fixing proximate is sometimes correct (blast-radius control) but must be a stated choice.
5. **Design the fix against the cause,** not the symptom. The fix's description must reference the cause's mechanism: "removes the drift by X" not "adds a check so the error stops."
6. **New-cause check before shipping.** Ask: what does this fix change for callers/paths OTHER than the failing one? Enumerate the call sites or consumers of the changed behavior (index/Grep, not memory) and confirm each tolerates the change. A fix that introduces a new root cause elsewhere fails this skill.
7. **Verify the causal chain, not just the symptom.** After fixing: the symptom is gone AND the mechanism is demonstrably closed (e.g., the previously-diverging code paths now share one source of truth). Symptom-gone alone is consistent with coincidence.

## Output format

```
SYMPTOM: {concrete instance, with output/error}
ROOT CAUSE: {mechanism} at {file:line} — evidence: {snippet}
CAUSAL CHAIN: {cause} → {intermediate} → {symptom}, each link verified
PROXIMATE VS ROOT: {which is being fixed and why}
FIX: {change, referencing the mechanism}
NEW-CAUSE CHECK: {other consumers of changed behavior + why each is safe}
```

## Integration

- **hypothesis-before-read** drives the backward trace (step 2).
- **evidence-reasoning** governs the cause statement — a cause without citation is an ASSUMPTION, and you don't fix on assumptions.
- **adversarial-disproof** on the cause before fixing when stakes are high: could this evidence have another explanation?
- **verified-done** closes the loop; Master Framework Gate 6 requires this skill's output verbatim.

---
name: plan-gate
description: Use before ANY implementation work — feature, fix, refactor, migration, config change. Produces a verified plan and gates on user review before the first edit. Trigger keywords - "implement", "build", "add", "fix", "change", "wire", "migrate". Do NOT use when the task is trivially mechanical (< 5 minutes, < 3 files, single obvious change like a typo fix or a rename with no behavioral effect) — gating those wastes the user's time.
---

# plan-gate

Before any implementation, produce a verified plan. The user reviews the plan before the first edit is made. The gate exists because the cheapest place to catch a wrong approach is before code exists — every line written on a wrong plan is a line that must be found, understood, and reverted.

## When invoked

1. **Triviality check first.** If the task is < 5 min, < 3 files, and single-interpretation: skip the gate, state "skipping plan-gate: trivially mechanical" in one line, and proceed. Anything else continues.
2. **Establish current state with evidence.** Locate every file the change touches (index/Grep first, sliced reads). No plan step may rest on a remembered or assumed code location — each named location needs a this-session lookup behind it.
3. **Write the plan** in the output format below. Every step names its file(s), the nature of the change (add/modify/delete), and its verification method.
4. **Run assumption-flagging on the plan.** Surface every hidden assumption; resolve HIGH-risk ones by verification before presenting.
5. **Present and STOP.** The plan goes to the user. No Edit/Write on production files until the user approves or amends. Questions embedded in the plan are fine; edits are not.
6. **On approval:** execute the plan as written. Any mid-execution deviation from the plan is surfaced the moment it's discovered ("step 3 is wrong because X, proposing Y instead"), not silently absorbed.

## Output format

```
## Plan: {task title}

GOAL: {one sentence — what "done" means, checkable}
CURRENT STATE: {2-4 bullets, each with file:line evidence}

STEPS:
1. {file} — {add/modify/delete}: {what and why} → verify: {how}
2. ...

OUT OF SCOPE: {explicit list — see scope-fence}
RISKS: {what could go wrong; which step tests the riskiest assumption}
ASSUMPTIONS: {from assumption-flagging, each with risk level}

Awaiting review before any edit.
```

## Integration

- **scope-fence** runs inside step 3 — the OUT OF SCOPE list is mandatory plan content.
- **assumption-flagging** runs at step 4 on the drafted plan.
- **cartography-first** precedes this skill on unfamiliar codebases — you cannot plan territory you haven't mapped.
- **verified-done** consumes this plan's per-step verification methods at completion time.
- In the Master Framework, this skill IS Gate 3.

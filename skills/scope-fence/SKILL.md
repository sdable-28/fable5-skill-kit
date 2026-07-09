---
name: scope-fence
description: Use at the start of any task that modifies anything — code, docs, config, data. Defines an explicit IN/OUT scope boundary and refuses to expand it without user acknowledgment. Trigger keywords - "change", "fix", "update", "clean up", "improve", "refactor". Especially critical when the codebase contains locked files, live systems, or the request uses vague verbs ("improve", "clean up"). Do NOT use for pure read/analysis tasks that modify nothing.
---

# scope-fence

Define the boundary before touching anything. The model's default failure is doing MORE than asked — the helpful-seeming refactor, the drive-by rename, the extra error handling. Every out-of-fence change is un-reviewed risk the user didn't sign up for.

## When invoked

1. **Write the fence** before the first modification:
   - **IN**: the specific files/functions/sections the task requires, each traced to a phrase in the user's request.
   - **OUT (explicit)**: adjacent things a helpful model would be tempted to touch — name them specifically. Formatting, renames, "while I'm here" fixes, adjacent bugs noticed en route, and any file marked locked/live are OUT by default.
2. **Check standing fences.** Scan CLAUDE.md / memory / task notes for locked files and no-touch rules; copy any that apply into the OUT list so they're visible in this task's context.
3. **Enforce during execution.** Before each Edit/Write, the target must be on the IN list. If it isn't, stop — do not edit first and justify later.
4. **On discovering needed out-of-scope work:** surface it, don't do it. Format: "Blocked/adjacent: {finding}. It is outside the fence. Options: (a) expand scope to include it — needs your ack, (b) log it and continue, (c) it actually blocks the task, so the task can't complete without a decision." Wait only if (a) or (c); otherwise log and continue.
5. **On discovering a bug outside the fence:** report it in the final summary under "Found, not touched." Fixing it silently is a fence violation even when the fix is correct.
6. **At completion:** diff review — every changed line traces to an IN item. Any stray change is reverted before delivery, not explained.

## Output format

At task start:
```
SCOPE FENCE
IN:  {file/function → request phrase that justifies it}
OUT: {explicit exclusions, including standing locks}
```
At completion, in the summary:
```
FENCE CHECK: all changes within scope ✓ (or: reverted {x}; found-not-touched: {y})
```

## Integration

- Embedded in **plan-gate**'s output (OUT OF SCOPE section) when both run.
- **verified-done**'s regression check uses the fence: changes outside it are automatic failures.
- Pairs with negative-specification prompting (Operating Manual 2.1) — the fence is the model-side enforcement of the user-side fence block.
- Master Framework: the fence is written at Stage 1 (out-of-scope list) and enforced at Stage 4.

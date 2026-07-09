---
name: verified-done
description: Use before claiming ANY task complete, fixed, working, or passing — before committing, before "done", before ticking a task box. Defines done as criterion-met + no-regressions + verified-by-stated-method. Trigger keywords - "done", "complete", "fixed", "works now", "should be good", "ready to commit". Do NOT use mid-task on subcomponents you haven't finished — it gates the completion claim, not progress reports.
---

# verified-done

"The code ran" is not done. "I made the edit" is not done. Done means: (a) the task's success criterion is met, (b) nothing that worked before is broken, (c) verification used the completion method the task stated — and the evidence is shown. The gap between "AI ran the code" and "criterion satisfied" is where silent failures live: code that runs but computes the wrong thing, tests that pass but don't cover the change, fixes that fix a different bug.

## When invoked

1. **Retrieve the original criterion verbatim.** Re-read the task's actual success criterion (from the request, the plan, or Stage 1). Do not verify against your memory of it — criterion drift (verifying something adjacent to what was asked) is the most common failure this skill catches.
2. **Execute the stated verification method.** If the task said "verify by running the test suite," run it. If it said "confirm the output matches $X," produce the output and compare. If no method was stated, choose the strongest available: end-to-end exercise of the changed behavior > targeted test > static inspection — and say which you used and why.
3. **Check for regressions.** Run whatever existing checks cover the touched area (tests, linters, a known-good invocation). Diff-scan for accidental changes outside the fence.
4. **Compare evidence to criterion, clause by clause.** Each clause of the criterion maps to a piece of concrete evidence (command output, file content, observed behavior). A clause without evidence = NOT done.
5. **Report honestly.** Three legal verdicts:
   - **DONE** — every clause evidenced; regressions checked; evidence shown.
   - **NOT DONE** — state exactly which clause lacks evidence and what remains.
   - **DONE WITH CAVEATS** — criterion met but something material surfaced (e.g., verified in sim, not live). Caveats are in the verdict line, not buried.
   Never "should work," "looks good," or "I believe this fixes it."

## Output format

```
## Verification: {task}
CRITERION (verbatim): {quoted from source}
METHOD: {what was executed/inspected}
EVIDENCE:
  - {clause 1} → {command/output/observation}
  - {clause 2} → {...}
REGRESSIONS: {checks run + result}
VERDICT: DONE | NOT DONE ({missing}) | DONE WITH CAVEATS ({caveat})
```

## Integration

- Consumes **plan-gate**'s per-step verification methods.
- **scope-fence**'s completion diff-check runs as part of step 3.
- If the verdict is NOT DONE, hand off to **root-cause-first** — never patch-and-reclaim without a cause.
- Master Framework: this skill IS Gate 5. Task-list boxes get ticked only on a DONE verdict from this skill.

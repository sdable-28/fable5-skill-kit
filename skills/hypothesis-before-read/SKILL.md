---
name: hypothesis-before-read
description: MANDATORY for all investigation tasks — debugging, auditing, tracing, verifying. Before reading any file or section, state in one sentence what you expect to find; after reading, compare and state when wrong. Trigger - every Read during an investigation. Do NOT use for non-investigative reads (loading a config to use it, opening a file you just wrote) — it gates investigation, not mechanical access.
---

# hypothesis-before-read

Reading without a hypothesis is scrolling. The hypothesis does three jobs: it forces your mental model onto the record where it can be falsified; it makes the read targeted (you know what you're checking for); and the miss — "expected X, found Y" — is the single most informative event in an investigation, because it localizes exactly where your model of the system is wrong.

## When invoked

1. **Before the read, write one sentence:** "Expect: {specific, falsifiable finding}." Specific means checkable against the text — "Expect: the stop floor is applied in open_trade() before contract sizing" is a hypothesis; "Expect: relevant position logic" is not. If you cannot form a hypothesis, you haven't done cartography — go map first.
2. **Read the targeted slice** (offset+limit from an index/Grep hit — never the whole file because "the answer is somewhere in there").
3. **After the read, compare, honestly.** Three verdicts:
   - **MATCH** — model confirmed; proceed on it.
   - **PARTIAL** — right shape, wrong detail (right function, different ordering). Update the model, note the delta.
   - **MISS** — expected X, found Y. Say so explicitly in the output — never silently absorb a miss.
4. **On a MISS, stop and update before the next read.** A miss means your model of the system is wrong somewhere upstream of this file. Ask: what belief generated the wrong expectation? Correct that belief first — otherwise the next five reads inherit the same error. Misses cluster; a corrected model prevents the cluster.
5. **Track the hit rate loosely.** Mostly MATCHes → your model is good, reads can get sparser. Repeated MISSes → your model is bad; drop back to cartography rather than continuing to read on a broken map.

## Output format

Inline in the investigation narrative, per read:
```
→ {file:lines} | Expect: {hypothesis} | Found: MATCH / PARTIAL ({delta}) / MISS ({what was actually there; which belief was wrong})
```
Terse is fine; skipping is not — on investigation tasks this line accompanies every read.

## Integration

- **cartography-first** generates the initial hypotheses; this skill tests them read by read.
- Drives the backward trace in **root-cause-first** step 2.
- MISSes are evidence for **coverage-accounting** ("model wrong about area X — nearby unread code now higher-risk") and are the raw material of **self-correction**.
- **code-investigation** Phase 3 mandates this on every read; the phase output includes the expect/found log.

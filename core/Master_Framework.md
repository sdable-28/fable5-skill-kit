# Master Framework — Universal Problem-Solving and Execution Protocol

Domain-agnostic. Applies to code, research, writing, analysis, design, operations. The skills library implements individual stages; this file defines the spine that sequences them.

---

## 4.1 The 7-Stage Universal Workflow

Run stages in order. Define "done" for each stage before starting it. Each stage ends at a **gate** — a specific, verifiable pass/fail condition. A failed gate sends you back, never forward.

### Stage 1 — UNDERSTAND
*What is the actual problem — the root need, not the stated request?*

- **Techniques:** 5 Whys on the request ("why do you want the gate?" → "losses cascade" → the real problem is cascade risk, not a missing gate). Stakeholder perspective: who consumes the output and what do they do with it? Constraint mapping: hard limits (time, money, locked files, irreversibility) listed explicitly.
- **Output:** Problem statement (one paragraph) + success criteria (checkable, not vibes) + out-of-scope list.
- **GATE 1:** Answer in writing: "If I solve exactly this, is the user's actual goal achieved?" PASS = yes with a stated reason. FAIL = "probably" → return to questioning or state the interpretation being assumed with `[ASSUMPTION]`.

### Stage 2 — DECOMPOSE
*Break into independently solvable subproblems.*

- Identify dependencies: which parts strictly precede others (draw the edges, don't assume linearity).
- Identify parallelizable parts: no shared state, no ordering constraint → candidates for subagents.
- **Output:** Work breakdown with dependency graph (a list with "blocks/blocked-by" annotations is enough).
- **GATE 2:** Every subproblem has (a) a one-line completion criterion and (b) no hidden dependency — checked by asking "can I start this with only the listed inputs?" for each. Any "no" = missing edge, fix the graph.

### Stage 3 — PLAN
*For each subproblem: approach, tools, verification method.*

- **Ordering rule:** blockers first → highest-risk first → fastest-to-validate first. Rationale: kill the plan cheaply if it's going to die.
- Each task line: what, how, and *how I will know it worked* (the verification is part of the plan, not an afterthought).
- **Output:** Ordered task list with per-task verification criteria.
- **GATE 3:** (a) The riskiest assumption in the plan is scheduled to be tested in the first 20% of the work. (b) `assumption-flagging` has been run on the plan and no HIGH-risk assumption is unverified. (c) For non-trivial work, the user has seen the plan (`plan-gate`). All three or FAIL.

### Stage 4 — EXECUTE
*One subproblem at a time.*

- New territory → `cartography-first` before deep reads.
- Any investigation → `hypothesis-before-read` on every file.
- Any claim → `evidence-reasoning` citation discipline.
- **Never start subproblem N+1 before verifying subproblem N** — errors compound; a wrong foundation invalidates everything built on it.
- **GATE 4 (per subproblem):** its Stage-2 completion criterion is met and demonstrated (output shown, test run, value confirmed). "The code looks right" is FAIL; "the command ran and printed X" is PASS.

### Stage 5 — VERIFY
*Check the assembled whole against Stage 1's success criteria.*

- Not "did it run" — "does it meet the criterion as originally written." Re-read the Stage 1 criteria verbatim before judging; drift between what was asked and what was checked is the most common verification failure.
- Apply `adversarial-disproof` to any significant conclusion (three lenses: evidence correct? handled elsewhere? impact real?).
- Apply `verified-done`: criterion met, no regressions, verified by the method the task specified.
- **GATE 5:** Every Stage 1 success criterion maps to a piece of concrete evidence. Any criterion without evidence = NOT DONE, say so plainly.

### Stage 6 — SELF-CORRECT
*If verification fails: root cause before re-execution.*

- `root-cause-first`: state the cause with evidence before touching anything. Patching a symptom re-enters this stage with less credibility.
- `self-correction-loop`: before re-attempting, re-read your own failed attempt as a skeptical reviewer — the flaw is often in the plan, not the execution.
- **GATE 6:** The root cause is stated, cited, and the new attempt explains why it cannot reproduce the same failure. A retry without a cause statement is FAIL.

### Stage 7 — ITERATE / CLOSE
*Close the loop.*

- What changed, what was learned, what's next.
- Non-obvious insight → memory/lessons (falsifications especially — they prevent repeat work).
- Session ending mid-task → handoff state per Operating Manual 2.5.
- **GATE 7:** The task list reflects reality (done = verified done); any new fence or falsification is persisted; the next action is written down. Then stop.

---

## 4.2 Adaptation Rules

### Full vs. abbreviated (decision tree)
```
Estimated < 15 min AND reversible AND single-domain?
├─ YES → Abbreviated: Understand (one sentence) → Execute → Verify. Skip 2,3,6,7.
└─ NO → Multiple files or sessions? Irreversible steps? Feeds a money/production decision?
    ├─ Any YES → Full 7-stage.
    └─ All no → Middle path: stages 1,3,4,5 (skip formal decompose; fold correction into execute).
```

### When to escalate to adversarial phase
Escalate (add `adversarial-disproof` + independent verification) when ANY of: the conclusion contradicts prior belief or a previous session; the result is surprisingly good (too-good results are usually measurement bugs); the output feeds an irreversible decision; a single source underpins the whole conclusion.

### When to spawn subagents
Spawn when: ≥3 independent dimensions (parallel lenses); the search space is wide but the needed conclusion is narrow (keep raw data out of main context); or coverage requires more reading than one context holds. Don't spawn for: single lookups, work needing conversation context, or anything you'd immediately redo yourself.

### When to pause and ask the user
Only at: missing input only they have, irreversible action above threshold, or genuine goal ambiguity (Stage 1 gate failed twice). Everything else: decide, state the decision and its reversibility, proceed.

### Domain-specific gate additions
- **Code:** Gate 4 additionally requires index re-sync after edits; Gate 5 requires the stated test/run method executed.
- **Trading/quantitative:** Gate 5 requires SIM/LIVE labeling on every figure; both-halves (or out-of-sample) stability before any "edge" claim; Gate 3 requires the falsification ledger checked before planning any experiment.
- **Writing/documents:** Gate 5 = read-through as the target audience; every section answers "why does the reader need this?"
- **Research:** Gate 5 requires ≥2 independent sources per load-bearing claim; Gate 7 requires the falsified-hypotheses list updated.

---

## 4.3 Quality Gates — Summary Table

A quality gate is a specific verifiable condition, never "looks good."

| Gate | PASS condition (verbatim checkable) | FAIL symptom |
|---|---|---|
| G1 Understand | Written yes+reason to "does solving this achieve the goal?"; success criteria are checkable statements | "Build what was asked" without knowing why |
| G2 Decompose | Every subproblem has completion criterion + startable from listed inputs alone | A task that stalls waiting on an unlisted input |
| G3 Plan | Riskiest assumption tested in first 20%; no unverified HIGH-risk assumption; plan seen by user (non-trivial) | Risky bet discovered dead at 80% complete |
| G4 Execute | Per-subproblem criterion demonstrated with output/evidence | "Should work now" |
| G5 Verify | Each Stage-1 criterion ↔ concrete evidence, 1:1 | Verified something adjacent to what was asked |
| G6 Correct | Root cause stated + cited; new attempt provably immune to old failure | Second patch on the same symptom |
| G7 Close | Task list truthful; lessons persisted; next action written | Next session starts by re-deriving this one |

---
name: assumption-flagging
description: Use on any plan, design, estimate, or analysis BEFORE acting on it — scans for hidden assumptions, surfaces each with risk level and verification method, and resolves high-risk ones before proceeding. Trigger points - end of plan drafting, before committing to an approach, before quoting an estimate, after writing any "therefore". Do NOT use as a substitute for verification — flagging is triage; HIGH-risk flags must actually get verified.
---

# assumption-flagging

Plans fail at their unstated assumptions — the things so obvious nobody checked them. This skill is a deliberate scan: walk the artifact, extract every claim that is neither verified nor user-given, and force each into the open with a risk grade and a verification path.

## When invoked

1. **Walk the artifact clause by clause** asking of each: "what must be true for this to work, that I haven't verified this session?" Hunt especially in the five classic hides:
   - **Environmental** — versions, paths, permissions, tool availability ("the index is current", "the VPS has the branch").
   - **Behavioral** — how existing code behaves off the happy path ("the caller handles None", "this is idempotent").
   - **Data-shape** — formats, ranges, timezones, nullability ("timestamps are UTC", "the CSV has a header").
   - **Intent** — what the user meant by an ambiguous term ("'latest' means most recent by date, not by version").
   - **Continuity** — that things haven't changed since last observed ("the config still has X" — from a prior session = assumption).
2. **Flag each:** `[ASSUMPTION: {statement} | RISK: HIGH/MED/LOW | VERIFY: {concrete check}]`.
   - Risk = damage-if-wrong × plausibility-of-wrong. An assumption that would silently corrupt data is HIGH even if probably true; one that would fail loudly and immediately is LOW even if shaky (it self-detects).
3. **Resolve HIGH before proceeding — no exceptions.** Verify (run the check), transform (redesign so the plan no longer depends on it), or escalate (only the user can resolve it — intent assumptions usually land here). A HIGH-risk assumption carried into execution is a gate failure.
4. **MED: verify if the check is under ~2 minutes; otherwise carry visibly** — it appears in the plan's ASSUMPTIONS section and again in the final deliverable. **LOW: list, proceed.**
5. **Re-scan after material plan changes.** Edits introduce fresh assumptions; the scan is per-version, not per-task.

## Output format

```
## Assumptions ({artifact})
HIGH (resolved before proceeding):
  - {statement} → {verified: result / redesigned: how / escalated: question}
MED (carried, visible):
  - {statement} | VERIFY: {check} | fails-how: {loud/silent}
LOW: {compact list}
```

## Integration

- Mandatory step 4 of **plan-gate**; Master Framework Gate 3 requires zero unresolved HIGH flags.
- Flags inherit **evidence-reasoning**'s ASSUMPTION tier; resolution upgrades them to VERIFIED.
- Carried MED/LOW flags flow into **uncertainty-handling** for output phrasing, and into **coverage-accounting** when the assumption bounds what was checked.
- The intent-category flags are the main legitimate trigger for pausing to ask the user (Master Framework 4.2).

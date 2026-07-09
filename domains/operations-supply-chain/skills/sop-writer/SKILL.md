---
name: sop-writer
description: Author or rewrite a Standard Operating Procedure that captures how work is verifiably done — actor-scoped steps, decision points, control checks, and failure branches — from observed reality, not managerial intent. Trigger phrases — "write an SOP", "document this process", "work instruction", "we need this in the quality manual", "ISO audit needs a procedure", "capture tribal knowledge before Priya leaves". Do NOT use when the process itself is disputed or being redesigned — resolve the design first (plan-gate the redesign), an SOP freezes a process, it does not choose one; and do NOT use for one-off runbooks with no repeating operator.
---

# SOP Writer

## When invoked
1. Establish the source of truth for each step before writing anything. Rank sources: direct observation / system logs > operator walkthrough > manager description. If the only source is a manager description, stop and say the SOP will document intent, not reality — recommend a process-reality-checker pass or a walkthrough first.
2. Fix the scope with a trigger-and-terminus statement: the exact event that starts the procedure (e.g., "ASN received in WMS") and the exact state that ends it ("pallet putaway confirmed, LPN scanned to location"). Reject vague boundaries like "when goods arrive."
3. Assign every step to exactly one named role (not a person, not a department). If a step has two possible actors, split it or add an explicit handoff step with the handoff artifact named (ticket, scan, signature).
4. Write steps as verb-first imperatives with the acceptance criterion inline: not "check the seal" but "Inspect container seal; number must match the seal number on the BOL. Mismatch → step 12 (quarantine)." Every inspection step names what PASS looks like and where FAIL goes.
5. Encode every decision point as an explicit branch with all exits covered — no decision may have an undocumented "else." Every exception path must terminate in a named procedure, a named role, or an escalation, never in "notify supervisor" without stating what the supervisor's options are.
6. Embed the control metadata the quality system requires: document ID, version, effective date, owner role, review cadence, training requirement, and the records the procedure generates (which form/scan/log constitutes evidence it was followed).
7. Validate by tabletop walkthrough: execute the draft mentally as the named role with only the SOP in hand and no tribal knowledge. Every noun must be findable (system name, screen, field, physical location) and every tool/input available at that step. Fix every point where you needed unstated knowledge.

## Output format
A complete **SOP document** with: header block (ID, version, effective date, owner, scope trigger/terminus, records generated); roles table; numbered procedure body (verb-first steps, inline acceptance criteria, explicit branches); exception/escalation section; revision history stub. Plus a separate **Source Map** listing, per step or step-range, the evidence source it was written from.

## Quality gate
PASS only if: zero steps lack an actor role; zero decision points lack a full set of exits; every inspection step states its pass criterion and fail destination; and the Source Map shows no step sourced solely from managerial description without a flag. FAIL if the tabletop walkthrough (step 7) required any knowledge not present in the document — list each such point as a defect before finalizing.

## Integration
- **verified-done**: the tabletop walkthrough is the verification step — the SOP is not "done" at draft, only after walkthrough defects are zero.
- **evidence-reasoning**: the Source Map is its artifact; every step carries provenance.
- Consumes **process-reality-checker** output: DOC-DEFECT and re-capture findings are the preferred input; write from its Reality Gap Register when one exists.
- Pairs with **plan-gate**: if writing the SOP surfaces a design dispute (two teams do it differently on purpose), exit to plan-gate — do not silently canonize one variant.
- Provides the controlled baseline that future **process-reality-checker** runs diff against.

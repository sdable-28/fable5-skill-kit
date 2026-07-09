---
name: process-reality-checker
description: Reconcile the documented process (SOP, BPMN, swimlane, work instruction) against how the work actually happens on the floor, and classify every divergence as doc-defect, process-drift, or legitimate workaround. Trigger phrases — "the SOP says X but the team does Y", "audit found nonconformance", "nobody follows the process", "as-is vs to-be", "shadow process", "tribal knowledge". Do NOT use when no documented process exists yet — that is greenfield mapping, hand it to sop-writer; and do NOT use for pure system/code behavior gaps with no human process step involved.
---

# Process Reality Checker

## When invoked
1. Obtain the document of record: the current SOP/BPMN version, its effective date, and its owner. If multiple versions circulate, list all and identify which one operators were actually trained on — that is the comparison baseline, not the newest one.
2. Reconstruct the as-performed process from evidence, never from the process owner's description alone. Acceptable evidence, in preference order: system event logs / timestamps (task mining), transaction records, direct observation notes, operator interviews. Interviews of managers alone are insufficient — managers describe the documented process back to you.
3. Walk the two processes step-by-step in a single alignment table. For each documented step record: performed as written / performed differently / skipped / performed but undocumented extra steps inserted.
4. Classify every divergence into exactly one of three types:
   - **DOC-DEFECT** — the document is wrong or stale; reality is correct (e.g., references a retired system).
   - **DRIFT** — the document is correct; execution decayed (skipped checks, batched signoffs). Quantify the risk the skipped control was protecting against.
   - **WORKAROUND** — reality deviates because the documented process is unworkable (missing input, tool gap, timing conflict). The workaround is the symptom; the constraint is the finding.
5. For each DRIFT item, run 5 Whys to the enabling condition (why is skipping possible and consequence-free day to day?). For each WORKAROUND, name the upstream constraint that forces it.
6. Decide disposition per divergence: update the document, retrain to the document, or redesign the process. Never default to "retrain" — retraining against a WORKAROUND recreates the deviation within weeks.

## Output format
A **Reality Gap Register**: (1) baseline doc identity (version, date, owner, training lineage); (2) evidence inventory with source type per finding; (3) step-alignment table; (4) divergence register — one row each: step, observed behavior, evidence, classification (DOC-DEFECT/DRIFT/WORKAROUND), root condition, disposition; (5) count summary by classification.

## Quality gate
PASS only if: every divergence row cites non-interview evidence OR is explicitly flagged "interview-only, unverified"; every row has exactly one classification; and no DRIFT item lacks its enabling-condition answer. FAIL if any disposition is "retrain" on a row classified WORKAROUND, or if the baseline document version is unstated.

## Quality gate note
If more than ~70% of steps diverge, stop classifying and escalate: the document is fiction, not a baseline — route the whole process to sop-writer for re-capture from observed reality.

## Integration
- **evidence-reasoning**: the evidence ladder in step 2 is enforced by it — claims about "what actually happens" carry their source type.
- **root-cause-first / adversarial-disproof**: step 5 classification must survive the challenge "could this WORKAROUND actually be DRIFT with a convenient excuse?"
- **plan-gate**: dispositions marked "redesign" enter planning through plan-gate; this skill ends at the register, it does not redesign.
- Feeds **sop-writer**: DOC-DEFECT and re-capture outputs are its direct input. Feeds **bullwhip-detector** when undocumented order-batching workarounds surface in replenishment steps.

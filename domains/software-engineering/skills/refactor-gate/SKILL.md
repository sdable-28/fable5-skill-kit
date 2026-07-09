---
name: refactor-gate
description: Behavior-preservation gate for restructuring existing code — extracting functions, renaming, moving modules, collapsing duplication, strangler-fig migrations, dependency inversion. Trigger phrases: "clean this up", "refactor", "extract into", "reduce duplication", "restructure", "migrate module", "this file is too big". Do NOT use when the change is meant to alter behavior (feature, bugfix, config change) — behavior-changing edits go through normal plan/verify flow, and mixing them into a refactor voids this gate.
---

# Refactor Gate

## When invoked

1. Declare the invariant: "external behavior is identical before and after." Enumerate the observable surface being preserved — public function signatures, API responses, DB writes, log lines consumed downstream, serialization formats, error types callers catch, and ordering guarantees.
2. Capture the before-state. Run the existing test suite and record pass/fail counts. Where the surface is untested, write characterization tests FIRST: call the current code with representative inputs (including edge and error inputs) and pin its actual outputs — even outputs that look wrong. Wrong-but-depended-on behavior is behavior.
3. Map the blast radius. Find every caller, importer, subclass, and reflection/string-based reference (DI containers, ORM configs, route tables, serialized class names) of each symbol being moved or renamed. List them explicitly; string-based references do not show up in compiler errors.
4. Refactor in mechanical steps, each independently green: rename → run tests; extract → run tests; move → run tests. Never batch structural changes with logic edits. If a logic bug is discovered mid-refactor, stop, note it, finish or revert the refactor, then fix the bug as a separate change.
5. Diff-audit the result: read the full diff and confirm every hunk is structure-only. Any hunk that changes a condition, default, ordering, or literal is a behavior change — remove it or reclassify the task.
6. Rerun the full before-state suite plus characterization tests. Counts must match exactly.

## Output format

A **Preservation Report**: `Invariant Surface` (bullet list of preserved observables), `Characterization Tests Added` (file:test names), `Blast Radius` (caller/reference list incl. string-based), `Step Ledger` (each mechanical step + test result), `Diff Audit` (per-hunk classification: structural / VIOLATION), `Before vs After test counts`.

## Quality gate

PASS only if: (a) test pass/fail counts are identical before and after, (b) every previously-untested touched surface gained a characterization test, and (c) the diff audit contains zero hunks classified as behavior-changing. FAIL immediately if any step ledger entry shows a red test that was "fixed" by changing the test's expected value.

## Quality gate note on locked code

If the target is marked locked/frozen (e.g., a LOCKED strategy file), refuse the refactor and report that instead — additions only.

## Integration

- Runs inside **plan-gate**: the Invariant Surface and Blast Radius are produced at plan time, before the first edit.
- Characterization tests are **evidence-reasoning** artifacts — pinned actual behavior, not assumed behavior.
- The diff audit is an **adversarial-disproof** pass: hunt for the hunk that breaks the invariant.
- If a refactor step turns a test red for unclear reasons, invoke **debug-isolator** rather than tweaking until green.
- Signatures on the invariant surface that other services consume also require **api-contract-verifier**.
- Completion claims route through **verified-done** with the Preservation Report attached.

---
name: race-condition-prober
description: Detection and proof protocol for concurrency defects — async/await ordering bugs, check-then-act races, double-submit, lost updates, deadlocks, non-idempotent retries, flaky tests that pass alone but fail in parallel. Trigger phrases: "flaky test", "happens under load", "duplicate records", "fails randomly", "race condition", "works in sequence but not in parallel", "retry created two". Do NOT use for deterministic single-threaded bugs (use debug-isolator), or for performance tuning of correctly-synchronized code — slowness without interleaving-dependent wrongness is not a race.
---

# Race Condition Prober

## When invoked

1. Confirm the defect is interleaving-dependent: run the failing scenario serially N times, then concurrently N times. If it fails serially too, exit to debug-isolator — it is not a race. Record both failure rates; they are the baseline.
2. Inventory the shared mutable state on the suspect path: module globals, class attributes, caches, connection/session objects, DB rows, files, counters, singletons — and every await point, thread boundary, callback, or process hop between a READ of that state and a WRITE derived from it. Every read→await→write triple is a candidate race window.
3. Classify each candidate by pattern: check-then-act (exists check then insert), read-modify-write (lost update), ordering assumption (callback before continuation), non-atomic multi-step (partial write visible), or non-idempotent retry (side effect repeats). Name the pattern — the fix is pattern-determined.
4. Prove the race by forcing the interleaving, not by rerunning and hoping: inject a sleep/yield inside the suspected window and show the failure becomes deterministic; or run a stress harness (dozens of concurrent tasks hammering the path) and show failure rate rises far above baseline. A race you cannot force at will is not yet located.
5. Fix with the mechanism that matches the pattern: atomic compare-and-swap or DB unique constraint for check-then-act; row locking / optimistic version column for lost updates; idempotency keys for retries; moving state to local scope for shared-mutable leaks; explicit ordering (await, join, barrier) for ordering bugs. Never fix a race by adding a sleep.
6. Reverify: with the fix in place, rerun the forced-interleaving test (must now pass WITH the injected delay still present) and the stress harness (0 failures across a run count sized to the pre-fix failure rate).

## Output format

A **Race Proof**: `Serial vs Concurrent baseline` (N runs each, failure counts), `Shared-State Inventory` (state item → read site → suspension point → write site, file:line), `Pattern Classification` per candidate, `Forcing Evidence` (injected-delay or stress result making failure deterministic/frequent), `Fix Mechanism` (named pattern-matched primitive), `Reverification` (forced test + stress run counts, 0 failures).

## Quality gate

PASS only if the failure was made deterministic or high-frequency on demand BEFORE the fix, and the same forcing setup passes AFTER the fix. FAIL if the evidence is only "ran it 10 times and it didn't fail again," if the fix contains a sleep/timeout as the synchronization mechanism, or if any inventoried read→await→write window is left unclassified.

## Integration

- Extends **debug-isolator**: step 1 is the branch point — deterministic bugs go back there; this skill owns the non-deterministic branch.
- Forcing the interleaving is **adversarial-disproof** in executable form: actively try to make the code fail.
- Use **statistical-analysis** to size reverification runs (pre-fix failure rate p → run count giving high confidence of detecting a survivor).
- Idempotency fixes on request handlers change retry semantics — run **api-contract-verifier** on the affected endpoint.
- DB-level fixes (unique constraints, version columns) are schema changes — route through **migration-safety**. Completion requires **verified-done** with the Race Proof attached.

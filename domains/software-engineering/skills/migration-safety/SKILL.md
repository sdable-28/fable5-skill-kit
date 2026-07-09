---
name: migration-safety
description: Safety protocol for database schema and data migrations — ALTER TABLE, adding/dropping columns or indexes, backfills, type changes, splitting tables, renaming under live traffic. Trigger phrases: "add a column", "write a migration", "change the column type", "backfill", "drop this table", "add an index to production". Do NOT use for application-code-only changes, for throwaway local/dev databases with no data worth preserving, or for read-only query optimization with no DDL — that needs no migration gate.
---

# Migration Safety

## When invoked

1. Establish the deploy topology first: does old application code run against the new schema at any moment (rolling deploy, replicas, canary)? If yes — and it almost always is — every migration must be compatible with BOTH the previous and next code version. Design for N/N+1 compatibility, not for the end state.
2. Decompose every rename, type change, or NOT NULL addition into expand–contract steps, each independently deployable: (a) expand — add the new column/table nullable, (b) dual-write from code, (c) backfill in batches, (d) switch reads, (e) contract — drop the old column in a LATER release, never the same one. A single-step rename under live traffic is an automatic redesign.
3. Audit lock behavior per statement on the actual engine and version: which statements take exclusive locks and for how long at production table size (e.g., adding an index without CONCURRENTLY/ONLINE, volatile column defaults on older engines, type changes forcing table rewrites). State the expected lock class for every DDL statement. Unknown lock behavior = look it up, not guess.
4. Write the rollback before the forward migration. For each step, classify: reversible (write the down-migration and state whether it loses data), or irreversible (dropped column data, lossy type narrowing) — irreversible steps require an explicit backup/snapshot named in the plan and must land in their own release.
5. Batch all backfills with a bounded chunk size, progress checkpoint, and throttle; a backfill must be resumable after being killed mid-run. Verify with a count/checksum query comparing source and target after completion.
6. Rehearse against realistic scale: run the full migration on a copy or staging DB with production-comparable row counts, and record wall-clock time per step. A migration timed only on a 100-row dev table is untested.

## Output format

A **Migration Plan** with: `Topology Assumption` (N/N+1 statement), `Step Table` (each step → DDL/code/backfill, release it ships in, lock class, expected duration at prod scale), `Rollback per Step` (down-migration or named backup), `Backfill Verification Query` + expected result, `Rehearsal Evidence` (timings from realistic-scale run).

## Quality gate

PASS only if: (a) every step is N/N+1 compatible or explicitly justified as maintenance-window-only, (b) every irreversible step has a named backup and its own release, (c) rehearsal timings exist from a realistic-scale run, and (d) the backfill verification query and its result are recorded. FAIL any plan that renames or drops in the same release that stops writing to the old shape.

## Integration

- The Migration Plan is the **plan-gate** artifact for schema work — no DDL is written before it exists.
- Rehearsal timings and verification queries are the **evidence-reasoning** record; "it should be fast" is not evidence.
- Apply **adversarial-disproof** to step ordering: for each moment mid-deploy, ask "what breaks if old code runs now?"
- Schema changes that alter serialized shapes consumed elsewhere also trigger **api-contract-verifier**.
- Post-migration count/checksum mismatches route into **debug-isolator** (bisect the data axis), and completion goes through **verified-done** with the plan's evidence attached.

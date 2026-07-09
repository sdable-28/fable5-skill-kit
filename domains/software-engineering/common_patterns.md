# Software Engineering — Common Task Patterns

## 1. Debugging from an incomplete stack trace
**Trigger:** Error report with a truncated/async-swallowed trace, a symptom without a line number, or "works locally, fails in prod."
**Approach:** 1. Reproduce before theorizing — script the failing input; if you cannot reproduce, instrument first (structured logs at boundaries), fix nothing. 2. Binary-search the failure surface: disable half the pipeline (feature flag, stub, commit bisect) and rerun. 3. Shrink to a minimal reproduction — smallest input, fewest components, one process. 4. State one falsifiable hypothesis; add an assertion that would fail if it is true; run. 5. Fix, then re-run the original reproduction AND the minimal case.
**Checklist:** `[ ] repro script exists  [ ] git bisect or component bisect done  [ ] minimal case < 30 lines  [ ] hypothesis written before fix  [ ] regression test committed with fix`
**Variation:** Race conditions vanish under instrumentation (heisenbugs). If adding a log "fixes" it, suspect ordering/timing — reach for stress loops (`for i in {1..500}`), thread sanitizers, or deterministic schedulers, not more prints.

## 2. Adding an endpoint to an existing API
**Trigger:** New client need, new resource, or an existing endpoint being overloaded with query params it was never designed for.
**Approach:** 1. Find the nearest existing endpoint and copy its conventions (auth middleware, error envelope, pagination style) — do not invent a second style. 2. Define the contract first: method, path, request/response schema, status codes, idempotency behavior for non-GET. 3. Decide versioning impact: additive fields are safe; changed semantics require a new version or a new path. 4. Implement validation → authz → business logic → serialization, in that order. 5. Add rate-limit class and a contract test before wiring the client.
**Template:** `METHOD /v{N}/resource — auth: __ — idempotent: Y/N (key: __) — 2xx: __ — 4xx cases: __ — pagination: __ — rate class: __ — breaking? N (else new version)`
**Variation:** The "temporary" internal endpoint that skips auth or validation and ships to prod. Every endpoint gets the full middleware chain on day one; there is no internal-only in a networked service.

## 3. Diagnosing an N+1 / slow query
**Trigger:** Endpoint latency scales with result-set size; DB CPU spikes; ORM in the loop.
**Approach:** 1. Turn on query logging for one request; count queries — >10 similar queries is N+1. 2. Capture `EXPLAIN ANALYZE` on the hot query with production-shaped data (not a 100-row dev DB). 3. Fix in preference order: eager-load/join at the ORM layer → add covering index → denormalize/cache. 4. Verify query count and p95 latency after, on the same dataset.
**Checklist:** `[ ] query count before/after recorded  [ ] EXPLAIN shows index scan not seq scan  [ ] index write-cost accepted (table write rate checked)  [ ] fix tested at 10x current row count`
**Variation:** Adding an index that the planner ignores because of a function-wrapped column, mismatched collation, or low cardinality. Always confirm with EXPLAIN after — never assume the index is used.

## 4. Writing a schema migration
**Trigger:** Model change, new feature needing columns/tables, or a rename/type change on live data.
**Approach:** 1. Classify: additive (safe), destructive (drop/rename — needs multi-deploy), or transform (backfill — needs batching). 2. For destructive/transform, use expand-migrate-contract: add new column → dual-write from code → backfill in batches with progress logging → switch reads → drop old column in a later release. 3. Never lock a large table: no `ALTER ... NOT NULL` with default on huge tables without the concurrent path; create indexes `CONCURRENTLY`. 4. Write the down-migration or explicitly document why rollback is forward-only.
**Template:** `Migration: __ — class: additive/destructive/transform — lock risk: __ — deploy steps: 1) expand 2) dual-write 3) backfill (batch __ rows) 4) contract — rollback: __`
**Variation:** Backfill and code deploy racing each other — code reads the new column before backfill finishes. Gate the read path on flag or null-check until backfill is verified complete.

## 5. Reviewing a pull request
**Trigger:** Review request; also self-review before merging your own branch.
**Approach:** 1. Read the description and linked issue; reject scope you cannot map to it. 2. First pass for correctness only: boundary conditions, error paths, concurrency, null/empty inputs. 3. Second pass for blast radius: callers of changed signatures, shared state, migration ordering, config differences per environment. 4. Check tests assert behavior, not implementation — a test that mirrors the code line-by-line proves nothing. 5. Separate blocking defects from style preferences; label each comment as one or the other.
**Checklist:** `[ ] every changed public signature — callers checked  [ ] error paths tested  [ ] no secrets/credentials in diff  [ ] injection/authz on new inputs (OWASP)  [ ] backward compat: old clients survive this deploy  [ ] feature-flagged if risky`
**Variation:** Rubber-stamping large diffs. If the PR exceeds ~400 changed lines, request a split or review commit-by-commit — approval quality collapses past that size, and the correctness bugs live in the middle files nobody reads.

## 6. Isolating an environment-specific bug
**Trigger:** "Works on my machine" / passes CI but fails staging / fails only in one region or container.
**Approach:** 1. Diff the environments explicitly: env vars, dependency lockfile versions, OS/libc, timezone/locale, resource limits, data shape. Write the diff down — do not eyeball. 2. Reproduce the failing environment locally via container image parity (same base image, same env file). 3. Bisect the diff list: apply one environment difference at a time to the working setup until it breaks. 4. Fix by removing the divergence (pin the version, set the var in all envs), not by patching around the symptom.
**Template:** `Env diff table: var/dep/limit | works-env value | fails-env value | ruled out? — first divergence that reproduces: __`
**Variation:** Timezone and locale bugs masquerading as data corruption (date parsing, string collation ordering). Check `TZ`/locale first when the failure involves dates, sorting, or case-insensitive comparison.

## 7. Untangling a circular dependency
**Trigger:** Import error at startup, build-order failure, or a refactor blocked because module A and B require each other.
**Approach:** 1. Draw the actual cycle: list each import edge, not the assumed ones. 2. Identify what each side truly needs from the other — usually one type or one function, not the whole module. 3. Break with the cheapest move that fits: extract the shared piece into a third module → invert with an interface/protocol the consumer defines → last resort, deferred import at call site with a comment explaining why. 4. Add a lint rule or import-order check so the cycle cannot silently return.
**Checklist:** `[ ] cycle edges enumerated  [ ] minimal shared surface identified  [ ] extraction module has no back-imports  [ ] import-cycle check added to CI`
**Variation:** "Fixing" the cycle by moving imports inside functions everywhere. One deferred import is a documented tactical fix; five is an undiagnosed design problem — the shared abstraction still needs extracting.

# Software Engineering — Verification Gates

Pass/fail gates specific to software work. Apply the gates matching the task type before declaring done. Every "how to check" is an executed command or a mechanical inspection — never a judgment call about intentions.

---

## Gate 1 — Reproduction Gate (bug fixes)

**Pass:** The failure was observed directly in this session BEFORE the first fix edit: a failing test run, an error in a served request, a crash with the reported stack trace, or a query returning wrong data — captured in the transcript. After the fix, the identical trigger produces the correct behavior, also captured.

**Fail:** Fix written from the bug description alone. "This should fix it" with no before/after observation. Reproduction attempted only after editing (contaminated baseline).

**How to check:** Transcript order must be: trigger → observed failure output → edit → same trigger → observed success output. If reproduction was impossible (needs prod-only state), the deliverable must explicitly say "UNREPRODUCED — fix is hypothesis-grade" and name what evidence would confirm it in production.

---

## Gate 2 — Regression-Proof Test Gate

**Pass:** At least one automated test exists that fails on the pre-change code and passes on the post-change code, and this bidirectional property was demonstrated (run the test with the fix stashed/reverted, watch it fail; restore, watch it pass) — or an explicit, stated reason why a test is not feasible (e.g., requires live third-party sandbox) with a named manual verification substitute.

**Fail:** New test that also passes without the fix (tests nothing). Test asserting only that mocks were called. "Existing tests cover this" without naming which test and confirming it exercises the changed branch.

**How to check:** `git stash && <run new test> && git stash pop && <run new test>` — first run must fail, second must pass. For coverage claims: run the named existing test with a deliberately broken version of the fix; it must fail.

---

## Gate 3 — Diff Hygiene Gate

**Pass:** Every hunk in `git diff` traces to the stated task. No formatting-only hunks, no renames, no import reordering, no commented-out code, no debug prints, no stray files (editor swap, `.env`, build artifacts). Lockfile changes only if the task was a dependency change.

**Fail:** Any hunk whose removal would not affect the task's outcome. `console.log`/`print(` debugging left in. TODOs added without an owner/task reference. Whitespace churn from format-on-save.

**How to check:** Read the full `git diff` hunk-by-hunk and state the task-link for each file. `git diff --stat` file list must match the plan's file list or the delta must be explained. Grep the diff for `console.log|print(|debugger|TODO|FIXME|XXX` and justify every hit.

---

## Gate 4 — Behavioral Execution Gate

**Pass:** The changed code path was executed in a running context, not only under test: server started and endpoint curled with the response inspected; CLI invoked with real args; worker processed a real job; migration applied to a real (local) database and the schema inspected; UI change loaded in a browser and the element observed. Output is in the transcript.

**Fail:** "Tests pass" as the sole evidence. App never booted after the change. Migration written but never applied anywhere. Frontend change verified only by reading the JSX.

**How to check:** Transcript contains the boot/serve/invoke command AND its observed output after the final edit. For web: an HTTP status + response body, or a screenshot. For DB: `\d table` / `PRAGMA table_info` output post-migration.

---

## Gate 5 — Blast Radius Gate

**Pass:** Before the change was finalized: all callers of every modified function were enumerated (Grep/CodeGraph output in transcript) and each was either confirmed compatible or updated; all consumers of any changed schema/API response/event payload/serialized format were enumerated the same way; the count of affected sites equals the count of handled sites (N/N accounting).

**Fail:** "I don't think anything else calls this." Changed a shared type/interface without searching for implementers. Renamed/removed a field that appears in a persisted format (DB, cache, queue message, localStorage) without a compatibility story for already-persisted old-format data.

**How to check:** Transcript contains the caller/consumer search with its result count, and an explicit disposition per site. Special check for persisted formats: ask "does data written by the OLD code still exist anywhere the NEW code will read?" — the answer must be written down.

---

## Gate 6 — Security Boundary Gate (any diff touching input handling, auth, output rendering, SQL, shell, files, deserialization)

**Pass:** Checked against the applicable OWASP classes at code level, on the diff:
- **Injection (A03):** all SQL uses parameterized queries/ORM binding — zero string interpolation into SQL (`f"... {x}"`, `"..." + x`, `%` into query strings). Shell invocations use arg arrays, never interpolated strings. Example failure: `cursor.execute(f"SELECT * FROM users WHERE id = {user_id}")` → must be `cursor.execute("SELECT * FROM users WHERE id = %s", (user_id,))`.
- **XSS (A03):** no `dangerouslySetInnerHTML`/`innerHTML`/`v-html`/`| safe`/`mark_safe` on data that ever touched user input; if unavoidable, sanitization library named and applied at the render site.
- **Broken Access Control (A01):** every new endpoint/handler names its authorization check; object access verifies ownership (`WHERE id = ? AND user_id = ?`), not just authentication — IDOR check: can user A retrieve object B by changing an ID?
- **Auth failures (A07):** passwords only via bcrypt/argon2/scrypt; tokens compared with constant-time comparison; session fixation on privilege change considered.
- **SSRF (A10):** any server-side fetch of a user-supplied URL validates scheme + host against an allowlist and blocks internal ranges (169.254.0.0/16, 10/8, 172.16/12, 192.168/16, localhost).
- **Cryptographic failures (A02):** no secrets in code or logs; no MD5/SHA1 for passwords; TLS not disabled (`verify=False`, `rejectUnauthorized: false` are automatic failures).
- **Insecure deserialization (A08):** no `pickle.loads`/`yaml.load` (unsafe loader)/`eval`/`Function()` on external data.

**Fail:** Any single item above present in the diff, regardless of "it's internal-only" or "it's behind auth."

**How to check:** Grep the diff (not the repo) for: `execute(f"`, `execute("+`, `innerHTML`, `dangerouslySetInnerHTML`, `v-html`, `mark_safe`, `|safe`, `pickle.loads`, `yaml.load(`, `eval(`, `verify=False`, `rejectUnauthorized`, `shell=True`, `os.system`, `md5`, hard-coded strings matching key/token patterns. Every hit gets an explicit verdict.

---

## Gate 7 — Query & Data Access Gate (any diff touching DB access or adding loops over fetched data)

**Pass:** Every loop containing a query/ORM relation access/awaited fetch is either batched (JOIN, `IN`, `select_related`/`joinedload`, dataloader) or annotated with the expected maximum N and why it is acceptable. Every new query against a table expected to exceed ~10k rows has its plan checked (`EXPLAIN`/`EXPLAIN ANALYZE`) or its index named. New migrations adding columns to large tables state the lock behavior (e.g., Postgres `ADD COLUMN ... DEFAULT` semantics for the target version).

**Fail:** Relation access inside a loop with no batching decision. `SELECT *` in new code feeding a hot path. New `WHERE` clause on an unindexed column of a large table with no plan check. Migration that rewrites or locks a large table during business hours with no mention of it.

**How to check:** Inspect every loop in the diff for query calls. For flagged queries: run `EXPLAIN` against a local DB with representative row counts, or cite the covering index by name from the schema. Query-count check where infrastructure allows: enable query logging, execute the flow once, report the count.

---

## Gate 8 — Concurrency & Idempotency Gate (any diff touching async code, shared state, queue/webhook/cron handlers, or retry paths)

**Pass:** Every read-modify-write on shared state across an await/network boundary names its atomicity mechanism (DB atomic update, `SELECT FOR UPDATE`, unique constraint + upsert, CAS, lock, single-writer design). Every handler that can be invoked more than once for one logical event (at-least-once queues, webhooks, client retries, cron overlap) names its idempotency mechanism or carries an explicit stated exemption. Every new lock acquisition states its ordering relative to other locks (deadlock check).

**Fail:** `x = await read(); await write(f(x))` on contended state with no mechanism named. Check-then-insert without a unique constraint. Webhook handler that creates records keyed only by auto-increment ID. "It's unlikely two requests hit this at once" as the argument.

**How to check:** For each flagged site, write the two-actor interleaving explicitly (Actor A at step n, Actor B at step m → resulting state) and show the mechanism prevents the bad state. If the interleaving cannot be written down, the analysis has not been done — gate fails.

---

## Gate 9 — Deploy-Order & Rollback Gate (schema changes, API contract changes, message format changes)

**Pass:** The change is safe under rolling deploy: code version N works against schema/format version N and N+1; migration applies cleanly against a copy of the current schema; a one-sentence rollback story exists ("git revert + deploy" / "flip flag X" / "run down-migration Y, which is lossless because Z"). API changes are additive, or versioned, or all consumers were enumerated and migrate in lockstep by proof (Gate 5).

**Fail:** Destructive migration (drop/rename column, change type) in the same unit as the code change that requires it. Down-migration that loses data without saying so. Removed/renamed API response field with external consumers. "Rollback: restore from backup" for a routine change.

**How to check:** Answer in writing: (1) Old code + new schema — works? (2) New code + old schema — works? (3) Exact rollback command? Any "no" without a flag/versioning mitigation fails the gate.

---

## Gate 10 — Build & Toolchain Cleanliness Gate

**Pass:** The project's own quality commands (discovered from CI config, Makefile, package.json scripts, pyproject — not assumed) were run on the touched scope and pass: type checker zero new errors, linter zero new warnings on changed files, build succeeds, the affected package's test suite passes. Pre-existing failures on unmodified main are documented as pre-existing with proof (same failure reproduced on a clean checkout/stash of the change).

**Fail:** Running a guessed command instead of the project's configured one (e.g., `pytest` when CI runs `pytest -m "not slow" --cov`). Ignoring type errors as "pre-existing" without verifying they exist on main. Skipping the linter because the code "looks clean."

**How to check:** Cite the source of each command (`.github/workflows/*.yml`, `Makefile`, `package.json`) and paste the passing output. For pre-existing-failure claims: transcript shows the same failure with the change stashed.

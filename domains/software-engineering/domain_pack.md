# Software Engineering — Domain Pack

Internal operating instructions. Imperative. Binding for every task in this domain.

---

## 1. Domain Overview

### What makes this domain unique for AI

Software engineering is the one domain where the work product is executable and therefore **self-verifying**. A claim about code can almost always be checked mechanically — run the test, run the type checker, run the query with `EXPLAIN`, curl the endpoint. Exploit this constantly. Never assert what can be executed.

Three properties distinguish this domain from every other:

1. **The codebase is the ground truth, not the documentation, not the ticket, not memory.** Comments lie. READMEs rot. The ticket describes what someone believed three weeks ago. The only reliable source is the code as it exists at HEAD, plus the observed behavior of the running system. Every investigation starts by re-establishing ground truth, never by trusting a description of it.
2. **Changes have non-local blast radius.** Editing one function can break a caller four modules away, a serialized format read by another service, a database migration ordering, or a CI pipeline. The cost of a change is dominated by its unseen couplings, not its visible diff. Map the coupling before touching the line.
3. **State is invisible and history matters.** A running system carries caches, connection pools, in-flight requests, half-applied migrations, and environment variables that no file shows. Bugs that "cannot happen" from reading the code happen because of state the code does not display.

### Where AI adds most value

- **Exhaustive mechanical search**: finding every caller, every implementer of an interface, every place a config key is read. Humans sample; do this exhaustively via Grep/CodeGraph/Glob.
- **Cross-layer tracing**: following a request from HTTP handler through service layer, ORM, SQL, and back — holding the entire path in working memory at once.
- **Systematic hypothesis elimination in debugging**: humans anchor on their first theory; run the full elimination protocol without emotional attachment.
- **Boilerplate-heavy, pattern-following work**: migrations, test scaffolding, API client generation, applying a known fix across N call sites.
- **Reading unfamiliar code fast**: onboarding into a codebase in minutes and producing an accurate structural map.

### Where to defer to human expertise

- **Product intent and priority.** Whether a behavior is a bug or a feature is a business decision. When code and ticket disagree, surface the conflict; do not silently pick.
- **Irreversible production actions.** Deploys, destructive migrations (`DROP`, `DELETE` without `WHERE`-verified backups), force-pushes, secret rotation. Present the plan and command; the human pulls the trigger unless explicitly pre-authorized.
- **Trade-offs with organizational context.** "Should we take on this dependency" depends on team skills, vendor relationships, and roadmap — data not present in the repo. Present the trade-off table; let the human weigh it.
- **Anything touching money, auth, or PII where the spec is ambiguous.** Ambiguity in a security-sensitive path is a stop-and-ask, never a judgment call.

---

## 2. Core Principles

Each is falsifiable — compliance can be checked from the transcript.

1. **Reproduce before you fix.** No bug fix ships until the failure has been observed directly (test run, log line, curl output) in this session. If the bug cannot be reproduced, the deliverable is a reproduction attempt report, not a speculative fix. *Check: transcript contains the failing output before the first edit.*

2. **Read the failing line before theorizing about it.** When a stack trace names `file:line`, read that exact location plus 20 lines of context before proposing any cause. *Check: a Read of the named location precedes the first hypothesis.*

3. **Map before edit.** Before modifying any function, enumerate its callers and any serialized/persisted representations of its output (DB rows, cache entries, API responses, files). One Grep/CodeGraph query minimum. *Check: caller enumeration appears in transcript before the Edit.*

4. **One behavioral change per commit-sized unit.** A diff that fixes a bug does not also rename variables, reorder imports, or reformat. If the formatter fires on save, revert unrelated hunks. *Check: every changed hunk traces to the stated task.*

5. **Never claim "done" without executed evidence.** "Done" requires: the relevant test/command was run in this session, its output is in the transcript, and the output shows the intended behavior. Type-checking alone is not evidence of behavior. *Check: verification command output appears after the final edit.*

6. **Match the codebase, not your preference.** Detect the existing conventions (error handling style, test framework, naming, directory layout) and follow them even when you know a "better" way. Introducing a second pattern is a defect. *Check: new code is indistinguishable in style from adjacent code.*

7. **Treat all input as hostile at trust boundaries.** Every value crossing from user/network/file into the system gets validated or parameterized at the boundary. String-concatenated SQL, unsanitized HTML interpolation, and `eval` on external input are automatic failures regardless of context. *Check: grep the diff for interpolation into SQL/HTML/shell.*

8. **Additive before destructive in schemas and APIs.** Add the new column/field/endpoint, migrate readers, migrate writers, then remove the old — never in one step. A migration that cannot run against yesterday's code is deployed wrong. *Check: each migration step is independently deployable and reversible.*

9. **Idempotency is the default for anything that can retry.** Handlers behind queues, webhooks, cron jobs, and payment paths must produce the same end state when executed twice. If a handler is not idempotent, say so explicitly and justify it. *Check: for every new async/queue/webhook handler, the transcript states the idempotency mechanism (key, upsert, dedup table) or the explicit exemption.*

10. **N+1 is checked, not assumed absent.** Any code that loops over a collection and touches the ORM/DB/HTTP inside the loop is flagged and either batched or explicitly justified with the expected N. *Check: loops containing `await`/query calls in the diff have a stated batching decision.*

11. **Concurrency claims require a interleaving argument.** Any statement like "this is thread-safe" or "no race here" must be accompanied by the specific reason (single-threaded event loop, lock held, atomic operation, immutable data). "It looks fine" is not an argument. *Check: shared mutable state in the diff has a named synchronization mechanism.*

12. **Feature-flag anything risky enough to need a rollback story.** If a change alters behavior for existing users and cannot be reverted by a single `git revert` + deploy within minutes, it goes behind a flag or a config default that preserves old behavior. *Check: risky behavior changes name their rollback mechanism.*

13. **Version pins and lockfiles are law.** Never upgrade a dependency as a side effect of another task. Dependency changes are their own task with their own verification. *Check: lockfile diffs appear only in tasks explicitly about dependencies.*

14. **Errors carry context or they are bugs.** Every caught exception is either re-raised with added context, logged with enough state to reproduce (IDs, inputs — never secrets), or handled with a specific recovery. Bare `except: pass` and swallowed promise rejections are defects. *Check: grep the diff for empty catch blocks and `.catch(() => {})`.*

15. **State the assumption before acting on it.** Every inference about unobserved behavior ("this queue delivers at-least-once", "this field is never null in prod") is written down as an assumption with a confidence level before code depends on it. *Check: assumptions section exists in any non-trivial plan.*

---

## 3. Master Framework — Software Engineering Adaptation

### Stage 1 — Understand

Establish ground truth before interpreting the request.

- Restate the task as an observable behavior change: "currently X happens when Y; after this change, Z happens when Y." If you cannot write this sentence, the task is under-specified — ask.
- Identify the task type immediately: bug fix, feature, refactor, migration, investigation, review. Each has a different done-criterion and a different first move.
- Locate the ground truth: which repo, which branch, which environment exhibits the behavior. `git log --oneline -10`, `git status`, check for uncommitted changes that might already address the task.
- For bugs: obtain the exact error text, the version/commit it occurred on, and whether it reproduces on HEAD. A bug report against a 3-week-old deploy may already be fixed.
- **Tools:** `git log/status/blame`, issue text, Read on the named files only, CodeGraph/Graphify query for the named symbols.

### Stage 2 — Decompose

Break by risk and by deployability, not by file.

- Split into units that are independently verifiable: each unit has its own "how I'll know it works" command.
- Order units so the riskiest unknown is resolved first (the spike). If success depends on a third-party API behaving a certain way, prove that with a 10-line script before building around it.
- Separate mechanical changes (rename, move, apply pattern to N sites) from judgment changes (new logic). Never interleave them in one unit.
- For schema/API changes, decompose along the expand-migrate-contract axis: each phase is a separate unit.
- **Tools:** CodeGraph for dependency ordering, Grep for counting affected sites (the count IS the decomposition input).

### Stage 3 — Plan

The plan names files, functions, and verification commands — not intentions.

- For each unit: files to touch, functions/symbols to change, new symbols to create, and the exact command that proves it works.
- Enumerate blast radius: callers of every changed function, consumers of every changed schema/API/event, tests that cover the touched paths. This list comes from Grep/CodeGraph queries executed now, not from memory.
- Write the assumptions list with confidence: "assuming `user_id` is unique per session (confidence: high, enforced by DB constraint at schema.sql:42)".
- Decide the rollback story before writing code: revert-safe? flag-gated? migration-reversible?
- For anything ambiguous with ≥2 defensible interpretations, present both and stop.
- **Tools:** CodeGraph `context`, Grep with counts, existing test suite inventory (`Glob **/test_*`, `**/*.test.*`).

### Stage 4 — Execute

- Follow the plan's unit order. Finish and verify one unit before starting the next.
- Read before every edit: the exact function, its imports, its nearest test. Edit with surgical diffs.
- When reality contradicts the plan (a caller you didn't expect, a test that constrains behavior), stop, update the plan, note the delta. Do not improvise around it silently.
- Run the fastest relevant feedback loop after every meaningful edit: the single test file, the type checker on the changed module, the linter on the diff — not the whole suite every time, but never zero.
- Keep a scratch file of deferred observations ("noticed dead code in utils.py — out of scope") instead of fixing them inline.
- **Tools:** Edit, targeted test runs, language servers/type checkers, `git diff` review of own changes before declaring a unit done.

### Stage 5 — Verify

Verification is adversarial, layered, and executed — never inferred.

1. **Static layer:** type checker, linter, build — zero new warnings on touched files.
2. **Unit layer:** run tests covering changed code. If no test covers it, write one that fails on the old code and passes on the new (run both directions when feasible: `git stash` the fix, watch the test fail, restore).
3. **Behavioral layer:** exercise the actual flow — start the server and curl it, run the CLI, execute the query against a real dataset. Tests passing while the app crashes on startup is a known failure mode.
4. **Regression layer:** run the broader suite for the affected package. Read failures fully; "flaky" is claimed only with evidence (the test fails on unmodified main too — prove it).
5. **Diff audit:** read the entire `git diff` line by line as if reviewing a stranger's PR. Every hunk must trace to the task.
- **Tools:** test runners, `git diff`, curl/httpie, `EXPLAIN ANALYZE` for query changes, browser/Playwright for UI changes.

### Stage 6 — Self-Correct

- When verification fails, resist patching the symptom. Re-enter the debugging protocol: what is the actual observed failure, what did I assume, which assumption does this falsify.
- Two consecutive failed fix attempts on the same symptom = mandatory stop. Re-read the original error, list every assumption made so far, and identify which one has not been directly verified. The bug is almost always inside an unverified assumption.
- If a fix required touching more files than planned, treat that as a design smell signal — reassess whether the approach is wrong before continuing to expand the diff.
- Revert freely. A clean revert plus a better approach beats a tower of compensating patches. `git stash`/`git checkout -p` are tools, not defeats.

### Stage 7 — Iterate

- After the task: state what was verified, what was NOT verified (untested paths, environments not exercised), and any observations deferred.
- Update indexes and living docs that the codebase mandates (e.g., code-search indexes after edits; task lists; changelogs).
- Capture falsifications explicitly: if the investigation disproved a theory ("the leak is NOT in the connection pool — proven by X"), record it so no future session re-runs the dead end.
- Propose, do not perform, follow-up work discovered along the way.

---

## 4. Pitfalls Checklist

1. **The Sympathetic Edit**
   - *Looks like:* Task says "fix the null check in `parse_order`"; the diff also renames `ord` to `order`, adds type hints to two neighbors, and reformats the file because the formatter ran.
   - *Detection:* `git diff` contains hunks with no causal link to the stated task.
   - *Prevention:* Review own diff hunk-by-hunk before declaring done; revert every hunk that doesn't trace to the request. Disable format-on-save effects with `git checkout -p` if needed.

2. **Fixing the Stack Trace's Last Frame**
   - *Looks like:* `TypeError: 'NoneType' has no attribute 'id'` at `notify.py:88` → adding `if user is None: return` at line 88, when the real bug is `get_user()` returning None for soft-deleted users three calls up.
   - *Detection:* The fix adds a null/error guard at the crash site without explaining why the value was invalid.
   - *Prevention:* Trace the invalid value to its origin. The fix belongs where the invariant was broken, not where it was noticed. Ask: "what SHOULD have prevented this value from existing?"

3. **The Green-Tests Mirage**
   - *Looks like:* All tests pass; the app fails at import time in production because the new module imports a dev-only dependency, or the migration was never applied to the test DB.
   - *Detection:* No transcript evidence of the application actually starting/serving after the change.
   - *Prevention:* Behavioral layer of verification is mandatory: boot the app, hit the endpoint, run the job once. Tests + one real execution, always.

4. **N+1 by ORM Innocence**
   - *Looks like:* `for order in user.orders: total += order.items.count()` — reads as clean code, executes 1+N+N queries. Ships fine on a 10-row dev DB, melts at 10k rows.
   - *Detection:* Any loop body containing an ORM attribute access on a relation, a `.get()`, or an awaited fetch. Enable query logging locally and count queries for one request.
   - *Prevention:* Batch at the boundary: `select_related`/`joinedload`/dataloader/`IN` query. State the expected N for any loop left unbatched.

5. **Await-Gap Race**
   - *Looks like:* `balance = await get_balance(); await set_balance(balance + amount)` — two concurrent requests read the same balance; one write is lost. Also: check-then-create without a unique constraint ("if not exists → insert" firing twice).
   - *Detection:* Read-modify-write across an `await`/network boundary on shared state; check-then-act on data another request can mutate.
   - *Prevention:* Push atomicity to the storage layer: `UPDATE ... SET x = x + ?`, `INSERT ... ON CONFLICT`, `SELECT ... FOR UPDATE`, compare-and-swap, or a distributed lock — named explicitly in the diff.

6. **Cache Invalidation Half-Truth**
   - *Looks like:* New write path added for `user.email`; the read path serves `user:{id}` from Redis with 1h TTL. Email changes appear to "not save" for up to an hour, but only for some users, only sometimes.
   - *Detection:* Grep for every cache key pattern touching the entity being written. If a write path exists that does not invalidate/update a cache that reads the same entity, it's a bug.
   - *Prevention:* Maintain the rule "every new write path enumerates the caches of what it wrote." Search by entity name across the codebase before finishing any write-path change.

7. **Migration/Code Deploy-Order Coupling**
   - *Looks like:* One PR renames the column in the migration AND in the code. During rolling deploy, old pods query the new schema (crash) or new pods query the old schema (crash). Works perfectly in dev where migrate+restart is atomic.
   - *Detection:* A single diff that both alters a schema destructively and changes the code reading it.
   - *Prevention:* Expand-migrate-contract. Every migration must be compatible with the code version before AND after it. If it isn't, split the work.

8. **The Optimistic Third-Party Assumption**
   - *Looks like:* Assuming the payment webhook fires exactly once, the SDK's `list()` returns all items (it paginates at 100), or `library.parse()` doesn't mutate its input (it does — undocumented). Code is correct against the imagined API, wrong against the real one.
   - *Detection:* Any dependency behavior load-bearing to correctness that has not been observed directly or confirmed in the library's source.
   - *Prevention:* For load-bearing behavior: read the library source (it's on disk in `node_modules`/site-packages), or write a 5-line probe script. Log the assumption with confidence otherwise.

9. **Environment Split-Brain**
   - *Looks like:* "Works on my machine" — dev uses SQLite (no strict types), prod uses Postgres (strict); dev has `DEBUG=true` masking the error; the bug needs prod's TLS termination, timezone, or case-sensitive filesystem.
   - *Detection:* Bug reproduces in one environment only. That is not noise — the environment delta IS the clue.
   - *Prevention:* Diff the environments explicitly: DB engine + version, env vars, dependency versions (`pip freeze` both sides), OS/filesystem, proxy layers. Binary-search the delta.

10. **Circular Import Whack-a-Mole**
    - *Looks like:* Adding `from services.billing import charge` to `models/user.py` → `ImportError` that only fires on a specific entry point, "fixed" by moving the import inside the function, which hides the design defect and slows the hot path.
    - *Detection:* Import moved into function body, or `import` at bottom of file, without a stated reason.
    - *Prevention:* When two modules need each other, the shared concept belongs in a third module below both. Fix the layering, or explicitly document why the deferred import is the accepted trade-off.

11. **Retry Amplification / Non-Idempotent Replay**
    - *Looks like:* Queue consumer creates an invoice; consumer times out AFTER the DB write; broker redelivers; customer gets two invoices. Or: client retry on 504 double-submits an order.
    - *Detection:* Any handler behind at-least-once delivery (queues, webhooks, cron, HTTP retries) performing a non-idempotent write without a dedup key.
    - *Prevention:* Idempotency key stored transactionally with the side effect, or upsert semantics, or "check processed-set inside the same transaction." Name the mechanism in the diff.

12. **Slow Leak, Fast Blame**
    - *Looks like:* Memory grows over days; blamed on "the framework"; actual cause is an unbounded module-level dict used as a cache, listeners registered per-request and never removed, or a global list appended in a handler.
    - *Detection:* Grep for module-level mutable containers (`= {}`, `= []` at top level) written inside request/loop-scoped code; event `on(...)` without matching `off(...)`.
    - *Prevention:* Every long-lived container gets a bound (LRU, TTL, max size) at creation time. Every subscribe pairs with an unsubscribe in the same review.

13. **Timezone/Encoding/Locale Corner**
    - *Looks like:* Daily report job "skips a day" twice a year (naive datetime vs DST); filename with é breaks on the cp1252 Windows console; sorting differs between dev (en_US) and prod (C locale).
    - *Detection:* `datetime.now()` without tz, string comparisons feeding business logic, byte/str mixing at I/O boundaries.
    - *Prevention:* UTC-aware datetimes internally, convert at display edges only; explicit `encoding=` on every file/stream open; never let locale-dependent functions feed logic.

14. **Test That Tests the Mock**
    - *Looks like:* Test mocks `repository.save`, asserts `save` was called with X — while the real `save` would have rejected X (constraint violation). The test enshrines the bug.
    - *Detection:* Assertions only on mock call args; zero assertions on observable output/state; the test cannot fail if the real dependency's contract changes.
    - *Prevention:* Test through the thinnest real boundary affordable (in-memory DB, real serializer). Mock only what is genuinely external (network, clock, randomness). For every mock, ask: "what real contract am I now not checking?"

15. **Scope Creep via "While I'm Here" Refactor**
    - *Looks like:* Bug fix in a 400-line function → "this function is a mess" → 40-line diff becomes 600 lines of restructuring → the fix now cannot be reviewed, reverted, or cherry-picked, and introduced its own regression.
    - *Detection:* Diff size disproportionate to the behavioral change; moved code intermixed with modified code.
    - *Prevention:* Fix in the existing structure. File the refactor as proposed follow-up. If refactor is genuinely prerequisite, do it as a separate, behavior-preserving unit verified independently BEFORE the fix.

---

## 5. Sample Task Walkthrough

**Task:** "Users report that updating their notification email sometimes doesn't take effect — they keep getting notifications at the old address. Intermittent, more common for active users. Fix it." Stack: Python/FastAPI, PostgreSQL, Redis, Celery worker sending notifications.

**Stage 1 — Understand.** Restate as observable behavior: after `PATCH /users/me/email` returns 200, notifications must go to the new address; currently some go to the old address for an unbounded period. Classify: bug, intermittent, state-dependent — high suspicion of caching or async staleness, but suspicion is not evidence. Establish ground truth: `git log --oneline -10` on the service; confirm the reported behavior exists at HEAD, not just on an old deploy. Query CodeGraph for `notification email` and `update email` symbols; get `api/users.py:update_email` (write path) and `workers/notify.py:send_notification` (read path).

**Stage 2 — Decompose.** Units: (1) reproduce the staleness locally; (2) identify the exact stale read; (3) fix; (4) prove fix with a test that fails on old code; (5) audit for sibling instances of the same defect.

**Stage 3 — Plan + blast radius.** Read only the two functions plus 20 lines context. `update_email` writes the DB row and returns. `send_notification` calls `get_user_cached(user_id)`. Grep `get_user_cached` → `cache/users.py`: Redis key `user:{id}`, TTL 3600, populated on read. Hypothesis H1: write path never invalidates `user:{id}`. But do not stop at the first plausible story — enumerate rivals: H2: Celery task already carries the old email in its serialized args at enqueue time; H3: read replica lag. Check H2 now, because if the email is baked into task args, cache invalidation fixes nothing: Read the enqueue site — task is enqueued with `user_id` only, email resolved at send time. H2 eliminated with evidence. H3: repo uses a single DB in this deployment (settings show one DSN) — eliminated. Blast radius of the fix: Grep for every write to the `users` table (`update_email`, `update_profile`, admin panel `admin/users.py`) and every consumer of `user:{id}` key — three readers found.

**Stage 4 — Execute (reproduce first).** Local repro before any edit: start the stack, create a user, trigger one notification (warms cache), `PATCH` the email, trigger another notification. Observed: second notification logs the OLD address. Reproduction in hand — the "intermittent" pattern is explained: it only bites when the cache is warm, hence "more common for active users." Now fix: add cache invalidation in `update_email` — but choose delete-after-commit, not update-in-place (writing the new value into the cache from the request path races with a concurrent read-miss repopulating old data; delete is the safer primitive). Place `cache.delete(f"user:{user_id}")` after the DB transaction commits, not before (invalidate-then-commit leaves a window where a reader repopulates the cache with the pre-commit row). Apply the same invalidation to `update_profile` and the admin write path — same defect, three sites, found in the blast-radius grep.

**Stage 5 — Verify.** (a) New test: warm cache → update email → assert next resolution returns new email. Run it against the pre-fix code (`git stash`) — it fails with the old address; restore — passes. The test provably detects the bug. (b) Behavioral: rerun the manual repro end-to-end — second notification now logs the new address. (c) Race audit: is delete-after-commit still racy? Yes, narrowly — a reader that loaded the old row before commit can write it to cache after our delete. State this residual honestly: window is milliseconds and self-heals at TTL; eliminating it needs versioned keys or a distributed lock — out of scope, filed as follow-up with the interleaving written out. (d) Regression: run the user + cache + notification test modules; full diff audit — every hunk traces to the fix.

**What could go wrong and how it's caught:** Fixing only `update_email` (caught by the blast-radius grep for all `users`-table writers). Writing the fresh value to cache instead of deleting (caught by the race analysis in verification — this is the classic "fix that reintroduces the bug under concurrency"). Declaring done off the unit test alone (caught by the mandatory behavioral rerun — the Celery worker imports `get_user_cached` from a different module path; a bad patch target would pass unit tests and change nothing in the worker). Assuming H1 without eliminating H2 (caught by the rival-hypothesis step — had task args carried the email, the entire cache fix would have been theater).

**Stage 6/7.** No self-correction needed this run. Close out: report the residual race window explicitly, file the follow-up, note the third write path (admin) was also fixed, sync code indexes.

---

## 6. Integration with Core Skills

**Tier 1 — invoked on effectively every task:**

- **root-cause-first** — the backbone of Section 4's pitfalls 2 and top of every debugging task. Domain variation: "root cause" is defined as *the point where the invariant was first violated*, not where the error surfaced. Pair with the stack-trace rule: last frame is the symptom's address, rarely the cause's.
- **verified-done** — domain variation: verification means *executed* commands with output in transcript, layered static→unit→behavioral→regression (Stage 5). Type-check-only completion is a violation.
- **scope-fence** — domain variation: the fence is the `git diff`. Enforcement is mechanical: hunk-by-hunk audit, revert anything untraceable to the task. Deferred observations go to a follow-up list, never inline.
- **cartography-first** — domain variation: the map is callers + consumers + persisted representations, built from CodeGraph/Grep before any edit (Principle 3). Do not open implementation files until the structural map exists.
- **hypothesis-before-read** — before opening any file, state what you expect to find and why. If the file contradicts the expectation, that delta is signal — log it. Prevents drift-reading through a large codebase.

**Tier 2 — invoked on debugging and design tasks:**

- **adversarial-disproof** — the engine of hypothesis elimination in debugging. Domain variation: for each bug hypothesis, design the cheapest experiment that would *falsify* it (a log line, a bisect, a probe script), not the experiment that would confirm it. A hypothesis survives only by resisting disproof.
- **evidence-reasoning** — every causal claim in a debugging chain cites an observation (log line, test output, EXPLAIN plan). "Probably the cache" without an observation is a hypothesis, not a finding — label it as such.
- **assumption-flagging** — domain variation: dependency behavior, delivery semantics, environment parity, and data invariants ("this column is never null") are the four assumption classes that must always be flagged with confidence + verification cost.
- **self-correction-loop** — bound to the two-failed-fixes tripwire (Stage 6): two failed attempts on one symptom forces a full assumption re-enumeration, never a third patch.
- **plan-gate** — any change touching schemas, public APIs, auth, payments, or >5 files passes through an explicit plan with blast radius and rollback story before the first edit.

**Tier 3 — invoked on architecture and large-scope work:**

- **system-design / enterprise-architect** — feed the ADR pattern (see common_patterns.md P5): every significant decision gets context → options → trade-offs → decision → consequences, with at least two real options genuinely costed.
- **coverage-accounting** — for migrations and cross-cutting changes: the Grep count of affected sites is the denominator; track sites-converted/total explicitly until it reads N/N. Never "I think I got them all."
- **long-task-orchestration + context-budget-management** — for multi-day refactors/migrations: persist the site inventory and progress ledger to a file, since no single context window survives the task. Read targeted slices, never whole files (this codebase's Rule 0 is the hard form of this skill).
- **security-threat-modeling** — mandatory on any diff touching auth, session, file upload, deserialization, SQL construction, or HTML rendering. Run the OWASP checklist from verification_gates.md Gate 6 against the diff, not against intentions.
- **multi-agent-orchestration** — parallelize only truly independent units (per-package migrations, independent test suites). Never parallelize edits with a shared file or shared schema — merge conflicts and interleaved half-states cost more than the parallelism saves.
- **code-investigation** — the read-only sibling of this whole pack: when the deliverable is understanding rather than a diff, run Stages 1–3 and 5 (verification of claims against code), skip 4.

**Combination pattern for the modal task (bug fix):** cartography-first → hypothesis-before-read → root-cause-first → adversarial-disproof → scope-fence → verified-done. Skip none; abbreviate for trivial scope only after cartography confirms the scope is actually trivial.

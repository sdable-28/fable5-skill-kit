# Operating Manual — Running Opus 4.8 at Fable Effectiveness

This manual is for the human operator. It describes how to prompt, pace, and audit Opus 4.8 so that its output approaches Fable-grade reliability. The companion files (`system_prompt_opus.md`, `Master_Framework.md`, `Anti_Hallucination.md`, the skills library) are what you install; this is how you drive.

---

## 2.1 Prompting Patterns

### Short + "why" beats long spec
The model performs better with goal + motivation + constraint than with an exhaustive requirements list. The "why" lets it make correct micro-decisions you didn't anticipate; a long spec invites literal compliance with the letter and violation of the intent.

- **Weak:** "Add a function that checks if request_count exceeds 100 and if so sets a flag, and also check error_count >= 5, and make sure it's called from the request handler..."
- **Strong:** "Add a circuit breaker: stop calling the upstream service when it has returned 5 errors OR 100 requests in the window — protect our latency, don't try to be clever about recovery. It must fail-open (never block a request on the breaker's own error) like every other middleware. Wire it where the other request gates live."

The strong version transfers the design intent (fail-open, colocation with existing gates), so the model resolves edge cases the way you would.

### Negative specification
What NOT to do is as load-bearing as what to do, because the model's default failure is *doing more than asked*.

Always include the fence: "Do not refactor adjacent code." "Do not touch the payment module — it is locked." "Do not add error handling beyond the one case described." "Do not run the migration — tell me when the change is ready and I'll run it."

Example fence block to paste into risky tasks:
```
OUT OF SCOPE: any file not listed above; formatting changes; renaming;
"while I'm here" improvements; running long jobs; committing.
```

### Effort-anchoring phrases
The model calibrates depth from your verbs. Use them deliberately:

| Phrase | What it buys |
|---|---|
| "quick check" / "just tell me" | direct answer, no phases, no report |
| "look into" / "explain how X works" | cartography + targeted reads |
| "investigate thoroughly" / "find all gaps" | full 5-phase protocol, coverage accounting |
| "comprehensive audit" / "find everything wrong" | full protocol + adversarial verify + parallel agents |
| "full phase discipline" | explicit invocation of the Master Framework stages |

If you get a 5-section report for a yes/no question, your prompt lacked an effort anchor. If you get a two-line answer to an architecture question, same problem in reverse.

### Context injection: paste vs. trust
- **Paste** when the fact is volatile or session-local: today's config values, the error you just saw, the exact diff under discussion, a decision made three sessions ago.
- **Trust the model's tools** when the fact is on disk and indexed: code structure, function bodies, git history. Pasting stale code is worse than pasting nothing — the model will treat your paste as current truth.
- **Never paste and also ask it to verify the same thing** — pick one source of truth per fact.

### Multi-turn vs. single-turn
- **Single-turn** (one full spec): mechanical tasks with a known shape — "rename X across the repo", "write the migration for this schema change". The model doesn't need your feedback mid-flight.
- **Multi-turn** (break into steps): anything where step N's design depends on step N−1's findings — investigations, architecture, debugging. Forcing these into one turn makes the model commit to a plan before evidence exists. Rule of thumb: if you can't state the acceptance criterion for the whole task up front, it's multi-turn.

---

## 2.2 Effort Levels

| Level | Triggers | Protocol | Example |
|---|---|---|---|
| **Low** | "quick check", "what is X", one-file lookup | Search → read slice → answer. No phases, no report, no coverage list. | "What's the current default cache TTL?" |
| **Medium** | "review this", "explain how X works", "is this safe?" | Cartography of the touched area + targeted reads + evidence-anchored answer. Hypothesis-before-read on each file. | "Explain how a request flows from the API gateway to the auth service." |
| **High** | "find all gaps", "plan the implementation", "review the architecture" | Full 5-phase protocol (`code-investigation` skill): Brief → Cartography → Investigation → Gap Analysis → Adversarial Review. Coverage accounting mandatory. | "Audit the checkout path for idempotency gaps." |
| **Max** | "comprehensive audit", "find everything wrong", stakes = production/money | High protocol + adversarial disproof on every finding + parallel subagents per dimension + completeness critic pass ("what modality did we not run?"). | "Full audit of the payment lifecycle before we onboard enterprise customers." |

Escalate one level when: the output feeds a live-money decision; the model's first pass produced findings you can't independently check; or two sessions have disagreed about the same fact.

---

## 2.3 Memory and Lessons Systems

### MEMORY.md as index, files as facts
`MEMORY.md` holds one line per memory — title, link, hook. The fact itself lives in its own file with frontmatter (`name`, `description`, `type`). The index is loaded every session; the files are read on demand. Never put content in the index; never leave a new file unindexed.

### Memory types — when to write each
- **user**: who the operator is (timezone, expertise, standing preferences). Write once, update rarely.
- **feedback**: a correction or confirmed approach — *how the model should behave*. Must include **Why** and **How to apply**. Write immediately when the user corrects you; a correction not written down will be repeated.
- **project**: state not derivable from the repo — decisions with rationale, live account state, validated/falsified hypotheses, deployment status. Convert relative dates to absolute.
- **reference**: pointers — URLs, SSH strings, dashboard locations, tool invocations.

Do NOT save what the repo already records (code structure, git history) or what only matters this conversation.

### The falsification ledger — the highest-value memory
Keep a dedicated "FALSIFIED — do not repeat" section. Every disproven hypothesis goes there with the evidence. This is the single biggest compounding win: it prevents re-running dead research lines across sessions. A falsification entry needs: the exact claim, the evidence that killed it, and the date.

### Pre-compact hook protocol
When context compression is imminent, log BEFORE it happens (a hook should prompt this):
1. Every decision made this session, with why and outcome status.
2. Every falsification, with evidence.
3. Current task state: what's done, what's mid-flight, exact next action.
4. Any number that must survive verbatim (results, commits, balances).

Compression preserves gist, not precision. Precision goes to disk.

### Session handoff template
```
## Handoff — {date}
STATE: branch {x} @ {commit}; uncommitted: {files or "clean"}
DONE THIS SESSION: {1-3 bullets, each with verification status}
IN FLIGHT: {task} — next concrete action: {exact command or edit}
DECISIONS: {each: what, why, CONFIRMED/PENDING}
OPEN QUESTIONS: {things only the user can answer}
DO NOT: {any fence discovered this session}
```
A cold model must be able to resume from this alone, without transcript access.

---

## 2.4 Anti-Hallucination Protocols

(Full taxonomy in `Anti_Hallucination.md`; these are the operating habits.)

### The "I don't know" discipline
Correct output when evidence is absent: "I don't know; to find out I would {specific check}." Wrong output: a fluent guess. Instruct the model explicitly: *"If you're not sure, say so and tell me how to check — do not infer."* The model will comply, but the default pull is toward fluent completion; the instruction re-anchors it.

### The "let me verify" discipline
Before the model cites any specific fact — a line number, a config value, a function signature, a result figure — it must verify in-session, not recall. Watch for the tell: specific numbers appearing without a preceding tool call. Challenge those: "Where did that number come from?"

### Tool-use vs. model knowledge
Model knowledge is unreliable for: library versions and APIs (training-cutoff stale), anything that changed recently, precise numbers, your codebase's current state (it changes between sessions), and niche domains. Tool use is mandatory for all of these. Model knowledge is fine for: general concepts, standard algorithms, language semantics, well-established stable APIs.

### Cross-check for high-stakes claims
Any claim feeding a production or money decision needs two independent confirmation paths (e.g., the code says X *and* the log output shows X; the backtest CSV says Y *and* the summary recomputes to Y). One source = PLAUSIBLE, not VERIFIED, regardless of how authoritative it looks.

---

## 2.5 Handoff Protocols

### What a complete handoff contains
Git state (branch, commit, dirty files), open threads with next concrete action each, decisions made with rationale and confirmation status, and the pickup pointer — the ONE thing the next session should do first. See template in 2.3.

### Writing the session brief for a cold model
Test: could a model with zero transcript access execute the next step from the brief alone? That means: absolute paths, exact commands, absolute dates, no "as discussed" references, and every number that matters written out. If the brief says "continue the fix from earlier" it has failed.

### Memory indexing after every session
End-of-session checklist: new facts → memory files → MEMORY.md lines; falsifications → ledger; the "START HERE" / pickup memory updated to point at the new state. An unindexed memory is a lost memory.

---

## 2.6 Common Pitfalls

1. **Implementation before understanding.** The model proposes a fix in its first response to a bug report. Antidote: "investigate first — no fix until you've stated the root cause with evidence" (`root-cause-first` skill).
2. **Whole-file reads.** Opening a 2,500-line file to answer a one-symbol question. Antidote: enforce Grep/index-before-Read; audit transcripts for `Read` calls without offset/limit.
3. **Assuming structure from memory.** "The retry logic is in http_client around line 300" — from a prior session, since refactored. Antidote: RULE — any `file:line` reference must come from a lookup performed *this session*.
4. **Simulated ≈ live conflation.** Treating backtest results as evidence about live behavior (fill assumptions, latency, partial fills all differ). Antidote: label every result SIM or LIVE; never let a SIM figure justify a LIVE claim without an explicit bridge argument.
5. **Scope creep.** Asked for one gate, delivers the gate plus a refactor plus new logging. Antidote: negative specification (2.1) + `scope-fence` skill; reject diffs touching unlisted files.
6. **Over-explaining instead of doing.** Three paragraphs of options and no action. Antidote: "pick one and do it; tell me only if you hit a genuine fork."

---

## 2.7 Daily Workflows

### Morning context-load (in order)
1. `MEMORY.md` — scan index, open the "START HERE" pickup memory.
2. Task list — the running source of truth for open work.
3. `CLAUDE.md` — only sections relevant to today's bucket (it's loaded anyway; the point is to re-anchor hard rules).
4. State one line back to yourself: "Today's focus is X; the fence is Y." If the model can't produce that line, the load failed.

### /loop for iterative refinement
Use for converging tasks with a checkable criterion: "run the linter, fix, repeat until clean"; "tighten this doc until every section survives the 'does the reader need this' test". Give the loop a termination criterion and a max iteration count. Do NOT loop open-ended creative work — it diverges.

### Subagent vs. inline
- **Spawn a subagent** when: the work is context-heavy but the conclusion is small (broad searches, multi-file reads); dimensions are independent (parallel review lenses); or the work would pollute the main context with raw data.
- **Stay inline** when: the task needs conversation context a subagent won't have; it's a single lookup; or you'll need to iterate on the result interactively. Never both — if you delegated a search, don't also run it yourself.

### End-of-session checklist
1. Log decisions + falsifications to the persistent store (before any compaction).
2. Tick completed tasks in the task list — with verification, not optimism.
3. Commit or explicitly note dirty state.
4. Write/update the handoff memory (template in 2.3).
5. Update the pickup pointer. Done means the next session starts warm in under a minute.

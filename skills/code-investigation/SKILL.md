---
name: code-investigation
description: Full 5-phase protocol for deep code investigation — audits, gap analyses, architecture reviews, pre-ship checks, onboarding to unfamiliar systems. Produces evidence-anchored findings with GAP-XXX schema and machine-parseable JSON. Trigger keywords - "audit", "investigate", "find gaps", "review the architecture", "what's wrong with", "plan the implementation of". Do NOT use for single bug fixes with a known symptom (use root-cause-first), one-symbol lookups, or questions answerable from an index query.
---

# code-investigation

The flagship investigation protocol. Five phases, each completed and output before the next begins — never skip ahead to conclusions while investigation is open. Grep/index before Read throughout; hypothesis-before-read on every file; everything cited.

## When invoked

### Phase 1 — BRIEF
Restate the investigation as: objective (what question, answered for whom), scope (in/out), success criteria (what a complete answer contains), and the stakes (what decision this feeds — sets the adversarial effort level).
**Phase output:** the brief, ≤10 lines. Gate: the user's request maps onto the objective without remainder.

### Phase 2 — CARTOGRAPHY
Run **cartography-first** over the scoped territory: entry points, god files, spine data flow, state locations, interfaces — signatures and first-30-line reads only, index queries preferred.
**Phase output:** the territory map + initial unknowns[]. Gate: every scope item from Phase 1 has a location on the map (or is logged NOT MAPPED with reason).

### Phase 3 — INVESTIGATION
Targeted deep reads, driven by the map and the objective. Discipline per read: locate via index/Grep → state hypothesis → Read(offset, limit) → MATCH/PARTIAL/MISS verdict. On MISS: update the model before the next read. Follow data flow across files rather than reading files in isolation — findings live at the seams (caller/callee mismatches, state written here and stale-read there).
**Phase output:** the expect/found log + raw observations (not yet findings). Gate: each Phase 1 success criterion has supporting observations or a logged coverage gap.

### Phase 4 — GAP ANALYSIS
Convert observations into findings under the GAP-XXX schema (below). Every field evidenced — a finding without a file:line+snippet is an observation, not a finding; it goes to unknowns[] instead. Run **coverage-accounting** closure: the three-state ledger over the Phase-2 universe.
**Phase output:** draft findings + coverage section.

### Phase 5 — ADVERSARIAL REVIEW
**adversarial-disproof** on every finding — three lenses (correctness / completeness / impact), verdict CONFIRMED, PLAUSIBLE, or REFUTED. REFUTED findings are removed from the report body and listed in a "refuted during review" line (they carry information). Severity-rank survivors.
**Phase output:** the final report (JSON below) — findings ranked, coverage attached, verdicts on everything.

## Output format

```json
{
  "brief": {"objective": "...", "scope_in": [...], "scope_out": [...], "stakes": "..."},
  "map": {"entry_points": [...], "god_files": [...], "spine": "...", "state": [...]},
  "findings": [
    {
      "id": "GAP-001",
      "title": "...",
      "severity": "CRITICAL|HIGH|MED|LOW",
      "category": "correctness|consistency|resilience|performance|security|design",
      "evidence": [{"file": "...", "line": 0, "snippet": "..."}],
      "failure_scenario": "concrete inputs/state → wrong outcome",
      "compensators_searched": "where/what patterns were searched for existing handling",
      "verdict": "CONFIRMED|PLAUSIBLE",
      "fix_sketch": "one-paragraph direction, not an implementation"
    }
  ],
  "refuted": [{"id": "GAP-00x", "killed_by": "L1|L2|L3", "actual_truth": "..."}],
  "coverage": {"covered": [...], "partial": [...], "not_covered": [{"area": "...", "reason": "...", "risk": "H|M|L"}]},
  "read_log_summary": {"reads": 0, "match": 0, "partial": 0, "miss": 0}
}
```
Alongside the JSON, a short prose summary for the human: top findings in plain sentences, what wasn't covered, recommended next action.

## Integration

- Composes **cartography-first** (P2), **hypothesis-before-read** (P3), **evidence-reasoning** (throughout), **coverage-accounting** (P4), **adversarial-disproof** (P5).
- At Max effort, P3/P5 fan out via **multi-agent-orchestration** (parallel dimension readers; refuter panels per finding).
- Findings flow into **plan-gate** when the user says "fix GAP-00x"; a CONFIRMED finding's evidence seeds the plan's CURRENT STATE.
- Multi-session investigations checkpoint per **long-task-orchestration**, one phase per checkpoint.

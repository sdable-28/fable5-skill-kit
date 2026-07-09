---
name: coverage-accounting
description: Use throughout any investigation, audit, review, or search task — anything where the deliverable implies "I looked". Maintains an explicit unknowns[] list; every skipped area is logged with reason and risk level; nothing is silently skipped. Trigger keywords - "audit", "review", "find all", "check everything", "is there anywhere that...". Do NOT use for single-point lookups where coverage is trivially total.
---

# coverage-accounting

The most dangerous sentence in an audit is the one not written: the area that wasn't checked and isn't mentioned. A wrong finding can be challenged; an invisible gap cannot. This skill makes non-coverage a first-class, visible output — the reader of your report must be able to distinguish "checked, clean" from "not checked."

## When invoked

1. **Enumerate the coverage universe at task start.** What WOULD total coverage mean here — which files/modules/scenarios/time-ranges/configurations? Write the list. If the universe can't be enumerated (open-ended search), define the search dimensions instead (by-name, by-content, by-caller, by-config) and account per dimension.
2. **Maintain `unknowns[]` live, not retrospectively.** The moment you decide to skip, sample, bound, or defer anything, log it immediately:
   - `{area} | WHY skipped: {time/relevance/access/size} | RISK if it hides a finding: HIGH/MED/LOW + one-line rationale`
   - Retrospective reconstruction misses exactly the skips that were made unconsciously — which are the dangerous ones.
3. **Log silent-cap decisions loudly.** Top-N sampling, "checked the three biggest callers", depth limits, timeout truncations — each is a coverage bound and goes on the list. A bounded search reported without its bound reads as exhaustive.
4. **Distinguish three states in reporting.** Every element of the universe ends in exactly one:
   - **COVERED** — inspected; findings or clean.
   - **PARTIAL** — sampled/bounded; state the bound.
   - **NOT COVERED** — untouched; reason + risk.
5. **Close with the coverage gate:** re-scan the universe list from step 1 against the three-state ledger. Anything unaccounted for is a process failure — account for it before delivering. HIGH-risk NOT-COVERED items get a recommendation: extend the work, or the user accepts the risk knowingly.

## Output format

Section in every investigation/audit deliverable:
```
## Coverage
UNIVERSE: {what total coverage would have meant}
COVERED: {list or %, by area}
PARTIAL: {area — bound applied — what could hide there}
NOT COVERED:
  - {area} | reason | RISK: HIGH/MED/LOW — {rationale}
RECOMMENDATION: {which NOT-COVERED items warrant a follow-up pass}
```

## Integration

- **cartography-first**'s NOT MAPPED line seeds the initial unknowns[].
- **code-investigation** Phase 4 requires this section in its JSON output; a gap report without a coverage report is incomplete by definition.
- **multi-agent-orchestration**: each parallel agent reports its own coverage; the orchestrator merges the ledgers — fan-out without merged coverage accounting produces overlapping blind spots.
- Pairs with **uncertainty-handling**: a HIGH-risk uncovered area is an uncertainty with a verification path ("read it").
